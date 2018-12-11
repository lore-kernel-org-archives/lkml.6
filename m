Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC6DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819E420672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyKm1u/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819E420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbeLKGCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:02:18 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46619 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLKGCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:02:16 -0500
Received: by mail-vs1-f68.google.com with SMTP id n10so8178815vso.13;
        Mon, 10 Dec 2018 22:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1bT4gHieCuXM7O8hpEoAf+010TtD3oV3pq5JZwJ+hI=;
        b=PyKm1u/OYwNSmGbKimVyu3CNQwZBSpGbPDA0GgQsQpHToDTm74S+DXepw3tY4wq5Hf
         0FDRdV6wu2Eu3x5a9WhJPZUfCZxGCskOxzXFIHgOEm3iu+40E5oxTpysoxKs6emCw0wO
         jSEcAuandS3mTZPlcEC1y1hmmxwgMqcyFfJEiOokkIIqrbd/TcUeVqo8AcOHId2hl6Bj
         kjEy4oOD84rG+offZ9IOs4p/aWgH+GMvi56rEwXBBGVhTEcqrN73TD1uBUshA1orynro
         BkCRgLKQDgerzex7oG70mCY2QLStvw/MVmI681JLknNfcbfjbYTOgBxEiw4b6i6YARWR
         9ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P1bT4gHieCuXM7O8hpEoAf+010TtD3oV3pq5JZwJ+hI=;
        b=dVuqeMdK79vggNbC7mGSMmdO/BnMhaWOFUuJHSEyj8ZqfrXVIPmc0hzFmol6slNath
         dxinGkReIiYqjn116Pkj0gbPwDbstEhBOkteMUBbIPYPHWMZfvvBgHS6w7paKwHe2XFD
         HkbC5dJc3BFt3pFl08Viij8zKD5zpm9jBwgTf3pmgmuxSXz+/bCnmDFUnFE+XExCJI7V
         qxinrZQVCSmAHYDwUUthyeTS+83ulymul91eOYUsyXvRpB/jBQxZGQ3uZAfs/s/c2NkL
         d8JjrDGkOPq33jmZdPJWqeCuHDEbz77sywDfXGwmf4f4ZJBhzsoLsZd3yF0OxAH3N1/x
         DmRg==
X-Gm-Message-State: AA+aEWZFYgh9rE9DNtrAtUTq8jTARuSyNcCpgw2cQoCjJ3fM45qcDjDW
        7N/9xUpmY3nrR/k3+kh4SQ==
X-Google-Smtp-Source: AFSGD/UodvBzuABCqgnkDV3Hhp68/P1rQb+NhcisCuPTQ8T422YMKshmbP7tosCWAq/tR4NOXSnyxw==
X-Received: by 2002:a67:8cc2:: with SMTP id o185mr6528692vsd.55.1544508135030;
        Mon, 10 Dec 2018 22:02:15 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a137sm5700765vsd.24.2018.12.10.22.02.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:02:14 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     ayman.bagabas@gmail.com
Subject: [PATCH v10 0/3] Huawei laptops
Date:   Tue, 11 Dec 2018 01:01:19 -0500
Message-Id: <20181211060125.28671-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is based on the new audio LED triggers in topic/leds-trigger branch from
        git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

Changes in v10:
* Use ec_get_handle instead of acpi_get_handle since we are using the ec device
* Switch to WMI0_EXPENSIVE_GUID and wmi_query_block to fetch keycode when WMI0 is used

Changes in v9:
* Explicitly use NULL in acpi_get_handle
* Drop __initconst from huawei_wmi_keymap

Changes in v8:
* Switch to wmi_driver
* Use devm to allocate and manage devices
* Skip registering LED subsystem if a ACPI controller method was not found

Changes in v7:
* Use audio LED triggers patch set
* Use KEY_CONFIG (XF86Tools) instead of KEY_PROG1.
 In Windows, the key is used to launch Huawei PC manager. XF86Tools is
 used by default on most desktop environments i.e. Gnome.

Changes in v6:
* Review tags

Changes in v5:
* Consistency in file names
* How module would be enabled (Kconfig)
* Match license in SPDX and MODULE_LICENSE 

Changes in v4:
* Code formatting

Changes in v3:
* Support for Huawei MBX
* Style and formatting issues

Ayman Bagabas (3):
  ALSA: hda: fix front speakers on Huawei MBXP.
  x86: add support for Huawei WMI hotkeys.
  ALSA: hda: add support for Huawei WMI micmute LED

 drivers/platform/x86/Kconfig      |  17 +++
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/huawei-wmi.c | 220 ++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     |  22 +++
 4 files changed, 260 insertions(+)
 create mode 100644 drivers/platform/x86/huawei-wmi.c

-- 
2.19.2

