Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdOty5cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72D0960555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeFFSru (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:47:50 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44892 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932334AbeFFSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:47:48 -0400
X-Google-Smtp-Source: ADUXVKIw7MoKQ1WolBlHnOdl299lppWdn4OZqfsk3g4oz8iK4qFoUjD6oISFYRKi7d+UGXrKIkRIDGiX/vP2+U2f06k=
MIME-Version: 1.0
In-Reply-To: <1528224240-30786-3-git-send-email-mark.jonas@de.bosch.com>
References: <1528224240-30786-1-git-send-email-mark.jonas@de.bosch.com> <1528224240-30786-3-git-send-email-mark.jonas@de.bosch.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 6 Jun 2018 21:47:46 +0300
Message-ID: <CAHp75Vd0xqKwJCYqOWvFTpMy8iH4PPf_HXX4dkx=KER4UD13fA@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: implement companion-spi driver
To: Mark Jonas <mark.jonas@de.bosch.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiko Schocher <hs@denx.de>, Zhu Yi <yi.zhu5@cn.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 9:43 PM, Mark Jonas <mark.jonas@de.bosch.com> wrote:

> The low level companion-spi driver encapsulates the communication
> details with the companion processor, and provides interface for
> the upper level drivers to access.

> +int companion_do_io_tx(struct device     *parent,
> +                       const char __user *buf,
> +                       size_t             count)
> +{
> +       struct companion_spi_priv *priv = dev_get_drvdata(parent);
> +       unsigned int               copied;
> +       int                        error;
> +       struct companion_packet    p;
> +

> +       /*TODO: support mutiple packets in one write in future*/

Hmm... Either fix this, or remove comment?

> +       if (copy_from_user(p.data, buf, sizeof(p)) == 0) {
> +               if (is_can_type(&p))
> +                       return -EINVAL;
> +       } else {
> +               dev_info(parent, "copy from user not succeed in one call\n");

Shouldn't it return immediately?

> +       }

> +
> +       error = qm_io_txq_in(&priv->pm.qm, buf, count, &copied);

...what the point to call if we got garbage from user space?

> +       if (!error) {

The usual pattern is to check for errors first.

> +               wake_up_interruptible(&priv->wait);
> +               priv->pm.stats.io_tx++;
> +               return copied;
> +       } else {
> +               priv->pm.stats.io_tx_overflows++;
> +       }
> +       return error;
> +}

> +       ... qm_io_rxq_out(&priv->pm.qm, buf, count, &copied);

> +       ... pm_can_data_tx(&priv->pm, port, prio, cf);

Oh, oh, oh.

These namespaces are too generic, moreover pm is kinda occupied by
power management. You bring a lot of confusion here, I think.

> +       err = pm_can_get_txq_status(pm, port);
> +       if (!err) {

if (err)
 return err;

> +       }
> +       return err;


> +       int                        ret, value;
> +
> +       ret = sscanf(buf, "%d", &value);
> +       if (ret != 1) {

> +       }

You have to be consistent in your code.

I've already noticed

err
error

and now

ret

Choose one and stick with it.

Also check your entire patch series' code for consistency.

> +static DEVICE_ATTR(dump_packets, S_IRUGO | S_IWUSR,
> +                   show_dump_packets, store_dump_packets);

We have helpers, like DEVICE_ATTR_RW().

> +               ret  = snprintf(buf + pos, PAGE_SIZE - pos,
> +                               "\ntx: %u, rx: %u, err: %u\n\n",
> +                               total,
> +                               priv->pm.stats.can_rx_overflows[i],
> +                               priv->pm.stats.can_err_overflows[i]);

Please, avoid leading '\n'.

> +       gpio_set_value(priv->cs_gpios, priv->cs_gpios_assert);

> +       gpio_set_value(priv->cs_gpios, !priv->cs_gpios_assert);

Can you switch to GPIO descriptor API?

> +       unsigned int count = READY_POLL_US / READY_POLL_US_GRAN;
> +       while (count--) {

For counting like this better to have
do {
} while (--count);

The rationale, reader at first glance will know that the loop will
iterate at least once.

> +               if (slave_is_not_busy(priv))
> +                       return 0;
> +

> +               udelay(READY_POLL_US_GRAN);

Should it be atomic?
Can it use read_poll_* type of helpers instead?

> +       }

Above comments applicable to entire code you have.

> +static void companion_spi_cpu_to_be32(char *buf)
> +{
> +       u32 *buf32 = (u32*)buf;
> +       int  i;
> +
> +       for (i = 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32++)
> +               *buf32 = cpu_to_be32(*buf32);
> +}

This entire function should be replaced by one of the helpers from
include/linux/byteorder/generic.h

I guess cpu_to_be32_array() is a right one.

> +static void companion_spi_be32_to_cpu(char *buf)
> +{
> +       u32 *buf32 = (u32*)buf;
> +       int  i;
> +
> +       for (i = 0; i < (BCP_PACKET_SIZE / sizeof(u32)); i++, buf32++)
> +               *buf32 = be32_to_cpu(*buf32);
> +}

Ditto.

Recommendation: check your code against existing helpers.

> +               p = (const struct companion_packet*)transfer->tx_buf;

> +       companion_spi_cpu_to_be32((char*)transfer->tx_buf);

If tx_buf is type of void * all these castings are redundant.

Also looking at the function, did you consider to use whatever SPI
core provides, like CS handling, messages handling and so on?

> +static int companion_spi_thread(void *data)
> +{
> +       struct companion_spi_priv *priv = data;
> +       struct companion_packet    tx_packet;
> +       struct companion_packet    rx_packet;
> +       struct spi_message         message;
> +       struct spi_transfer        transfer;
> +
> +       memset(&transfer, 0, sizeof(transfer));
> +       transfer.tx_buf        = tx_packet.data;
> +       transfer.rx_buf        = rx_packet.data;
> +       transfer.len           = sizeof(struct companion_packet);

> +       transfer.cs_change     = 0;

Redundant.

> +       transfer.bits_per_word = 32;
> +

> +       for (;;) {

Infinite loops are evil in most of the cases.
I see here

do {
} while (kthread_should_stop());

> +               if (wait_event_interruptible(priv->wait,
> +                                            kthread_should_stop()   ||
> +                                            slave_has_request(priv) ||
> +                                            qm_has_tx_data(&priv->pm.qm)))
> +                       continue;
> +
> +               if (kthread_should_stop())
> +                       break;
> +
> +               pm_prepare_tx(&priv->pm, &tx_packet);
> +               companion_spi_transceive(priv, &message, &transfer);
> +               pm_on_tx_done(&priv->pm);
> +               pm_on_rx_done(&priv->pm, &rx_packet);
> +       }
> +
> +       return 0;
> +}

> +static const struct of_device_id companion_spi_of_match[] = {
> +       { .compatible = DRIVER_NAME, .data = NULL, },
> +       { /* sentinel */ },

terminators better without commas.

> +};

> +static struct spi_driver companion_spi_driver = {
> +       .driver = {
> +               .name           = DRIVER_NAME,

> +               .owner          = THIS_MODULE,

This is redundant, macro you are using below sets that.

> +               .of_match_table = of_match_ptr(companion_spi_of_match),
> +       },
> +       .probe  = companion_spi_probe,
> +       .remove = companion_spi_remove,
> +};
> +module_spi_driver(companion_spi_driver);

> +static void io_process(struct companion_protocol_manager *pm,
> +                       const struct companion_packet     *p)

Something wrong with indentation in this file.

> +#define CHECK_SIZE(x) BUILD_BUG_ON(sizeof(struct companion_packet) != \
> +                                   sizeof(x))

Better to split like
 _SIZE(x) \
BUILD_BUG_ON()

> +void pm_init(struct companion_protocol_manager *pm)

Unfortunately, horrible name for the function.
Namespace is kinda occupied, name itself way too generic.

> +       if (ctrl & CAN_CTRLMODE_LISTENONLY)
> +               p.mode = BCP_CAN_MODE_LISTEN;
> +       else
> +               return -EOPNOTSUPP;

if (!(cond))
 return -ERRNO;

?

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Do you still need this text?

> + * TODO: add more statistics fields and export to sysfs

Do it or remove the comment?

> + * TODO: re-think the data structure for handle CAN response

Ditto.

> +/**
> + * BCP status field definitions
> + */
> +#define BCP_STATUS_SUCCESS 0x00u
> +#define BCP_STATUS_UNKNOWN 0x01u
> +#define BCP_STATUS_OTHER   0x02u

BIT() ?


> +struct companion_packet {
> +       __u8 data[BCP_PACKET_SIZE];
> +};

Is it going from / to user space? Otherwise why __ kind of type?

> +#define CAN_MAX_IN_A_ROW 8
> +
> +
> +

Too many blank lines.

> +int companion_do_can_err(struct device           *parent,
> +                         u8                       port,
> +                         struct can_berr_counter *bec,
> +                         u8                      *state,
> +                         u8                      *code);

+ blank line here.

> +#define COMPANION_CAN_STATE_WARNING 0x01u
> +#define COMPANION_CAN_STATE_PASSIVE 0x02u
> +#define COMPANION_CAN_STATE_BUS_OFF 0x04u
> +#define COMPANION_CAN_ERROR_STUFF   0x01u
> +#define COMPANION_CAN_ERROR_FORM    0x02u
> +#define COMPANION_CAN_ERROR_ACK     0x04u
> +#define COMPANION_CAN_ERROR_BIT1    0x08u
> +#define COMPANION_CAN_ERROR_BIT0    0x10u
> +#define COMPANION_CAN_ERROR_CRC     0x20u
> +#define COMPANION_CAN_ERROR_RXOV    0x80u

BIT() ?

-- 
With Best Regards,
Andy Shevchenko
