Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 246DB20675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570388;
	bh=2d2Lh2Hjywqwt6GMf8sQY6AAZq8U2trl5JhtBlHMRgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTUS6g7d3br7DnN2fTTDl68zZ6gzO/Gd6OPtf2/sMDOahUfT+1ZpB0wvns6E9pP0g
	 ZRnL/hcuDdBjI4GXbu31G02QusQTXian1WZ/1ywFOgLMVEXjZ6GavkkdKtR/81ailH
	 BWrRGkFOvAoszjbTZ1bCsPOQC7LH/pXq8zIp8D8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbfAOQjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:39:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732404AbfAOQjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990B82054F;
        Tue, 15 Jan 2019 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570382;
        bh=2d2Lh2Hjywqwt6GMf8sQY6AAZq8U2trl5JhtBlHMRgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1GNAiSG4Lw+cSPX8pzCd6Jmttx34F6cNAqRxSuECT5tPyMom5eEkGK02kE7ydwzj
         gukC30G+HYGnPfTPniXH9irkFr1eu0tV52fm+M2wM/DYCfiTv0V2VwicFsixmz7baH
         O68UHB3zfjDPR/jnX6pnon0FR8rHtxZEHEDyhoCU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 4.9 05/16] USB: storage: dont insert sane sense for SPC3+ when bad sense specified
Date:   Tue, 15 Jan 2019 17:35:48 +0100
Message-Id: <20190115154848.807053087@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154848.164648613@linuxfoundation.org>
References: <20190115154848.164648613@linuxfoundation.org>
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

From: Icenowy Zheng <icenowy@aosc.io>

commit c5603d2fdb424849360fe7e3f8c1befc97571b8c upstream.

Currently the code will set US_FL_SANE_SENSE flag unconditionally if
device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
which claims SPC4, will show strange behavior with 96-byte sense
(put the chip into a wrong state that cannot read/write anything).

Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE on
SPC4+ devices.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Cc: stable <stable@vger.kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/storage/scsiglue.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -251,8 +251,12 @@ static int slave_configure(struct scsi_d
 		if (!(us->fflags & US_FL_NEEDS_CAP16))
 			sdev->try_rc_10_first = 1;
 
-		/* assume SPC3 or latter devices support sense size > 18 */
-		if (sdev->scsi_level > SCSI_SPC_2)
+		/*
+		 * assume SPC3 or latter devices support sense size > 18
+		 * unless US_FL_BAD_SENSE quirk is specified.
+		 */
+		if (sdev->scsi_level > SCSI_SPC_2 &&
+		    !(us->fflags & US_FL_BAD_SENSE))
 			us->fflags |= US_FL_SANE_SENSE;
 
 		/*


