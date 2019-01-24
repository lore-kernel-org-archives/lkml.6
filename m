Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EEC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459CB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548361106;
	bh=HNOfTUfTqSPfF588wEbPic9CG6z5K6RaceyWK7mdsgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uVpuSNeSiofn72S932Nh5srGCb73b0GepEpW98DXsOzKNcaKKHWPrBRZRMWN4/5m/
	 g9RhDEnJ7mfuR0Z13vB9fHysDYd6pa8uqFJbDfX/5kcIVS9Tb5sHL+BftGxGFlfJxd
	 mAVu8CXn1TS4hcPJbp53jv+xN5mAdap24lMUKd/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAXUSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:18:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729538AbfAXTW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0141E218D2;
        Thu, 24 Jan 2019 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357748;
        bh=HNOfTUfTqSPfF588wEbPic9CG6z5K6RaceyWK7mdsgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8RIyWouPG0TWOwPixOkeGM092Z1IyUxwI12yFdG+cJJZ6IqxHv1MBgGHuzL0rwxy
         7pp/VQMNRVEil04fS7gD3KYjY3kGTR0p9xaFzTGTb3vaw38pj0EyVgo3ati+Pj3P2m
         vcX1ABna4kNOiJllHcCKWWP0dSJuyN1S6Exppkk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 3.18 05/52] USB: storage: dont insert sane sense for SPC3+ when bad sense specified
Date:   Thu, 24 Jan 2019 20:19:29 +0100
Message-Id: <20190124190141.791154485@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -223,8 +223,12 @@ static int slave_configure(struct scsi_d
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
 
 		/* USB-IDE bridges tend to report SK = 0x04 (Non-recoverable


