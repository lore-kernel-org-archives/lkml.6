Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeBSRif (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:38:35 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:43288 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753186AbeBSRie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:38:34 -0500
Date: Mon, 19 Feb 2018 18:38:13 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: tim@krieglstein.org, jarkko.nikula@linux.intel.com,
        preid@electromag.com.au, wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: i2c-designware: sound and s2ram broken on Broadwell-U system
 since commit ca382f5b38f367b6 (add i2c gpio recovery option)
Message-ID: <20180219173813.GA16875@light.dominikbrodowski.net>
References: <20180217132543.GA21571@light.dominikbrodowski.net>
 <1518879773.22495.378.camel@linux.intel.com>
 <1518880180.22495.379.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518880180.22495.379.camel@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 05:09:40PM +0200, Andy Shevchenko wrote:
> On Sat, 2018-02-17 at 17:02 +0200, Andy Shevchenko wrote:
> > On Sat, 2018-02-17 at 14:25 +0100, Dominik Brodowski wrote:
> > 
> > > on v4.16-rc1+, sound does not work any more on my Dell XPS 13;
> > > suspend-to-RAM hangs as well. I have bisected this problem down to
> > > commit ca382f5b38f3; reverting this on top of Linus' latest
> > > (1e3510b2b053)
> > > fixes these issues.
> > > And a few snippets from a broken kernel dmesg:
> > > 
> > > 	i2c_designware: probe of INT3432:00 failed with error -38
> > > 	i2c_designware: probe of INT3433:00 failed with error -38
> > 
> > ENOSYS here at probe time, taking into account the commit you think is
> > a
> > culprit, can be passed from gpiod_get() calls only.
> > 
> > > Ideas on how to fix this properly?
> > 
> > Enable CONFIG_DEBUG_GPIO first and share through some service the
> > dmesg.
> > (it might be good idea to add 'ignore_loglevel initcall_debug' to the
> > kernel command line)
> 
> And tell if the following patch helps.
> 
> --- a/drivers/i2c/busses/i2c-designware-master.c
> +++ b/drivers/i2c/busses/i2c-designware-master.c
> @@ -644,7 +644,7 @@ static int i2c_dw_init_recovery_info(struct
> dw_i2c_dev *dev)
>         gpio = devm_gpiod_get(dev->dev, "scl", GPIOD_OUT_HIGH);
>         if (IS_ERR(gpio)) {
>                 r = PTR_ERR(gpio);
> -               if (r == -ENOENT)
> +               if (r == -ENOENT || r == -ENOSYS)
>                         return 0;
>                 return r;
>         }
> 

Fixes: ca382f5b38f3 ("i2c: designware: add i2c gpio recovery option")
Tested-and-reported-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
