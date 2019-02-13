Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CFEC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069D0222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfBMJtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:49:52 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44200 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfBMJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:49:52 -0500
Received: by mail-lf1-f68.google.com with SMTP id g2so1250345lfh.11;
        Wed, 13 Feb 2019 01:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HoMGGX+5zdEEa0C02OuypFSvCmkI3tZjRSEsx4Z8vCg=;
        b=AxpOkR2l9K2c0htFSsmSQEmr53gMz6nKRzaW8hKxlQnVRHegO7XNv4LOvQH3dm4rbG
         qmbFqQgomE/qFb+uCUurLXM6pTAgNKbs4aMBVIsVzfPo5b3dDij6N9cy1Ndsrgki601T
         jJCqKfnVudNSoP06PaSDmGAgQU/3FM1t+mAs0N0/l4ELhCLqGksDaDwP8Y13gm8thjO+
         3lMfrHXT4nVQ1ojMJf5A2M5W7kmkm8lQbdQB79+wa+Mld1oygtGm51Nq7INWi+RylpAy
         SSwjrhuRBGWHQyCHpEFQFu9oGkRlbUVAheMiqTXjipzwBp6kImJsysoGOvcm68y3uvb8
         BWAg==
X-Gm-Message-State: AHQUAub/pYG0x3t4TBSngQ1RU8l+/jz8NOhjH/1ljTN+j72SVY/e/aao
        ogVoS8+qahEIi6JMtNdJazs=
X-Google-Smtp-Source: AHgI3IYX6xIV//Ohthm4HGjm1o5MGpVTSRv4WMt1Jivtd4xOVhnaGlg6qkOe16GcYZoPq8ugS/P5pQ==
X-Received: by 2002:a19:cfd5:: with SMTP id f204mr5631035lfg.65.1550051388282;
        Wed, 13 Feb 2019 01:49:48 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h3sm3641536lfj.25.2019.02.13.01.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 01:49:47 -0800 (PST)
Date:   Wed, 13 Feb 2019 11:49:34 +0200
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
Subject: [PATCH v2 0/3] bd718x7: Support SNVS low power state
Message-ID: <cover.1550050645.git.matti.vaittinen@fi.rohmeurope.com>
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

This patch seris adds DT properties for specifying whether to use
SNVS as reset target state and for setting the HW run level
specific voltages.

Changelog v2:
- drop RFC tag
- add handling of SNVS as reset target
- add skipping SW control for critical regulators based on presense
  of regulator-always-on and regulator-boot-on

---

Matti Vaittinen (3):
  devicetree: bindings: bd718x7: document HW state related ROHM specific
    properties
  regulator: add regulator_desc_list_voltage_linear_range
  regulator: bd718x7: Support SNVS low power state

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  15 ++
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  30 +++
 drivers/regulator/bd718x7-regulator.c              | 201 ++++++++++++++++++---
 drivers/regulator/helpers.c                        |  39 +++-
 include/linux/regulator/driver.h                   |   6 +
 5 files changed, 256 insertions(+), 35 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
