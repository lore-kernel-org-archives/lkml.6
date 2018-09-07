Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D51C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4954B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4954B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbeIHCIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeIHCIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:54 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E0DDEF09;
        Fri,  7 Sep 2018 21:26:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yannik Sembritzki <yannik@sembritzki.me>,
        David Howells <dhowells@redhat.com>, kexec@lists.infradead.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 17/89] Fix kexec forbidding kernels signed with keys in the secondary keyring to boot
Date:   Fri,  7 Sep 2018 23:09:11 +0200
Message-Id: <20180907210854.770395068@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
References: <20180907210852.341064285@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yannik Sembritzki <yannik@sembritzki.me>

commit ea93102f32244e3f45c8b26260be77ed0cc1d16c upstream.

The split of .system_keyring into .builtin_trusted_keys and
.secondary_trusted_keys broke kexec, thereby preventing kernels signed by
keys which are now in the secondary keyring from being kexec'd.

Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
verify_pefile_signature().

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
Cc: kexec@lists.infradead.org
Cc: keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: stable@kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/kexec-bzimage64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loade
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       VERIFY_USE_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif


