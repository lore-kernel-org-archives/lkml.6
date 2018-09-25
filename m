Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B10ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C1C2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oOQ4C+2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C1C2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIZBCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:02:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35516 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeIZBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:02:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so11855239pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CTn+i6ZqxJNXicx/UTn67+UmeGpHreE3kFtIi+rsYvk=;
        b=oOQ4C+2D27mfUkQraKPDQyr2n98PFgXpz3AXnCbJjmDdMKb0SgU9DpRnynn7EZikG4
         ifO/VTO0AVHsdaoPfd7qzb0o7qcZTmMIhR60an9iWmjfycI8rdlIUIcU1MQ7NX+8VgjO
         O1eB0NN66e+spQ6hyYRybtVE8bsuCXHypqrzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CTn+i6ZqxJNXicx/UTn67+UmeGpHreE3kFtIi+rsYvk=;
        b=fvDU3r0nR6MDRCBH9MgFD66NkWycYFUJLweOv26RnBfD+YoMqXlkvi4Ly7tdcCLPbW
         K2ZwCS20auOWCBS2wYO2C4Ds7COZRid9nOeB4C9KAXTxAie2NNlmHgjTIDV7K92FD8qv
         csqFQu4yLWj2Ii4xF/NSUvmIbscD770loI8stv0vkmu4DqZxIE6oWTw+3i+1Gmn8Wm66
         SOUae5DTwLftt5nNFSJqZMc8GEOyFvheTPYcFi2qjO9K4gh+DTU2CLtni7XsYRBGnDsI
         gRRMqxHJZ/tHWwG41jAMUTZ1FBj2XvsKvmr2BXc7i3Jej0sDZtdgogzwXL0KKkzdtjs3
         lxFA==
X-Gm-Message-State: ABuFfojmIVqWdwnBFfeVpplkcVbdBY9YelAQxQMzKmC8pVYZ05l8/RQt
        55GVaeQ1OWWEQtOnMzuQmTF4iw==
X-Google-Smtp-Source: ACcGV60m1pkj821AP8MKVfQmU6aeG2MJNXIVG45OQZSVXwNm0hgVv8j/Gd8Bg+LKV8et3rdY4OW01A==
X-Received: by 2002:a63:5845:: with SMTP id i5-v6mr2249211pgm.272.1537901637668;
        Tue, 25 Sep 2018 11:53:57 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p7-v6sm5208971pfb.101.2018.09.25.11.53.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:53:56 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 0/2] Add API to retrieve the Bluetooth Device Address (BD_ADDR)
Date:   Tue, 25 Sep 2018 11:53:37 -0700
Message-Id: <20180925185339.80701-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
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

Matthias Kaehlcke (1):
  device property: Add device_get_bd_address() and
    fwnode_get_bd_address()

Miguel Ojeda (1):
  Compiler Attributes: naked can be shared

 drivers/base/property.c           | 46 +++++++++++++++++++++++++++++++
 include/linux/compiler-gcc.h      |  8 ------
 include/linux/compiler_types.h    |  8 ++++++
 include/linux/property.h          | 18 ++++++++++++
 include/linux/types.h             |  5 ++++
 include/net/bluetooth/bluetooth.h |  5 ----
 6 files changed, 77 insertions(+), 13 deletions(-)

-- 
2.19.0.605.g01d371f741-goog

