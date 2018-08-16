Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5E8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819D421480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 13:05:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819D421480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391623AbeHPQD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 12:03:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391608AbeHPQD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 12:03:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D5F87B2B3;
        Thu, 16 Aug 2018 13:05:27 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B9A02026D7E;
        Thu, 16 Aug 2018 13:05:23 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/2] Fix kexec forbidding kernels signed with keys in the
 secondary keyring to boot
From:   David Howells <dhowells@redhat.com>
To:     yannik@sembritzki.me, torvalds@linux-foundation.org
Cc:     kexec@lists.infradead.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, stable@vger.kernel.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, James.Bottomley@HansenPartnership.com,
        gregkh@linuxfoundation.org
Date:   Thu, 16 Aug 2018 14:05:23 +0100
Message-ID: <153442472298.17751.5395559214488109936.stgit@warthog.procyon.org.uk>
In-Reply-To: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
References: <153442471049.17751.3835342719465644394.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 13:05:27 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 16 Aug 2018 13:05:27 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannik Sembritzki <yannik@sembritzki.me>

The split of .system_keyring into .builtin_trusted_keys and
.secondary_trusted_keys broke kexec, thereby preventing kernels signed by
keys which are now in the secondary keyring from being kexec'd.

Fix this by passing VERIFY_USE_SECONDARY_KEYRING to
verify_pefile_signature().

Fixes: d3bfe84129f6 ("certs: Add a secondary system keyring that can be added to dynamically")
Signed-off-by: Yannik Sembritzki <yannik@sembritzki.me>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: kexec@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: linux-security-module@vger.kernel.org
cc: stable@vger.kernel.org
---

 arch/x86/kernel/kexec-bzimage64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7326078eaa7a..278cd07228dd 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -532,7 +532,7 @@ static int bzImage64_cleanup(void *loader_data)
 static int bzImage64_verify_sig(const char *kernel, unsigned long kernel_len)
 {
 	return verify_pefile_signature(kernel, kernel_len,
-				       NULL,
+				       VERIFY_USE_SECONDARY_KEYRING,
 				       VERIFYING_KEXEC_PE_SIGNATURE);
 }
 #endif

