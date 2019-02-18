Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECC921905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499179;
	bh=c0XmBm66hTbFqy8CP4C7Bzsvglme6SEGq9xq/HDaBes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hgbwpjB2WcOKn80O/h+GMDIVu6mB94J/slmUlXqSnoxVxsuSOqEjX9mwcCSAmL/ON
	 DWyL+7Aht3bMSFp3UcWUsUk5sGx+Nc4obzo8D8m8wRs8kkJDcMyw8jgwHxWEfu8R4d
	 WNyePlZMYeUu1HZjeb27PisiJqm6gjzfdztc0uvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392208AbfBROM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:57536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392173AbfBROMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05C0B218AD;
        Mon, 18 Feb 2019 14:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499172;
        bh=c0XmBm66hTbFqy8CP4C7Bzsvglme6SEGq9xq/HDaBes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYIQZgNu21PLRHOYaAGbNAa52DVlJBr8uww14XSUN895ccweUJ8GQNz5u6tiu4Lgq
         tpXpZyFaasfpTXfCi0Aq8oGPGhspbq2DZ71ELFpo2Ad5RMTpy+6ygagevJ4sQq9eJj
         n3AvmAnPGfcK1KC3Dw6D0TmDth5WFHSgfy/cWORo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matti Kurkela <Matti.Kurkela@iki.fi>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3.18 099/108] Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780
Date:   Mon, 18 Feb 2019 14:44:35 +0100
Message-Id: <20190218133524.248145425@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

From: Matti Kurkela <Matti.Kurkela@iki.fi>

commit e8b22d0a329f0fb5c7ef95406872d268f01ee3b1 upstream.

Like Fujitsu CELSIUS H760, the H780 also has a three-button Elantech
touchpad, but the driver needs to be told so to enable the middle touchpad
button.

The elantech_dmi_force_crc_enabled quirk was not necessary with the H780.

Also document the fw_version and caps values detected for both H760 and
H780 models.

Signed-off-by: Matti Kurkela <Matti.Kurkela@iki.fi>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/elantech.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1114,6 +1114,8 @@ static int elantech_get_resolution_v4(st
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu CELSIUS H760    0x570f02        40, 14, 0c      3 hw buttons (**)
+ * Fujitsu CELSIUS H780    0x5d0f02        41, 16, 0d      3 hw buttons (**)
  * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
  * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
@@ -1156,6 +1158,13 @@ static const struct dmi_system_id elante
 			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
 		},
 	},
+	{
+		/* Fujitsu H780 also has a middle button */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H780"),
+		},
+	},
 #endif
 	{ }
 };


