Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F0CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA1C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 02:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYc8sBJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeLQCiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 21:38:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40318 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeLQCiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 21:38:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so5354882pgp.7;
        Sun, 16 Dec 2018 18:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXDACVh22seFNxE4dT+5fY/aYAArK2yblbN4cXeQJAc=;
        b=tYc8sBJVtV2S+aWq6d8sY5mzNmZaRXxDkjKy2Sx501sEDVzSftthH49ugqkz1EzsSD
         8GQ+IQlicrBg97fF3cRZ9wvkNW7YbfWdWkeIJ3x2LSkzDJM2EXypn6mWjcIVAyDY1ySp
         YWUDlUNl0igY/8CUk0lA8MGRAESgyKjX+zKw06shsV54TfgSV4wEkq9DFQDarw84hYBl
         3TrCXwLSdQQ7xNr0e/3WDuD5NvcdHx67a+Az0bg4VXWncPQpS/KeU8b6qmEKCntkX/I+
         E8rxLOQ9S8jKf6wN5NQCOOtHQ5zejvftj1rRpaZGkSt9yiRBR5MNhnzKaL7y4qARcC1u
         Ti+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXDACVh22seFNxE4dT+5fY/aYAArK2yblbN4cXeQJAc=;
        b=hca5bEwl7SozFkdCaKj1iLfZ+3PbVqwyqNWL1D+FW0vqHyZz9zgIKfPHlrCsfXWK6l
         XjzJQSVTagNu8R0uNZqTUXyvcxcIb8+9G58KNqSAhtQdH2MBlGkucVPN7KubQBaa8QRv
         u7ndKDFhl66UezOsS78qEkH3yfukZUVjaMNb4V2CI2OEzMouLWRfIR4+E0WJ0xk4Vb1e
         WZ61w5UzUG91ue187semvRpNTJC1L2pigR0BDWtDibwdAFI4Mvg/xZ5MdLOViolpMW39
         paXHUbYXUEbzArJgqf4WYYqh4pkPMq3+KFKt/Vey6XWA513YdBgwOEbovut8dCbse4G6
         tgRA==
X-Gm-Message-State: AA+aEWYvyqgvjjNirnqxUGlOPnAiwgo237QwNEathnm7ttQfX6qYmwtZ
        JAmRBiuQsy4KncO1svlpSBPj0JB3
X-Google-Smtp-Source: AFSGD/VbtpAeOuR5JfYKouP2Hg+2XTdGN2+f529vRstfQxKM7EqBX7xsVHnoEBqDIzSHW9s8ZfBGLw==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr10559431pgc.200.1545014329381;
        Sun, 16 Dec 2018 18:38:49 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id b26sm23129781pfe.91.2018.12.16.18.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 18:38:48 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>, p.zabel@pengutronix.de,
        Fabio Estevam <fabio.estevam@nxp.com>, cphealy@gmail.com,
        l.stach@pengutronix.de, Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/3] Reset controller support for i.MX8MQ
Date:   Sun, 16 Dec 2018 18:38:24 -0800
Message-Id: <20181217023827.7947-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone:

This patch contains changes I made in order to add support for i.MX8MQ
to reset-imx7.c in order to enable support of PCIE IP block on i.MX8MQ
SoCs.

NOTE: This patch depens on CONFIG_ARCH_IMX8MQ introduced in [imx8mq]

Feedback is welcome!

Thanks,
Andrey Smirnov

Changes since [v2]

 - Constified "variant" field in struct imx7_src

 - Moved dt-bindings/reset/imx8mq-reset.h to be a part of the patch
   documenting DT bindings

Changes since [v1]

 - Series re-written to use a per-variant LUT instead of using a
   single table

- Changed driver to use "imx8mq" insead of "imx8m" to match other
  drivers and CONFIG_ARCH_IMX8MQ

- Updated list of exported i.MX8MQ resets, add missing and remove
  bogus ones (hopefully nothing is missing this time)

[v2] lkml.kernel.org/r/20181128043738.12714-1-andrew.smirnov@gmail.com
[v1] lkml.kernel.org/r/20181117181131.9330-2-andrew.smirnov@gmail.com
[imx8mq] https://www.spinics.net/lists/arm-kernel/msg687293.html

Andrey Smirnov (3):
  reset: imx7: Add plubming to support multiple IP variants
  dt-bindings: reset: imx7: Document usage on i.MX8MQ SoCs
  reset: imx7: Add support for i.MX8MQ IP block variant

 .../bindings/reset/fsl,imx7-src.txt           |   7 +-
 drivers/reset/Kconfig                         |   2 +-
 drivers/reset/reset-imx7.c                    | 166 ++++++++++++++++--
 include/dt-bindings/reset/imx8mq-reset.h      |  64 +++++++
 4 files changed, 220 insertions(+), 19 deletions(-)
 create mode 100644 include/dt-bindings/reset/imx8mq-reset.h

-- 
2.19.1

