Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C7B4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7792089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CqvvLovk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7792089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934550AbeFLAVU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:21:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46211 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeFLAVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:21:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so22112782qtm.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=bGa1QubF+VL63ZyqOjzfg2sxhD2JabjZpgmRbPgptac=;
        b=CqvvLovkt+Wpi//Nkaul6ZhlHvJyfYpnXs18NMDnuuFHMkdEPXG/vujOu3oLKDYAtS
         jcfdb85cXAcCQdsug5HmieQkaUMVj2gor+ROrLkfJmQkP/jusLhziKW6ITwoxmUfVWvv
         iR1OzjSG47QNdOMtmTScQsLKM74j2JYrKCApg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bGa1QubF+VL63ZyqOjzfg2sxhD2JabjZpgmRbPgptac=;
        b=TdUvEhq7PquLUkXKsq38oeXDDGIQ/3cjQoi29Zn9sFe6aeEr2h1S7McvtCtFj2jX4g
         /RusYLX2fabr2uR3WDMKSqrIwMFj2BpBbNvmb39TP49/CmVeURl4a2u6QdZ+Rehdh0tA
         PGS0zdQjox4/WM6L1oMrW/z5GSc5k5YAtU4OCTSZmf2hwv1zf8wAlJMZWkDio1Q4zFt1
         u753DLUG4UeazjBZyC6bel29g6sJuiVrZsxehs8qQRqk6ZNHFEFpikqp2NuCylgWX5kl
         eYbjY7RRc2L6umxyO/V3a1voDxYSJULI1djApbmK2i8CWBuZz0nKvbJ1MB9Xu4MEp8Su
         sh1g==
X-Gm-Message-State: APt69E3sG844D4KEzPiibnCx7Zz6DnbMA9xpK++UQNFhQLSTz7OtJgBJ
        d1oKpd3MZ7RkYMyARwdiyphg5w==
X-Google-Smtp-Source: ADUXVKKOLG+8c7SMbWxCEEV+WHIAA61PXCBXmMe9O1XlVZLjFX8L8cBDg9N0EFIsdWSNEFcpKQiRvw==
X-Received: by 2002:a0c:81b2:: with SMTP id 47-v6mr1374405qvd.31.1528762877752;
        Mon, 11 Jun 2018 17:21:17 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31470299qtc.12.2018.06.11.17.21.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 17:21:16 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 0/5] Improve Broadcom PAXC support
Date:   Mon, 11 Jun 2018 17:21:02 -0700
Message-Id: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series improves the Broadcom PAXC support by 1) adding more
quirks for specific versions of PAXC controllers; 2) adding logic to
reject internally unconfigured physical functions from the embedded
network processor acting as endpoint; 3) reducing verbose print level
in the outbound/inbound mapping code

This patch series is based off v4.17 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sr-paxc-v2

Changes since v1:
 - consolidate 2 PAXC related patch series into 1
 - change the way how the capability list corruption is handled, per
recommendation from Bjorn. Now handle and fix up the corruption at
the config register read
 - rebase to v4.17

Ray Jui (5):
  PCI: iproc: Activate PAXC bridge quirk for more devices
  PCI: iproc: Fix up corrupted PAXC root complex config registers
  PCI: iproc: Disable MSI parsing in certain PAXC blocks
  PCI: iproc: Reject unconfigured physical functions from PAXC
  PCI: iproc: Reduce inbound/outbound mapping print level

 drivers/pci/host/pcie-iproc.c | 159 +++++++++++++++++++++++++++++++++++-------
 drivers/pci/host/pcie-iproc.h |   8 +++
 drivers/pci/quirks.c          |   3 +
 3 files changed, 144 insertions(+), 26 deletions(-)

-- 
2.1.4

