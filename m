Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F817C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9B820892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107513;
	bh=fWpO+bwpj7kjPyCgUU7M1BPiWBp6at7NMi9AclcvQU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hKALk3pl+ziirw4cKLKUX/pB+1stupnSU8NvhzPLZDyTRxLBD0IzZvOPVpB3lGdj0
	 XI8cewXlYInnXwk2weSmvKrIhI95etwAVNSy6Ojpt8G9SqH2kOsHsyURRLdSJUbB9w
	 mK9Vp65jjzFE+etsMANiNbfxxAhETZHGQWsYsHzY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9B820892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbeLFOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:45:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730160AbeLFOpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:45:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC38A20661;
        Thu,  6 Dec 2018 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107502;
        bh=fWpO+bwpj7kjPyCgUU7M1BPiWBp6at7NMi9AclcvQU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgPZcOFa/JEiX9zddhdzALWfKXFuN23LpZdBkyLJDYqxYXFV9j4zBDiyTenm9szuU
         b4zuCofhbVMFAciA7a/MBOe1aHI82PE7B2gVODTvVCc0xmCuEvbEyU2p/95L2+aU7g
         V8Yd18rIOLJLgpakLWt2L8aOUqrMAJlVY/cAifJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 003/101] test_hexdump: use memcpy instead of strncpy
Date:   Thu,  6 Dec 2018 15:38:02 +0100
Message-Id: <20181206143011.815189571@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit b1286ed7158e9b62787508066283ab0b8850b518 upstream.

New versions of gcc reasonably warn about the odd pattern of

	strncpy(p, q, strlen(q));

which really doesn't make sense: the strncpy() ends up being just a slow
and odd way to write memcpy() in this case.

Apparently there was a patch for this floating around earlier, but it
got lost.

Acked-again-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/test_hexdump.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -81,7 +81,7 @@ static void __init test_hexdump_prepare_
 		const char *q = *result++;
 		size_t amount = strlen(q);
 
-		strncpy(p, q, amount);
+		memcpy(p, q, amount);
 		p += amount;
 
 		*p++ = ' ';


