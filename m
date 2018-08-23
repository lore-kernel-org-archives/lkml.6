Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A30C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0A321564
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 10:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A321564
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeHWN6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 09:58:01 -0400
Received: from www.osadl.org ([62.245.132.105]:33722 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbeHWN6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 09:58:00 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id w7NAPW1G007384;
        Thu, 23 Aug 2018 12:25:32 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Steve French <sfrench@samba.org>
Cc:     Jerome Marchand <jmarchan@redhat.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] cifs: check kmalloc before use
Date:   Thu, 23 Aug 2018 12:24:02 +0200
Message-Id: <1535019842-18103-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmalloc was not being checked - if it fails issue a warning
and return -ENOMEM to the caller.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: b8da344b74c8 ("cifs: dynamic allocation of ntlmssp blob")
---

Problem was located with an experimental coccinelle script

Both call-sites will expect non-0 to indicate error so -ENOMEM
should be OK here. Setting buflen to 0 seems to be the expected
behavior on failure although it will not be checked/used at
the call-sites - probably this could be removed here as well as
in the handling of authentication error (preceding this change)
it was just retained for consistency.

Patch was compile tested with: x86_64_defconfig + CONFIG_CIFS=y
(with sparse and smatch warning unrelated to proposed change)

Patch is against 4.18 (localversion-next is next-20180823)

 fs/cifs/sess.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 8b0502c..aa23c00 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -398,6 +398,12 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 		goto setup_ntlmv2_ret;
 	}
 	*pbuffer = kmalloc(size_of_ntlmssp_blob(ses), GFP_KERNEL);
+	if (!*pbuffer) {
+		rc = -ENOMEM;
+		cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
+		*buflen = 0;
+		goto setup_ntlmv2_ret;
+	}
 	sec_blob = (AUTHENTICATE_MESSAGE *)*pbuffer;
 
 	memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);
-- 
2.1.4

