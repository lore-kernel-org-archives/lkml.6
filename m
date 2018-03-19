Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932945AbeCSKum (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 06:50:42 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39179 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSKuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 06:50:39 -0400
X-Google-Smtp-Source: AG47ELsHp1wdsoT5oz9sT9xAH+FAnzEFi6w4Lh9uTvGEDN5VJCkTST/Q5UD3SUrAPbRquT1fguKvCQ==
From: Jan Glauber <jglauber@cavium.com>
X-Google-Original-From: Jan Glauber <jglauber@caviumnetworks.com>
Date: Mon, 19 Mar 2018 11:50:35 +0100
To: Wolfram Sang <wsa@the-dreams.de>
Cc: George Cherian <george.cherian@cavium.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kamlakant Patel <kamlakant.patel@cavium.com>
Subject: Re: [PATCH v2] i2c: xlp9xx: Add support for SMBAlert
Message-ID: <20180319105035.GA10534@wintermute>
References: <1520347594-184146-1-git-send-email-george.cherian@cavium.com>
 <20180317210300.yyft3errf3opj2t3@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180317210300.yyft3errf3opj2t3@ninjato>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 10:03:00PM +0100, Wolfram Sang wrote:
> On Tue, Mar 06, 2018 at 06:46:34AM -0800, George Cherian wrote:
> > Add support for SMBus alert mechanism to i2c-xlp9xx driver.
> > The second interrupt is parsed to use for SMBus alert.
> > The first interrupt is the i2c controller main interrupt.
> > 
> > Signed-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> > Signed-off-by: George Cherian <george.cherian@cavium.com>
> 
> Are the previous reviewers happy now?

Reviewed-by: Jan Glauber <jglauber@cavium.com>

> > ---
> >  drivers/i2c/busses/i2c-xlp9xx.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> > index eb8913e..d5cadb6 100644
> > --- a/drivers/i2c/busses/i2c-xlp9xx.c
> > +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/completion.h>
> >  #include <linux/i2c.h>
> > +#include <linux/i2c-smbus.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > @@ -84,6 +85,8 @@ struct xlp9xx_i2c_dev {
> >  	struct device *dev;
> >  	struct i2c_adapter adapter;
> >  	struct completion msg_complete;
> > +	struct i2c_smbus_alert_setup alert_data;
> > +	struct i2c_client *ara;
> >  	int irq;
> >  	bool msg_read;
> >  	bool len_recv;
> > @@ -447,6 +450,19 @@ static int xlp9xx_i2c_get_frequency(struct platform_device *pdev,
> >  	return 0;
> >  }
> >  
> > +static int xlp9xx_i2c_smbus_setup(struct xlp9xx_i2c_dev *priv,
> > +				  struct platform_device *pdev)
> > +{
> > +	if (!priv->alert_data.irq)
> > +		return -EINVAL;
> > +
> > +	priv->ara = i2c_setup_smbus_alert(&priv->adapter, &priv->alert_data);
> > +	if (!priv->ara)
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> >  static int xlp9xx_i2c_probe(struct platform_device *pdev)
> >  {
> >  	struct xlp9xx_i2c_dev *priv;
> > @@ -467,6 +483,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
> >  		dev_err(&pdev->dev, "invalid irq!\n");
> >  		return priv->irq;
> >  	}
> > +	/* SMBAlert irq */
> > +	priv->alert_data.irq = platform_get_irq(pdev, 1);
> > +	if (priv->alert_data.irq <= 0)
> 
> '< 0' should do, or?
> 
> > +		priv->alert_data.irq = 0;
> >  
> >  	xlp9xx_i2c_get_frequency(pdev, priv);
> >  	xlp9xx_i2c_init(priv);
> > @@ -493,6 +513,10 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
> >  	if (err)
> >  		return err;
> >  
> > +	err = xlp9xx_i2c_smbus_setup(priv, pdev);
> > +	if (err)
> > +		dev_info(&pdev->dev, "No active SMBus alert %d\n", err);
> > +
> 
> Do you really want to print this info every time SMBus alert is not
> used? Is it common on this platform

We do the same thing in the ThunderX driver and thought it is useful to
have the info print.

--Jan
