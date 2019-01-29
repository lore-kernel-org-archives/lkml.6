Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C29C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF7F2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762416;
	bh=waHCZt964ElGKcR5whMcvxMfWXmFTIPHjGLK0WnXm2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UIlXTxctCEOGleMH8mD65ovrD0qFP0MJGoB9yNL/pmur5WUBmAXEJDcVnDTjewGwt
	 MeS1nH4T5vulYUWOgRRGeyNMVo9ESzWXts393BM8oO6V3t+/mHq4Es7X9cdXn10J4U
	 hHHRBHavp/DxlaXGtCHupN40Yk3OqPNsr0DoSbng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfA2Lqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:37502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfA2Lqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:46:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2801721874;
        Tue, 29 Jan 2019 11:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762410;
        bh=waHCZt964ElGKcR5whMcvxMfWXmFTIPHjGLK0WnXm2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oH7+6pEULaqpVgYT4vvWHw5RfIksq2baPVI/oK0CBAKXT8JFkN2ZFo3p065bm8ISe
         nVaWLhZyD45h4Quyx+4VY7xaKyDPgqcEtcRQ//hDtD9p70f+5H9IUB8gjCne/sTTLl
         X+NVVhuQUbU/2nyGt10++NcyQK39pM48WixpTJcg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.19 065/103] dm crypt: fix parsing of extended IV arguments
Date:   Tue, 29 Jan 2019 12:35:42 +0100
Message-Id: <20190129113204.552478151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milan Broz <gmazyland@gmail.com>

commit 1856b9f7bcc8e9bdcccc360aabb56fbd4dd6c565 upstream.

The dm-crypt cipher specification in a mapping table is defined as:
  cipher[:keycount]-chainmode-ivmode[:ivopts]
or (new crypt API format):
  capi:cipher_api_spec-ivmode[:ivopts]

For ESSIV, the parameter includes hash specification, for example:
aes-cbc-essiv:sha256

The implementation expected that additional IV option to never include
another dash '-' character.

But, with SHA3, there are names like sha3-256; so the mapping table
parser fails:

dmsetup create test --table "0 8 crypt aes-cbc-essiv:sha3-256 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdb 0"
  or (new crypt API format)
dmsetup create test --table "0 8 crypt capi:cbc(aes)-essiv:sha3-256 9c1185a5c5e9fc54612808977ee8f5b9e 0 /dev/sdb 0"

  device-mapper: crypt: Ignoring unexpected additional cipher options
  device-mapper: table: 253:0: crypt: Error creating IV
  device-mapper: ioctl: error adding target to table

Fix the dm-crypt constructor to ignore additional dash in IV options and
also remove a bogus warning (that is ignored anyway).

Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Milan Broz <gmazyland@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-crypt.c |   25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2405,9 +2405,21 @@ static int crypt_ctr_cipher_new(struct d
 	 * capi:cipher_api_spec-iv:ivopts
 	 */
 	tmp = &cipher_in[strlen("capi:")];
-	cipher_api = strsep(&tmp, "-");
-	*ivmode = strsep(&tmp, ":");
-	*ivopts = tmp;
+
+	/* Separate IV options if present, it can contain another '-' in hash name */
+	*ivopts = strrchr(tmp, ':');
+	if (*ivopts) {
+		**ivopts = '\0';
+		(*ivopts)++;
+	}
+	/* Parse IV mode */
+	*ivmode = strrchr(tmp, '-');
+	if (*ivmode) {
+		**ivmode = '\0';
+		(*ivmode)++;
+	}
+	/* The rest is crypto API spec */
+	cipher_api = tmp;
 
 	if (*ivmode && !strcmp(*ivmode, "lmk"))
 		cc->tfms_count = 64;
@@ -2477,11 +2489,8 @@ static int crypt_ctr_cipher_old(struct d
 		goto bad_mem;
 
 	chainmode = strsep(&tmp, "-");
-	*ivopts = strsep(&tmp, "-");
-	*ivmode = strsep(&*ivopts, ":");
-
-	if (tmp)
-		DMWARN("Ignoring unexpected additional cipher options");
+	*ivmode = strsep(&tmp, ":");
+	*ivopts = tmp;
 
 	/*
 	 * For compatibility with the original dm-crypt mapping format, if


