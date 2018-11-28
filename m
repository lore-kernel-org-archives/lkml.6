Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 077032086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMDgsZWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 077032086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeK1Ua6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:30:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38199 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbeK1Ua5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:30:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so9254161pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bZfZFWO8LVzOeMYPieoDTbNggt+PEiM2bxAXF77bHsI=;
        b=WMDgsZWolkQsoERl+MdBz0avaFGJ5YhHTtfSzrjl9JJkHYMEzR4TRtej616H/kvPoL
         W9j4i0NtBjQgAKvPVh1/XBEV82kr1ZhlFuA3ZWNPtSNYdNSXG7hNz7kj0pYFbwWDLTAz
         XfBxYFNvhGCzzCvS+Og9FulVJMqigqgjPIBVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bZfZFWO8LVzOeMYPieoDTbNggt+PEiM2bxAXF77bHsI=;
        b=mVD69Gds5L5VqjqEW3q0oK+Ns+5PfCog9/f3tSQsciPa2bawsY+Z9KTpstJAqk+stu
         ZdaLxZR47EMrJIIahBVeOy+NzA27U3z764ACmybdb8+C3V3RgSeiOS/d6NfPda5HckW/
         9GfoTjHWXZ0kH7wiUR80XdjEzzy0eZK5VFz6Juvx+qmKx0EvnFDb4C3GauvCrt6NrMJb
         NqDaVb/Pvh3l+7v1JfpLkPcbs2xS5SwJMTD1hA0iAQKu2al6JdkvRanL2MThh0ErcU4O
         vuvFgHG/xQjq0bB4WhqOSvscLEa7VJUZPxtACYweaAiD0jJtF6+2qVBaq5kTyx5VFv0N
         3i9Q==
X-Gm-Message-State: AA+aEWasWLLTcpwGtO2RziDJQUr8KNIFg/X5py+uteOIde0qa2bXbNBl
        vMdqGNdL7MiRlAnqP83s/DFYNw==
X-Google-Smtp-Source: AFSGD/XV4jsXigI2p3fC9If+Tm7pBoVjiB0eBEexvS8sarPOwafw9wxmFI8L8aFLOtyKhImoKDzgtg==
X-Received: by 2002:a63:f1f:: with SMTP id e31mr145184pgl.274.1543397398353;
        Wed, 28 Nov 2018 01:29:58 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e128sm7870444pfe.67.2018.11.28.01.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 01:29:57 -0800 (PST)
From:   "Hsin-Yi, Wang" <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [V2] usb/mtu3: power down device ip at setup
Date:   Wed, 28 Nov 2018 17:29:53 +0800
Message-Id: <20181128092953.41541-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181128060412.630-1-hsinyi@chromium.org>
References: <20181128060412.630-1-hsinyi@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally, when dr_mode is USB_DR_MODE_HOST, it didn't power down device ip,
so host ip sleep will fail at ssusb_host_disable.

Power down device ip at ssusb_host_setup.


Signed-off-by: Hsin-Yi, Wang <hsinyi@chromium.org>
---
 drivers/usb/mtu3/mtu3_plat.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
index 46551f6d16fd..cdef66141e20 100644
--- a/drivers/usb/mtu3/mtu3_plat.c
+++ b/drivers/usb/mtu3/mtu3_plat.c
@@ -200,6 +200,12 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
 	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
 	udelay(1);
 	mtu3_clrbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL0, SSUSB_IP_SW_RST);
+
+	/*
+	 * device ip is default power-on in fact
+	 * power down device ip, otherwise ip-sleep will fail
+	 */
+	mtu3_setbits(ssusb->ippc_base, U3D_SSUSB_IP_PW_CTRL2, SSUSB_IP_DEV_PDN);
 }
 
 /* ignore the error if the clock does not exist */
-- 
2.18.1

