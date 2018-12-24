Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55ED21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZOZAmER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbeLXWA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:00:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40292 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLXWA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:00:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so12538302wrt.7;
        Mon, 24 Dec 2018 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UVK3picnxEN2rlJmIqzlDdlyx6P0B1CQOZKOVIBWBms=;
        b=PZOZAmER3sPxNMpPc/WXdL58IrIRLODqkUw3bojdeQ3GkKKKPv/h7ZsT4fo+4z/hS1
         PHOHfr9KEYDp31+vpVyKdTqZMC6p11vhcTZ8dx8BGDPlocuDSExLak3tvlbd/uMkgJ6y
         eGN4wk74qAh2ref8/V0EiEIUsPTKoSI7+THMjI2gnxO5fSDKjTPeyoEzxFAFJtwkDTTc
         gSdVf9ECJDf5gsqOJpNMCI3RN/gAESsQe0jkz+ZcMgVkyBoWmLRTgIVvYT69Jv12p+xq
         oMSN1UE46oeqdAuO24TcBqZgiCWa8iQNBnJARoRt+blAJdK++QsQjTDGiH72mLgytrqH
         //+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UVK3picnxEN2rlJmIqzlDdlyx6P0B1CQOZKOVIBWBms=;
        b=NHJ19TdsDM8hUM78QDe9sxqr7RwwDPi4dqG36WIA2EzzqZH+nrxxYHewv/H4q4sZHI
         +LZTTCxahlJxwzbd6rFuPI26jVLg0Ndm1wfKN2yg9dwQ7MSQXtUfU+l1uJVZxdLHDXFx
         Ff3+gfDZHi+n4tH2i98imHcnUd0pEl2dfLjGb7Pm1CZp7OUHe/oZsHh8eXYdZBPkCvgb
         l+qQo0veL2zqgMRqtR0PWpRVrxdbXBnQ+FB9WwZDsm/8TnqNwn9fVX5BFPwYQx8giZyN
         QL/RBJcV31dFL2tD3PcBj49k4BXlzF/k6jCea6O0sfHu7dkfnT+Zp8aqxS5GyY/SGbZq
         1oPA==
X-Gm-Message-State: AJcUukfbJIwtJWyQVMTYNBbR8INkOtymTMMgpyyuhtS2olOzKF0a4t2R
        wqtNPBG4UTIkpVKZ+yLFUPc=
X-Google-Smtp-Source: ALg8bN467yOrdPebH2WOjaiAY3PdvXhrHguy4lWN8PvunBAYBSuw1x0bianSlOoMdTk17vkTGh5xBw==
X-Received: by 2002:adf:c505:: with SMTP id q5mr12824650wrf.84.1545688854136;
        Mon, 24 Dec 2018 14:00:54 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:00:53 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 01/14] spi: stm32: switch to SPDX identifier
Date:   Mon, 24 Dec 2018 23:00:27 +0100
Message-Id: <1545688840-23992-2-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
References: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Cezary Gapinski <cezary.gapinski@gmail.com>
---
 drivers/spi/spi-stm32.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index ad1e55d..5f30578 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1,23 +1,10 @@
-/*
- * STMicroelectronics STM32 SPI Controller driver (master mode only)
- *
- * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
- * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
- *
- * License terms: GPL V2.0.
- *
- * spi_stm32 driver is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * spi_stm32 driver is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License along with
- * spi_stm32 driver. If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// STMicroelectronics STM32 SPI Controller driver (master mode only)
+//
+// Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+// Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
+
 #include <linux/debugfs.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-- 
2.7.4

