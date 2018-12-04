Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB0DC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7162081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H6ehsH9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7162081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeLDUQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:16:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41731 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:16:34 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so8765822pfi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz9tfpCGadVbQt0yaZ3W+NwXwGShaAhsCq/60kibDD0=;
        b=H6ehsH9Z29rcd4VT1OmZHywObPy6+NiLiXiblRf/vtA72zAB2Rxv/McQ6zYwbSMBYc
         pZeZYJHxKm5CoEn40Zddl1X7qZ5JI1mdAnBHWk04J1leWpP8e+joABQCkG5TI+wF4eZ8
         ZB3j1CIjQ3Xsl1dgsKHiaZMy2icBPw1SC9Xdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hz9tfpCGadVbQt0yaZ3W+NwXwGShaAhsCq/60kibDD0=;
        b=VB/OEAk0fk+lPNvZefzspJD6aii28P5wt0fCqYXFc1cvBYKlh4WUteQcCRe4UOPdEc
         E/OXT6TRGvI8CGmjTRXYGV4FO0/cRxGcW7iLds5tZAz/a4Z/JPBGJGfOcqi7MAOiOb6R
         qFBH8+6crBAkUfyeetsfMM2UbcNfRhUKBZpSatVCBgnAGh2xZlSIGbw0884R4LGHs1+A
         /IjDNz4Byl3HeBT3n8i2GHsPsL5O/Ue1u/qO2euc1HbUejPaGY2m5thuCsv7IfTkP+oD
         4Ytmz6ggvCqjPaeuZVijtGNbRhFqA6UDemu2tJeJi0agLBW/A22ehWN4ia3ZUzwQDW3w
         k4Mw==
X-Gm-Message-State: AA+aEWYW4Hj0ldSRvdl4+wmLUJ0hjH3e26u2NfifCVWzp7VfQ1oRTNgi
        Nw5qhCHApuSPh2ZtgmFDq2gPqQ==
X-Google-Smtp-Source: AFSGD/Ukt2OHnIm2glRWsxOMtCJRSetAjzJeLKg39s1Mag8wkDeH38z2JdGx+S9Xf6cZ0AjhjYE1qA==
X-Received: by 2002:a63:2c82:: with SMTP id s124mr17559213pgs.73.1543954592382;
        Tue, 04 Dec 2018 12:16:32 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b185sm29499593pga.85.2018.12.04.12.16.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:16:31 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH RESEND v2 0/3] Add quirk for reading BD_ADDR from fwnode property
Date:   Tue,  4 Dec 2018 12:16:12 -0800
Message-Id: <20181204201615.245574-1-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the address is
through the device tree (patched in by the bootloader). The btqcomsmd
driver is an example, it can read the address from the DT property
'local-bd-address'.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds the quirk HCI_QUIRK_USE_BDADDR_PROPERTY to
retrieve the BD address of a device from the DT and adapts the
btqcomsmd and hci_qca drivers to use this quirk.

First post: https://lore.kernel.org/patchwork/project/lkml/list/?series=370982

Matthias Kaehlcke (3):
  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990

 drivers/bluetooth/btqcomsmd.c | 29 +++-------------------
 drivers/bluetooth/hci_qca.c   |  1 +
 include/net/bluetooth/hci.h   | 12 ++++++++++
 net/bluetooth/hci_core.c      | 45 +++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          |  6 +++--
 5 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.20.0.rc1.387.gf8505762e3-goog

