Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EBA20821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VUFIZZO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfBEGTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:19:11 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46353 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfBEGTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:19:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so1865032edt.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Vvd3nR7p14N8GxyMXTUjYz5uA5/B2tjh0nCeOlhyFSM=;
        b=VUFIZZO1Xc91ETEBoJR6uAsrKO1idUqGdpaWE2ek9TgRMaxm+IqnsEVbuqpXOEpn3o
         ZrfyuomqwsonmtWkymCEScztazAhbjYdr94RPKJ5bZPrgvGaJg3lTxoSsSjVGvAMp3xj
         68Pq3RYA6lGBiS7YbSb7a4LlnDbszC46wMWfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vvd3nR7p14N8GxyMXTUjYz5uA5/B2tjh0nCeOlhyFSM=;
        b=eO1DMxXNowvX9VUIlfObwWTo15eWFgiMdBVUEsLM+jq941HzNXmo2+nSlThJKoPppW
         mNpsAVZHjNMfm5iFbjy968mDjpsNjpmWQ+iOHx67c1ez8B237Mrn9hL15F77KaTMIwpz
         LqlyOX4q3EPGz2L0SNzKMPwgdlXo+UPUuRe/QcwlzLUp2xibKLPXp2ZxX7wCuviigCpU
         Ug8+gIWMhKu30dLEEP9fM+to2uepks/UYnljNZhTxQJz+CuUXxC4xRC7B/bMzxRfj4HP
         +6z/TSv4P+oodztPV+QEQ9+kF/AR6E7AnWSoIreJ0UpbwRtg/Nt8cUEIVFvAqrGY3lSf
         Rp0w==
X-Gm-Message-State: AHQUAuaQJisyDOyW6gbiAIaYGLxBr8MH1cpvmUGMgGMaDg/SK4BTX68s
        mDmWZ5XCd1slrWmVUYUAd/UiIg==
X-Google-Smtp-Source: AHgI3IY1Vxve64KwwM0vMMX2C5t5SSItjk6GGFkyf6LY0kW0irNJ7eWYUXJzCtyLjEvRfEPChFt4WQ==
X-Received: by 2002:aa7:d749:: with SMTP id a9mr2445593eds.223.1549347548795;
        Mon, 04 Feb 2019 22:19:08 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t26sm2835120ejs.48.2019.02.04.22.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 22:19:08 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 0/2] Reset xHCI port PHY on disconnect
Date:   Tue,  5 Feb 2019 11:48:52 +0530
Message-Id: <1549347534-11320-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds a quirk in xHCI driver to reset PHY of xHCI port
on its disconnect event.

This patch set is based on Linux-5.0-rc2.

Srinath Mannam (2):
  dt-bindings: usb-xhci: Add usb-phy-port-reset property
  drivers: xhci: Add quirk to reset xHCI port PHY

 Documentation/devicetree/bindings/usb/usb-xhci.txt |  1 +
 drivers/usb/core/hcd.c                             |  6 ++++++
 drivers/usb/core/phy.c                             | 21 +++++++++++++++++++++
 drivers/usb/core/phy.h                             |  1 +
 drivers/usb/host/xhci-plat.c                       |  3 +++
 drivers/usb/host/xhci-ring.c                       |  9 ++++++---
 drivers/usb/host/xhci.h                            |  1 +
 include/linux/usb/hcd.h                            |  1 +
 8 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.7.4

