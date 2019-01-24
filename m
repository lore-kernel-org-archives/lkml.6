Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83EC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4F3218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358142;
	bh=tHnQDh0oMUayOnElXjiMp8X5BFJcWzdiVKIJbdiaHR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fBJxtK88fLX/1AJcnEi2guwg/eFbME46bI60XmyhfOTi5gmZRc7wl4rtZ7xnt37ju
	 hpAjUUVvB7+ATyXxIrrPm/Rwsun89fWjLgkA3rLrCuc2rSTf+iL36lv0B7JljTdK+o
	 PAO141LXatKp/z7OK86Z4mJBeGrgbRwfdSSxSvP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbfAXT3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731071AbfAXT24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67507218D4;
        Thu, 24 Jan 2019 19:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358135;
        bh=tHnQDh0oMUayOnElXjiMp8X5BFJcWzdiVKIJbdiaHR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLn+ADE5atToIAbymgneWY2+pB/XOaTPe9xlJEsCcLLk4MUzlTiC2JCg4vvQrUqeh
         T2lQ4t2diTaUfrwliZHWPa/cA4sOh8R2sIi+t1XkJSqL3Paa+wPGhzfxh/ByFSMfLG
         ypZy/p7TYLRdp2HRDeZsDIzGaWv48dBSZkxhbqVA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Disseldorp <ddiss@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        "Bryant G. Ly" <bly@catalogicsoftware.com>,
        Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 087/104] scsi: target: use consistent left-aligned ASCII INQUIRY data
Date:   Thu, 24 Jan 2019 20:20:16 +0100
Message-Id: <20190124190204.555770008@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

[ Upstream commit 0de263577de5d5e052be5f4f93334e63cc8a7f0b ]

spc5r17.pdf specifies:

  4.3.1 ASCII data field requirements
  ASCII data fields shall contain only ASCII printable characters (i.e.,
  code values 20h to 7Eh) and may be terminated with one or more ASCII null
  (00h) characters.  ASCII data fields described as being left-aligned
  shall have any unused bytes at the end of the field (i.e., highest
  offset) and the unused bytes shall be filled with ASCII space characters
  (20h).

LIO currently space-pads the T10 VENDOR IDENTIFICATION and PRODUCT
IDENTIFICATION fields in the standard INQUIRY data. However, the PRODUCT
REVISION LEVEL field in the standard INQUIRY data as well as the T10 VENDOR
IDENTIFICATION field in the INQUIRY Device Identification VPD Page are
zero-terminated/zero-padded.

Fix this inconsistency by using space-padding for all of the above fields.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bryant G. Ly <bly@catalogicsoftware.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_spc.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_spc.c b/drivers/target/target_core_spc.c
index 9413e1a949e5..5af4d6a03d6e 100644
--- a/drivers/target/target_core_spc.c
+++ b/drivers/target/target_core_spc.c
@@ -108,12 +108,17 @@ spc_emulate_inquiry_std(struct se_cmd *cmd, unsigned char *buf)
 
 	buf[7] = 0x2; /* CmdQue=1 */
 
-	memcpy(&buf[8], "LIO-ORG ", 8);
-	memset(&buf[16], 0x20, 16);
+	/*
+	 * ASCII data fields described as being left-aligned shall have any
+	 * unused bytes at the end of the field (i.e., highest offset) and the
+	 * unused bytes shall be filled with ASCII space characters (20h).
+	 */
+	memset(&buf[8], 0x20, 8 + 16 + 4);
+	memcpy(&buf[8], "LIO-ORG", sizeof("LIO-ORG") - 1);
 	memcpy(&buf[16], dev->t10_wwn.model,
-	       min_t(size_t, strlen(dev->t10_wwn.model), 16));
+	       strnlen(dev->t10_wwn.model, 16));
 	memcpy(&buf[32], dev->t10_wwn.revision,
-	       min_t(size_t, strlen(dev->t10_wwn.revision), 4));
+	       strnlen(dev->t10_wwn.revision, 4));
 	buf[4] = 31; /* Set additional length to 31 */
 
 	return 0;
@@ -251,7 +256,9 @@ check_t10_vend_desc:
 	buf[off] = 0x2; /* ASCII */
 	buf[off+1] = 0x1; /* T10 Vendor ID */
 	buf[off+2] = 0x0;
-	memcpy(&buf[off+4], "LIO-ORG", 8);
+	/* left align Vendor ID and pad with spaces */
+	memset(&buf[off+4], 0x20, 8);
+	memcpy(&buf[off+4], "LIO-ORG", sizeof("LIO-ORG") - 1);
 	/* Extra Byte for NULL Terminator */
 	id_len++;
 	/* Identifier Length */
-- 
2.19.1



