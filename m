Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCEDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E93B20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cxFyscCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E93B20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504622AbeKXAqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:46:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37747 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504597AbeKXAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:46:53 -0500
Received: by mail-wr1-f67.google.com with SMTP id j10so12452658wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vr2WFONZiJqGma1/1g2X5331BfzPeNGuOHlpWIC/LOs=;
        b=cxFyscCqWha5oiM/qVtq+bI2XsnoHmrL7qI+gCI6ktRPCQtVOWialhCZ4kbeSEPU+d
         4b5YtI2Q5Athy4dx9tPR/WjQNPqtwx6yawxnyCqV43U7EMiEe6CVFzKgjSq7Ew/3mYd2
         004EXbkHpZdm70CxF5z0qS7x21S8nEdEb08MI2Xt9CdTPHG0nv0CiUitTYTIj9aSCVPU
         2AS10+XlEvZuADq0uW9xV4QA4H210yDVEEBMZIU1X8YldQhwvugd6L2yrzEHUJXP2WQq
         hMZIt40oXeYF6fJIs68PJPpC/1vJbOZBqcbGoiFjdvN0rQME4Y4vCeV6o3s+JfUqNRjK
         MdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vr2WFONZiJqGma1/1g2X5331BfzPeNGuOHlpWIC/LOs=;
        b=Mvs3R519bD3k+ZW3T7t8ZeEwdPLE+VFBcMI7S84LsK8I+Y1F34/rUwPFpxMXupWg1C
         8GsmGj8i275ANyxljd1H+uTnPrcBHeHXLeZ23hnBo5MMWqBr96O00M/UDFa2clzgf/1I
         DWf9sFTVn11hGFB8wMEAu1YRZHz/u12KY61XyJAySEl0Sl0J/5eTbgkIMELbQP6UeOrm
         D9SSytWU3CohxI1oerZ/Gg2tDoYu3YEGUv48FWjcVDIbOuwI6FgZxG8Y65XZKUDAP6f8
         r6rJJqegkal68WwopDbYZQNjpgkGShG9WiCuSTTaIhLJRwnfPZ7JOvI13qbMf/2RmAAC
         gd/A==
X-Gm-Message-State: AA+aEWbXB2XPjrxOMY8kjRMh5EJ6dKJQ555GFVC66a6Fs7P0+twVOqsR
        w6sZbqPe526Di6J9LPQIzaDDww==
X-Google-Smtp-Source: AFSGD/VTUBoFsiQOnJWmW91EA4r5A7TQH8GOSl36eRqi6uvFN84op/qdo05XTYp8slbZsgfjGPMuwA==
X-Received: by 2002:adf:ab51:: with SMTP id r17mr13934037wrc.62.1542981752392;
        Fri, 23 Nov 2018 06:02:32 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id x8sm15172185wrd.53.2018.11.23.06.02.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Nov 2018 06:02:30 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/8] drm/meson: add support for HDMI2.0 2160p modes
Date:   Fri, 23 Nov 2018 15:02:16 +0100
Message-Id: <20181123140221.15700-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123140221.15700-1-narmstrong@baylibre.com>
References: <20181123140221.15700-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we support the TMDS Clock > 3.4GHz and support the SCDC Control
operation in the DW-HDMI Controller, we can enable support for the
HDMI2.0 3840x2160@60/50 RGB444 display modes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_venc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 0fbe525b94c8..1bcd642b6e42 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -848,6 +848,8 @@ struct meson_hdmi_venc_vic_mode {
 	{ 93, &meson_hdmi_encp_mode_2160p24 },
 	{ 94, &meson_hdmi_encp_mode_2160p25 },
 	{ 95, &meson_hdmi_encp_mode_2160p30 },
+	{ 96, &meson_hdmi_encp_mode_2160p25 },
+	{ 97, &meson_hdmi_encp_mode_2160p30 },
 	{ 0, NULL}, /* sentinel */
 };
 
-- 
2.19.1

