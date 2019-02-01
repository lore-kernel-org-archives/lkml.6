Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45523C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A832146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+EEaovV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfBAV6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:58:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36176 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfBAV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:58:35 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so7113215ljk.3;
        Fri, 01 Feb 2019 13:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHhPwrZPgt6B8pz1XVtHFoanhutQIhbQo9+Di5TCI0s=;
        b=g+EEaovVKU74JDpYiQB6y+Qd5Ccdf+FMfkLWMlQysOWqGoPtnKtThpFgOtsVmTl69J
         j/H14fCVO1js4DIFUX5x2DB2RLTemakBMJ+WVXrR5LZ5BjFgno0XYyXLMlFcxgDu4Ab5
         5GWWLUFzayEPB2jmPUqwyDsKwSy7BV07Mu4V10xIeHuUrrZLJ17gGtReGSvvF6jQNUrV
         8j2PzmrXAh67KRUTEte6oVF9c12NsuK2NwPpvCPEli/t9e/rbIyZaVpae6JPw36LCFf4
         kcfS0gWN/+GhN5HTodamwvg2rahPQ/HMI1rhZcC1Mx8QdCmJME7BJP/GFCD+aCtpSLWu
         vN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZHhPwrZPgt6B8pz1XVtHFoanhutQIhbQo9+Di5TCI0s=;
        b=IVSmlNN1XKEa0qkKezBcV9/yfgo4WJ+HFXenrNT+5PYrx67zndpobccPITjlBKmVaB
         y153xMf/yTnxMnUqcmQGtUEStwP1SqINMCLJ0bLqnhfcM9eiuAZRrx9FheflWPHklbQL
         bHBDiswsQObCDzREbeME7koY5Dnd5z8rX4VrRzhtFlVXz5PlFQQ1FP7l0oJy0K6qmuiZ
         xM2N1ofTkO0FdWq6UxBunaoaDVQDT13kCeml2gq4NseDq0x5M7zeATLDXMu7KqFZoruK
         ROU/Wtjq1GciyJ7FnIkfZjUyE7FukTkvtNdIqK/F/v2z/pB2EpFgPMuPP3IIye4ZnIze
         BGpQ==
X-Gm-Message-State: AJcUukfMEKg/UApTAS5G5P+Ia2wLMAnCb0908vTOg+MzvUBErLh8yy5K
        9Te8RETGvHZDws193yRHKxVnaCD51x4=
X-Google-Smtp-Source: ALg8bN4Q0dFokf7bKboeJ52yT87aZaU8pgfzniNPPKntuvRQyPu0dixCoUNddJXrx2kA6cCIxtKoGA==
X-Received: by 2002:a2e:20f:: with SMTP id 15-v6mr33276064ljc.172.1549058312576;
        Fri, 01 Feb 2019 13:58:32 -0800 (PST)
Received: from arch.domain.name (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id s20sm1567630lfb.51.2019.02.01.13.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:58:31 -0800 (PST)
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jic23@jic23.retrosnub.co.uk, pmeerw@pmeerw.net,
        johan@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH v3 0/3] add support for PMS7003 PM sensor
Date:   Fri,  1 Feb 2019 22:57:56 +0100
Message-Id: <20190201215759.14569-1-tduszyns@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Plantower PMS7003 PM matter sensor.

Unfortunately datasheet is not available for download from the Plantower
website so one needs to find it elsewhere, for instance here:

https://download.kamami.com/p564008-p564008-PMS7003%20series%20data%20manua_English_V2.5.pdf

v3:
* fix whitespaces
* drop unused printk format specifier
* make vcc-supply mandatory in dt binding
* use a generic node name (air-pollution-sensor) instead of a sensor model

v2:
 * check number of bytes returned from serdev_device_write()
   (due to changes in linux 5.0 serdev api)
 * add missing pins descriptions to the driver binding
 * keep commands in the lookup table
 * buffer data and process everything in one go instead of using state machine
 * keep pm offset in channel address to simplify reading measurements


Tomasz Duszynski (3):
  iio: chemical: add support for Plantower PMS7003 sensor
  dt-bindings: add Plantower to the vendor prefixes
  dt-bindings: iio: chemical: pms7003: add device tree support

 .../iio/chemical/plantower,pms7003.txt        |  20 ++
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 drivers/iio/chemical/Kconfig                  |  10 +
 drivers/iio/chemical/Makefile                 |   1 +
 drivers/iio/chemical/pms7003.c                | 340 ++++++++++++++++++
 5 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.txt
 create mode 100644 drivers/iio/chemical/pms7003.c

--
2.20.1

