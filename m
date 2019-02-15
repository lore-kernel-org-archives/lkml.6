Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63CFB2192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2B2Lr2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbfBOPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:53:49 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:34870 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:53:49 -0500
Received: by mail-pl1-f178.google.com with SMTP id p8so5152165plo.2;
        Fri, 15 Feb 2019 07:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=BNAyIQULOch2oxRm1MowAvaRc8wMMBA8HOdLECedo60=;
        b=U2B2Lr2wwDeSat1za8pMmL0TZD3gRiBVgsWjzLOkmtbLV0dMOTsxk4Phq2UCzNPC8B
         KJxiTN4WHBxfmFys2CkR1g2bshwzu7Oy+/AbnmUk6qUXTketl80JyNzoWJgyn/Cz5usA
         6s/sJ5b+sVYGcRMWLix+ofnzOrrKTMeNkFeqUF06mHwnNKbyV+Ft/qBjKX4S304QWHGS
         QnC9ix7iVc0hKrKl0O71fu8dnnQqVO6kWxIOV+2xi/xhG7cqiCX+hL8yUI/lXLac5eui
         w8sN+vvUnOQlLDFzALb4pAaNgLek94XRsLCWZw5KPXToVSc4jnvlb0QNAF5F8ooIxcAx
         WxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BNAyIQULOch2oxRm1MowAvaRc8wMMBA8HOdLECedo60=;
        b=IDu/cI8nux2CqRz0zQVGqdVnFyVis3mr7xufbzdKXOfA0fGPIBmRAfcSQBnVEu1svz
         6sEebUrICq8ZDX8cYh1fD/jWFpOFVesZ2vq5k1kqWaAvEJhZjBhxGzAbMhz/Fxa448hW
         khU2F+75q2PmOhkFORfqvqvAwulddDnNq+wxK+eU3NVk4AxlmE/YyvKAXHkO+kyCHqON
         tcQ584/gcC1nHLmtu7vuuX8yxPDzzemr5tBnY3AWeW3F2GW7MX1F6D4ECnCrf3m1CWPJ
         rdKhtwdug8aWT8MG3xXzDL3hN5Oc/93DpHq/KWW+yRirLptnOUDO4aSl3AiQLbcaI+s5
         DVwQ==
X-Gm-Message-State: AHQUAube1t58xkAaVqn8AlB10/ApjNl5afw4KwkLN4ExwJmdyGjn78dC
        whIvQsuInmX5DZ2Vr48AsGc=
X-Google-Smtp-Source: AHgI3IYnGWxcjdzFWMa031Ut+5X47a7wz+L7Yiiv34Jv13ZlT1TFHkIhFD5mOq+cUb1691jtAJyt2w==
X-Received: by 2002:a17:902:9a09:: with SMTP id v9mr6444714plp.225.1550246028680;
        Fri, 15 Feb 2019 07:53:48 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v75sm10267969pfa.164.2019.02.15.07.53.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 07:53:48 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 0/4] arm64: dts: allwinner: h6: Enable CPU DVFS(cpufreq)
Date:   Fri, 15 Feb 2019 10:53:34 -0500
Message-Id: <20190215155338.10564-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cpufreq information of h6 to dts, source of information is as follows.

h6 cpu opp info:
https://github.com/Allwinner-Homlet/H6-BSP4.9-linux/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi

axp805 spec:
http://linux-sunxi.org/images/b/bc/AXP805_Datasheet_V1.0_en.pdf

Yangtao Li (4):
  arm64: dts: allwinner: h6: orangepi: Add CPU supply regulator
  arm64: dts: allwinner: h6: pine: Add CPU supply regulator
  arm64: dts: allwinner: h6: Add clock to CPU cores
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

---
v3:
-only update changelog between version 
v2:
-remove the opp of 1.8GHz
-update changelog

I tested the opp table on two H6 boards(with the same axp805 pmu),
but not the pine board or orangepi board.
---

 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  8 ++-
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  8 ++-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 63 +++++++++++++++++++
 3 files changed, 75 insertions(+), 4 deletions(-)

-- 
2.17.0

