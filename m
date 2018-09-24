Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49208C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047772087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EzezjHM3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 047772087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbeIYBis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:38:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41178 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbeIYBis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:38:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so4688621pgv.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7DbMj9cPLA/wH1eC3vGrKUSlQEjo0U4OMyKE56JmYs=;
        b=EzezjHM3Id2i0blaa4lgfQ4YrUgctMoalCoQUT7vPnSZIV8CDeFWl5QvpIGl6wcJzh
         PNf4rSAjS1+mrnXXSBv58NRGylF0LVEDRb82vnyiFa13p6Q4+2uVPnu3z5ekHjkHYEBA
         e9n3wIOi3K6KMuB9snNGEE3ngkfVgR1bZZXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r7DbMj9cPLA/wH1eC3vGrKUSlQEjo0U4OMyKE56JmYs=;
        b=SPWjwNf3qjoBue9QATmQwXfI3jUSu5sVC/R3FGM0wJmWMfMAZxr+vO/luu5NZJdXus
         PjaMD8XVnkZBzUwMj1ki27mi8fsIe/Mw156b0yxrOayK6CeL28tadxw1oEsyk1PBx7lA
         /vKjMI/97vqNOYY4/A4rNf+OTJYRyFs55M7Azs339WJ3KD3No4Pflldp0t3TZgrVjCfZ
         HhmGK0916NQuHAH2ZK7cfkT7rnWozgAg1VVxar08m+bjCq2coLxec45D+UKQ7kQjnETI
         ZA8ZByn3qzzw+4nLW8PJvYjCX7g91K71+TewTJt6bZiDL7eRsbCVYjdpbxVt/oVyZ8RP
         OQQA==
X-Gm-Message-State: ABuFfogjuadtHMwsWWKk8L74JhGUAGEfEUAwIi/jiTPCCa7w3LoP78N+
        4l1M+YuBUnU5/VAMzWFlotq6FA==
X-Google-Smtp-Source: ACcGV625DnfScF30xSyERn6KKbc/FGgB31r3hLvxxHYiysrOm0N1vLJyZFj/MRUeARN3LOJ2oSerbg==
X-Received: by 2002:a62:6699:: with SMTP id s25-v6mr278447pfj.84.1537817703365;
        Mon, 24 Sep 2018 12:35:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm112234pfw.159.2018.09.24.12.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:35:02 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Mon, 24 Sep 2018 12:33:50 -0700
Message-Id: <20180924193352.96335-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems the Bluetooth Device Address (BD_ADDR) isn't stored
on the Bluetooth chip itself. One way to configure the BD address is
through the device tree. The btqcomsmd driver is an example, it can
read the BD address from the DT property 'local-bd-address'. It is
also planned to extend the hci_qca driver to support setting the BD
address through the DT.

To avoid redundant open-coded reading of 'local-bd-address' and error
handling this series adds an API to retrieve the BD address of a device
and adapts the btqcomsmd driver to use this API.

Matthias Kaehlcke (2):
  device property: Add device_get_bd_address() and
    fwnode_get_bd_address()
  Bluetooth: btqcomsmd: Get the BD address with device_get_bd_address()

 drivers/base/property.c       | 46 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqcomsmd.c |  4 +--
 include/linux/property.h      |  3 +++
 3 files changed, 50 insertions(+), 3 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

