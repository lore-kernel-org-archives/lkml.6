Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753641AbeCQSUF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753478AbeCQSUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:20:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BD2F21737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 18:19:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: Manish Narani <manish.narani@xilinx.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, michal.simek@xilinx.com,
        lee.jones@linaro.org, broonie@kernel.org, arnaud.pouliquen@st.com,
        quentin.schulz@free-electrons.com, linus.walleij@linaro.org,
        ksenija.stanojevic@gmail.com, arnd@arndb.de, martenli@axis.com,
        jan.kiszka@siemens.com, lukas@wunner.de, vilhelm.gray@gmail.com,
        geert+renesas@glider.be, fabio.estevam@nxp.com, jackoalan@gmail.com,
        mnarani@xilinx.com, mike.looijmans@topic.nl,
        alexander.sverdlin@gmail.com, jacopo+renesas@jmondi.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] iio: adc: Add Xilinx AMS driver
Message-ID: <20180317181936.14468be2@archlinux>
In-Reply-To: <20180316201925.GA18013@himanshu-Vostro-3559>
References: <1521124947-18950-1-git-send-email-mnarani@xilinx.com>
        <20180316201925.GA18013@himanshu-Vostro-3559>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Mar 2018 01:49:25 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Thu, Mar 15, 2018 at 08:12:27PM +0530, Manish Narani wrote:
> > The AMS includes an ADC as well as on-chip sensors that can be used to
> > sample external voltages and monitor on-die operating conditions, such as
> > temperature and supply voltage levels. The AMS has two SYSMON blocks.
> > PL-SYSMON block is capable of monitoring off chip voltage and temperature.
> > PL-SYSMON block has DRP, JTAG and I2C interface to enable monitoring from
> > external master. Out of these interface currently only DRP is supported.
> > Other block PS-SYSMON is memory mapped to PS.
> > 
> > The AMS can use internal channels to monitor voltage and temperature
> > as well as one primary and up to 16 auxiliary channels for measuring
> > external voltages.
> > 
> > The voltage and temperature monitoring channels also have event
> > capability which allows to generate an interrupt when their value
> > falls below or raises above a set threshold.
> > 
> > Signed-off-by: Manish Narani <mnarani@xilinx.com>
> > ---  
> 
> [..]
> 
> > +static const struct of_device_id ams_of_match_table[] = {
> > +       { .compatible = "xlnx,zynqmp-ams", &ams_pl_apb },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ams_of_match_table);  
> 
> [..]
> 
> > +static int ams_probe(struct platform_device *pdev)
> > +{
> > +       struct iio_dev *indio_dev;
> > +       struct ams *ams;
> > +       struct resource *res;
> > +       const struct of_device_id *id;
> > +       int ret;
> > +
> > +       if (!pdev->dev.of_node)
> > +               return -ENODEV;
> > +
> > +       id = of_match_node(ams_of_match_table, pdev->dev.of_node);
> > +       if (!id)
> > +               return -ENODEV;  
> 
> Is the above check required ?
> 
> Isn't the probe function called if and only if a match is found in
> ams_of_match_table[] since it is a pure OF driver ?
> 
> And therefore the above condition would never happen!
Agreed in principle.  However, from a reviewer point of view, it is sometimes
easier to have an error check that can never happen than have to check whether
or not it can.  Hence I'd keep this in place (well actually not because there
are better ways of doing this block of code, but that is unconnected to your
comment Himanshu!)

Was a good point to raise though and sometimes people add comments
saying "This can never fail but is here for completeness" or similar.
Not necessary but does avoid reviewers then asking why it was done.

Jonathan

> 
> > +static struct platform_driver ams_driver = {
> > +       .probe = ams_probe,
> > +       .remove = ams_remove,
> > +       .driver = {
> > +               .name = "ams",
> > +               .pm     = &ams_pm_ops,
> > +               .of_match_table = ams_of_match_table,
> > +       },
> > +};
> > +module_platform_driver(ams_driver);  
> 
> 
