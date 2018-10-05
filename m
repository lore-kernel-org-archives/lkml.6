Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350ECC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D3220834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWYH5gi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D3220834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbeJFAgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:36:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37305 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFAgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:36:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so2663690wmt.2;
        Fri, 05 Oct 2018 10:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdxhiLR3tttAUka/LOfx19DBAfwKEQ7KWriNfOyE2pw=;
        b=WWYH5gi51fRlY+M8KDNR89l3yT3WCbr15sI7RTaeEiT7U5VgFbeyux9pSsp4rElSBc
         UeOFvnZhUEeovyUYrVRav8poZDmGnzJBN7rtBQhnD5gDulwI0PN/4XncRW1qgI3mtZqa
         OlhdyIY/tCdlYOZmvfZOGIgeAIx9KNvE9Z5b2jhKdCwbKzIaeMp9hxHIjjqxCUzL3VBs
         ekUDFKnZpiy8+0NyerA3PLU6MrqSmuXWYglaLWcpfTSdHAC90c1TA5nEZ1nyRrE5HZEf
         KCStIUPrsOXZoRJR6t6E+NIjr3WUUWgFpmR+aD60Ch7ev6jqQoyzM1EkzQx+hN9oitDQ
         YK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdxhiLR3tttAUka/LOfx19DBAfwKEQ7KWriNfOyE2pw=;
        b=jKRzaINCBilEFypDfTjYOGKWCJW/8y4xi39isnZdwRsJHLgYdWrtSM1nhmT13K4GnF
         8aqpM+R3LvaHELRkQc+QzZ2Uc3ocN6YerI8jEeA1P9rJaBie75jC0WhO/M8cZEBGp3ib
         zPHVGQHoiic8BdVcRb8VPEY2pDwtl1IfaUhA4N25CE74OmL/dvj9AR8scmFCqe5d1s65
         GLVAEF8Y2IOZOXhaUAmNeta4IQ4VRgWYlJvm7cxKp25afxVn2rM3KqU+sTC3iNsQKRZD
         Cv6JgRFeOOCP3i3DEqo/MtKRyWnLNtJSUWRJdvV/oBTrGD9+K+8NhokKFVY38jc0QCxk
         ZGFg==
X-Gm-Message-State: ABuFfog5OiqqiE9zQ+eKGUTmoBuc07WqADJqVW71h+S03hwoILo5J3mg
        Uu+tqKF+M2WyrGd+rYeOy9U=
X-Google-Smtp-Source: ACcGV61sGXwBB9/lj8aLOl42X2hXSacOgqiyhfyBNavvPGVxOcKHDYAdxK7pOTrolifJkmOAekdYWg==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr8142008wmf.114.1538761014580;
        Fri, 05 Oct 2018 10:36:54 -0700 (PDT)
Received: from localhost.localdomain (generic-nat1.unisi.it. [193.205.5.2])
        by smtp.gmail.com with ESMTPSA id t2-v6sm8763269wrr.7.2018.10.05.10.36.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 10:36:53 -0700 (PDT)
From:   ektor5 <ek5.chimenti@gmail.com>
Cc:     hverkuil@xs4all.nl, luca.pisani@udoo.org, jose.abreu@synopsys.com,
        sean@mess.org, sakari.ailus@linux.intel.com,
        ektor5 <ek5.chimenti@gmail.com>, jacopo@jmondi.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 0/2] Add SECO Boards CEC device driver
Date:   Fri,  5 Oct 2018 19:33:57 +0200
Message-Id: <cover.1538760098.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538474121.git.ek5.chimenti@gmail.com>
References: <cover.1538474121.git.ek5.chimenti@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches aims to add CEC functionalities to SECO
devices, in particular UDOO X86.

The communication is achieved via Braswell SMBus (i2c-i801) to the
onboard STM32 microcontroller that handles the CEC signals. The driver
use direct access to the PCI addresses, due to the limitations of the
specific driver in presence of ACPI calls.

The basic functionalities are tested with success with cec-ctl and
cec-compliance.

v2:
 - Removed useless debug prints
 - Added DMI && PCI to dependences
 - Removed useless ifdefs
 - Renamed all irda references to ir
 - Fixed SPDX clause
 - Several style fixes

Ettore Chimenti (2):
  media: add SECO cec driver
  seco-cec: add Consumer-IR support

 MAINTAINERS                                |   6 +
 drivers/media/platform/Kconfig             |  22 +
 drivers/media/platform/Makefile            |   2 +
 drivers/media/platform/seco-cec/Makefile   |   1 +
 drivers/media/platform/seco-cec/seco-cec.c | 829 +++++++++++++++++++++
 drivers/media/platform/seco-cec/seco-cec.h | 141 ++++
 6 files changed, 1001 insertions(+)
 create mode 100644 drivers/media/platform/seco-cec/Makefile
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.h

-- 
2.18.0

