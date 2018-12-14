Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ADB214ED
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789728;
	bh=cTTbKEqIs6+gO7dfCjFzW1c0H4K6Tuzi+VsW4OfoVZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZRhKR6+9NIYeEuOdmf8GuIO/F3Aqs2xjr2XqNKuUOMVDjyLVkOCjPZo0npG9AzEGG
	 8SEAYG/3CeRex/DPGsXa44k52f/OVSgtwDNzPdyhutIwJRfa/iozHzGyCsKLdSOwLk
	 S1IN9zML4WKbfeEqTWRmrlqj2s9/CHOgazTR7hMI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3ADB214ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbeLNMP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732554AbeLNMPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:15:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D8D214F0;
        Fri, 14 Dec 2018 12:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789724;
        bh=cTTbKEqIs6+gO7dfCjFzW1c0H4K6Tuzi+VsW4OfoVZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUZXdKh3HcQ+8rcmzbOTbZz36BmLjdEzheQmB0lLCPAxT9ZboO22wq/065Mw1UEAG
         In/iDELw/iych4nqhmkI2zJj/rtvbmCGhA/6RBm2GIPKp3fOW8FiQoZzwXLUepf18h
         ZRG9c81ULkIweKaJM/b7idemyPXV5j9zEj+fudR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4.4 52/88] x86: fix SMAP in 32-bit environments
Date:   Fri, 14 Dec 2018 13:00:26 +0100
Message-Id: <20181214115706.592803346@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit de9e478b9d49f3a0214310d921450cf5bb4a21e6 upstream.

In commit 11f1a4b9755f ("x86: reorganize SMAP handling in user space
accesses") I changed how the stac/clac instructions were generated
around the user space accesses, which then made it possible to do
batched accesses efficiently for user string copies etc.

However, in doing so, I completely spaced out, and didn't even think
about the 32-bit case.  And nobody really even seemed to notice, because
SMAP doesn't even exist until modern Skylake processors, and you'd have
to be crazy to run 32-bit kernels on a modern CPU.

Which brings us to Andy Lutomirski.

He actually tested the 32-bit kernel on new hardware, and noticed that
it doesn't work.  My bad.  The trivial fix is to add the required
uaccess begin/end markers around the raw accesses in <asm/uaccess_32.h>.

I feel a bit bad about this patch, just because that header file really
should be cleaned up to avoid all the duplicated code in it, and this
commit just expands on the problem.  But this just fixes the bug without
any bigger cleanup surgery.

Reported-and-tested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/uaccess_32.h |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/arch/x86/include/asm/uaccess_32.h
+++ b/arch/x86/include/asm/uaccess_32.h
@@ -48,20 +48,28 @@ __copy_to_user_inatomic(void __user *to,
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__put_user_size(*(u8 *)from, (u8 __user *)to,
 					1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__put_user_size(*(u16 *)from, (u16 __user *)to,
 					2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__put_user_size(*(u32 *)from, (u32 __user *)to,
 					4, ret, 4);
+			__uaccess_end();
 			return ret;
 		case 8:
+			__uaccess_begin();
 			__put_user_size(*(u64 *)from, (u64 __user *)to,
 					8, ret, 8);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -103,13 +111,19 @@ __copy_from_user_inatomic(void *to, cons
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -148,13 +162,19 @@ __copy_from_user(void *to, const void __
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}
@@ -170,13 +190,19 @@ static __always_inline unsigned long __c
 
 		switch (n) {
 		case 1:
+			__uaccess_begin();
 			__get_user_size(*(u8 *)to, from, 1, ret, 1);
+			__uaccess_end();
 			return ret;
 		case 2:
+			__uaccess_begin();
 			__get_user_size(*(u16 *)to, from, 2, ret, 2);
+			__uaccess_end();
 			return ret;
 		case 4:
+			__uaccess_begin();
 			__get_user_size(*(u32 *)to, from, 4, ret, 4);
+			__uaccess_end();
 			return ret;
 		}
 	}


