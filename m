Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441FEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131482081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896301;
	bh=4/19itBEudqhcmlumZj6Ae8jZFfnGZEe6OAC4hrzb6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sz0jgCJh7lyEyDXphtzTvpoSRsKqdJbYXNbAXMnkhW8UsqAsE1GITHLlK0B/PtTQB
	 7KQB8u4P2lti89SXyZcjssSlqr1l5sdhSGJbLbDnyq8Y3bVtFe8BlNNMaJtJDzMphi
	 vAiFrV0XOV3+qy7gWtvIBJxmU5caJyyFkP+FnarY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732937AbfBKOo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732512AbfBKOoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:44:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5710D20700;
        Mon, 11 Feb 2019 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896294;
        bh=4/19itBEudqhcmlumZj6Ae8jZFfnGZEe6OAC4hrzb6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2IWaqjYAGw/zFsQZ9yHz2mWTSjV7MJ4+jrxSFMWFtYN+Sf8w3crh8FTAmtWTe8QR
         1BJppTRJXzb8iQyWsljUTWuE4fJV/6MQz8BjsE2dEITvtNPntkb2Y1gjkHjd1Dn8Yo
         KNmBmT6NO+fVBxT0hfUtQRmpFQGq9JJ4RIC5b6g0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joey Zhang <joey.zhang@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 137/313] switchtec: Fix SWITCHTEC_IOCTL_EVENT_IDX_ALL flags overwrite
Date:   Mon, 11 Feb 2019 15:16:57 +0100
Message-Id: <20190211141902.828919146@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

[ Upstream commit e4a7dca5de625018b29417ecc39dc5037d9a5a36 ]

In the ioctl_event_ctl() SWITCHTEC_IOCTL_EVENT_IDX_ALL case, we call
event_ctl() several times with the same "ctl" struct.  Each call clobbers
ctl.flags, which leads to the problem that we may not actually enable or
disable all events as the user requested.

Preserve the event flag value with a temporary variable.

Fixes: 52eabba5bcdb ("switchtec: Add IOCTLs to the Switchtec driver")
Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/switch/switchtec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 54a8b30dda38..37d0c15c9eeb 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -800,6 +800,7 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 {
 	int ret;
 	int nr_idxs;
+	unsigned int event_flags;
 	struct switchtec_ioctl_event_ctl ctl;
 
 	if (copy_from_user(&ctl, uctl, sizeof(ctl)))
@@ -821,7 +822,9 @@ static int ioctl_event_ctl(struct switchtec_dev *stdev,
 		else
 			return -EINVAL;
 
+		event_flags = ctl.flags;
 		for (ctl.index = 0; ctl.index < nr_idxs; ctl.index++) {
+			ctl.flags = event_flags;
 			ret = event_ctl(stdev, &ctl);
 			if (ret < 0)
 				return ret;
-- 
2.19.1



