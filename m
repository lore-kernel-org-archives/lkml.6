Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E05C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D0A24DE2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 04:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QX8ac4qd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74D0A24DE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932644AbeF2EpA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 00:45:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39942 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932408AbeF2Eoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 00:44:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so3624978pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 21:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LH5UDGakN+9Gwbyqc01AIYH53IMT9wHGjwD8rZ/P44A=;
        b=QX8ac4qdOKfemvYTPzT3l8lwt+XnZiqySeeiXNoloI9YBP55xE+ku3zWkoqmntZrHi
         QeTNcwQ2/WhVhh9LfLbOUhIeP3rzUWjbiMjdA7PNJ+j7xOuGb/Viwu7T1wveQmbw+ajN
         yUIIDtBfjkI2XURbWyyvth4sN0Fh5vDJ8RvGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LH5UDGakN+9Gwbyqc01AIYH53IMT9wHGjwD8rZ/P44A=;
        b=sVxkxhrSn1EF5WhBB/LOTv0ifkqeFz7sNzKsV0f33oe+aXaT2FnL4lY0lXtwFEMu2S
         w6o/3b4rKiKZt0xGUQMIo0uyxPLkTISHbvslTxw5wkb+h05TQNxKejk49FWffXfUhB13
         K4uvTShkYm5TYmUH9sKkD8Tf9h1+jhCjk0ECH3ph2gys/MKTw7zmChZYx7+WfOCuqcUP
         D7h0B8sb6nNtFpUV2QpAxo4l5aesU4VpcZbflR4UoRj8cqAXMRORW4REg4rIQmU/KMTg
         /twxhaT0rRUCRp+MhRBamebOIw6g3oTYaSgiA8vEIl9PSxmDakqUUhMrXj42rD/BByxx
         BeAg==
X-Gm-Message-State: APt69E0b6Tn5WVl8fQqWScLX4Miha16WkMsQNU21qOHOr0EaA9HOIHJd
        22QKMQc8v5hSlUIoXCHNp93P
X-Google-Smtp-Source: AAOMgpfpWwmW9khrf97hBG5g2/bLLJdvDRjS1BcddjemBTPj6q1GO3KFRd+jXmmrW61oxuWRlg7AXw==
X-Received: by 2002:a62:6882:: with SMTP id d124-v6mr12869894pfc.122.1530247494878;
        Thu, 28 Jun 2018 21:44:54 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:720b:254d:f4c4:21af:c2bc:89b6])
        by smtp.gmail.com with ESMTPSA id y3-v6sm17625371pge.29.2018.06.28.21.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Jun 2018 21:44:54 -0700 (PDT)
Date:   Fri, 29 Jun 2018 10:14:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de,
        linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
Subject: Re: [PATCH v2 0/6] Add Actions Semi S900 I2C support
Message-ID: <20180629044439.GA29931@Mani-XPS-13-9360>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
 <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76F2EEF1-A266-4E05-8C72-74492928A531@axentia.se>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jun 29, 2018 at 06:13:31AM +0200, Peter Rosin wrote:
> On June 28, 2018 8:10:36 PM GMT+02:00, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >This patchset adds I2C controller support for Actions Semi S900 SoC.
> >This driver has been structured in a way such that there will be only
> >one controller driver for the whole OWL family series (S500, S700 and
> >S900 SoCs).
> >
> >There are 6 I2C controllers with separate memory mapped register space.
> >The I2C controller can handle atmost two messages concatenated by a
> >repeated start via its internal address feature. Hence the driver
> >uses this feature for messages of length greater than 1. In those
> >cases,
> >the first message of the combined message should be a `write` with
> >maximum
> >message length 6 and the second message's maximum length should be 240
> >bytes.
> >
> >As far as the bus speed is concerned, this driver only supports
> >Standard (100KHz) and High speed (400KHz) for now.
> >
> >The pinctrl definitions are only available for I2C0, I2C1 and I2C2.
> >With the mux option available only for I2C0.
> >
> >For Bubblegum-96 board utilizing the S900 SoC, only I2C1 and I2C2 which
> >are exposed on the Low speed expansion connector are enabled.
> >
> >Thanks,
> >Mani
> >
> >Changes in v2:
> >
> >As per Andy's review:
> >* Modified infinite loops to fixed number of retries
> >* Used i2c_8bit_addr_from_msg for constructing the slave address
> >* Removed unnecessary parenthesis around defines
> >* Modified certain dev_warn to dev_dbg
> >* Modified the error handling to more generic pattern
> >
> >* Fixed the return value in owl_i2c_master_xfer
> >* Added MAINTAINERS patch for I2C driver and its binding
> >
> >Manivannan Sadhasivam (6):
> >  dt-bindings: i2c: Add binding for Actions Semi OWL I2C controller
> >  arm64: dts: actions: Add Actions Semi S900 I2C controller nodes
> >  arm64: dts: actions: Add pinctrl definition for S900 I2C controller
> >  arm64: dts: actions: Enable I2C1 and I2C2 in Bubblegum-96 board
> >  i2c: Add Actions Semi OWL family S900 I2C driver
> >  MAINTAINERS: Add entry for Actions Semi OWL I2C driver
> >
> > .../devicetree/bindings/i2c/i2c-owl.txt       |  27 +
> > MAINTAINERS                                   |   2 +
> > .../dts/actions/s900-bubblegum-96-pins.dtsi   |  29 ++
> > .../boot/dts/actions/s900-bubblegum-96.dts    |  11 +
> > arch/arm64/boot/dts/actions/s900.dtsi         |  60 +++
> > drivers/i2c/busses/Kconfig                    |   7 +
> > drivers/i2c/busses/Makefile                   |   1 +
> > drivers/i2c/busses/i2c-owl.c                  | 471 ++++++++++++++++++
> > 8 files changed, 608 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
> >create mode 100644
> >arch/arm64/boot/dts/actions/s900-bubblegum-96-pins.dtsi
> > create mode 100644 drivers/i2c/busses/i2c-owl.c
> 
> Hi!
> 
> I don't know for sure, but over here the arch/arm64/boot/dts/actions folder has no pinctrl nodes at all (v4.18-rc2). So, what is this series based on? The reason I started looking was that patch 2 *appears* to depend on patch 3, and I just wanted to double check that...
> 

You are right. The pinctrl patch [1] is still not merged by the platform
maintainer Andreas but it has been reviewed by the pinctrl maintainer
Linus Walleij. For your reference, I have queued up all reviewed dts patches
in my tree [2] from which Andreas is picking them for 4.19.

For this series, since the dts patches will go through the ARM SoC tree,
Andreas will pick it up once it is reviewed.

Hope this clarifies!

Thanks,
Mani

[1] https://patchwork.kernel.org/patch/10322937/
[2] https://git.linaro.org/people/manivannan.sadhasivam/linux.git/log/?h=s900-for-next

> Cheers,
> Peter
