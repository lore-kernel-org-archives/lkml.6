Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752527AbeCMSTk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:19:40 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45689 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeCMSTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:19:38 -0400
X-Google-Smtp-Source: AG47ELvSF7yR1/+y+SONwnuateDyNQ11I7as+pliqesdKYBK0+58wHNi9c0hUHzP7bxZF+K7a2ykk7s8ncF28B3mgEQ=
MIME-Version: 1.0
In-Reply-To: <20180313160326.18180-4-thierry.escande@linaro.org>
References: <20180313160326.18180-1-thierry.escande@linaro.org> <20180313160326.18180-4-thierry.escande@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Tue, 13 Mar 2018 19:18:57 +0100
Message-ID: <CAMZdPi-hoqhX_S-nFeE6ABUOZAp6oPtZqpLbpXoe5jDqmiFozA@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: Add serdev support
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 17:03, Thierry Escande <thierry.escande@linaro.org> wrote:
> From: Thierry Escande <thierry.escande@collabora.com>
>
> Add support for Qualcomm serial slave devices. Probe the serial device,
> retrieve its maximum speed and register a new hci uart device.
>
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
>  drivers/bluetooth/Kconfig   |   2 +-
>  drivers/bluetooth/hci_qca.c | 102 +++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 101 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 07e55cd8f8c8..c2a6a7ebd14b 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -195,7 +195,7 @@ config BT_HCIUART_BCM
>
>  config BT_HCIUART_QCA
>         bool "Qualcomm Atheros protocol support"
> -       depends on BT_HCIUART
> +       depends on BT_HCIUART_SERDEV

Driver depends on both BT_HCIUART and BT_HCIUART_SERDEV.

> @@ -386,6 +399,7 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
>  /* Initialize protocol */
>  static int qca_open(struct hci_uart *hu)
>  {
> +       struct qca_serdev *qcadev;
>         struct qca_data *qca;
>
>         BT_DBG("hu %p qca_open", hu);
> @@ -444,6 +458,13 @@ static int qca_open(struct hci_uart *hu)
>         timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>         qca->tx_idle_delay = IBS_TX_IDLE_TIMEOUT_MS;
>
> +       if (hu->serdev) {
> +               serdev_device_open(hu->serdev);
> +
> +               qcadev = serdev_device_get_drvdata(hu->serdev);
> +               gpiod_set_value(qcadev->bt_en, 1);

I suggest to replace gpiod_set_value calls with the _cansleep version.
You always set gpio value from sleepable context and this should avoid
any further issue with different gpio controller.

Regards,
Loic
