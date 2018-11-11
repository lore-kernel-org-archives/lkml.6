Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB9C20839
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHY/doyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB9C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbeKLJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:46:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:34210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbeKLISP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:15 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C92521707;
        Sun, 11 Nov 2018 22:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975299;
        bh=hTWr3X24XRC0Op1U8qGvydHrXA2AlBb6kRtUWB6u5dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHY/doyK9FU9vWK0FYsR//7lkB0msy0Qw/gb61WogKAjUuRKaBziz/aMc9Dt2EDAU
         f6ljeF4/Sf/6YVuSJka+ID9aASbtk36k0L8caCVVvacvhohZ7hdPLnglVdAQWHyPEr
         vxzAHfA7xTzK/0XtY+eqo8VVTBkeAT79uGUV0rrQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 257/361] kbuild: fix kernel/bounds.c W=1 warning
Date:   Sun, 11 Nov 2018 14:20:04 -0800
Message-Id: <20181111221653.657445058@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 6a32c2469c3fbfee8f25bcd20af647326650a6cf upstream.

Building any configuration with 'make W=1' produces a warning:

kernel/bounds.c:16:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]

When also passing -Werror, this prevents us from building any other files.
Nobody ever calls the function, but we can't make it 'static' either
since we want the compiler output.

Calling it 'main' instead however avoids the warning, because gcc
does not insist on having a declaration for main.

Link: http://lkml.kernel.org/r/20181005083313.2088252-1-arnd@arndb.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/bounds.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/bounds.c
+++ b/kernel/bounds.c
@@ -13,7 +13,7 @@
 #include <linux/log2.h>
 #include <linux/spinlock_types.h>
 
-void foo(void)
+int main(void)
 {
 	/* The enum constants to put into include/generated/bounds.h */
 	DEFINE(NR_PAGEFLAGS, __NR_PAGEFLAGS);
@@ -23,4 +23,6 @@ void foo(void)
 #endif
 	DEFINE(SPINLOCK_SIZE, sizeof(spinlock_t));
 	/* End of constants */
+
+	return 0;
 }


