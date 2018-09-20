Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C982ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4142621533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m5jjHK8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4142621533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbeIUEUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:20:38 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37929 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbeIUEUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:20:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so5028949pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z8CIvxrAHyRGb2AyIYOLeEW1yTMR7/vrBhDyK2caO0=;
        b=m5jjHK8+bcF+kLZ7z0wnvXUawEmW5K5v4gWjWdKVTzhpdrxuTqNIMwks7v+5PZ4M0z
         MP7SOMAmMKs+8uRr9d1F7BHkmnri5Bu8d2+SfoxLBSnpkCIJ4IJ70VDit+ORbt1YUxec
         iT9XQp51qxXhtFW0unkNt8tKQ41KsarMkGJ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/Z8CIvxrAHyRGb2AyIYOLeEW1yTMR7/vrBhDyK2caO0=;
        b=ruHszIf9wNwQ2VcWIXX0KPtbi3/g1pE3TmMOfiIrAmc1i/99U719tsdTuMaFcuhtpX
         UBjKQ1YUluthpg42/TsNaqdCDWtwPQGoONsDFWPZ6Si3x5kg+p86aqUp7rO4q1ANi8TC
         eYuAmwQyodLB6xHVOY8V4wl5Svfw1v89g1d5rm6WfXsZYJz074mri0GfqoQiePHfXV8q
         LEgrWbqoLBvuHw/a67OeFNoDPVO/ueb5G44YTdUh+SKiG894Y4lRTSC2DKMqB8k3eYcP
         JhdB0eyHoAZ5HFiJvxnCggKPqbvUp1LQ4Lhu0BjbfFY04JRz/ns9aEkyO9UDOPR5dSob
         wVhg==
X-Gm-Message-State: APzg51Dhv3KoNl9q77BAWFJXmVnhdLVZh4NseCEdvUOti5D/fhrfvaJJ
        mVqODI0gSD6CEus2gHUiBzgX2A==
X-Google-Smtp-Source: ANB0VdbArV4kJ4KhaNtihJfoy7/CONjfzXGL0Wax/QDHv0ffSO22/8b1NwYICgV0hTcCQVGL0IHn+w==
X-Received: by 2002:a63:a745:: with SMTP id w5-v6mr38306572pgo.374.1537482894127;
        Thu, 20 Sep 2018 15:34:54 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g11-v6sm31366696pgi.90.2018.09.20.15.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:34:53 -0700 (PDT)
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
Subject: [PATCH 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Thu, 20 Sep 2018 15:34:34 -0700
Message-Id: <20180920223436.202454-1-mka@chromium.org>
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

 drivers/base/property.c       | 49 +++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqcomsmd.c |  5 ++--
 include/linux/property.h      |  4 +++
 3 files changed, 55 insertions(+), 3 deletions(-)

-- 
2.19.0.444.g18242da7ef-goog

