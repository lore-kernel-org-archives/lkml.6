Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70285C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FFE2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvVSPqth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FFE2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbeK3BiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:41558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729157AbeK3BiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:38:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 545102145D;
        Thu, 29 Nov 2018 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501957;
        bh=yTcEiYZ8xJEn4vsZhhx1s4SxYhlxw4MSau60bh0QXbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SvVSPqthr+Ii9rr8COhWR/ATT0/pBa280ilBfgVDGaZCR8BtgDilnWxMe0Z7wFvc0
         D1MaMgrbBDwSXy8ulSnzVjKdRjNZH8q1uG9ZrJ0fCkc3ExErwOnQ3r/UDcfkC/J6FZ
         xQBVrvDJ2uQ1wpnXzE1S8KtNS8jIELemL6G0vmDA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hugues Fruchet <hugues.fruchet@st.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH 4.19 110/110] media: ov5640: fix auto controls values when switching to manual mode
Date:   Thu, 29 Nov 2018 15:13:21 +0100
Message-Id: <20181129135925.730818989@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

From: Hugues Fruchet <hugues.fruchet@st.com>

commit a8f438c684eaa4cbe6c98828eb996d5ec53e24fb upstream.

When switching from auto to manual mode, V4L2 core is calling
g_volatile_ctrl() in manual mode in order to get the manual initial value.
Remove the manual mode check/return to not break this behaviour.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
Tested-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/ov5640.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -2337,16 +2337,12 @@ static int ov5640_g_volatile_ctrl(struct
 
 	switch (ctrl->id) {
 	case V4L2_CID_AUTOGAIN:
-		if (!ctrl->val)
-			return 0;
 		val = ov5640_get_gain(sensor);
 		if (val < 0)
 			return val;
 		sensor->ctrls.gain->val = val;
 		break;
 	case V4L2_CID_EXPOSURE_AUTO:
-		if (ctrl->val == V4L2_EXPOSURE_MANUAL)
-			return 0;
 		val = ov5640_get_exposure(sensor);
 		if (val < 0)
 			return val;


