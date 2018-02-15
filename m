Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032077AbeBONPq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 08:15:46 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:52704 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030561AbeBONPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 08:15:45 -0500
Date: Thu, 15 Feb 2018 14:15:33 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Daney <david.daney@cavium.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rtc: isl12026: Add driver.
Message-ID: <20180215131533.GL8219@piout.net>
References: <20180214005536.22739-1-david.daney@cavium.com>
 <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcQm-gr0GRszBSRJSZOpdSutRyhVkw-BN_YAwhjaPM4yg@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 at 14:45:11 +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2018 at 2:55 AM, David Daney <david.daney@cavium.com> wrote:
> > The ISL12026 is a combination RTC and EEPROM device with I2C
> > interface.  The standard RTC driver interface is provided.  The EEPROM
> > is accessed via the NVMEM interface via the "eeprom0" directory in the
> > sysfs entry for the device.
> 
> Thanks for an update, my comments below.
> 
> > +struct isl12026 {
> > +       struct rtc_device *rtc;
> > +       struct i2c_client *nvm_client;
> > +       struct nvmem_config nvm_cfg;
> > +       /*
> > +        * RTC write operations require that multiple messages be
> > +        * transmitted, we hold the lock for all accesses to the
> > +        * device so that these sequences cannot be disrupted.  Also,
> 
> > +        * the write cycle to the nvmem takes many mS during which the
> 
> What mS means? milliseconds? The standard abbreviation for it 'ms'.
> 
> > +        * device does not respond to commands, so holding the lock
> > +        * also prevents access during these times.
> > +        */
> > +       struct mutex lock;
> > +};
> 
> > +static int isl12026_read_reg(struct i2c_client *client, int reg)
> > +{
> 
> > +       ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> > +       if (ret != ARRAY_SIZE(msgs)) {
> > +               dev_err(&client->dev, "read reg error, ret=%d\n", ret);
> > +               ret = ret < 0 ? ret : -EIO;
> > +       } else {
> > +               ret = val;
> > +       }
> 
> > +       return val;
> 
> Something wrong. ret is not used after all.
> 
> > +}
> 
> Check entire code for such.
> 
> > +       /* 2 bytes of address, most significant first */
> > +       addr[0] = (offset >> 8) & 0xff;
> > +       addr[1] = offset & 0xff;
> 
> Consider to drop '& 0xff', they are pointless (you have u8 type).
> 
> > +               payload[0] = (offset >> 8) & 0xff;
> > +               payload[1] = offset & 0xff;
> 
> Ditto.
> 
> > +static void isl12026_force_power_modes(struct i2c_client *client)
> > +{
> > +       int ret;
> > +       int pwr, requested_pwr;
> > +       u32 bsw_val, sbib_val;
> 
> > +       bool set_bsw, set_sbib;
> > +
> 
> > +       ret = of_property_read_u32(client->dev.of_node,
> > +                                  "isil,pwr-bsw", &bsw_val);
> > +       set_bsw = (ret == 0);
> 
> Which is not fully correct. Better to do
> 
> set_bsw = of_property_present();
> 
> ret = of_property_read...();
> if (ret)
>   return ret;
> 
> > +
> > +       ret = of_property_read_u32(client->dev.of_node,
> > +                                  "isil,pwr-sbib", &sbib_val);
> > +       set_sbib = (ret == 0);
> 
> Ditto.
> 
> > +
> > +       /* Check if PWR.BSW and/or PWR.SBIB need specified values */
> > +
> 
> > +       if (set_bsw || set_sbib) {
> 
> if (!x && !y)
>  return;
> 
> > +               pwr = isl12026_read_reg(client, ISL12026_REG_PWR);
> > +               if (pwr < 0) {
> > +                       dev_err(&client->dev,
> > +                               "Error: Failed to read PWR %d\n", pwr);
> > +                       return;
> > +               }
> > +
> > +               requested_pwr = pwr;
> > +
> > +               if (set_bsw) {
> > +                       if (bsw_val)
> > +                               requested_pwr |= ISL12026_REG_PWR_BSW;
> > +                       else
> > +                               requested_pwr &= ~ISL12026_REG_PWR_BSW;
> > +               }
> 
> Undefined state if no value?
> 
> > +               if (set_sbib) {
> > +                       if (sbib_val)
> > +                               requested_pwr |= ISL12026_REG_PWR_SBIB;
> > +                       else
> > +                               requested_pwr &= ~ISL12026_REG_PWR_SBIB;
> > +               }
> 
> Ditto.
> 
> > +
> > +               if (pwr >= 0 && pwr != requested_pwr) {
> 
> > +                       dev_info(&client->dev, "PWR: %02x\n", (u8)pwr);
> > +                       dev_info(&client->dev,
> > +                                "Updating PWR to: %02x\n", (u8)requested_pwr);
> > +                       isl12026_write_reg(client,
> > +                                          ISL12026_REG_PWR, requested_pwr);
> 
> If you do explicit casting in printf() parameters you are doing
> something wrong in 99.9% cases.
> 
> > +               }
> > +       }
> > +}
> 
> > +static int isl12026_probe_new(struct i2c_client *client)
> > +{
> > +       struct isl12026 *priv;
> > +       int ret;
> 
> 
> > +       /* The NVMem array responds at i2c address 0x57 */
> > +       priv->nvm_client = i2c_new_dummy(client->adapter, 0x57);
> 
> Magic. Make it #define and put comment there.
> 
> > +       if (!priv->nvm_client)
> > +               return -ENOMEM;
> 
> > +}
> 
> > +#ifdef CONFIG_OF
> 
> Remove this ugly #ifdef. Your driver OF only one.
> 

Well, it is DT only because you asked for that on v1.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
