Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75BAECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF142083C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 16:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss87ex8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF142083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJVBOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:14:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40118 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeJVBOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:14:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id d2-v6so42360636wro.7;
        Sun, 21 Oct 2018 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Tm0jAIxOJeUyc8Y4ERCd/9gN5LpG7UNHqRcmT+Mp+M=;
        b=ss87ex8+bsjIfdkaFoJI3EyNKnfzjfXbHqxtgNHOJYxqV48AwV1ZxFyCitX0tXS4jD
         n1yz2xOflA0rcZ3yBWQnR6vR9OssK8PhJi2mWSHEX1hFJNO4v5AM10DlogA3ErumMVeL
         CDGOgBr/+O9AMDKNoJmY+E9XLpkp0u70bLXJkHjM3XbM7R5g0mU2Yh8aT7iuKlg98bfO
         7YZi9AUAT2rFcKAN0FbEe+YKaejRqflgVLLB9GQlOU+PXc9nUFOMAeVX1ZmGkhDawJKU
         4gfEL0fw1s7O+a0lDdxuNLSSunfpq79f8JHQyH8UxgkXut+KeSpiEeuQKt3/AYW6k585
         B0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Tm0jAIxOJeUyc8Y4ERCd/9gN5LpG7UNHqRcmT+Mp+M=;
        b=hgqlKOUYIXtq3oGELk45Qr3skqF0r0LQb7rvo2mpE7GhAtM4uiD6hhbapITNvEBbQJ
         k9Z5pYcDfi8e/9YT4fhOP4DirPQts6m9i3RaUxDjjNTJ2gcZMlE7Xv/hMf5BgS6RPUQ2
         FdOmwxkgvcy3FkWLX+ReG1MzfSygIPMbcXjY0KodDB7mu4yrRKFMIhOyDgV/CjZyFrIK
         iLaDf5YpiM4TTBiwrXxrrD1h/d/ib9XkBImEF69rhj2tP8UAQJrrHlHg6AzksbMB/pKn
         njY3fag33vkhP4b/4o6pIGsA7vxCJ6dMwjywhv99a5XgBbxubICnxbBf8Ipx5yZ1oHYc
         JNtw==
X-Gm-Message-State: ABuFfogoY33oxya0Qccd5+pqZc/Xl+r6TTDVJBOSbWmyNqSwfxSQgIm+
        ToPzVmJPx62/af8cbu7s3z4=
X-Google-Smtp-Source: ACcGV63VFUPl8bIjBX8a2W66wnwNgoBQ0us5fk2S4VO2Diwe4TtKURAbRfOR1QWKm1ZJ0MBYmA1XMw==
X-Received: by 2002:a5d:4306:: with SMTP id h6-v6mr44937594wrq.189.1540141152579;
        Sun, 21 Oct 2018 09:59:12 -0700 (PDT)
Received: from localhost.localdomain (175-235-243-213.terrecablate.net. [213.243.235.175])
        by smtp.gmail.com with ESMTPSA id b71-v6sm13437230wma.13.2018.10.21.09.59.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 09:59:11 -0700 (PDT)
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
        Neil Armstrong <narmstrong@baylibre.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Lee Jones <lee.jones@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v4 0/2] Add SECO Boards CEC device driver
Date:   Sun, 21 Oct 2018 18:58:18 +0200
Message-Id: <cover.1539963738.git.ek5.chimenti@gmail.com>
X-Mailer: git-send-email 2.18.0
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

v4:
 - Reduced SMBus timeout
 - Removed/updated debug printouts
 - Removed useless return values
 - Update SECO denomination

v3:
 - Refactored rx/tx for loops
 - Removed more debug prints
 - Sorted headers 

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
 drivers/media/platform/seco-cec/seco-cec.c | 795 +++++++++++++++++++++
 drivers/media/platform/seco-cec/seco-cec.h | 141 ++++
 6 files changed, 967 insertions(+)
 create mode 100644 drivers/media/platform/seco-cec/Makefile
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 create mode 100644 drivers/media/platform/seco-cec/seco-cec.h

-- 
2.18.0

