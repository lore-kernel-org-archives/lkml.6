Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeCQSQ5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 14:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753056AbeCQSQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 14:16:54 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 919F121737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 18:16:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Manish Narani <manish.narani@xilinx.com>, michal.simek@xilinx.com,
        mnarani@xilinx.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] iio: adc: Add Xilinx AMS driver
Message-ID: <20180317181648.26728c27@archlinux>
In-Reply-To: <alpine.DEB.2.21.1803151619480.30465@vps.pmeerw.net>
References: <1521124947-18950-1-git-send-email-mnarani@xilinx.com>
        <alpine.DEB.2.21.1803151619480.30465@vps.pmeerw.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 16:51:31 +0100 (CET)
Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:

> minor comments below
> 
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
Hi Manish,

First thing is that if you post as an RFC you should say why it is an
RFC.  That is normally done to ask for comments on a particular thing,
or to make it clear that you know something still needs doing but
would like comments on the rest of the code.

A few more comments form me.  One thing that is always useful when
posting a new driver with a non trivial ABI is to add a listing
of the all the sysfs files created in the patch description.  Makes
it very easy to check the ABI is sensible.

Needs dt bindings and ABI docs.

I assume you are thinking of using the iio-hwmon bridge to expose the hwmon
stuff via standard interfaces?  If doing so, I would suggest testing that
and also presenting the resulting interface from there with this patch.

One other thing is there is a lot of code to look up values associated with
particular channels.  If possible, move all that into constant look up tables.

Thanks,

Jonathan

> > ---
> >  drivers/iio/adc/Kconfig      |   10 +
> >  drivers/iio/adc/Makefile     |    1 +
> >  drivers/iio/adc/xilinx-ams.c | 1115 ++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iio/adc/xilinx-ams.h |  278 +++++++++++
> >  4 files changed, 1404 insertions(+)
> >  create mode 100644 drivers/iio/adc/xilinx-ams.c
> >  create mode 100644 drivers/iio/adc/xilinx-ams.h
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 72bc2b7..f1b8a5f 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -931,4 +931,14 @@ config XILINX_XADC
> >           The driver can also be build as a module. If so, the module will be called
> >           xilinx-xadc.
> > 
> > +config XILINX_AMS
> > +       tristate "Xilinx AMS driver"
> > +       depends on ARCH_ZYNQMP || COMPILE_TEST
> > +       depends on HAS_IOMEM
> > +       help
> > +         Say yes here to have support for the Xilinx AMS.
> > +
> > +         The driver can also be build as a module. If so, the module will be called
> > +         xilinx-ams.
> > +
> >  endmenu
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 28a9423..27ded4f 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -85,3 +85,4 @@ obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> >  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> >  obj-$(CONFIG_SD_ADC_MODULATOR) += sd_adc_modulator.o
> > +obj-$(CONFIG_XILINX_AMS) += xilinx-ams.o  
> 
> maybe put after xilinx-xadc
Good point. That file should be in alphabetical order.  We'll want to
fix that up at somepoint - it greatly reduces the noise as the chances
of patches interfering with each other is much less than when they are
all adding lines at the end.

> 
> > diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
> > new file mode 100644
> > index 0000000..2f519e6
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.c
> > @@ -0,0 +1,1115 @@
> > +/*
> > + * Xilinx AMS driver
> > + *
> > + * Licensed under the GPL-2
> > + *
One of my silly pet hates ;)  This blank line has no purpose so don't put one here.

> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/of_address.h>
> > +#include <linux/iopoll.h>
If nothing makes another ordering clearer, default is to put headers
in alphabetical ordering.

> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/buffer.h>  
> 
> iio/buffer is not actually used?
> 
> > +#include <linux/io.h>
> > +
> > +#include "xilinx-ams.h"
> > +#include <linux/delay.h>  
> 
> the delay #include should be moved up
> 
> > +
> > +static const unsigned int AMS_UNMASK_TIMEOUT = 500;
Unit?  Best if you put that in the name.  Might as well be a define
as well rather than a constant.

Also as it is only ever used in jiffies, perhaps make the define a jiffies
value?

> > +
> > +static inline void ams_read_reg(struct ams *ams, unsigned int offset, u32 *data)
> > +{
> > +       *data = readl(ams->base + offset);
> > +}
> > +
> > +static inline void ams_write_reg(struct ams *ams, unsigned int offset, u32 data)
> > +{
> > +       writel(data, ams->base + offset);
> > +}
For these two, I'm not sure the result is cleaner than just calling the readl and writel
directly?  Might just about be worth while, but I would make the read_reg just return
the value rather to keep with standard conventions of readl and writel.

> > +
> > +static inline void ams_update_reg(struct ams *ams, unsigned int offset,
> > +                                 u32 mask, u32 data)
> > +{
> > +       u32 val;
> > +
> > +       ams_read_reg(ams, offset, &val);
> > +       ams_write_reg(ams, offset, (val & ~mask) | (mask & data));
> > +}
> > +
> > +static inline void ams_ps_read_reg(struct ams *ams, unsigned int offset,
> > +                                  u32 *data)
> > +{
> > +       *data = readl(ams->ps_base + offset);
> > +}
> > +
> > +static inline void ams_ps_write_reg(struct ams *ams, unsigned int offset,
> > +                                   u32 data)
> > +{
> > +       writel(data, ams->ps_base + offset);
> > +}
> > +
> > +static inline void ams_ps_update_reg(struct ams *ams, unsigned int offset,
> > +                                    u32 mask, u32 data)
> > +{
> > +       u32 val;
> > +
> > +       ams_ps_read_reg(ams, offset, &val);
> > +       ams_ps_write_reg(ams, offset, (val & ~mask) | (data & mask));
> > +}
> > +
> > +static inline void ams_apb_pl_read_reg(struct ams *ams, unsigned int offset,
> > +                                      u32 *data)
> > +{
> > +       *data = readl(ams->pl_base + offset);
> > +}
> > +
> > +static inline void ams_apb_pl_write_reg(struct ams *ams, unsigned int offset,
> > +                                       u32 data)
> > +{
> > +       writel(data, ams->pl_base + offset);
> > +}
> > +
> > +static inline void ams_apb_pl_update_reg(struct ams *ams, unsigned int offset,
> > +                                        u32 mask, u32 data)
> > +{
> > +       u32 val;
> > +
> > +       ams_apb_pl_read_reg(ams, offset, &val);
> > +       ams_apb_pl_write_reg(ams, offset, (val & ~mask) | (data & mask));
> > +}  
> 
> can't we have some MACRO() magic to save these three implementations?
Agreed - or squish them inline 
> 
> > +
> > +static void ams_update_intrmask(struct ams *ams, u64 mask, u64 val)
> > +{
> > +       /* intr_mask variable in ams represent bit in AMS regisetr IDR0 and IDR1  
> 
> regisetr -> register
> 
> > +        * first 32 biit will be of IDR0, next one are of IDR1 register.  
> 
> biit -> bit
> 
> and I still don't get it
> 
> > +        */
> > +       ams->intr_mask &= ~mask;
> > +       ams->intr_mask |= (val & mask);
> > +
> > +       ams_write_reg(ams, AMS_IER_0, ~(ams->intr_mask | ams->masked_alarm));
> > +       ams_write_reg(ams, AMS_IER_1,
> > +                     ~(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT));
> > +       ams_write_reg(ams, AMS_IDR_0, ams->intr_mask | ams->masked_alarm);
> > +       ams_write_reg(ams, AMS_IDR_1,
> > +                     ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT);
> > +}
> > +
> > +static void iio_ams_disable_all_alarm(struct ams *ams)  
> 
> consistent ams_ prefix would be nice; why the iio_?
> 
> > +{
> > +       /* disable PS module alarm */
> > +       if (ams->ps_base) {
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
> > +                                 AMS_REGCFG1_ALARM_MASK);
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
> > +                                 AMS_REGCFG3_ALARM_MASK);
> > +       }
> > +
> > +       /* disable PL module alarm */
> > +       if (ams->pl_base) {
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG1,
> > +                                   AMS_REGCFG1_ALARM_MASK,
> > +                                   AMS_REGCFG1_ALARM_MASK);
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG3,
> > +                                   AMS_REGCFG3_ALARM_MASK,
> > +                                   AMS_REGCFG3_ALARM_MASK);
> > +       }
> > +}
> > +
> > +static void iio_ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
> > +{
> > +       u32 cfg;
> > +       unsigned long flags;
> > +       unsigned long pl_alarm_mask;
> > +
> > +       if (ams->ps_base) {
> > +               /* Configuring PS alarm enable */
> > +               cfg = ~((alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> > +                              AMS_CONF1_ALARM_2_TO_0_SHIFT);
> > +               cfg &= ~((alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> > +                               AMS_CONF1_ALARM_6_TO_3_SHIFT);
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_REGCFG1_ALARM_MASK,
> > +                                 cfg);
> > +
> > +               cfg = ~((alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> > +                               AMS_ISR0_ALARM_12_TO_7_MASK);
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG3, AMS_REGCFG3_ALARM_MASK,
> > +                                 cfg);
> > +       }
> > +
> > +       if (ams->pl_base) {
> > +               pl_alarm_mask = (alarm_mask >> AMS_PL_ALARM_START);
> > +               /* Configuring PL alarm enable */
> > +               cfg = ~((pl_alarm_mask & AMS_ISR0_ALARM_2_TO_0_MASK) <<
> > +                              AMS_CONF1_ALARM_2_TO_0_SHIFT);
> > +               cfg &= ~((pl_alarm_mask & AMS_ISR0_ALARM_6_TO_3_MASK) <<
> > +                               AMS_CONF1_ALARM_6_TO_3_SHIFT);
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG1,
> > +                               AMS_REGCFG1_ALARM_MASK, cfg);
> > +
> > +               cfg = ~((pl_alarm_mask >> AMS_CONF3_ALARM_12_TO_7_SHIFT) &
> > +                               AMS_ISR0_ALARM_12_TO_7_MASK);
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG3,
> > +                               AMS_REGCFG3_ALARM_MASK, cfg);
> > +       }
> > +
> > +       spin_lock_irqsave(&ams->lock, flags);
> > +       ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
> > +       spin_unlock_irqrestore(&ams->lock, flags);
> > +}
> > +
> > +static void ams_enable_channel_sequence(struct ams *ams)
> > +{
> > +       int i;
> > +       unsigned long long scan_mask;
> > +       struct iio_dev *indio_dev = iio_priv_to_dev(ams);
> > +
> > +       /* Enable channel sequence. First 22 bit of scan_mask represent
> > +        * PS channels, and  next remaining bit represents PL channels.  
> 
> not a proper multi-line comment
> extra space after and
> 
> > +        */
> > +
> > +       /* Run calibration of PS & PL as part of the sequence */
> > +       scan_mask = 1 | (1 << PS_SEQ_MAX);  
> 
> magic 1
> maybe use BIT() macro
> 
> > +       for (i = 0; i < indio_dev->num_channels; i++)
> > +               scan_mask |= BIT(indio_dev->channels[i].scan_index);
> > +
> > +       if (ams->ps_base) {
> > +               /* put sysmon in a soft reset to change the sequence */
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                                 AMS_CONF1_SEQ_DEFAULT);
> > +
> > +               /* configure basic channels */
> > +               ams_ps_write_reg(ams, AMS_REG_SEQ_CH0,
> > +                                scan_mask & AMS_REG_SEQ0_MASK);
> > +               ams_ps_write_reg(ams, AMS_REG_SEQ_CH2, AMS_REG_SEQ2_MASK &
> > +                               (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT));
> > +
> > +               /* set continuous sequence mode */
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                                 AMS_CONF1_SEQ_CONTINUOUS);
> > +       }
> > +
> > +       if (ams->pl_base) {
> > +               /* put sysmon in a soft reset to change the sequence */
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                                   AMS_CONF1_SEQ_DEFAULT);
> > +
> > +               /* configure basic channels */
> > +               scan_mask = (scan_mask >> PS_SEQ_MAX);  
> 
> parenthesis not needed
> 
> > +               ams->pl_bus->write(ams, AMS_REG_SEQ_CH0,
> > +                               scan_mask & AMS_REG_SEQ0_MASK);
> > +               ams->pl_bus->write(ams, AMS_REG_SEQ_CH2, AMS_REG_SEQ2_MASK &
> > +                               (scan_mask >> AMS_REG_SEQ2_MASK_SHIFT));
> > +               ams->pl_bus->write(ams, AMS_REG_SEQ_CH1, AMS_REG_SEQ1_MASK &
> > +                               (scan_mask >> AMS_REG_SEQ1_MASK_SHIFT));
> > +
> > +               /* set continuous sequence mode */
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                               AMS_CONF1_SEQ_CONTINUOUS);
> > +       }
> > +}
> > +
> > +static int iio_ams_init_device(struct ams *ams)
> > +{
> > +       int ret = 0;  
> 
> no need to init ret
> 
> > +       u32 reg;
> > +
> > +       /* reset AMS */
> > +       if (ams->ps_base) {
> > +               ams_ps_write_reg(ams, AMS_VP_VN, AMS_PS_RESET_VALUE);
> > +
> > +               ret = readl_poll_timeout(ams->base + AMS_PS_CSTS, reg,
> > +                                        (reg & AMS_PS_CSTS_PS_READY) ==
> > +                                        AMS_PS_CSTS_PS_READY, 0,
> > +                                        AMS_INIT_TIMEOUT);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /* put sysmon in a default state */
> > +               ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                                 AMS_CONF1_SEQ_DEFAULT);
> > +       }
> > +
> > +       if (ams->pl_base) {
> > +               ams->pl_bus->write(ams, AMS_VP_VN, AMS_PL_RESET_VALUE);
> > +
> > +               ret = readl_poll_timeout(ams->base + AMS_PL_CSTS, reg,
> > +                                        (reg & AMS_PL_CSTS_ACCESS_MASK) ==
> > +                                        AMS_PL_CSTS_ACCESS_MASK, 0,
> > +                                        AMS_INIT_TIMEOUT);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               /* put sysmon in a default state */
> > +               ams->pl_bus->update(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                                   AMS_CONF1_SEQ_DEFAULT);
> > +       }
> > +
> > +       iio_ams_disable_all_alarm(ams);
> > +
> > +       /* Disable interrupt */
> > +       ams_update_intrmask(ams, ~0, ~0);
> > +
> > +       /* Clear any pending interrupt */
> > +       ams_write_reg(ams, AMS_ISR_0, AMS_ISR0_ALARM_MASK);
> > +       ams_write_reg(ams, AMS_ISR_1, AMS_ISR1_ALARM_MASK);
> > +
> > +       return ret;  
> 
> just 
> return 0;
> 
> > +}
> > +
> > +static void ams_enable_single_channel(struct ams *ams, unsigned int offset)
> > +{
> > +       u8 channel_num = 0;
> > +
> > +       switch (offset) {
> > +       case AMS_VCC_PSPLL0:
> > +               channel_num = AMS_VCC_PSPLL0_CH;
> > +               break;
> > +       case AMS_VCC_PSPLL3:
> > +               channel_num = AMS_VCC_PSPLL3_CH;
> > +               break;
> > +       case AMS_VCCINT:
> > +               channel_num = AMS_VCCINT_CH;
> > +               break;
> > +       case AMS_VCCBRAM:
> > +               channel_num = AMS_VCCBRAM_CH;
> > +               break;
> > +       case AMS_VCCAUX:
> > +               channel_num = AMS_VCCAUX_CH;
> > +               break;
> > +       case AMS_PSDDRPLL:
> > +               channel_num = AMS_PSDDRPLL_CH;
> > +               break;
> > +       case AMS_PSINTFPDDR:
> > +               channel_num = AMS_PSINTFPDDR_CH;
> > +               break;
> > +       default:
> > +               break;  
> 
> really? no error condition?
> is 0 a valid channel number? why not use a #define then?
> 
> > +       }
> > +
> > +       /* set single channel, sequencer off mode */
> > +       ams_ps_update_reg(ams, AMS_REG_CONFIG1, AMS_CONF1_SEQ_MASK,
> > +                       AMS_CONF1_SEQ_SINGLE_CHANNEL);
> > +
> > +       /* write the channel number */
> > +       ams_ps_update_reg(ams, AMS_REG_CONFIG0, AMS_CONF0_CHANNEL_NUM_MASK,
> > +                       channel_num);
> > +       mdelay(1);
> > +}
> > +
> > +static void ams_read_vcc_reg(struct ams *ams, unsigned int offset, u32 *data)
> > +{
> > +       ams_enable_single_channel(ams, offset);
> > +       ams_read_reg(ams, offset, data);
> > +       ams_enable_channel_sequence(ams);
> > +}
> > +
> > +static int ams_read_raw(struct iio_dev *indio_dev,
> > +                       struct iio_chan_spec const *chan,
> > +                       int *val, int *val2, long mask)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               mutex_lock(&ams->mutex);
> > +               if (chan->scan_index >= (PS_SEQ_MAX * 3))
Define macros to identify the 3 cases so we can just call
if (ams_is_reg_channel(chan->scan_index)) etc.

> > +                       ams_read_vcc_reg(ams, chan->address, val);
> > +               else if (chan->scan_index >= PS_SEQ_MAX)
> > +                       ams->pl_bus->read(ams, chan->address, val);
> > +               else
> > +                       ams_ps_read_reg(ams, chan->address, val);
> > +               mutex_unlock(&ams->mutex);
> > +
> > +               *val2 = 0;  
> 
> no need to set val2
> 
> > +               return IIO_VAL_INT;
> > +       case IIO_CHAN_INFO_SCALE:
> > +               switch (chan->type) {
> > +               case IIO_VOLTAGE:
> > +                       switch (chan->address) {
> > +                       case AMS_SUPPLY1:
> > +                       case AMS_SUPPLY2:
> > +                       case AMS_SUPPLY3:
> > +                       case AMS_SUPPLY4:
> > +                               *val = AMS_SUPPLY_SCALE_3VOLT;
> > +                               break;
> > +                       case AMS_SUPPLY5:
> > +                       case AMS_SUPPLY6:
> > +                               if (chan->scan_index < PS_SEQ_MAX)
> > +                                       *val = AMS_SUPPLY_SCALE_6VOLT;
> > +                               else
> > +                                       *val = AMS_SUPPLY_SCALE_3VOLT;
> > +                               break;
> > +                       case AMS_SUPPLY7:
> > +                       case AMS_SUPPLY8:
> > +                               *val = AMS_SUPPLY_SCALE_6VOLT;
> > +                               break;
> > +                       case AMS_SUPPLY9:
> > +                       case AMS_SUPPLY10:
> > +                               if (chan->scan_index < PS_SEQ_MAX)
> > +                                       *val = AMS_SUPPLY_SCALE_3VOLT;
> > +                               else
> > +                                       *val = AMS_SUPPLY_SCALE_6VOLT;
> > +                               break;
> > +                       case AMS_VCC_PSPLL0:
> > +                       case AMS_VCC_PSPLL3:
> > +                       case AMS_VCCINT:
> > +                       case AMS_VCCBRAM:
> > +                       case AMS_VCCAUX:
> > +                       case AMS_PSDDRPLL:
> > +                       case AMS_PSINTFPDDR:
> > +                               *val = AMS_SUPPLY_SCALE_3VOLT;
> > +                               break;
> > +                       default:
> > +                               *val = AMS_SUPPLY_SCALE_1VOLT;
> > +                               break;
> > +                       }
> > +                       *val2 = AMS_SUPPLY_SCALE_DIV_BIT;
> > +                       return IIO_VAL_FRACTIONAL_LOG2;
> > +               case IIO_TEMP:
> > +                       *val = AMS_TEMP_SCALE;
> > +                       *val2 = AMS_TEMP_SCALE_DIV_BIT;
> > +                       return IIO_VAL_FRACTIONAL_LOG2;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +       case IIO_CHAN_INFO_OFFSET:
> > +               /* Only the temperature channel has an offset */
> > +               *val = AMS_TEMP_OFFSET;
> > +               *val2 = 0;  
> 
> no need to set val2 to 0
> 
> > +               return IIO_VAL_INT;
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> > +static int ams_get_alarm_offset(int scan_index, enum iio_event_direction dir)
> > +{
> > +       int offset = 0;
> > +
This looks like it could be easily mapped to a big constant table.
That would be preferable to this large block of code.

> > +       if (scan_index >= PS_SEQ_MAX)
> > +               scan_index -= PS_SEQ_MAX;
> > +
> > +       if (dir == IIO_EV_DIR_FALLING) {
> > +               if (scan_index < AMS_SEQ_SUPPLY7)
> > +                       offset = AMS_ALARM_THRESHOLD_OFF_10;
> > +               else
> > +                       offset = AMS_ALARM_THRESHOLD_OFF_20;
> > +       }
> > +
> > +       switch (scan_index) {
> > +       case AMS_SEQ_TEMP:
> > +               return (AMS_ALARM_TEMP + offset);  
> 
> no need for parenthesis
> 
> > +       case AMS_SEQ_SUPPLY1:
> > +               return (AMS_ALARM_SUPPLY1 + offset);
> > +       case AMS_SEQ_SUPPLY2:
> > +               return (AMS_ALARM_SUPPLY2 + offset);
> > +       case AMS_SEQ_SUPPLY3:
> > +               return (AMS_ALARM_SUPPLY3 + offset);
> > +       case AMS_SEQ_SUPPLY4:
> > +               return (AMS_ALARM_SUPPLY4 + offset);
> > +       case AMS_SEQ_SUPPLY5:
> > +               return (AMS_ALARM_SUPPLY5 + offset);
> > +       case AMS_SEQ_SUPPLY6:
> > +               return (AMS_ALARM_SUPPLY6 + offset);
> > +       case AMS_SEQ_SUPPLY7:
> > +               return (AMS_ALARM_SUPPLY7 + offset);
> > +       case AMS_SEQ_SUPPLY8:
> > +               return (AMS_ALARM_SUPPLY8 + offset);
> > +       case AMS_SEQ_SUPPLY9:
> > +               return (AMS_ALARM_SUPPLY9 + offset);
> > +       case AMS_SEQ_SUPPLY10:
> > +               return (AMS_ALARM_SUPPLY10 + offset);
> > +       case AMS_SEQ_VCCAMS:
> > +               return (AMS_ALARM_VCCAMS + offset);
> > +       case AMS_SEQ_TEMP_REMOTE:
> > +               return (AMS_ALARM_TEMP_REMOTE + offset);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct iio_chan_spec *ams_event_to_channel(
> > +               struct iio_dev *indio_dev, u32 event)
> > +{
> > +       int scan_index = 0, i;
> > +
> > +       if (event >= AMS_PL_ALARM_START) {
> > +               event -= AMS_PL_ALARM_START;
> > +               scan_index = PS_SEQ_MAX;
> > +       }
> > +
> > +       switch (event) {
> > +       case AMS_ALARM_BIT_TEMP:
> > +               scan_index += AMS_SEQ_TEMP;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY1:
> > +               scan_index += AMS_SEQ_SUPPLY1;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY2:
> > +               scan_index += AMS_SEQ_SUPPLY2;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY3:
> > +               scan_index += AMS_SEQ_SUPPLY3;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY4:
> > +               scan_index += AMS_SEQ_SUPPLY4;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY5:
> > +               scan_index += AMS_SEQ_SUPPLY5;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY6:
> > +               scan_index += AMS_SEQ_SUPPLY6;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY7:
> > +               scan_index += AMS_SEQ_SUPPLY7;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY8:
> > +               scan_index += AMS_SEQ_SUPPLY8;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY9:
> > +               scan_index += AMS_SEQ_SUPPLY9;
> > +               break;
> > +       case AMS_ALARM_BIT_SUPPLY10:
> > +               scan_index += AMS_SEQ_SUPPLY10;
> > +               break;
> > +       case AMS_ALARM_BIT_VCCAMS:
> > +               scan_index += AMS_SEQ_VCCAMS;
> > +               break;
> > +       case AMS_ALARM_BIT_TEMP_REMOTE:
> > +               scan_index += AMS_SEQ_TEMP_REMOTE;
> > +               break;
> > +       }
> > +
> > +       for (i = 0; i < indio_dev->num_channels; i++)
> > +               if (indio_dev->channels[i].scan_index == scan_index)
> > +                       break;
This is somewhat of a fast path to find such a search in.  It may be
worth setting up a look up table when we originally do the probe to match
alarm bit to channel.

> > +
> > +       return &indio_dev->channels[i];
> > +}
> > +
> > +static int ams_get_alarm_mask(int scan_index)
> > +{
> > +       int bit = 0;
We would normally try to embed this in the channel structure
in some fashion so that it becomes static data rather than
a big switch statement.
It may not be easy here however, I haven't checked!

> > +
> > +       if (scan_index >= PS_SEQ_MAX) {
> > +               bit = AMS_PL_ALARM_START;
> > +               scan_index -= PS_SEQ_MAX;
> > +       }
> > +
> > +       switch (scan_index) {
> > +       case AMS_SEQ_TEMP:
> > +               return BIT(AMS_ALARM_BIT_TEMP + bit);
> > +       case AMS_SEQ_SUPPLY1:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY1 + bit);
> > +       case AMS_SEQ_SUPPLY2:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY2 + bit);
> > +       case AMS_SEQ_SUPPLY3:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY3 + bit);
> > +       case AMS_SEQ_SUPPLY4:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY4 + bit);
> > +       case AMS_SEQ_SUPPLY5:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY5 + bit);
> > +       case AMS_SEQ_SUPPLY6:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY6 + bit);
> > +       case AMS_SEQ_SUPPLY7:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY7 + bit);
> > +       case AMS_SEQ_SUPPLY8:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY8 + bit);
> > +       case AMS_SEQ_SUPPLY9:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY9 + bit);
> > +       case AMS_SEQ_SUPPLY10:
> > +               return BIT(AMS_ALARM_BIT_SUPPLY10 + bit);
> > +       case AMS_SEQ_VCCAMS:
> > +               return BIT(AMS_ALARM_BIT_VCCAMS + bit);
> > +       case AMS_SEQ_TEMP_REMOTE:
> > +               return BIT(AMS_ALARM_BIT_TEMP_REMOTE + bit);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int ams_read_event_config(struct iio_dev *indio_dev,
> > +                                const struct iio_chan_spec *chan,
> > +                                enum iio_event_type type,
> > +                                enum iio_event_direction dir)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +
> > +       return (ams->alarm_mask & ams_get_alarm_mask(chan->scan_index)) ? 1 : 0;
> > +}
> > +
> > +static int ams_write_event_config(struct iio_dev *indio_dev,
> > +                                 const struct iio_chan_spec *chan,
> > +                                 enum iio_event_type type,
> > +                                 enum iio_event_direction dir,
> > +                                 int state)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +       unsigned int alarm;
> > +
> > +       alarm = ams_get_alarm_mask(chan->scan_index);
> > +
> > +       mutex_lock(&ams->mutex);
> > +
> > +       if (state)
> > +               ams->alarm_mask |= alarm;
> > +       else
> > +               ams->alarm_mask &= ~alarm;
> > +
> > +       iio_ams_update_alarm(ams, ams->alarm_mask);
> > +
> > +       mutex_unlock(&ams->mutex);
> > +
> > +       return 0;
> > +}
> > +
> > +static int ams_read_event_value(struct iio_dev *indio_dev,
> > +                               const struct iio_chan_spec *chan,
> > +                               enum iio_event_type type,
> > +                               enum iio_event_direction dir,
> > +                               enum iio_event_info info, int *val, int *val2)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +       unsigned int offset = ams_get_alarm_offset(chan->scan_index, dir);
> > +
> > +       mutex_lock(&ams->mutex);
> > +
> > +       if (chan->scan_index >= PS_SEQ_MAX)
> > +               ams->pl_bus->read(ams, offset, val);
> > +       else
> > +               ams_ps_read_reg(ams, offset, val);
> > +
> > +       mutex_unlock(&ams->mutex);
> > +
> > +       *val2 = 0;  
> 
> no need to set val2 to 0
> 
> > +       return IIO_VAL_INT;
> > +}
> > +
> > +static int ams_write_event_value(struct iio_dev *indio_dev,
> > +                                const struct iio_chan_spec *chan,
> > +                                enum iio_event_type type,
> > +                                enum iio_event_direction dir,
> > +                                enum iio_event_info info, int val, int val2)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +       unsigned int offset;
> > +
> > +       mutex_lock(&ams->mutex);
> > +
> > +       /* Set temperature channel threshold to direct threshold */
> > +       if (chan->type == IIO_TEMP) {
> > +               offset = ams_get_alarm_offset(chan->scan_index,
> > +                                             IIO_EV_DIR_FALLING);
> > +
> > +               if (chan->scan_index >= PS_SEQ_MAX)
> > +                       ams->pl_bus->update(ams, offset,
> > +                                           AMS_ALARM_THR_DIRECT_MASK,
> > +                                           AMS_ALARM_THR_DIRECT_MASK);
> > +               else
> > +                       ams_ps_update_reg(ams, offset,
> > +                                         AMS_ALARM_THR_DIRECT_MASK,
> > +                                         AMS_ALARM_THR_DIRECT_MASK);
> > +       }
> > +
> > +       offset = ams_get_alarm_offset(chan->scan_index, dir);
> > +       if (chan->scan_index >= PS_SEQ_MAX)
> > +               ams->pl_bus->write(ams, offset, val);
> > +       else
> > +               ams_ps_write_reg(ams, offset, val);
> > +
> > +       mutex_unlock(&ams->mutex);
> > +
> > +       return 0;
> > +}
> > +
> > +static void ams_handle_event(struct iio_dev *indio_dev, u32 event)
> > +{
> > +       const struct iio_chan_spec *chan;
> > +
> > +       chan = ams_event_to_channel(indio_dev, event);
> > +
> > +       if (chan->type == IIO_TEMP) {
Perhaps store the event type in a variable rather than doing the iio_push in here.
It's a long function name so becomes a bit unreadable if indented so far?
(really small thing so I don't care if you want to keep it like this.)
> > +               /* The temperature channel only supports over-temperature
> > +                * events
> > +                */
> > +               iio_push_event(indio_dev,
> > +                              IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> > +                                                   IIO_EV_TYPE_THRESH,
> > +                                                   IIO_EV_DIR_RISING),
> > +                       iio_get_time_ns(indio_dev));
> > +       } else {
> > +               /* For other channels we don't know whether it is a upper or
> > +                * lower threshold event. Userspace will have to check the
> > +                * channel value if it wants to know.
> > +                */
> > +               iio_push_event(indio_dev,
> > +                              IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> > +                                                   IIO_EV_TYPE_THRESH,
> > +                                                   IIO_EV_DIR_EITHER),
> > +                       iio_get_time_ns(indio_dev));
> > +       }
> > +}
> > +
> > +static void ams_handle_events(struct iio_dev *indio_dev, unsigned long events)
> > +{
> > +       unsigned int bit;
> > +
> > +       for_each_set_bit(bit, &events, AMS_NO_OF_ALARMS)
> > +               ams_handle_event(indio_dev, bit);
> > +}
> > +
> > +/**
> > + * ams_unmask_worker - ams alarm interrupt unmask worker
> > + * @work :             work to be done
> > + *
> > + * The ZynqMP threshold interrupts are level sensitive. Since we can't make the
> > + * threshold condition go way from within the interrupt handler, this means as
> > + * soon as a threshold condition is present we would enter the interrupt handler
> > + * again and again. To work around this we mask all active thresholds interrupts  
> 
>  threshold interrupts
> 
> > + * in the interrupt handler and start a timer. In this timer we poll the
> > + * interrupt status and only if the interrupt is inactive we unmask it again.
> > + */
Some hardware supports a 'repeat frequency' so that you get an interrupt every
1/F seconds.  It may be worth emulating that.  Not sure if it is useful in this
case.


> > +static void ams_unmask_worker(struct work_struct *work)
> > +{
> > +       struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
> > +       unsigned int status, unmask;
> > +
> > +       spin_lock_irq(&ams->lock);
> > +
> > +       ams_read_reg(ams, AMS_ISR_0, &status);
> > +
> > +       /* Clear those bits which are not active anymore */
> > +       unmask = (ams->masked_alarm ^ status) & ams->masked_alarm;
> > +
> > +       /* clear status of disabled alarm */
> > +       unmask |= ams->intr_mask;
> > +
> > +       ams->masked_alarm &= status;
> > +
> > +       /* Also clear those which are masked out anyway */
> > +       ams->masked_alarm &= ~ams->intr_mask;
> > +
> > +       /* Clear the interrupts before we unmask them */
> > +       ams_write_reg(ams, AMS_ISR_0, unmask);
> > +
> > +       ams_update_intrmask(ams, 0, 0);
> > +
> > +       spin_unlock_irq(&ams->lock);
> > +
> > +       /* if still pending some alarm re-trigger the timer */
> > +       if (ams->masked_alarm)
> > +               schedule_delayed_work(&ams->ams_unmask_work,
> > +                                     msecs_to_jiffies(AMS_UNMASK_TIMEOUT));
> > +}
> > +
> > +static irqreturn_t ams_iio_irq(int irq, void *data)
> > +{
> > +       unsigned int isr0, isr1;
> > +       struct iio_dev *indio_dev = data;
> > +       struct ams *ams = iio_priv(indio_dev);
> > +
> > +       spin_lock(&ams->lock);
> > +
> > +       ams_read_reg(ams, AMS_ISR_0, &isr0);
> > +       ams_read_reg(ams, AMS_ISR_1, &isr1);
> > +
> > +       /* only process alarm that are not masked */  
> 
> alarms
> 
> > +       isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->masked_alarm);
> > +       isr1 &= ~(ams->intr_mask >> AMS_ISR1_INTR_MASK_SHIFT);
> > +
> > +       /* clear interrupt */
> > +       ams_write_reg(ams, AMS_ISR_0, isr0);
> > +       ams_write_reg(ams, AMS_ISR_1, isr1);
> > +
> > +       if (isr0) {
> > +               /* Once the alarm interrupt occurred, mask until get cleared */
> > +               ams->masked_alarm |= isr0;
> > +               ams_update_intrmask(ams, 0, 0);
> > +
> > +               ams_handle_events(indio_dev, isr0);
> > +
> > +               schedule_delayed_work(&ams->ams_unmask_work,
> > +                                     msecs_to_jiffies(AMS_UNMASK_TIMEOUT));
> > +       }
> > +
> > +       spin_unlock(&ams->lock);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_event_spec ams_temp_events[] = {
> > +       {
> > +               .type = IIO_EV_TYPE_THRESH,
> > +               .dir = IIO_EV_DIR_RISING,
> > +               .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> > +                               BIT(IIO_EV_INFO_VALUE),
> > +       },
> > +};
> > +
> > +static const struct iio_event_spec ams_voltage_events[] = {
> > +       {
> > +               .type = IIO_EV_TYPE_THRESH,
> > +               .dir = IIO_EV_DIR_RISING,
> > +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +       }, {
> > +               .type = IIO_EV_TYPE_THRESH,
> > +               .dir = IIO_EV_DIR_FALLING,
> > +               .mask_separate = BIT(IIO_EV_INFO_VALUE),
> > +       }, {
> > +               .type = IIO_EV_TYPE_THRESH,
> > +               .dir = IIO_EV_DIR_EITHER,
> > +               .mask_separate = BIT(IIO_EV_INFO_ENABLE),
> > +       },
> > +};
> > +
> > +static const struct iio_chan_spec ams_ps_channels[] = {
> > +       AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "ps_temp"),
> > +       AMS_PS_CHAN_TEMP(AMS_SEQ_TEMP_REMOTE, AMS_TEMP_REMOTE, "remote_temp"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, "vccpsintlp"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, "vccpsintfp"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, "vccpsaux"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, "vccpsddr"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, "vccpsio3"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, "vccpsio0"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, "vccpsio1"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, "vccpsio2"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, "psmgtravcc"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, "psmgtravtt"),
> > +       AMS_PS_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, "vccams"),
> > +};
> > +
> > +static const struct iio_chan_spec ams_pl_channels[] = {
> > +       AMS_PL_CHAN_TEMP(AMS_SEQ_TEMP, AMS_TEMP, "pl_temp"),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY1, AMS_SUPPLY1, "vccint", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY2, AMS_SUPPLY2, "vccaux", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFP, AMS_VREFP, "vccvrefp", false),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VREFN, AMS_VREFN, "vccvrefn", false),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY3, AMS_SUPPLY3, "vccbram", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY4, AMS_SUPPLY4, "vccplintlp", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY5, AMS_SUPPLY5, "vccplintfp", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY6, AMS_SUPPLY6, "vccplaux", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VCCAMS, AMS_VCCAMS, "vccams", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_VP_VN, AMS_VP_VN, "vccvpvn", false),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY7, AMS_SUPPLY7, "vuser0", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY8, AMS_SUPPLY8, "vuser1", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY9, AMS_SUPPLY9, "vuser2", true),
> > +       AMS_PL_CHAN_VOLTAGE(AMS_SEQ_SUPPLY10, AMS_SUPPLY10, "vuser3", true),
I'm curious, what makes a user voltage reading not a general purpose one?

> > +       AMS_PL_AUX_CHAN_VOLTAGE(0, "vccaux0"),
These extended names aren't useful.  I assume these are the general purpose
pins?  If so that is expressed by 'not' having an extended name for a voltage
channel.
in_voltageX_raw is a general purpose channel.

> > +       AMS_PL_AUX_CHAN_VOLTAGE(1, "vccaux1"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(2, "vccaux2"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(3, "vccaux3"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(4, "vccaux4"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(5, "vccaux5"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(6, "vccaux6"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(7, "vccaux7"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(8, "vccaux8"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(9, "vccaux9"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(10, "vccaux10"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(11, "vccaux11"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(12, "vccaux12"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(13, "vccaux13"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(14, "vccaux14"),
> > +       AMS_PL_AUX_CHAN_VOLTAGE(15, "vccaux15"),
> > +};
> > +
> > +static const struct iio_chan_spec ams_ctrl_channels[] = {
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSPLL, AMS_VCC_PSPLL0, "vcc_pspll0"),
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCC_PSBATT, AMS_VCC_PSPLL3, "vcc_psbatt"),
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCINT, AMS_VCCINT, "vccint"),
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCBRAM, AMS_VCCBRAM, "vccbram"),
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_VCCAUX, AMS_VCCAUX, "vccaux"),
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_PSDDRPLL, AMS_PSDDRPLL, "vcc_psddrpll"),  
> 
> AMS_PSDDRPLL but string is vcc_psddrpll; is the vcc_ correct?
> no idea
> 
> > +       AMS_CTRL_CHAN_VOLTAGE(AMS_SEQ_INTDDR, AMS_PSINTFPDDR, "vccpsintfpddr"),
> > +};
> > +
> > +static int ams_init_module(struct iio_dev *indio_dev, struct device_node *np,
> > +                          struct iio_chan_spec *channels)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +       struct device_node *chan_node, *child;
> > +       int ret, num_channels = 0;
> > +       unsigned int reg;
> > +
> > +       if (of_device_is_compatible(np, "xlnx,zynqmp-ams-ps")) {
Really need those well documented device tree bindings to have any
idea what the intent here is.  This isn't the main device
match value so I'm guessing a child?


> > +               ams->ps_base = of_iomap(np, 0);
> > +               if (!ams->ps_base)
> > +                       return -ENXIO;
> > +
> > +               /* add PS channels to iio device channels */
> > +               memcpy(channels + num_channels, ams_ps_channels,
> > +                      sizeof(ams_ps_channels));
> > +               num_channels += ARRAY_SIZE(ams_ps_channels);
> > +       } else if (of_device_is_compatible(np, "xlnx,zynqmp-ams-pl")) {
> > +               ams->pl_base = of_iomap(np, 0);
> > +               if (!ams->pl_base)
> > +                       return -ENXIO;
> > +
> > +               /* Copy only first 10 fix channels */
fix? Should be fixed perhaps.

> > +               memcpy(channels + num_channels, ams_pl_channels,
> > +                      AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
> > +               num_channels += AMS_PL_MAX_FIXED_CHANNEL;
> > +
> > +               chan_node = of_get_child_by_name(np, "xlnx,ext-channels");
> > +               if (chan_node) {
> > +                       for_each_child_of_node(chan_node, child) {
> > +                               ret = of_property_read_u32(child, "reg", &reg);
> > +                               if (ret || reg > AMS_PL_MAX_EXT_CHANNEL)
> > +                                       continue;
> > +
> > +                               memcpy(&channels[num_channels],
> > +                                      &ams_pl_channels[reg +
> > +                                      AMS_PL_MAX_FIXED_CHANNEL],
> > +                                      sizeof(*channels));
> > +
> > +                               if (of_property_read_bool(child,
> > +                                                         "xlnx,bipolar"))
> > +                                       channels[num_channels].scan_type.sign =
> > +                                               's';
> > +
> > +                               num_channels += 1;
> > +                       }
> > +               }
> > +               of_node_put(chan_node);
> > +       } else if (of_device_is_compatible(np, "xlnx,zynqmp-ams")) {
> > +               /* add AMS channels to iio device channels */
> > +               memcpy(channels + num_channels, ams_ctrl_channels,
> > +                               sizeof(ams_ctrl_channels));
> > +               num_channels += ARRAY_SIZE(ams_ctrl_channels);
> > +       } else {
> > +               return -EINVAL;
> > +       }
> > +
> > +       return num_channels;
> > +}
> > +
> > +static int ams_parse_dt(struct iio_dev *indio_dev, struct platform_device *pdev)
> > +{
> > +       struct ams *ams = iio_priv(indio_dev);
> > +       struct iio_chan_spec *ams_channels, *dev_channels;
> > +       struct device_node *child_node = NULL, *np = pdev->dev.of_node;
> > +       int ret, chan_vol = 0, chan_temp = 0, i, rising_off, falling_off;
> > +       unsigned int num_channels = 0;
> > +
> > +       /* Initialize buffer for channel specification */
> > +       ams_channels = kzalloc(sizeof(ams_ps_channels) +
> > +                              sizeof(ams_pl_channels) +
> > +                              sizeof(ams_ctrl_channels), GFP_KERNEL);
> > +       if (!ams_channels)
> > +               return -ENOMEM;
> > +
> > +       if (of_device_is_available(np)) {
> > +               ret = ams_init_module(indio_dev, np, ams_channels);
> > +               if (ret < 0) {
> > +                       kfree(ams_channels);
goto and free in one place.

> > +                       return ret;
> > +               }
> > +
> > +               num_channels += ret;
> > +       }
> > +
> > +       for_each_child_of_node(np, child_node) {
> > +               if (of_device_is_available(child_node)) {
> > +                       ret = ams_init_module(indio_dev, child_node,
> > +                                             ams_channels + num_channels);
> > +                       if (ret < 0) {
> > +                               kfree(ams_channels);
goto

> > +                               return ret;
> > +                       }
> > +
> > +                       num_channels += ret;
> > +               }
> > +       }
> > +
> > +       for (i = 0; i < num_channels; i++) {
The depth of indentation here would suggest to me that we might
want to look at pulling the per channel element out as a utility
function.

> > +               if (ams_channels[i].type == IIO_VOLTAGE)
> > +                       ams_channels[i].channel = chan_vol++;
> > +               else
> > +                       ams_channels[i].channel = chan_temp++;
> > +
> > +               if (ams_channels[i].scan_index < (PS_SEQ_MAX * 3)) {
> > +                       /* set threshold to max and min for each channel */
> > +                       falling_off = ams_get_alarm_offset(
> > +                                       ams_channels[i].scan_index,
> > +                                       IIO_EV_DIR_FALLING);
> > +                       rising_off = ams_get_alarm_offset(
> > +                                       ams_channels[i].scan_index,
> > +                                       IIO_EV_DIR_RISING);
> > +                       if (ams_channels[i].scan_index >= PS_SEQ_MAX) {
> > +                               ams->pl_bus->write(ams, falling_off,
> > +                                               AMS_ALARM_THR_MIN);
> > +                               ams->pl_bus->write(ams, rising_off,
> > +                                               AMS_ALARM_THR_MAX);
> > +                       } else {
> > +                               ams_ps_write_reg(ams, falling_off,
> > +                                               AMS_ALARM_THR_MIN);
> > +                               ams_ps_write_reg(ams, rising_off,
> > +                                               AMS_ALARM_THR_MAX);
> > +                       }
> > +               }
> > +       }
> > +
> > +       dev_channels = devm_kzalloc(&pdev->dev, sizeof(*dev_channels) *
> > +                                   num_channels, GFP_KERNEL);
> > +       if (!dev_channels) {
> > +               kfree(ams_channels);
This has to be freed on all paths - use a goto instead of freeing it here.

> > +               return -ENOMEM;
> > +       }
> > +
> > +       memcpy(dev_channels, ams_channels,
> > +              sizeof(*ams_channels) * num_channels);
> > +       kfree(ams_channels);
> > +       indio_dev->channels = dev_channels;
> > +       indio_dev->num_channels = num_channels;
Switch the ordering around to have the kfree after the assignments and
you can have a nice shared exit path from and the error cases (using gotos)

> > +
> > +       return 0;
> > +}
> > +
> > +static const struct iio_info iio_pl_info = {
> > +       .read_raw = &ams_read_raw,
> > +       .read_event_config = &ams_read_event_config,
> > +       .write_event_config = &ams_write_event_config,
> > +       .read_event_value = &ams_read_event_value,
> > +       .write_event_value = &ams_write_event_value,
> > +};
> > +
> > +static const struct ams_pl_bus_ops ams_pl_apb = {
> > +       .read = ams_apb_pl_read_reg,
> > +       .write = ams_apb_pl_write_reg,
> > +       .update = ams_apb_pl_update_reg,
> > +};
> > +
> > +static const struct of_device_id ams_of_match_table[] = {
> > +       { .compatible = "xlnx,zynqmp-ams", &ams_pl_apb },
> > +       { }
> > +};
> > +MODULE_DEVICE_TABLE(of, ams_of_match_table);
> > +
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
of_device_get_match_data would be better I think..

> > +
> > +       indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ams));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       ams = iio_priv(indio_dev);
> > +       ams->pl_bus = id->data;
> > +       mutex_init(&ams->mutex);
> > +       spin_lock_init(&ams->lock);
> > +
> > +       indio_dev->dev.parent = &pdev->dev;
> > +       indio_dev->dev.of_node = pdev->dev.of_node;
> > +       indio_dev->name = "ams";
> > +
> > +       indio_dev->info = &iio_pl_info;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ams-base");
> > +       ams->base = devm_ioremap_resource(&pdev->dev, res);
> > +       if (IS_ERR(ams->base))
> > +               return PTR_ERR(ams->base);
> > +
> > +       INIT_DELAYED_WORK(&ams->ams_unmask_work, ams_unmask_worker);
> > +
> > +       ams->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(ams->clk))
> > +               return PTR_ERR(ams->clk);
> > +       clk_prepare_enable(ams->clk);
> > +
> > +       ret = iio_ams_init_device(ams);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failed to initialize AMS\n");
> > +               goto clk_disable;
> > +       }
> > +
> > +       ret = ams_parse_dt(indio_dev, pdev);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "failure in parsing DT\n");
> > +               goto clk_disable;
> > +       }
> > +
> > +       ams_enable_channel_sequence(ams);
> > +
> > +       ams->irq = platform_get_irq_byname(pdev, "ams-irq");
> > +       ret = devm_request_irq(&pdev->dev, ams->irq, &ams_iio_irq, 0, "ams-irq",
> > +                              indio_dev);
Here we are mixing devm managed calls with non devm ones.  This means
that we have then check very carefully for race conditions.   Much easier
is to just use managed allocations until the first time you cannot.
At that point switch to a traditional non managed form with clearly laid
out error handling.  That makes for a much easier to review driver.


> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to register interrupt\n");
> > +               goto clk_disable;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, indio_dev);
> > +
> > +       return iio_device_register(indio_dev);
This can result in an error. Handle it.

> > +
> > +clk_disable:
> > +       clk_disable_unprepare(ams->clk);
> > +       return ret;
> > +}
> > +
> > +static int ams_remove(struct platform_device *pdev)
> > +{
> > +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +       struct ams *ams = iio_priv(indio_dev);
> > +
> > +       cancel_delayed_work(&ams->ams_unmask_work);
> > +
> > +       /* Unregister the device */
> > +       iio_device_unregister(indio_dev);
> > +       clk_disable_unprepare(ams->clk);  
> 
> newline
> 
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused ams_suspend(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +       struct ams *ams = iio_priv(indio_dev);
> > +
> > +       clk_disable_unprepare(ams->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused ams_resume(struct device *dev)
> > +{
> > +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> > +       struct ams *ams = iio_priv(indio_dev);
Could roll these two lines into one as don't need to define
the types in between them.

struct ams *ams = iio_priv(get_drvdata(dev));

> > +
> > +       clk_prepare_enable(ams->clk);  
> 
> newlinke
> 
> > +       return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ams_pm_ops, ams_suspend, ams_resume);
> > +
> > +static struct platform_driver ams_driver = {
> > +       .probe = ams_probe,
> > +       .remove = ams_remove,
> > +       .driver = {
> > +               .name = "ams",
> > +               .pm     = &ams_pm_ops,
Odd indenting here.  I wouldn't bother to try aligning the values
it just causes pain when things change later and doesn't add clarity
in a small structure like this.

> > +               .of_match_table = ams_of_match_table,
> > +       },
> > +};
> > +module_platform_driver(ams_driver);
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_AUTHOR("Rajnikant Bhojani <rajnikant.bhojani@xilinx.com>");
> > diff --git a/drivers/iio/adc/xilinx-ams.h b/drivers/iio/adc/xilinx-ams.h
> > new file mode 100644
> > index 0000000..41d1dbc
> > --- /dev/null
> > +++ b/drivers/iio/adc/xilinx-ams.h
> > @@ -0,0 +1,278 @@
> > +#ifndef __XILINX_AMS_H__
> > +#define __XILINX_AMS_H__
> > +
> > +#define AMS_MISC_CTRL     0x000
> > +#define AMS_ISR_0         0x010
> > +#define AMS_ISR_1         0x014
> > +#define AMS_IMR_0         0x018
> > +#define AMS_IMR_1         0x01c
> > +#define AMS_IER_0         0x020
> > +#define AMS_IER_1         0x024
> > +#define AMS_IDR_0         0x028
> > +#define AMS_IDR_1         0x02c
> > +#define AMS_PS_CSTS       0x040
> > +#define AMS_PL_CSTS       0x044
> > +#define AMS_MON_CSTS      0x050
> > +
> > +#define AMS_VCC_PSPLL0    0x060
> > +#define AMS_VCC_PSPLL3    0x06C
> > +#define AMS_VCCINT        0x078
> > +#define AMS_VCCBRAM       0x07C
> > +#define AMS_VCCAUX        0x080
> > +#define AMS_PSDDRPLL      0x084
> > +#define AMS_PSINTFPDDR    0x09C
> > +
> > +#define AMS_VCC_PSPLL0_CH 48
> > +#define AMS_VCC_PSPLL3_CH 51
> > +#define AMS_VCCINT_CH     54
> > +#define AMS_VCCBRAM_CH    55
> > +#define AMS_VCCAUX_CH     56
> > +#define AMS_PSDDRPLL_CH   57
> > +#define AMS_PSINTFPDDR_CH 63
> > +
> > +#define AMS_REG_CONFIG0   0x100
> > +#define AMS_REG_CONFIG1   0x104
> > +#define AMS_REG_CONFIG2   0x108
> > +#define AMS_REG_CONFIG3   0x10C
> > +#define AMS_REG_CONFIG4   0x110
> > +#define AMS_REG_SEQ_CH0   0x120
> > +#define AMS_REG_SEQ_CH1   0x124
> > +#define AMS_REG_SEQ_CH2   0x118
> > +
> > +#define AMS_TEMP          0x000
> > +#define AMS_SUPPLY1       0x004
> > +#define AMS_SUPPLY2       0x008
> > +#define AMS_VP_VN         0x00c
> > +#define AMS_VREFP         0x010
> > +#define AMS_VREFN         0x014
> > +#define AMS_SUPPLY3       0x018
> > +#define AMS_SUPPLY4       0x034
> > +#define AMS_SUPPLY5       0x038
> > +#define AMS_SUPPLY6       0x03c
> > +#define AMS_SUPPLY7       0x200
> > +#define AMS_SUPPLY8       0x204
> > +#define AMS_SUPPLY9       0x208
> > +#define AMS_SUPPLY10      0x20c
> > +#define AMS_VCCAMS        0x210
> > +#define AMS_TEMP_REMOTE   0x214
> > +
> > +#define AMS_REG_VAUX(x)   (0x40 + (4*(x)))
> > +#define AMS_REG_VUSER(x)  (0x200 + (4*(x)))
> > +
> > +#define AMS_PS_RESET_VALUE   0xFFFFU
> > +#define AMS_PL_RESET_VALUE   0xFFFFU
> > +
> > +#define AMS_CONF0_CHANNEL_NUM_MASK      (0x3f << 0)
> > +
> > +#define AMS_CONF1_SEQ_MASK              (0xf << 12)
> > +#define AMS_CONF1_SEQ_DEFAULT           (0 << 12)
> > +#define AMS_CONF1_SEQ_SINGLE_PASS       (1 << 12)
> > +#define AMS_CONF1_SEQ_CONTINUOUS        (2 << 12)
> > +#define AMS_CONF1_SEQ_SINGLE_CHANNEL    (3 << 12)
> > +
> > +#define AMS_REG_SEQ0_MASK        0xFFFF
> > +#define AMS_REG_SEQ2_MASK        0x3F
> > +#define AMS_REG_SEQ1_MASK        0xFFFF
> > +#define AMS_REG_SEQ2_MASK_SHIFT  16
> > +#define AMS_REG_SEQ1_MASK_SHIFT  22
> > +
> > +#define AMS_REGCFG1_ALARM_MASK   0xF0F
> > +#define AMS_REGCFG3_ALARM_MASK   0x3F
> > +
> > +#define AMS_ALARM_TEMP            0x140
This mixture of register addresses and fields within in them
is very confusing.  Pick a standard naming convention and
use indenting to make the differences clear.
One that works well is.

#define AMS_REGNAME_REG                0xxxx
#define   AMS_REGNAME_FIELDNAME_SHIFT  7
#define   AMS_REGNAME_FIELDNAME_MASK   GENMASK(13, 7)

So add a small additional indent to fields and keep them consistently
named with the register they form part of.

There are other options, all I want is a consistent choice!
+ to see a grouping of everything about a given register.

> > +#define AMS_ALARM_SUPPLY1         0x144
> > +#define AMS_ALARM_SUPPLY2         0x148
> > +#define AMS_ALARM_OT              0x14c
> > +
> > +#define AMS_ALARM_SUPPLY3         0x160
> > +#define AMS_ALARM_SUPPLY4         0x164
> > +#define AMS_ALARM_SUPPLY5         0x168
> > +#define AMS_ALARM_SUPPLY6         0x16c
> > +#define AMS_ALARM_SUPPLY7         0x180
> > +#define AMS_ALARM_SUPPLY8         0x184
> > +#define AMS_ALARM_SUPPLY9         0x188
> > +#define AMS_ALARM_SUPPLY10        0x18c
> > +#define AMS_ALARM_VCCAMS          0x190
> > +#define AMS_ALARM_TEMP_REMOTE     0x194
> > +#define AMS_ALARM_THRESHOLD_OFF_10 0x10
> > +#define AMS_ALARM_THRESHOLD_OFF_20 0x20
> > +
> > +#define AMS_ALARM_THR_DIRECT_MASK 0x01
> > +#define AMS_ALARM_THR_MIN         0x0000
> > +#define AMS_ALARM_THR_MAX         0xffff
> > +
> > +#define AMS_NO_OF_ALARMS             32
> > +#define AMS_PL_ALARM_START           16
> > +#define AMS_ISR0_ALARM_MASK          0xFFFFFFFFU
> > +#define AMS_ISR1_ALARM_MASK          0xE000001FU
> > +#define AMS_ISR1_INTR_MASK_SHIFT     32
> > +#define AMS_ISR0_ALARM_2_TO_0_MASK     0x07
> > +#define AMS_ISR0_ALARM_6_TO_3_MASK     0x78
Use GENMASK for masks. I personally think they
are clearer when the mask is applied after
the shift...  Then you see something like
#define AMS_XX_ALARM_6_TO_3_MASK  GENMASK(8, 5)
#define AMS_XX_ALARM_6_TO_3_SHIFT 5

and
(current & ~AMS_XX_ALRM_6_TO_3_MASK) |
((value << AMS_XX_ALRM_6_TO_3_SHIFT) & AMS_XX_ALARM_6_TO_3_MASK)

At the moment your mask are sometimes shifted and sometimes not
(see AMS_REGCFG1_ALARM_MASK which is a compound of these two..)

> > +#define AMS_ISR0_ALARM_12_TO_7_MASK    0x3F
> > +#define AMS_CONF1_ALARM_2_TO_0_SHIFT   1
The association between the masks above and shifts here
is really not clear at all.  They get used together somewhat
at least.
> > +#define AMS_CONF1_ALARM_6_TO_3_SHIFT   5
> > +#define AMS_CONF3_ALARM_12_TO_7_SHIFT  8
> > +
> > +#define AMS_PS_CSTS_PS_READY       0x08010000U
> > +#define AMS_PL_CSTS_ACCESS_MASK    0x00000001U
> > +
> > +#define AMS_PL_MAX_FIXED_CHANNEL   10
> > +#define AMS_PL_MAX_EXT_CHANNEL     20
> > +
> > +#define AMS_INIT_TIMEOUT       10000
> > +
> > +/* Following scale and offset value is derivef from  
> 
> derived
> 
> > + * UG580 (v1.7) December 20, 2016
> > + */
> > +#define AMS_SUPPLY_SCALE_1VOLT     1000
> > +#define AMS_SUPPLY_SCALE_3VOLT     3000
> > +#define AMS_SUPPLY_SCALE_6VOLT     6000
> > +#define AMS_SUPPLY_SCALE_DIV_BIT   16
> > +
> > +#define AMS_TEMP_SCALE             509314
> > +#define AMS_TEMP_SCALE_DIV_BIT     16
> > +#define AMS_TEMP_OFFSET            -((280230L << 16) / 509314)

These aren't 'magic' numbers (which would be better explained
by a define) they are actual values.  It would be much
cleaner just to put them in the code directly.  IN the case
of the offset it is complex enough that it may be worth
explaining the logic that leads to this particular value in an
accompanying comment.

> > +
> > +enum ams_alarm_bit {
> > +       AMS_ALARM_BIT_TEMP,
It may seem overkill but, if you want to use an enum for
register bits, assign them specific integer values.
Makes it much easier to tell that nothing odd has happened such
as a missing entry breaking all the others.

Also, given you never actually use the enum type,
the purpose of making these an enum (type checking)
isn't valid.  I would just make them a set of defines.

> > +       AMS_ALARM_BIT_SUPPLY1,
> > +       AMS_ALARM_BIT_SUPPLY2,
> > +       AMS_ALARM_BIT_SUPPLY3,
> > +       AMS_ALARM_BIT_SUPPLY4,
> > +       AMS_ALARM_BIT_SUPPLY5,
> > +       AMS_ALARM_BIT_SUPPLY6,
> > +       AMS_ALARM_BIT_RESERVED,
> > +       AMS_ALARM_BIT_SUPPLY7,
> > +       AMS_ALARM_BIT_SUPPLY8,
> > +       AMS_ALARM_BIT_SUPPLY9,
> > +       AMS_ALARM_BIT_SUPPLY10,
> > +       AMS_ALARM_BIT_VCCAMS,
> > +       AMS_ALARM_BIT_TEMP_REMOTE
> > +};
> > +
> > +enum ams_seq {
> > +       AMS_SEQ_VCC_PSPLL,
> > +       AMS_SEQ_VCC_PSBATT,
> > +       AMS_SEQ_VCCINT,
> > +       AMS_SEQ_VCCBRAM,
> > +       AMS_SEQ_VCCAUX,
> > +       AMS_SEQ_PSDDRPLL,
> > +       AMS_SEQ_INTDDR
> > +};
> > +
> > +enum ams_ps_pl_seq {
> > +       AMS_SEQ_CALIB,
> > +       AMS_SEQ_RSVD_1,
> > +       AMS_SEQ_RSVD_2,
> > +       AMS_SEQ_TEST,
> > +       AMS_SEQ_RSVD_4,
> > +       AMS_SEQ_SUPPLY4,
> > +       AMS_SEQ_SUPPLY5,
> > +       AMS_SEQ_SUPPLY6,
> > +       AMS_SEQ_TEMP,
> > +       AMS_SEQ_SUPPLY2,
> > +       AMS_SEQ_SUPPLY1,
> > +       AMS_SEQ_VP_VN,
> > +       AMS_SEQ_VREFP,
> > +       AMS_SEQ_VREFN,
> > +       AMS_SEQ_SUPPLY3,
> > +       AMS_SEQ_CURRENT_MON,
> > +       AMS_SEQ_SUPPLY7,
> > +       AMS_SEQ_SUPPLY8,
> > +       AMS_SEQ_SUPPLY9,
> > +       AMS_SEQ_SUPPLY10,
> > +       AMS_SEQ_VCCAMS,
> > +       AMS_SEQ_TEMP_REMOTE,
> > +       AMS_SEQ_MAX
> > +};
> > +
> > +#define AMS_SEQ(x)          (AMS_SEQ_MAX + (x))
> > +#define AMS_VAUX_SEQ(x)     (AMS_SEQ_MAX + (x))
> > +
> > +#define PS_SEQ_MAX          AMS_SEQ_MAX
> > +#define PS_SEQ(x)           (x)
> > +#define PL_SEQ(x)           (PS_SEQ_MAX + x)
> > +
> > +#define AMS_CHAN_TEMP(_scan_index, _addr, _ext) { \
> > +       .type = IIO_TEMP, \
> > +       .indexed = 1, \
> > +       .address = (_addr), \
> > +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > +               BIT(IIO_CHAN_INFO_SCALE) | \
> > +               BIT(IIO_CHAN_INFO_OFFSET), \
> > +       .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +       .event_spec = ams_temp_events, \
> > +       .num_event_specs = ARRAY_SIZE(ams_temp_events), \
> > +       .scan_index = (_scan_index), \
> > +       .scan_type = { \  
> 
> scan_type not needed?
> 
> > +               .sign = 'u', \
> > +               .realbits = 12, \
> > +               .storagebits = 16, \
> > +               .shift = 4, \
> > +               .endianness = IIO_CPU, \
> > +       }, \
> > +       .extend_name = _ext, \
> > +}
> > +
> > +#define AMS_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) { \
> > +       .type = IIO_VOLTAGE, \
> > +       .indexed = 1, \
> > +       .address = (_addr), \
> > +       .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > +               BIT(IIO_CHAN_INFO_SCALE), \
> > +       .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> > +       .event_spec = (_alarm) ? ams_voltage_events : NULL, \
> > +       .num_event_specs = (_alarm) ? ARRAY_SIZE(ams_voltage_events) : 0, \
> > +       .scan_index = (_scan_index), \
> > +       .scan_type = { \
> > +               .realbits = 10, \
> > +               .storagebits = 16, \
> > +               .shift = 6, \
> > +               .endianness = IIO_CPU, \
> > +       }, \
> > +       .extend_name = _ext, \
A quick IIO rule of thumb is that we shouldn't have an extend_name without
a very very good reason.   These basically break generic userspace
code as it has no idea what to do with them.

So diving into what you have used them for, it may be valid, but
we need the docs to tell more easily!

> > +}
> > +
> > +#define AMS_PS_CHAN_TEMP(_scan_index, _addr, _ext) \
> > +       AMS_CHAN_TEMP(PS_SEQ(_scan_index), _addr, _ext)
> > +#define AMS_PS_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
> > +       AMS_CHAN_VOLTAGE(PS_SEQ(_scan_index), _addr, _ext, true)
> > +
> > +#define AMS_PL_CHAN_TEMP(_scan_index, _addr, _ext) \
> > +       AMS_CHAN_TEMP(PL_SEQ(_scan_index), _addr, _ext)
> > +#define AMS_PL_CHAN_VOLTAGE(_scan_index, _addr, _ext, _alarm) \
> > +       AMS_CHAN_VOLTAGE(PL_SEQ(_scan_index), _addr, _ext, _alarm)
> > +#define AMS_PL_AUX_CHAN_VOLTAGE(_auxno, _ext) \
> > +       AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(_auxno)), \
> > +                       AMS_REG_VAUX(_auxno), _ext, false)
> > +#define AMS_CTRL_CHAN_VOLTAGE(_scan_index, _addr, _ext) \
> > +       AMS_CHAN_VOLTAGE(PL_SEQ(AMS_VAUX_SEQ(AMS_SEQ(_scan_index))), \
> > +                       _addr, _ext, false)
> > +
> > +struct ams {
> > +       void __iomem *base;
> > +       void __iomem *ps_base;
> > +       void __iomem *pl_base;
> > +       struct clk *clk;
> > +       struct device *dev;
> > +
> > +       struct mutex mutex;
> > +       spinlock_t lock;
These two locks need documentation to explain exactly what they are protecting.
Makes it easier to see if they are being miss-used or missed.
> > +
> > +       unsigned int alarm_mask;
> > +       unsigned int masked_alarm;
> > +       u64 intr_mask;
> > +       int irq;
> > +
> > +       struct delayed_work ams_unmask_work;
> > +       const struct ams_pl_bus_ops *pl_bus;
> > +};
> > +
> > +struct ams_pl_bus_ops {
> > +       void (*read)(struct ams *ams, unsigned int offset, unsigned int *data);
> > +       void (*write)(struct ams *ams, unsigned int offset, unsigned int data);
> > +       void (*update)(struct ams *ams, unsigned int offset, u32 mask,
> > +                       u32 data);
> > +};
This abstraction only ever gets used with one set of functions.
So currently it just makes the code harder to read.

I guess there is another block of code coming that adds an alternative?
I would still have preferred this first version not do do this.  It should
ideally have been introduced in the patch series that adds an alternative.
Standard kernel rule is no abstraction unless needed...

> > +
> > +#endif /* __XILINX_AMS_H__ */
> > --
> > 2.7.4
> > 
> > This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
> >   
> 
