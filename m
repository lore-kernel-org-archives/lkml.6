Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BDBC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7FEA217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeLTLtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:49:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41536 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729294AbeLTLtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:49:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so1263088ljc.8;
        Thu, 20 Dec 2018 03:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=++fE5WyfRp7p5RmtKlaYKvepWNvJLvA8fbe9SppA5KI=;
        b=QleYexJD4UgoVU3OWRS5hFs0uH2n7xMtzjvn7KJRLiwzPn9VaIJIjQFUmSsRu2Jioe
         9uyTWGYOTei1IgdeVnlOWq/+KuccupCznjO3W9e5HsmZ4R2qfGw8dwdw/9+0IlazZeuq
         NnlrJGMRlAIfCjzjF0sbJH0bpSyM3NBDnRQFqCn5nEiapwEhVdX+2nXoVRx5V6zz4fhr
         sLvbfNNiTlE0jXmhiDJOVNgOqXYnm185/PPZNmq+pjXjaXxGnG9Wg3bU/SlyrZ+MmZhA
         Ts1risScJdZ9NTY/dLEIDz3Q1iDIOoQoCVmT2YtfJysYkv1nmK8hhfY9xt0keY9Uz11Z
         ULCw==
X-Gm-Message-State: AA+aEWZSg+GlSduJyZmT3TTuLEK0pxwkHhb7eAB2I8owR40BzWkwS2Nm
        SxtjwTDklAcYeJWtZPvi6UQ=
X-Google-Smtp-Source: AFSGD/XPGNmR1iS5gnJpFLIdSVp2NEcCXFzhAVZel1q0LMX3QpWdgdL1LkiZp/pBxXgFqjyGrA89EA==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr15082789ljg.155.1545306539932;
        Thu, 20 Dec 2018 03:48:59 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id s127sm4402673lfe.8.2018.12.20.03.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 03:48:59 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:48:56 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     sboyd@kernel.org, andy.gross@linaro.org, david.brown@linaro.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, matthias.bgg@kernel.org,
        heiko@sntech.de, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Regmap support for common clocks
Message-ID: <20181220114856.GH2477@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike, Stephen & All,

I am working with device drivers for some ROHM components. Recently I
clk did a driver for bd71837/bd71847 PMICs. The PMIC is connected using
i2c and contains a simple clk gate. If the connecting bus could be mmap'd
I would have used the clk-gate provided by common clk framework. But as
it is i2c I ended up making the driver and enable/disable functions myself.

I am now working with next PMIC - which once again has similar clk gate
in it. I could write new driver again - but it feels a bit stupid as it
would be mostly just a copy-paste of bd71837/bd71847 - driver.

I first thought of doing regmap based 'clk-gate, clk-div and clk-mux'.
But after some googling I found

https://patchwork.kernel.org/patch/5955831/
https://lore.kernel.org/lkml/1434464615-9080-1-git-send-email-matthias.bgg@gmail.com/

and reading comments makes me to assume there would be more...

Current way seems to be that we have vendor/platform specific sub
folders which all seem to more or less implement own regmap-based basic
clocks. (Well, I randonly skimmed through the qcom and meson subfolders
and aty least they did - I guess same holds with others).

I sure could create 'rohm' subfolder and build up the 'basic clocks
using regmap' there - and put ROHM component related drivers in it. But
that does feel really stupid. Maybe the series worked by Matthias (last
link in the mail) could be reworked - or maybe we could drop one of the
platform specific regmap implementatios from subfolder to generic
portion? I think that for example moving the

drivers/clk/qcom/clk-regmap.c to
drivers/clk/clk-regmap.c so that it could be used without enabling
qualcomm clk configs would be a good start.

Seeing the number of chips connected with i2c/spi/... increasing - and
seeing the comments from community when Matthias sent his patch series
- I'd say the basic clocks supporting regmap would be very welcome...

But maybe I am missing something? I would like to start working with the
clk driver for the new ROHM PMIC - but I would like to take sane
approach. Any good adviece on how to proceed?

Best Regards
	Matti Vaittinen


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
