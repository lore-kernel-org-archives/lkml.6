Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6124AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FB721738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JzcH2CTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbfBSUGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:06:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45009 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfBSUGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:06:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so10620193pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 12:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fjaVe2IWAjjmpinqrQyhO+TSntXi4mEIVbc/jdZCkw=;
        b=JzcH2CTX7Jza5c+4Su+PGpBbzoAXz3W58Lvdp0KY2jWbnt8b9eYrCr2is9cj9hotdo
         P6B+Vw4GuRyZpgikr/gvEvOlorE8uaGbr1SWKKF6PD2Smmq0frzkjBih/u2U0gd0AQGK
         6AX0flMrOgKbt+zSF5zNYxNb5JePCO+wol3Dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6fjaVe2IWAjjmpinqrQyhO+TSntXi4mEIVbc/jdZCkw=;
        b=iqrKg+NUiovTq8rVAgk51UNsq1R8RDBlyO/CtL/ib/Ri3qJDtsRiDzMd0OV0qoIhuL
         tvfBh7bEQowy1y7slfIaXvC/4lPzHDMEsjrCFTkqxOlyv95HhU0enfUf4kLro8kNldhD
         ArqY7mgH2bCPgm3SgspsMOePWdEM96OgBW3iRhEJq4fdMiufyrEjvQQ0M9mzapEmkqPH
         0Z/kLLlHawat7CBvnEV82pFdpRUTr2z7iaKq2HyqsGVDoC7d9gVbw4yFdVINCu/rEzXg
         B2D+hF0hzdXM9xJtVm1FasoGyj6wNQnmunXVOqR+3ZYXoUwk0T7/zxBWuT+iacrS41Te
         B28Q==
X-Gm-Message-State: AHQUAuZlZBf9iUhU3lOVi5MmbVT5g44hsI6FVU/HuWKVJxi/6mpRqdZX
        ykxHKkjgYfm8GAzJiysh/UEIOQ==
X-Google-Smtp-Source: AHgI3IYJxtI1kove61qhi04/fev9fsMWoilnBKzuhdhOkE9BqNqkt4khMHxXvjHq/Z5I+YpamhPDYQ==
X-Received: by 2002:a65:6553:: with SMTP id a19mr25810247pgw.267.1550606797745;
        Tue, 19 Feb 2019 12:06:37 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s73sm50115476pfi.124.2019.02.19.12.06.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 12:06:36 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 0/3] Add quirk for reading BD_ADDR from fwnode property
Date:   Tue, 19 Feb 2019 12:05:56 -0800
Message-Id: <20190219200559.13079-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
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

Matthias Kaehlcke (3):
  Bluetooth: Add quirk for reading BD_ADDR from fwnode property
  Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
  Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990

 drivers/bluetooth/btqcomsmd.c | 31 +++----------------------
 drivers/bluetooth/hci_qca.c   |  1 +
 include/net/bluetooth/hci.h   | 12 ++++++++++
 net/bluetooth/hci_core.c      | 43 +++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c          |  6 +++--
 5 files changed, 63 insertions(+), 30 deletions(-)

-- 
2.21.0.rc0.258.g878e2cd30e-goog

