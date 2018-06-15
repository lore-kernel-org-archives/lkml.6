Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D27C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D43208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RExculNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D43208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756578AbeFOVBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:01:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37367 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756127AbeFOVBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:01:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so5402967pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FI0VbjORdTz9NgaMNmg3AlyT0fJOQ8zZmKHz2BmAW4A=;
        b=RExculNhMzJAxwwC1YRCIoDpvBkzfRLigOI9OfCPzRZVLkg2TcZ5p8gy6Bp//6f35f
         K36X18U+ealOrwORZ41n31RyqzulDrxEdlATCVEZ6G06sy6VbgldOEA4kP0K8YrBG2qF
         Z8DSHF7LeQGOKmz6s7s0m9UOxK5/a3Y8Wvy3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FI0VbjORdTz9NgaMNmg3AlyT0fJOQ8zZmKHz2BmAW4A=;
        b=D2ueHKuf1T/yTxxO6Iwv9WlOgWMvLyPnsfbOxKdcx8rFnS+y1Pic09LALXw1rE2myQ
         k5a7e9DqqckF+BX1EM++tzUyjw/98GvUGsjXRvNq7G9MgGFpHoRkO3EwrVDtjnxVXMcU
         p768p+tqoMIZlW9bIGBq2dqCVm/+InGlPTDxWFZrx42ZLnvYNeSqMTCW18M2y7bUt5S+
         P33V/alt5JOaBqmcJZXFScOrcmqZXEideVhhv6DmeiVdjNe9NEcXqcQrsYFQKOrKAmsN
         JRTnx+iWHGmGiIz7x5txybAWGb+WPwP7Khw08HqG9kpRpM/QgYASztibdXH7D4f+OOhB
         u0VA==
X-Gm-Message-State: APt69E2fHbsDg9PRwGYNW6JcjDqdI2qpUr/cWbVCXU0XqFgoV6WFyme0
        puhi/kMm0hWgDyDWBoFpKg40zQ==
X-Google-Smtp-Source: ADUXVKIIxxld8jEIWVz4Qeld5MFu5YaYRNEAhZk7GpEd7QsbcgMQ9Ul4Geojs21uciDvfmwqpjgdlQ==
X-Received: by 2002:a63:7847:: with SMTP id t68-v6mr2967563pgc.329.1529096512965;
        Fri, 15 Jun 2018 14:01:52 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id v13-v6sm17664346pfa.131.2018.06.15.14.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 14:01:51 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 0/4] Enable UFS provisioning via Linux
Date:   Fri, 15 Jun 2018 14:00:45 -0700
Message-Id: <20180615210049.126123-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables provisioning UFS devices using the existing sysfs
interface. This functionality is primarily useful along the assembly
line, but might also be useful for end users that receive devices that
aren't locked down.

Changes since v1:
	- Reworked the interface to show each unit of the config
descriptor as a separate directory, rather than the previous method I
had of a file for selecting the unit, and then a common set of files
that interacted with whichever unit was selected. I did some kobject
magic to accomplish this. I noticed from Greg KH's reply to Sayali's
patches [1] that configfs might be the preferred method. Let me know
if I should abandon this series in favor of Sayali's, with the
possible exception of "Make sysfs attributes writable".
	- Squashed documentation changes into their respective code
changes.
	- I decided to keep the config descriptor attributes as their
own files, rather than hiding writes behind device descriptor and unit
descriptor, as I think that's more future proof and true to the UFS spec.

[1] https://lkml.org/lkml/2018/6/8/210

Evan Green (4):
  scsi: ufs: Add Configuration Descriptor to sysfs
  scsi: ufs: Make sysfs attributes writable
  scsi: ufs: Refactor descriptor read for write
  scsi: ufs: Enable writing config descriptor

 Documentation/ABI/testing/sysfs-driver-ufs | 156 ++++++++++--
 drivers/scsi/ufs/ufs-sysfs.c               | 367 +++++++++++++++++++++++++++--
 drivers/scsi/ufs/ufs-sysfs.h               |   1 +
 drivers/scsi/ufs/ufs.h                     |  29 +++
 drivers/scsi/ufs/ufshcd.c                  | 110 ++++++---
 drivers/scsi/ufs/ufshcd.h                  |  30 ++-
 6 files changed, 620 insertions(+), 73 deletions(-)

-- 
2.13.5

