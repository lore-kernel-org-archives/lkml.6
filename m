Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF8C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294D420855
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 05:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dvVNd+mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294D420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeIBJUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 05:20:44 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:34778 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbeIBJUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 05:20:43 -0400
Received: by mail-ua1-f67.google.com with SMTP id r15-v6so11013898uao.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 22:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zIMc182VuxitYFIq7hO2WmSlajamz2SpyFn/X7E8W+4=;
        b=dvVNd+mcuM7LZyyGqXrBADMP82n55zJONEf7NdW/tkJbeSk6UY1OVWg7cEqVzizS/b
         3fWmSiUjcF2hN+h6iR/cu/RTln181d4rnVtruUk50eJbx+fabiTTiXynH/0q4Q0x+xFA
         cKBeAJx5iLKW9fw5NXTcKPCWVNXcWMHILJNl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zIMc182VuxitYFIq7hO2WmSlajamz2SpyFn/X7E8W+4=;
        b=MHkdHjZrOrbFWiSqt/yMv6yQ321u++y9sFGKm6eOQKjSgPKQNMlSd9cmYQTqo/nDBY
         O4o7AjAAmu+4nSxjEGkgtHS06TEks78up9lUphBxupp75nUOs68UZbocmwlglWdnqUVZ
         1R/wBXl22EHQrH9sJQqtssuzBc5My8jB0obcoWtSRCYNRFeXaoUfnpy07iXcFVCFIgiw
         dwA2PzL3HseUlPZzlSoimn1zhbi6r9m09R/KQ2xVNxFNvDI2lZqp57q90qGlwUCMavZp
         aYJYm+SAkNudqxcX9Pgm8VvwDcGHivMC63vBx1NzU97LNn22OIUx+XbLYFWciqpOaxKO
         124Q==
X-Gm-Message-State: APzg51BLoU5LouTn+7RIsu1R14a1aqLWxaRS1MsfIrkt6UAXvtMR6kZP
        wbX7IFGvT8QqdHNp+LSFYNvPjEFQ96o=
X-Google-Smtp-Source: ANB0VdZR6/N3nSCUhKHJ4jiuH2Iiie9s8ptdIcIY8xgDd1DqsFBGHPnooE5W8bTX3lfZny7CpfM3gQ==
X-Received: by 2002:ab0:5a52:: with SMTP id m18-v6mr13947939uad.129.1535864773752;
        Sat, 01 Sep 2018 22:06:13 -0700 (PDT)
Received: from mail-vk0-f53.google.com (mail-vk0-f53.google.com. [209.85.213.53])
        by smtp.gmail.com with ESMTPSA id p24-v6sm5665710uag.54.2018.09.01.22.06.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 22:06:12 -0700 (PDT)
Received: by mail-vk0-f53.google.com with SMTP id b78-v6so6765325vka.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 22:06:12 -0700 (PDT)
X-Received: by 2002:a1f:ac08:: with SMTP id v8-v6mr11968696vke.32.1535864772187;
 Sat, 01 Sep 2018 22:06:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:3cd:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 22:06:10 -0700 (PDT)
In-Reply-To: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
References: <1535107336-2214-1-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 1 Sep 2018 22:06:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
Message-ID: <CAD=FV=XigmU1LXnNbj9NYkjJmj18chBFjbctrBeOKoS=34PLXw@mail.gmail.com>
Subject: Re: [PATCH V3] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 24, 2018 at 3:42 AM, Dilip Kota <dkota@codeaurora.org> wrote:
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---
> Addressing all the reviewer commets given in Patchset1.
> Summerizing all the comments below:
>
>         MAKEFILE: Arrange SPI-GENI driver in alphabetical order
>         Kconfig: Mark SPI_GENI driver dependent on QCOM_GENI_SE
>         Enable SPI core auto runtime pm, and remove runtime pm calls.
>         Remove spi_geni_unprepare_message(), spi_geni_unprepare_transfer_hardware()
>         Remove likely/unlikely keywords.
>         Remove get_spi_master() and use dev_get_drvdata()
>         Move request_irq to probe()
>         Mark bus number assignment to -1 as SPI core framework will assign dynamically
>         Use devm_spi_register_master()
>         Include platform_device.h instead of of_platform.h
>         Removing macros which are used only once:
>                 #define SPI_NUM_CHIPSELECT     4
>                 #define SPI_XFER_TIMEOUT_MS    250
>         Place Register field definitions next to respective Register definitions.
>         Replace int and u32 declerations to unsigned int.
>         Remove Hex numbers in debug prints.
>         Declare mode as u16 in spi_setup_word_len()
>         Remove the labels: setup_fifo_params_exit: exit_prepare_transfer_hardware:
>         Declaring struct spi_master as spi everywhere in the file.
>         Calling spi_finalize_current_transfer() for end of transfer.
>         Hard code the SPI controller max frequency instead of reading from DTSI node.
>         Spinlock not required, removed it.
>         Removed unrequired error prints.
>         Fix KASAN error in geni_spi_isr().
>         Remove spi-geni-qcom.h
>         Remove inter words delay and CS to Clock toggle delay logic in the driver, as of now no clients are using it.
>         Will submit this logic in the next patchset.
>         Use major, minor and step macros to read from hardware version register.
>
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt  |   2 -
>  drivers/spi/Kconfig                                |  12 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-geni-qcom.c                        | 678 +++++++++++++++++++++
>  4 files changed, 691 insertions(+), 2 deletions(-)

See below for comments.  In general I've tried to post patches to
address my own comments.  See the series ending at
<https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201142/1>.
From there you can download patch files by using the "DOWNLOAD" link
at the bottom.  Yell if you have problems.  Hopefully that's useful.
I expect that you can squash many of these into your patch to give you
a leg up on v3.

NOTE: I won't promise that I made no mistakes on my fixup patches nor
that I caught everything or did everything right.  I'll plan to take a
fresh look at the whole patch when I see your v3.


> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
> @@ -60,7 +60,6 @@ Required properties:
>  - interrupts:          Must contain SPI controller interrupts.
>  - clock-names:         Must contain "se".
>  - clocks:              Serial engine core clock needed by the device.
> -- spi-max-frequency:   Specifies maximum SPI clock frequency, units - Hz.

As per Rob's feedback, please split the device tree change into a
separate patch and justify it.  Perhaps the commit message could be
something like:

---

dt-bindings: spi: Remove spi-max-frequency from qcom,geni-se controller

No other SPI controllers have a "spi-max-frequency" at the controller
level.  The normal "spi-max-frequency" property is something that is
used when defining the nodes for SPI slaves.  While it is possible
that someone might want to define a controller-level max frequency it
should be done in other ways (perhaps by keying off a compatible
string?)

---

I think in the past Mark Brown has also requested that the bindings
actually live under "Documentation/devicetree/bindings/spi/", so
perhaps you should also add a patch to your series that moves this
documentation there and changes the "soc/qcom/qcom,geni-se.txt" to
reference that.


> +static irqreturn_t geni_spi_isr(int irq, void *data);
> +
> +struct spi_geni_master {
> +       struct geni_se se;
> +       unsigned int irq;

In v1 Stephen requested that many things in this struct become
"unsigned int", but he didn't mean the "irq".  Please change this back
to an int.  As you have things right now the code "if (spi_geni->irq <
0)" you have below is a no-op.  :(

...oh, and as Stephen pointed out to me offline you don't even need to
store irq.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201065


> +       struct device *dev;
> +       unsigned int rx_fifo_depth;
> +       unsigned int tx_fifo_depth;
> +       unsigned int tx_fifo_width;
> +       unsigned int tx_wm;

Anything that is effectively the contents of a hardware register
should be of type 'u32'.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201066


> +static int get_spi_clk_cfg(unsigned int speed_hz,
> +                       struct spi_geni_master *mas,
> +                       unsigned int *clk_idx,
> +                       unsigned int *clk_div)
> +{
> +       unsigned long sclk_freq;
> +       struct geni_se *se = &mas->se;
> +       int ret;
> +
> +       ret = geni_se_clk_freq_match(&mas->se,
> +                               (speed_hz * mas->oversampling), clk_idx,
> +                               &sclk_freq, true);

Pass "false" as the last parameter after picking my geni patch to make
this work right.  For my geni patch see
<https://lkml.kernel.org/r/20180830183612.169572-2-dianders@chromium.org>.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201064


> +       if (ret) {
> +               dev_err(mas->dev, "%s: Failed(%d) to find src clk for %dHz\n",
> +                                               __func__, ret, speed_hz);

As I said in previous reviews: printing __func__ is generally
discouraged for dev_xx printouts.  They've already got the device name
and that together with the string should be enough.  Remove it here
and elsewhere in this file.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201067


> +               return ret;
> +       }
> +
> +       *clk_div = ((sclk_freq / mas->oversampling) / speed_hz);

After changing exact to false, you'll want:

  *clk_div = DIV_ROUND_UP(sclk_freq, mas->oversampling * speed_hz);
  actual_hz = sclk_freq / (mas->oversampling * *clk_div);

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201064


> +       if (!(*clk_div)) {
> +               dev_err(mas->dev, "%s:Err:sclk:%lu oversampling:%d speed:%u\n",
> +                       __func__, sclk_freq, mas->oversampling, speed_hz);
> +               return -EINVAL;
> +       }

After change above to use DIV_ROUND_UP() you no longer need to check
for a zero clk_div.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201064


> +static void spi_setup_word_len(struct spi_geni_master *mas, u16 mode,
> +                                       unsigned int bits_per_word)
> +{
> +       unsigned int word_len, pack_words;
> +       bool msb_first = (mode & SPI_LSB_FIRST) ? false : true;
> +       struct geni_se *se = &mas->se;
> +
> +       word_len = readl_relaxed(se->base + SE_SPI_WORD_LEN);

Gratuitously using the __relaxed versions of readl() and writel() is
discouraged in Linux because it gives very little performance gain in
99.9% of the cases and it makes the code significantly harder to
reason about it.  Remove it in spi-geni-qcom.  If it is shown that a
particular read or write is in a performance critical section then
that one instance can be added back in after carefully analysis and
documentation.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201068


> +static int setup_fifo_params(struct spi_device *spi_slv,
> +                                       struct spi_master *spi)
> +{
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +       struct geni_se *se = &mas->se;
> +       unsigned int mode = spi_slv->mode;
> +       unsigned int loopback_cfg = readl_relaxed(se->base + SE_SPI_LOOPBACK);
> +       unsigned int cpol = readl_relaxed(se->base + SE_SPI_CPOL);
> +       unsigned int cpha = readl_relaxed(se->base + SE_SPI_CPHA);
> +       unsigned int demux_sel, clk_sel, m_clk_cfg, idx, div;
> +       int ret = 0;

In v1 Stephen said:

> Don't initialize variables and then overwrite them.

This is in lots of places in your code.  I've found and fixed them for you:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201070


> +       unsigned int demux_output_inv = 0;
> +
> +       loopback_cfg &= ~LOOPBACK_MSK;
> +       cpol &= ~CPOL;
> +       cpha &= ~CPHA;
> +
> +       if (mode & SPI_LOOP)
> +               loopback_cfg |= LOOPBACK_ENABLE;
> +
> +       if (mode & SPI_CPOL)
> +               cpol |= CPOL;
> +
> +       if (mode & SPI_CPHA)
> +               cpha |= CPHA;
> +
> +       if (spi_slv->mode & SPI_CS_HIGH)
> +               demux_output_inv = BIT(spi_slv->chip_select);
> +
> +       demux_sel = spi_slv->chip_select;
> +       mas->cur_speed_hz = spi_slv->max_speed_hz;
> +       mas->cur_word_len = spi_slv->bits_per_word;
> +
> +       ret = get_spi_clk_cfg(mas->cur_speed_hz, mas, &idx, &div);
> +       if (ret) {
> +               dev_err(mas->dev, "Err setting clks ret(%d) for %d\n",
> +                                                       ret, mas->cur_speed_hz);
> +               return ret;
> +       }
> +
> +       clk_sel = (idx & CLK_SEL_MSK);
> +       m_clk_cfg = ((div << CLK_DIV_SHFT) | SER_CLK_EN);

Please avoid useless parenthesis everywhere in this file.  Stephen
pointed out many of these in v1 but the correct thing to do would have
been to search for all instances and fix them, not just fix the ones
that Stephen pointed out.  I've now done it for you:

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201071


> +static int spi_geni_prepare_transfer_hardware(struct spi_master *spi)
> +{
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +       struct geni_se *se = &mas->se;
> +
> +       if (!mas->setup) {
> +               unsigned int proto = geni_se_read_proto(se);
> +               unsigned int major, minor, step, ver;
> +
> +               if (proto != GENI_SE_SPI) {
> +                       dev_err(mas->dev, "Invalid proto %d\n", proto);
> +                       return -ENXIO;
> +               }
> +               mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
> +               mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
> +               mas->tx_fifo_width = geni_se_get_tx_fifo_width(se);
> +
> +               /*
> +                * Hardware programming guide suggests to configure
> +                * RX FIFO RFR level to fifo_depth-2.
> +                */
> +               geni_se_init(se, 0x0, mas->tx_fifo_depth - 2);
> +               mas->oversampling = 1;
> +               /* Transmit an entire FIFO worth of data per IRQ */
> +               mas->tx_wm = 1;
> +               ver = geni_se_get_qup_hw_version(se);
> +               major = GENI_SE_VERSION_MAJOR(ver);
> +               minor = GENI_SE_VERSION_MINOR(ver);
> +               step = GENI_SE_VERSION_STEP(ver);

You don't use "step".  Kill it.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201069


> +       /*
> +        * If CS change flag is set, then toggle the CS line in between
> +        * transfers and keep CS asserted after the last transfer.
> +        * Else if keep CS flag asserted in between transfers and de-assert
> +        * CS after the last message.
> +        */
> +       if (xfer->cs_change) {
> +               if (list_is_last(&xfer->transfer_list,
> +                               &spi->cur_msg->transfers))
> +                       m_param |= FRAGMENTATION;
> +       } else {
> +               if (!list_is_last(&xfer->transfer_list,
> +                               &spi->cur_msg->transfers))

In v1 Stephen said:

> Combine else and if here into an else if.

...but really I think you could just do:

/*
 * Keep the CS asserted in either of the two cases:
 * - It's not the last transfer (and cs_change is not set)
 * - It is the last transfer (and cs_change is set)
 *
 * ...AKA keep it asserted whenever the "last transfer" and cs_change
 * booleans agree.
 */
if (!!xfer->cs_change ==
    !!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
        m_param |= FRAGMENTATION;

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201072


> +       if (m_cmd & SPI_TX_ONLY) {
> +               mas->tx_rem_bytes = xfer->len;
> +               writel_relaxed(trans_len, se->base + SE_SPI_TX_TRANS_LEN);
> +       }
> +
> +       if (m_cmd & SPI_RX_ONLY) {
> +               writel_relaxed(trans_len, se->base + SE_SPI_RX_TRANS_LEN);
> +               mas->rx_rem_bytes = xfer->len;
> +       }
> +       writel_relaxed(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
> +       geni_se_setup_m_cmd(se, m_cmd, m_param);
> +       if (m_cmd & SPI_TX_ONLY)
> +               writel_relaxed(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);

In v1 Stephen said:

> This can't be combined with above m_cmd & SPI_TX_ONLY statement?

In v2 I said:

> Girish said it can't.  ...but IMO if it really can't then please add a
> comment in the code so someone doesn't later go back and try to
> combine.

I don't see a comment.  An example of an appropriate comment (assuming
that the geni hardware really does need the services of a dark wizard)
would be:

/*
 * NOTE: we have to write the SE_GENI_TX_WATERMARK_REG _after_ the
 * write to SE_SPI_TRANS_CFG and the call to geni_se_setup_m_cmd()
 * because these two things perform a special incantation to summon a
 * dark wizard and we're not allowed to set the watermark until the
 * dark wizard arrives.
 */

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201073

Presumably writing to the watermark kicks off the interrupt happening
so it has to be last.  That would be something to say instead of
talking about magic.


> +static irqreturn_t geni_spi_handle_tx(struct spi_geni_master *mas)
> +{
> +       unsigned int i = 0;
> +       unsigned int tx_fifo_width = mas->tx_fifo_width / BITS_PER_BYTE;

This is super confusing.  You have two things with the same name
"tx_fifo_width" one that's in terms of bits and one that's in terms of
bytes.  ...in general it's really hard to figure out the units of all
your variables here.  For things that it's not clear you should rename
variables.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201075


> +       unsigned int max_bytes;
> +       const u8 *tx_buf;
> +       struct geni_se *se = &mas->se;
> +
> +       if (!mas->cur_xfer)
> +               return IRQ_NONE;
> +
> +       /*
> +        * For non-byte aligned bits-per-word values(e.g 9).
> +        * The FIFO packing is set to 1 SPI word per FIFO word.

In v1 Stephen said:

> Decapitalize "The"

You added a "." at the end of the first line so I guess it's not quite
as wrong as it was but it's still better grammar to just have one
sentence.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201074


> +        * Assumption is that each SPI word will be accomodated in
> +        * ceil (bits_per_word / bits_per_byte)
> +        * and the next SPI word starts at the next byte.
> +        * In such cases, we can fit 1 SPI word per FIFO word so adjust the
> +        * max byte that can be sent per IRQ accordingly.
> +        */
> +       max_bytes = (mas->tx_fifo_depth - mas->tx_wm);
> +       if (mas->tx_fifo_width % mas->cur_word_len)
> +               max_bytes *= ((mas->cur_word_len / BITS_PER_BYTE) + 1);

Even though the math should be the same (since you should you'll never
divide cur_word_len evenly), the above is clearer as:

  max_bytes *= DIV_ROUND_UP(mas->cur_word_len, BITS_PER_BYTE);

...oh, but even that is wrong.  SPI framework documents that we need
the nearest power of 2, so a 20-bit transfer will not take up 3 bytes
but will actually take up 4.

...and of course this same assumption is replicated twice in both the
tx and rx functions.  I'm just going to rewrite these two functions.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201076


> +       while (i < max_bytes) {
> +               unsigned int j;
> +               unsigned int fifo_word = 0;
> +               u8 *fifo_byte;
> +               unsigned int bytes_per_fifo = tx_fifo_width;
> +               unsigned int bytes_to_write = 0;
> +
> +               if (mas->tx_fifo_width % mas->cur_word_len)
> +                       bytes_per_fifo =
> +                               (mas->cur_word_len / BITS_PER_BYTE) + 1;
> +
> +               if (bytes_per_fifo < (max_bytes - i))
> +                       bytes_to_write = bytes_per_fifo;
> +               else
> +                       bytes_to_write = max_bytes - i;
> +
> +               fifo_byte = (u8 *)&fifo_word;
> +               for (j = 0; j < bytes_to_write; j++)
> +                       fifo_byte[j] = tx_buf[i++];

In previous reviews Stephen pointed out that he's not super keen on
this manual copy of bytes, but IMO it's not a huge deal and we can
find a better way to do it later.  ...but if someone wants to propose
a patch that makes it nicer then I won't object.


> +static irqreturn_t geni_spi_handle_rx(struct spi_geni_master *mas)
> +{
> +       unsigned int i = 0;
> +       struct geni_se *se = &mas->se;
> +       unsigned int fifo_width = mas->tx_fifo_width / BITS_PER_BYTE;

You're assuming TX and RX FIFO widths are the same.  Let's make that explicit.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201075


> +static int spi_geni_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct spi_master *spi;
> +       struct spi_geni_master *spi_geni;
> +       struct resource *res;
> +       struct geni_se *se;
> +
> +       spi = spi_alloc_master(&pdev->dev, sizeof(struct spi_geni_master));
> +       if (!spi) {
> +               ret = -ENOMEM;
> +               goto spi_geni_probe_err;

When spi_alloc_master() fails you don't want spi_master_put().

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201078


> +       spi->prepare_transfer_hardware = spi_geni_prepare_transfer_hardware;

IMO this is wrong.  You're using prepare_transfer_hardware() to do
one-time init.  Just do it at probe.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201079


> +       init_completion(&spi_geni->xfer_done);
> +       pm_runtime_enable(&pdev->dev);
> +       ret = devm_spi_register_master(&pdev->dev, spi);
> +       if (ret)
> +               goto spi_geni_probe_unmap;

In this error case I believe you need pm_runtime_disable().

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201078


> +       return ret;
> +spi_geni_probe_unmap:
> +       devm_iounmap(&pdev->dev, se->base);

The whole point of devm is that you don't need this kind of the error handling.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201078



> +static int spi_geni_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *spi = platform_get_drvdata(pdev);
> +       struct spi_geni_master *spi_geni = spi_master_get_devdata(spi);
> +
> +       geni_se_resources_off(&spi_geni->se);

In v2 I said:

> Why would you need to call geni_se_resources_off()?  Isn't it handled
> by pm_runtime?


> +       pm_runtime_put_noidle(&pdev->dev);

In v2 I said:

> I'm curious: why would you have a "put" here?  Won't that result in an
> imbalance since you don't exit probe with "get"?  ...or did pm_runtime
> throw me for a loop again?

> +       pm_runtime_disable(&pdev->dev);
> +       return 0;

So testing:

      cd /sys/bus/platform/drivers/geni_spi/
      echo 880000.spi > unbind
      sleep 2
      echo 880000.spi > bind

...in fact it yells a lot.  To me this means that you didn't test
spi_geni_remove() at all.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201077


> +static int __maybe_unused spi_geni_suspend(struct device *dev)
> +{
> +       if (!pm_runtime_status_suspended(dev))
> +               return -EBUSY;

I didn't have time to dig into Stephen Boyd's feedback, but please
make sure you address it here.  I agree that something seems fishy
here.

---

In v2, I said:

> I'm not sure where to comment about this, so adding it to the end:
>
> Between v1 and v2 you totally removed all the locking.  Presumably
> this is because you didn't want to hold the lock in
> handle_fifo_timeout() while waiting for the completion.  IMO taking
> the lock out was the wrong thing to do.  You should keep it, but just
> drop the lock before wait_for_completion_timeout() and add it back
> afterwards.  Specifically you _don't_ want the IRQ and timeout code
> stomping on each other.

...but still no spinlock?

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201081

---

As we've discussed offline, your current driver doesn't deal with chip
select in a correct enough way to make cros_ec_spi work.  I've applied
and fixed up your WIP patch to fix this.

https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/1201142


-Doug
