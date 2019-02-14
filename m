Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49EEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797F22229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437809AbfBNJeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:34:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39408 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388196AbfBNJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:34:34 -0500
Received: by mail-lj1-f195.google.com with SMTP id g80so4614409ljg.6;
        Thu, 14 Feb 2019 01:34:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZeUnetqvuA+PqiTe8imsP6iY5EBsg84BOkF6NC5DMOQ=;
        b=Qbxg+MVqhtBx8RTypxyrkBC7iUBsHUqgXLh+Nw2YGSXcCg3zaZMfjtDjpaitJldtO6
         AxV9W7MnzQEa3roHUc4eVLIY5hueROaeBILrVWS6nzGsQRHgcBVOtruoCaN7pz4ap+lG
         sbOzJ48hmEiAQvvBQ1E6587ASephzo7585i1WeundQCrMgQwZcy1pA2ILQlSQNq7NRDI
         DpjKj5/ouNGUO7upog1bpU5QO4mZIE1ibFVUwpAWLIfu+RysW5V3saKMkcX4676NOCYT
         ZGRGDK9hAPoQykdJfBwxYdt+UDhh+I6AsHyaRCz8XHPTUkFoBhvN3e1togiLX+O84gYu
         39Mg==
X-Gm-Message-State: AHQUAuYz3Wzq/dY9LPGGCqD4Gev5STt8tQk2OdWVaNsp8dH16nfPPLhv
        w6/jCr0lYtwFFHEbAhmMz7OKeYMi
X-Google-Smtp-Source: AHgI3Ibg672CD6QprUzl8emdd7X1rM2fKBHSjg5zD3clLS2qZPMmIiSGolgSViTqfTngIKs7LTXrvQ==
X-Received: by 2002:a2e:3a10:: with SMTP id h16-v6mr1777219lja.184.1550136872163;
        Thu, 14 Feb 2019 01:34:32 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id k68-v6sm341509ljb.35.2019.02.14.01.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 01:34:31 -0800 (PST)
Date:   Thu, 14 Feb 2019 11:34:19 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazzisaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com, Robin Gong <yibin.gong@nxp.com>,
        Elven Wang <elven.wang@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>
Subject: [PATCH v3 0/3] bd718x7: Support SNVS low power state
Message-ID: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
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

Changelog v3:
Patch 2 unchanged
- DT bindings SNVS rest description improved(?)
- Added optional HW state properties in usage example
- Fixed a bug from DVS voltage settings (buck 1 was initialize with
  voltag from buck 2 and buck 2 was uninitialized) - thanks to Angus
  Ainslie for reoporting.

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

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  17 ++
 .../bindings/regulator/rohm,bd71837-regulator.txt  |  38 ++++
 drivers/regulator/bd718x7-regulator.c              | 201 ++++++++++++++++++---
 drivers/regulator/helpers.c                        |  39 +++-
 include/linux/regulator/driver.h                   |   6 +
 5 files changed, 266 insertions(+), 35 deletions(-)

-- 
2.14.3


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
