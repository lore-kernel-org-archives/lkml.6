Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeBWMkQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:40:16 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:34898 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeBWMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:40:14 -0500
X-Google-Smtp-Source: AG47ELuVHWS3DJAWyufoIPpZb7Px+sObhDi62bbQxgENprNAc743/KiubUxtF7upkR8xGOwvcpRci80T+5UA8ot7Fb8=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
References: <20180222191647.4727-1-ard.biesheuvel@linaro.org>
 <20180222191647.4727-3-ard.biesheuvel@linaro.org> <CAHp75Vc1AGzdgTB281XVo=FmZerkU1vijLih3JUO=_wNPjxgfA@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 23 Feb 2018 12:40:12 +0000
Message-ID: <CAKv+Gu9XkmSPHZf+jVKOm-SX1GCWJUc7y3zTCuaHBwk8O3OC3Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 12:27, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 22, 2018 at 9:16 PM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> This is a cleaned up version of the I2C controller driver for
>> the Fujitsu F_I2C IP, which was never supported upstream, and
>> has now been incorporated into the Socionext SynQuacer SoC.
>>
>
> Thanks for an update.
> My comments below.
>
> In case you address them, feel free to add
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  drivers/i2c/busses/Kconfig         |  11 +
>>  drivers/i2c/busses/Makefile        |   1 +
>>  drivers/i2c/busses/i2c-synquacer.c | 796 ++++++++++++++++++++
>>  3 files changed, 808 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index a9805c7cb305..9001dbaeb60a 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -995,6 +995,17 @@ config I2C_SUN6I_P2WI
>>           This interface is used to connect to specific PMIC devices (like the
>>           AXP221).
>>
>> +config I2C_SYNQUACER
>> +       tristate "Socionext SynQuacer I2C controller"
>> +       depends on ARCH_SYNQUACER || COMPILE_TEST
>
>> +       depends on OF || ACPI
>
> Does it make any sense?
>

Not really. ARCH_SYNQUACER only exists on arm64, and it mandates
CONFIG_OF. I will remove it.

>> +       help
>> +         Say Y here to include support for the I2C controller used in some
>> +         Fujitsu and Socionext SoCs.
>> +
>> +         This driver can also be built as a module. If so, the module
>> +         will be called i2c-synquacer.
>> +
>>  config I2C_TEGRA
>>         tristate "NVIDIA Tegra internal I2C controller"
>>         depends on ARCH_TEGRA
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 2ce8576540a2..40ab7bfc3458 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
...
>> +static inline unsigned long calc_timeout_ms(struct synquacer_i2c *i2c,
>> +                                           struct i2c_msg *msgs,
>> +                                           int num)
>> +{
>> +       unsigned long bit_count = 0;
>> +       int i;
>> +
>> +       for (i = 0; i < num; i++, msgs++)
>> +               bit_count += msgs->len;
>> +
>> +       return DIV_ROUND_UP((bit_count * 9 + 10 * num) * 3, 200) + 10;
>
> When I suggested to drop parens, I also suggested to swap second pair
> arguments (b/c I was thinking that parens to prevent confusion + vs
> *), like
>
> 9 * bit_count + 10 * num, or
> bit_count * 9 + num * 10.
>
> Though, it is up to you, I still consider that + vs. * operator
> precedence is quite obvious.
>

I can change it if you like.

>> +}
>> +
>> +static void synquacer_i2c_stop(struct synquacer_i2c *i2c, int ret)
>> +{
>> +       /*
>> +        * clear IRQ (INT=0, BER=0)
>> +        * set Stop Condition (MSS=0)
>> +        * Interrupt Disable
>> +        */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BCR);
>> +
>> +       i2c->state = STATE_IDLE;
>> +
>> +       i2c->msg_ptr = 0;
>> +       i2c->msg = NULL;
>> +       i2c->msg_idx++;
>> +       i2c->msg_num = 0;
>> +       if (ret)
>> +               i2c->msg_idx = ret;
>> +
>> +       complete(&i2c->completion);
>> +}
>> +
>> +static void synquacer_i2c_hw_init(struct synquacer_i2c *i2c)
>> +{
>> +       unsigned char ccr_cs, csr_cs;
>> +       u32 rt = i2c->clkrate;
>> +
>> +       /* Set own Address */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_ADR);
>> +
>> +       /* Set PCLK frequency */
>> +       writeb(SYNQUACER_I2C_BUS_CLK_FR(i2c->clkrate),
>> +              i2c->base + SYNQUACER_I2C_REG_FSR);
>> +
>> +       switch (i2c->speed_khz) {
>> +       case SYNQUACER_I2C_SPEED_FM:
>> +               if (i2c->clkrate <= SYNQUACER_I2C_CLK_RATE_18M) {
>> +                       ccr_cs = SYNQUACER_I2C_CCR_CS_FAST_MAX_18M(rt);
>> +                       csr_cs = SYNQUACER_I2C_CSR_CS_FAST_MAX_18M(rt);
>> +               } else {
>> +                       ccr_cs = SYNQUACER_I2C_CCR_CS_FAST_MIN_18M(rt);
>> +                       csr_cs = SYNQUACER_I2C_CSR_CS_FAST_MIN_18M(rt);
>> +               }
>> +
>> +               /* Set Clock and enable, Set fast mode */
>> +               writeb(ccr_cs | SYNQUACER_I2C_CCR_FM |
>> +                      SYNQUACER_I2C_CCR_EN,
>> +                      i2c->base + SYNQUACER_I2C_REG_CCR);
>> +               writeb(csr_cs, i2c->base + SYNQUACER_I2C_REG_CSR);
>> +               break;
>> +       case SYNQUACER_I2C_SPEED_SM:
>> +               if (i2c->clkrate <= SYNQUACER_I2C_CLK_RATE_18M) {
>> +                       ccr_cs = SYNQUACER_I2C_CCR_CS_STD_MAX_18M(rt);
>> +                       csr_cs = SYNQUACER_I2C_CSR_CS_STD_MAX_18M(rt);
>> +               } else {
>> +                       ccr_cs = SYNQUACER_I2C_CCR_CS_STD_MIN_18M(rt);
>> +                       csr_cs = SYNQUACER_I2C_CSR_CS_STD_MIN_18M(rt);
>> +               }
>> +
>> +               /* Set Clock and enable, Set standard mode */
>> +               writeb(ccr_cs | SYNQUACER_I2C_CCR_EN,
>> +                     i2c->base + SYNQUACER_I2C_REG_CCR);
>> +               writeb(csr_cs, i2c->base + SYNQUACER_I2C_REG_CSR);
>> +               break;
>> +       default:
>> +               WARN_ON(1);
>> +       }
>> +
>> +       /* clear IRQ (INT=0, BER=0), Interrupt Disable */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +}
>> +
>> +static void synquacer_i2c_hw_reset(struct synquacer_i2c *i2c)
>> +{
>> +       /* Disable clock */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_CCR);
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_CSR);
>> +
>> +       WAIT_PCLK(100, i2c->clkrate);
>> +
>> +       synquacer_i2c_hw_init(i2c);
>> +}
>> +
>> +static int synquacer_i2c_master_start(struct synquacer_i2c *i2c,
>> +                                     struct i2c_msg *pmsg)
>> +{
>> +       unsigned char bsr, bcr;
>> +
>> +       if (pmsg->flags & I2C_M_RD)
>> +               writeb((pmsg->addr << 1) | 1,
>> +                      i2c->base + SYNQUACER_I2C_REG_DAR);
>> +       else
>> +               writeb(pmsg->addr << 1,
>> +                      i2c->base + SYNQUACER_I2C_REG_DAR);
>> +
>> +       dev_dbg(i2c->dev, "slave:0x%02x\n", pmsg->addr);
>> +
>> +       /* Generate Start Condition */
>> +       bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>> +       bcr = readb(i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       dev_dbg(i2c->dev, "bsr:0x%02x, bcr:0x%02x\n", bsr, bcr);
>> +
>> +       if ((bsr & SYNQUACER_I2C_BSR_BB) &&
>> +           !(bcr & SYNQUACER_I2C_BCR_MSS)) {
>> +               dev_dbg(i2c->dev, "bus is busy");
>> +               return -EBUSY;
>> +       }
>> +
>> +       if (bsr & SYNQUACER_I2C_BSR_BB) { /* Bus is busy */
>> +               dev_dbg(i2c->dev, "Continuous Start");
>> +               writeb(bcr | SYNQUACER_I2C_BCR_SCC,
>> +                      i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       } else {
>> +               if (bcr & SYNQUACER_I2C_BCR_MSS) {
>> +                       dev_dbg(i2c->dev, "not in master mode");
>> +                       return -EAGAIN;
>> +               }
>> +               dev_dbg(i2c->dev, "Start Condition");
>> +               /* Start Condition + Enable Interrupts */
>> +               writeb(bcr | SYNQUACER_I2C_BCR_MSS |
>> +                      SYNQUACER_I2C_BCR_INTE | SYNQUACER_I2C_BCR_BEIE,
>> +                      i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       }
>> +
>> +       WAIT_PCLK(10, i2c->clkrate);
>> +
>> +       /* get bsr&bcr register */
>> +       bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>> +       bcr = readb(i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       dev_dbg(i2c->dev, "bsr:0x%02x, bcr:0x%02x\n", bsr, bcr);
>> +
>> +       if ((bsr & SYNQUACER_I2C_BSR_AL) ||
>> +           !(bcr & SYNQUACER_I2C_BCR_MSS)) {
>> +               dev_dbg(i2c->dev, "arbitration lost\n");
>> +               return -EAGAIN;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int synquacer_i2c_master_recover(struct synquacer_i2c *i2c)
>> +{
>> +       unsigned int count = 0;
>> +       unsigned char bc2r;
>> +
>> +       /* Disable interrupts */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BCR);
>> +
>> +       /* monitor SDA, SCL */
>> +       bc2r = readb(i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +       dev_dbg(i2c->dev, "bc2r:0x%02x\n", bc2r);
>> +
>
>> +       while (count <= 100) {
>> +               WAIT_PCLK(20, i2c->clkrate);
>> +               bc2r = readb(i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +
>> +               /* another master is running */
>> +               if ((bc2r & SYNQUACER_I2C_BC2R_SDAS) ||
>> +                   !(bc2r & SYNQUACER_I2C_BC2R_SCLS)) {
>> +                       dev_dbg(i2c->dev, "another master is running?\n");
>> +                       return -EAGAIN;
>> +               }
>> +               count++;
>> +       }
>
> I still consider do {} while not only taking less LOCs, but more
> readable and understanble
>
> unsigned int count = 100;
>
> do {
> ...
> } while (--count);
>

Sure. I'll change that.

>> +
>> +       /* Force to make one clock pulse */
>
>> +       for (count = 1;; count++) {
>> +               /* SCL = L->H */
>> +               writeb(SYNQUACER_I2C_BC2R_SCLL,
>> +                      i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +               WAIT_PCLK(20, i2c->clkrate);
>> +               writeb(0, i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +
>> +               WAIT_PCLK(10, i2c->clkrate);
>> +
>> +               bc2r = readb(i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +
>> +               WAIT_PCLK(5, i2c->clkrate);
>> +
>> +               if (bc2r & SYNQUACER_I2C_BC2R_SDAS)
>> +                       break;
>> +               WAIT_PCLK(10, i2c->clkrate);
>
>> +               if (count > 9) {
>> +                       dev_err(i2c->dev, "count: %i, bc2r: 0x%x\n", count,
>> +                               bc2r);
>> +                       return -EIO;
>> +               }
>
> (1)
>
>> +       }
>
> Ditto. More over in case (1) it's an invariant to the loop, so, it
> shouldn't be there in any case.
>

Fair enough. I will move it out.

>> +
>> +       /* force to make bus-error phase */
>> +       /* SDA = L */
>> +       writeb(SYNQUACER_I2C_BC2R_SDAL,
>> +              i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +       WAIT_PCLK(10, i2c->clkrate);
>> +       /* SDA = H */
>> +       writeb(0, i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +       WAIT_PCLK(10, i2c->clkrate);
>> +
>> +       /* Both SDA & SDL should be H */
>> +       bc2r = readb(i2c->base + SYNQUACER_I2C_REG_BC2R);
>> +       if ((bc2r & (SYNQUACER_I2C_BC2R_SDAS | SYNQUACER_I2C_BC2R_SCLS))
>> +           != (SYNQUACER_I2C_BC2R_SDAS | SYNQUACER_I2C_BC2R_SCLS)) {
>> +               dev_err(i2c->dev, "bc2r: 0x%x\n", bc2r);
>> +               return -EIO;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
>> +                               struct i2c_msg *msgs, int num)
>> +{
>> +       unsigned char bsr;
>> +       unsigned long timeout, bb_timeout;
>> +       int ret;
>> +
>> +       if (i2c->is_suspended)
>> +               return -EBUSY;
>> +
>> +       synquacer_i2c_hw_init(i2c);
>> +       bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>> +       if (bsr & SYNQUACER_I2C_BSR_BB) {
>> +               dev_err(i2c->dev, "cannot get bus (bus busy)\n");
>> +               return -EBUSY;
>> +       }
>> +
>> +       init_completion(&i2c->completion);
>> +
>> +       i2c->msg = msgs;
>> +       i2c->msg_num = num;
>> +       i2c->msg_ptr = 0;
>> +       i2c->msg_idx = 0;
>> +       i2c->state = STATE_START;
>> +
>> +       ret = synquacer_i2c_master_start(i2c, i2c->msg);
>> +       if (ret < 0) {
>> +               dev_dbg(i2c->dev, "Address failed: (%d)\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       timeout = wait_for_completion_timeout(&i2c->completion,
>> +                                       msecs_to_jiffies(i2c->timeout_ms));
>> +       if (timeout <= 0) {
>> +               dev_dbg(i2c->dev, "timeout\n");
>> +               return -EAGAIN;
>> +       }
>> +
>> +       ret = i2c->msg_idx;
>> +       if (ret != num) {
>> +               dev_dbg(i2c->dev, "incomplete xfer (%d)\n", ret);
>> +               return -EAGAIN;
>> +       }
>> +
>> +       /* ensure the stop has been through the bus */
>> +       bb_timeout = jiffies + HZ;
>> +       do {
>> +               bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>> +       } while ((bsr & SYNQUACER_I2C_BSR_BB) &&
>> +                time_before(jiffies, bb_timeout));
>
> I would rather do split timeout exit path with main condition, i.e.
>
> bsr = ...
> if (bsr & ...)
>  break; // return 0; ?
> } while (...);
>
> return 0; // return -ETIMEDOUT; ?
>

OK

>> +
>
>> +       return ret;
>
> return 0; ?
>

Yes.

>> +}
>> +
>> +static irqreturn_t synquacer_i2c_isr(int irq, void *dev_id)
>> +{
>> +       struct synquacer_i2c *i2c = dev_id;
>> +
>> +       unsigned char byte;
>> +       unsigned char bsr, bcr;
>> +       int ret = 0;
>> +
>> +       bcr = readb(i2c->base + SYNQUACER_I2C_REG_BCR);
>> +       bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
>> +       dev_dbg(i2c->dev, "bsr:0x%02x, bcr:0x%02x\n", bsr, bcr);
>> +
>> +       if (bcr & SYNQUACER_I2C_BCR_BER) {
>> +               dev_err(i2c->dev, "bus error\n");
>> +               synquacer_i2c_stop(i2c, -EAGAIN);
>> +               goto out;
>> +       }
>> +       if ((bsr & SYNQUACER_I2C_BSR_AL) ||
>> +           !(bcr & SYNQUACER_I2C_BCR_MSS)) {
>> +               dev_dbg(i2c->dev, "arbitration lost\n");
>> +               synquacer_i2c_stop(i2c, -EAGAIN);
>> +               goto out;
>> +       }
>> +
>> +       switch (i2c->state) {
>> +
>> +       case STATE_START:
>> +               if (bsr & SYNQUACER_I2C_BSR_LRB) {
>> +                       dev_dbg(i2c->dev, "ack was not received\n");
>> +                       synquacer_i2c_stop(i2c, -EAGAIN);
>> +                       goto out;
>> +               }
>> +
>> +               if (i2c->msg->flags & I2C_M_RD)
>> +                       i2c->state = STATE_READ;
>> +               else
>> +                       i2c->state = STATE_WRITE;
>> +
>> +               if (is_lastmsg(i2c) && i2c->msg->len == 0) {
>> +                       synquacer_i2c_stop(i2c, 0);
>> +                       goto out;
>> +               }
>> +
>> +               if (i2c->state == STATE_READ)
>> +                       goto prepare_read;
>> +
>> +               /* fallthru */
>> +
>> +       case STATE_WRITE:
>> +               if (bsr & SYNQUACER_I2C_BSR_LRB) {
>> +                       dev_dbg(i2c->dev, "WRITE: No Ack\n");
>> +                       synquacer_i2c_stop(i2c, -EAGAIN);
>> +                       goto out;
>> +               }
>> +
>> +               if (!is_msgend(i2c)) {
>> +                       writeb(i2c->msg->buf[i2c->msg_ptr++],
>> +                              i2c->base + SYNQUACER_I2C_REG_DAR);
>> +
>> +                       /* clear IRQ, and continue */
>> +                       writeb(SYNQUACER_I2C_BCR_BEIE |
>> +                              SYNQUACER_I2C_BCR_MSS |
>> +                              SYNQUACER_I2C_BCR_INTE,
>> +                              i2c->base + SYNQUACER_I2C_REG_BCR);
>> +                       break;
>> +               }
>> +               if (is_lastmsg(i2c)) {
>> +                       synquacer_i2c_stop(i2c, 0);
>> +                       break;
>> +               }
>> +               dev_dbg(i2c->dev, "WRITE: Next Message\n");
>> +
>> +               i2c->msg_ptr = 0;
>> +               i2c->msg_idx++;
>> +               i2c->msg++;
>> +
>> +               /* send the new start */
>> +               ret = synquacer_i2c_master_start(i2c, i2c->msg);
>> +               if (ret < 0) {
>> +                       dev_dbg(i2c->dev, "restart error (%d)\n", ret);
>> +                       synquacer_i2c_stop(i2c, -EAGAIN);
>> +                       break;
>> +               }
>> +               i2c->state = STATE_START;
>> +               break;
>> +
>> +       case STATE_READ:
>> +               if (!(bsr & SYNQUACER_I2C_BSR_FBT)) { /* data */
>> +                       byte = readb(i2c->base + SYNQUACER_I2C_REG_DAR);
>> +                       i2c->msg->buf[i2c->msg_ptr++] = byte;
>> +               } else /* address */
>> +                       dev_dbg(i2c->dev, "address:0x%02x. ignore it.\n",
>> +                               readb(i2c->base + SYNQUACER_I2C_REG_DAR));
>> +
>> +prepare_read:
>> +               if (is_msglast(i2c)) {
>> +                       writeb(SYNQUACER_I2C_BCR_MSS |
>> +                              SYNQUACER_I2C_BCR_BEIE |
>> +                              SYNQUACER_I2C_BCR_INTE,
>> +                              i2c->base + SYNQUACER_I2C_REG_BCR);
>> +                       break;
>> +               }
>> +               if (!is_msgend(i2c)) {
>> +                       writeb(SYNQUACER_I2C_BCR_MSS |
>> +                              SYNQUACER_I2C_BCR_BEIE |
>> +                              SYNQUACER_I2C_BCR_INTE |
>> +                              SYNQUACER_I2C_BCR_ACK,
>> +                              i2c->base + SYNQUACER_I2C_REG_BCR);
>> +                       break;
>> +               }
>> +               if (is_lastmsg(i2c)) {
>> +                       /* last message, send stop and complete */
>> +                       dev_dbg(i2c->dev, "READ: Send Stop\n");
>> +                       synquacer_i2c_stop(i2c, 0);
>> +                       break;
>> +               }
>> +               dev_dbg(i2c->dev, "READ: Next Transfer\n");
>> +
>> +               i2c->msg_ptr = 0;
>> +               i2c->msg_idx++;
>> +               i2c->msg++;
>> +
>> +               ret = synquacer_i2c_master_start(i2c, i2c->msg);
>> +               if (ret < 0) {
>> +                       dev_dbg(i2c->dev, "restart error (%d)\n", ret);
>> +                       synquacer_i2c_stop(i2c, -EAGAIN);
>> +               } else
>> +                       i2c->state = STATE_START;
>> +               break;
>> +       default:
>> +               dev_err(i2c->dev, "called in err STATE (%d)\n", i2c->state);
>> +               break;
>> +       }
>> +
>> +out:
>> +       WAIT_PCLK(10, i2c->clkrate);
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +static int synquacer_i2c_xfer(struct i2c_adapter *adap,
>> +                             struct i2c_msg *msgs, int num)
>> +{
>> +       struct synquacer_i2c *i2c;
>> +       int retry;
>
>> +       int ret = 0;
>
> Redundant assignment.
>

OK will remove

>> +
>> +       if (!msgs)
>> +               return -EINVAL;
>> +       if (num <= 0)
>> +               return -EINVAL;
>> +
>> +       i2c = i2c_get_adapdata(adap);
>> +       i2c->timeout_ms = calc_timeout_ms(i2c, msgs, num);
>> +
>> +       dev_dbg(i2c->dev, "calculated timeout %d ms\n",
>> +               i2c->timeout_ms);
>> +
>> +       for (retry = 0; retry < adap->retries; retry++) {
>> +
>> +               ret = synquacer_i2c_doxfer(i2c, msgs, num);
>> +               if (ret != -EAGAIN)
>> +                       return ret;
>> +
>> +               dev_dbg(i2c->dev, "Retrying transmission (%d)\n",
>> +                       retry);
>> +
>> +               synquacer_i2c_master_recover(i2c);
>> +               synquacer_i2c_hw_reset(i2c);
>> +       }
>> +       return -EIO;
>> +}
>> +
>> +static u32 synquacer_i2c_functionality(struct i2c_adapter *adap)
>> +{
>> +       return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
>> +}
>> +
>> +static const struct i2c_algorithm synquacer_i2c_algo = {
>> +       .master_xfer    = synquacer_i2c_xfer,
>> +       .functionality  = synquacer_i2c_functionality,
>> +};
>> +
>> +static struct i2c_adapter synquacer_i2c_ops = {
>> +       .owner          = THIS_MODULE,
>> +       .name           = "synquacer_i2c-adapter",
>> +       .algo           = &synquacer_i2c_algo,
>> +       .retries        = 5,
>> +};
>> +
>> +static int synquacer_i2c_probe(struct platform_device *pdev)
>> +{
>> +       struct synquacer_i2c *i2c;
>> +       struct resource *r;
>> +       int speed_khz;
>> +       int ret;
>> +
>> +       ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>> +                                      &speed_khz);
>> +       if (ret) {
>> +               dev_err(&pdev->dev,
>> +                       "Missing clock-frequency property\n");
>> +               return -EINVAL;
>> +       }
>> +       speed_khz /= 1000;
>> +
>> +       i2c = devm_kzalloc(&pdev->dev, sizeof(*i2c), GFP_KERNEL);
>> +       if (!i2c)
>> +               return -ENOMEM;
>> +
>
>> +       if (dev_of_node(&pdev->dev)) {
>> +               i2c->clk = devm_clk_get(&pdev->dev, "pclk");
>> +               if (IS_ERR(i2c->clk)) {
>> +                       dev_err(&pdev->dev, "cannot get clock\n");
>> +                       return PTR_ERR(i2c->clk);
>> +               }
>> +               dev_dbg(&pdev->dev, "clock source %p\n", i2c->clk);
>> +
>> +               i2c->clkrate = clk_get_rate(i2c->clk);
>> +               dev_dbg(&pdev->dev, "clock rate %d\n", i2c->clkrate);
>> +               clk_prepare_enable(i2c->clk);
>> +       } else {
>> +               ret = device_property_read_u32(&pdev->dev,
>> +                                              "socionext,pclk-rate",
>> +                                              &i2c->clkrate);
>> +               if (ret)
>> +                       return ret;
>> +       }
>
> Okay, I got this case. It's more likely the one in 8250_dw.c.
>
> Can you do the similar way?
>

Could you elaborate?

>> +
>> +       if (i2c->clkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
>> +           i2c->clkrate > SYNQUACER_I2C_MAX_CLK_RATE) {
>> +               dev_err(&pdev->dev, "PCLK rate out of range (%d)\n",
>> +                       i2c->clkrate);
>> +               return -EINVAL;
>> +       }
>> +
>> +       r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       i2c->base = devm_ioremap_resource(&pdev->dev, r);
>> +       if (IS_ERR(i2c->base))
>> +               return PTR_ERR(i2c->base);
>> +
>
>> +       dev_dbg(&pdev->dev, "registers %p (%p)\n", i2c->base, r);
>
> This one is achievable via /proc/iomem, isn't it?
>

Yes, I can drop that.

>> +
>> +       i2c->irq = platform_get_irq(pdev, 0);
>> +       if (i2c->irq <= 0) {
>
> < 0 ?
>
> On some platforms IRQ == 0 might be valid.
>

Are you sure about that?

http://yarchive.net/comp/linux/no_irq.html

>> +               dev_err(&pdev->dev, "no IRQ resource found\n");
>> +               return -ENODEV;
>> +       }
>> +
>> +       ret = devm_request_irq(&pdev->dev, i2c->irq, synquacer_i2c_isr,
>> +                              0, dev_name(&pdev->dev), i2c);
>> +       if (ret < 0) {
>> +               dev_err(&pdev->dev, "cannot claim IRQ %d\n", i2c->irq);
>> +               return ret;
>> +       }
>> +
>> +       i2c->state = STATE_IDLE;
>> +       i2c->dev = &pdev->dev;
>> +       i2c->speed_khz = SYNQUACER_I2C_SPEED_SM;
>> +       if (speed_khz == SYNQUACER_I2C_SPEED_FM)
>> +               i2c->speed_khz = SYNQUACER_I2C_SPEED_FM;
>> +
>> +       synquacer_i2c_hw_init(i2c);
>> +
>> +       i2c->adapter = synquacer_i2c_ops;
>> +       i2c_set_adapdata(&i2c->adapter, i2c);
>> +       i2c->adapter.dev.parent = &pdev->dev;
>> +       i2c->adapter.nr = pdev->id;
>> +
>> +       ret = i2c_add_numbered_adapter(&i2c->adapter);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "failed to add bus to i2c core\n");
>> +               return ret;
>> +       }
>> +
>> +       platform_set_drvdata(pdev, i2c);
>> +
>> +       dev_info(&pdev->dev, "%s: synquacer_i2c adapter\n",
>> +                               dev_name(&i2c->adapter.dev));
>> +
>> +       return 0;
>> +}
>> +
>> +static int synquacer_i2c_remove(struct platform_device *pdev)
>> +{
>> +       struct synquacer_i2c *i2c = platform_get_drvdata(pdev);
>> +
>> +       platform_set_drvdata(pdev, NULL);
>> +       i2c_del_adapter(&i2c->adapter);
>> +       clk_disable_unprepare(i2c->clk);
>> +
>> +       return 0;
>> +};
>> +
>> +static int __maybe_unused synquacer_i2c_suspend(struct device *dev)
>> +{
>> +       struct synquacer_i2c *i2c = dev_get_drvdata(dev);
>> +
>> +       i2c_lock_adapter(&i2c->adapter);
>> +       i2c->is_suspended = true;
>> +       i2c_unlock_adapter(&i2c->adapter);
>> +
>> +       clk_disable_unprepare(i2c->clk);
>> +
>> +       return 0;
>> +}
>> +
>> +static int __maybe_unused synquacer_i2c_resume(struct device *dev)
>> +{
>> +       struct synquacer_i2c *i2c = dev_get_drvdata(dev);
>> +       int ret;
>> +
>> +       i2c_lock_adapter(&i2c->adapter);
>> +
>> +       ret = clk_prepare_enable(i2c->clk);
>> +       if (!ret)
>> +               i2c->is_suspended = false;
>> +
>> +       i2c_unlock_adapter(&i2c->adapter);
>> +
>> +       return ret;
>> +}
>> +
>> +static SIMPLE_DEV_PM_OPS(synquacer_i2c_pm, synquacer_i2c_suspend,
>> +                        synquacer_i2c_resume);
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id synquacer_i2c_dt_ids[] = {
>> +       { .compatible = "socionext,synquacer-i2c" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, synquacer_i2c_dt_ids);
>> +#endif
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id synquacer_i2c_acpi_ids[] = {
>> +       { "SCX0003" },
>> +       { /* sentinel */ }
>> +};
>> +#endif
>> +
>> +static struct platform_driver synquacer_i2c_driver = {
>> +       .probe  = synquacer_i2c_probe,
>> +       .remove = synquacer_i2c_remove,
>> +       .driver = {
>> +               .name = "synquacer_i2c",
>> +               .of_match_table = of_match_ptr(synquacer_i2c_dt_ids),
>> +               .acpi_match_table = ACPI_PTR(synquacer_i2c_acpi_ids),
>> +               .pm = &synquacer_i2c_pm,
>> +       },
>> +};
>> +module_platform_driver(synquacer_i2c_driver);
>> +
>> +MODULE_AUTHOR("Fujitsu Semiconductor Ltd");
>> +MODULE_DESCRIPTION("Socionext SynQuacer I2C Driver");
>> +MODULE_LICENSE("GPL v2");
>> --
>> 2.11.0
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
