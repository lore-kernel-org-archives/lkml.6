Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5912186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfBLOQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:16:52 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45616 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729954AbfBLOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:16:51 -0500
Received: by mail-lj1-f195.google.com with SMTP id s5-v6so2322412ljd.12;
        Tue, 12 Feb 2019 06:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XVxCSh3dYC+FXXwAk8lzA6hyzfU9vHFelmxuysp1HzA=;
        b=LSasf7NMaplbgxf3z6Wa11HGnVyiKbn8R4C+Q5Obq13duZDglxAXvp3KYB/nQrcCCh
         AGl13hRva2IIVsi9YIUlWAFDNFKj75+4GMb9oFNwzVKQp4HyocI8av2xMoVdqtF30I8d
         0km8YOWechmUGUDh4zR1Xwu71pntlPexp2+Dp7sb00Jz9xg6TEN5oo2NbpGFiWsfO0Qh
         la2WU9heFU93JhqJUzN19Um9xVfQuUmsl1hm8rUm8/lFc1eRIVdjcLuBaU4kLVdexr5F
         zktZlNGLtt7wrpxT8JEcr8XPVaULbe1T643mhQBKJnEkqAfShABW3mP0i84wKhKVGsMY
         rYrg==
X-Gm-Message-State: AHQUAubXKLf74C79buw9WrNKRTUK6izqos/NG3fACsUdpbcGydzh9uHZ
        oWiC3C1oexb04NQgTMrcoc4=
X-Google-Smtp-Source: AHgI3IagwhXF7qrAmgfmVBlOSRWt9tqXRYowPd/LUyMujbaaqVZfKjb2IAW1ke49TWvS7i1tMJXYag==
X-Received: by 2002:a2e:92ca:: with SMTP id k10-v6mr2481492ljh.63.1549981008454;
        Tue, 12 Feb 2019 06:16:48 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p14sm2968937lfk.16.2019.02.12.06.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 06:16:47 -0800 (PST)
Date:   Tue, 12 Feb 2019 16:16:35 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com,
        Robin Gong =?utf-8?B?4oCO?= <yibin.gong@nxp.com>,
        Elven Wang =?utf-8?B?4oCO?= <elven.wang@nxp.com>,
        Anson Huang =?utf-8?B?4oCO?= <anson.huang@nxp.com>
Subject: [RFC PATCH v1 0/3] bd718x7: Support SNVS low power state
Message-ID: <cover.1549980347.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding SNVS power state support to ROHM bd718x7 driver.

The SNVS is a low power state used by i.MX family of SoCs. In SNVS
state processor and most of the peripherials are shut off in order
to minimize power consumption.

BD71837 and BD71847 can be configured to use the SNVS state as a
reset/shutdown target state. There is some HW limitations though.
Main limitation is that regulators which have been under SW control
(regarding enable/disable state) will stay shut down after such reset.
Thus if SNVS is used as reset target the control of boot crucial
regulators must be left to HW state machine.

This patch seris allows one to describe the boot crucial regulators
and reset/shutdown target state as well as the default HW state
voltages from device-tree. I am unsure if the device-tree is the
correct way to bring this information and hence I send this initial
patch set as an RFC. Please comment and I will generate properly tested
patch series on top of this idea if this is seen as a reasonable
approach.

---

Matti Vaittinen (3):
  devicetree: bindings: bd718x7: document HW state related ROHM specific
    properties
  regulator: add regulator_desc_list_voltage_linear_range
  regulator: bd718x7: Support SNVS low power state

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  17 +++
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  36 ++++++
 drivers/regulator/bd718x7-regulator.c              | 135 +++++++++++++++++++++
 drivers/regulator/helpers.c                        |  39 ++++--
 include/linux/regulator/driver.h                   |   6 +
 5 files changed, 223 insertions(+), 10 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
