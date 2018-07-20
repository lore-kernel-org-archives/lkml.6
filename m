Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CBCECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A668206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 22:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="C0Qw+OT4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YDyLiyGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A668206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeGTXn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 19:43:29 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:44981 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbeGTXn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 19:43:29 -0400
Received: by mail-vk0-f66.google.com with SMTP id 125-v6so6777953vke.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 15:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uHRRg9tVuTD5kKP2VeFPD5lXgTQPwb/6uSAcDaaCzvw=;
        b=C0Qw+OT4OjVUKzTfl3HS3tpXsGTAJJekpODLlUcZG70qNWtol6jnZHe/gxT4EIK7Zl
         PVP/+Da0Z40XRkOCuXzL17lD0Vw/ECSOnRDtf/fuFcqc4j3CQfv8Q6RXOtC4N/JfDmqB
         LHJeCzajJyrz3kGHyp5X4/xyfFNSJ4XNTWlU8hccVi3R1rle1o54OTciTE1yCvjgU1k/
         CN8HoEbHG/Ina1z0woTW6FtR7A2o1S26dQmkm/fuWpgz8aMSNBY/NW39HbtAM+yTbjiF
         p96/mRD4/j9GjTLV6NHPzZXqXYATMGlrjzjR8pHhO17qTdLv2Pa6x5Y6bERfAn1SruO+
         f6Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=uHRRg9tVuTD5kKP2VeFPD5lXgTQPwb/6uSAcDaaCzvw=;
        b=YDyLiyGZK9xmOdFxOQjtULs+9R1IbAY82k9M048v/xSX6GrLhHeULynX6L21bfq1bM
         TL/9HoEn1X5mhq0gbA3Mp4xzMnwJ7h4hhu5eje6M40SYZ4xeWqAfO9/vL4gqOMDmz/+r
         2/dvSMMuOd/Xz8/En94amkamUp8y6S0BRS+90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=uHRRg9tVuTD5kKP2VeFPD5lXgTQPwb/6uSAcDaaCzvw=;
        b=oi2DOy03gu/ufQHei+WQkAOP62TFJCyTXzTwhQiSNqb9qhUS90bqmgYOO12UdWb6PY
         nPEO8W+T6mUBOUuZLnBBHuWQYiYRUTgW3aG5wmDOBQYsr1tj4/D18WC7PIw/weBoESzV
         hM5Q0zbVsVwdc6OoLyguw1o9Nm/fWFrY9MaHD4NTMV2vS70RRl2MbAuMdkysMVIUW0w8
         +ecfS7f3zb3KTsxJz8ZO6kts7JkZzOhdzJWFsUT/NhLKVYxKvONj1RTAD8+wbJBqcbQh
         H4uiFUmbv1Rf8in9SBcFtbPKIKsP+hfdpzdmvWht6T1SKSKGVAt+SxGDiHedEiY3dF6T
         4fww==
X-Gm-Message-State: AOUpUlHnzVmZMGtifzUvBemFTYymDbNSYvb/3LFwDzZgswrS3v7kRAxA
        6L8ZZ049TKhorgCye2ls6cpWjdbt7/nvrNC3wgxVnw==
X-Google-Smtp-Source: AAOMgpeDgn6hOT6FfWV+00APPiVV4duhoYYPX4FgDCA4HGHPgblbilRZbTx9MDKDfPT9pdciY1xh8ZTjcc0w2ZKtjoA=
X-Received: by 2002:a1f:3653:: with SMTP id d80-v6mr2408121vka.79.1532127186419;
 Fri, 20 Jul 2018 15:53:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:cd5:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 15:53:05 -0700 (PDT)
In-Reply-To: <1532087461-3474-2-git-send-email-dkota@codeaurora.org>
References: <1532087461-3474-1-git-send-email-dkota@codeaurora.org> <1532087461-3474-2-git-send-email-dkota@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 Jul 2018 15:53:05 -0700
X-Google-Sender-Auth: XcGvJwcPY9oW3wRO7Cd10YjqZwE
Message-ID: <CAD=FV=VEQwudhCU0h7muB6ZM1WPETW0h4-=wo_=jgk0gyqfhBA@mail.gmail.com>
Subject: Re: [PATCH V2] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
To:     Dilip Kota <dkota@codeaurora.org>
Cc:     Timur Tabi <timur@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi,

On Fri, Jul 20, 2018 at 4:50 AM, Dilip Kota <dkota@codeaurora.org> wrote:
> From: Girish Mahadevan <girishm@codeaurora.org>
>
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.
>
> Change-Id: Ib2c7feba5a2fc4015bc83319b233b4356f7d3190
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
> Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>

Why is Girish here twice?  That doesn't seem right.  This is also an
awful lot of Signed-off-by tags.  Did they all contribute code here?
v1 of this patch only had girish.


> Reviewed-by: Rob Herring <robh@kernel.org>

Rob may have reviewed the bindings, but that doesn't mean he's happy
with the code.  I'd suggest removing his Reviewed-by


> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Are you certain that Stephen provided his Reviewed-by?  I don't see
it.  ...and, as you can see below, it seems like you ignored most of
Stephen's comments on v1.



> Signed-off-by: Dilip Kota <dkota@codeaurora.org>
> ---

I would have expected some version history here to say what changed
from v1 to v2.  See my comments on the cover letter and consider using
patman <https://github.com/u-boot/u-boot/tree/master/tools/patman> to
help you.


> +config SPI_QCOM_GENI
> +       tristate "Qualcomm SPI controller with QUP interface"

On v1 Stephen Boyd said:

> This is the same help text as the SPI_QUP config up above. Please make
> it different somehow by adding GENI or something like that instead of
> QUP?

More explicitly, please change the line to:
  tristate "Qualcomm SPI controller with GENI interface"


> +       depends on QCOM_GENI_SE
> +       help
> +         This driver supports GENI serial engine based SPI controller in
> +         master mode on the Qualcomm Technologies Inc.'s SoCs. If you say
> +         yes to this option, support will be included for the built-in SPI

On v1 Stephen Boyd said:

> Drop "built-in"?


> +struct spi_geni_master {
> +       struct geni_se se;
> +       int irq;
> +       struct device *dev;
> +       int rx_fifo_depth;
> +       int tx_fifo_depth;
> +       int tx_fifo_width;
> +       int tx_wm;

In v1 Stephen said:

> All of these can be unsigned ints?


> +       bool setup;
> +       u32 cur_speed_hz;
> +       int cur_word_len;

In v1 Stephen said:

> unsigned?


> +       unsigned int tx_rem_bytes;
> +       unsigned int rx_rem_bytes;
> +       struct spi_transfer *cur_xfer;
> +       struct completion xfer_done;
> +       int oversampling;

In v1 Stephen said:

> unsigned?


> +static int get_spi_clk_cfg(u32 speed_hz, struct spi_geni_master *mas,

In v1 Stephen said:

> Why a u32? And not unsigned int?


> +       if (ret) {
> +               dev_err(mas->dev, "%s: Failed(%d) to find src clk for 0x%x\n",
> +                                               __func__, ret, speed_hz);

In v1 Stephen said:

> Frequency Hz printed in hex? I am not a hex computer! I hope!

...I'll further add that printing __func__ is generally discouraged
for dev_xx printouts.  They've already got the device name and that
together with the string should be enough.  Remove it.


> +static void spi_setup_word_len(struct spi_geni_master *mas, u32 mode,

In v1 Stephen said:

> mode is only u16 in spi_device struct. Maybe it would be better to pass
> the spi_device struct here and then pick out the mode from there.


> +static int setup_fifo_params(struct spi_device *spi_slv,
> +                                       struct spi_master *spi)
> +{
> +       struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +       struct geni_se *se = &mas->se;
> +       u16 mode = spi_slv->mode;
> +       u32 loopback_cfg = readl_relaxed(se->base + SE_SPI_LOOPBACK);
> +       u32 cpol = readl_relaxed(se->base + SE_SPI_CPOL);
> +       u32 cpha = readl_relaxed(se->base + SE_SPI_CPHA);
> +       u32 demux_sel = 0;
> +       u32 demux_output_inv = 0;
> +       u32 clk_sel = 0;
> +       u32 m_clk_cfg = 0;
> +       int ret = 0;

In v1 Stephen said:

> Don't initialize variables and then overwrite them.


> +       demux_sel = spi_slv->chip_select;
> +       mas->cur_speed_hz = spi_slv->max_speed_hz;

In v1 Stephen said:

> Why can't you use clk_get_rate() instead? Or call clk_set_rate() with
> the rate you want the master clk to run at and then divide that down
> from there?

...there was a bunch of arguments here and I'm not sure I followed all
of them, but the net-net is that there should be no rate at the
controller level.  Each SPI slave should request its rate and that
should take effect for each transfer.  Basically just honor the rate
of the transfer in setup_fifo_xfer and be done with it.


> +       mas->cur_word_len = spi_slv->bits_per_word;
> +
> +       ret = get_spi_clk_cfg(mas->cur_speed_hz, mas, &idx, &div);
> +       if (ret) {
> +               dev_err(mas->dev, "Err setting clks ret(%d) for %d\n",
> +                                                       ret, mas->cur_speed_hz);
> +               return ret;
> +       }
> +
> +       clk_sel |= (idx & CLK_SEL_MSK);

In v1 Stephen said:

> Just assign clk_sel instead of ORing it because it's initialized to 0
> up above.


> +       m_clk_cfg |= ((div << CLK_DIV_SHFT) | SER_CLK_EN);

In v1 Stephen said:

> Same story.


> +               mas->tx_fifo_depth = geni_se_get_tx_fifo_depth(se);
> +               mas->rx_fifo_depth = geni_se_get_rx_fifo_depth(se);
> +               mas->tx_fifo_width = geni_se_get_tx_fifo_width(se);
> +               geni_se_init(se, 0x0, (mas->tx_fifo_depth - 2));

In v1 Stephen said:

> Why 2? Drop extra parenthesis please.

Girish responded that the 2 is important and that he would add a
detailed comment, which I don't see.  I also still see parenthesis.


> +               mas->oversampling = 1;
> +               /* Transmit an entire FIFO worth of data per IRQ */
> +               mas->tx_wm = 1;
> +               geni_se_get_wrapper_version(se, major, minor, step);

In v1 Stephen said:

> Drop extra parenthesis.

I'll further add that I'd prefer it if you based your series atop
<https://patchwork.kernel.org/patch/10412417/> which changes the
prototype here.


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


> +       mas->cur_xfer = xfer;
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

Girish said it can't.  ...but IMO if it really can't then please add a
comment in the code so someone doesn't later go back and try to
combine.


> +static void geni_spi_handle_tx(struct spi_geni_master *mas)
> +{
> +       int i = 0;
> +       int tx_fifo_width = mas->tx_fifo_width / BITS_PER_BYTE;
> +       int max_bytes = 0;
> +       const u8 *tx_buf;
> +       struct geni_se *se = &mas->se;
> +
> +       if (!mas->cur_xfer)
> +               return;
> +
> +       /*
> +        * For non-byte aligned bits-per-word values. (e.g 9)
> +        * The FIFO packing is set to 1 SPI word per FIFO word.

In v1 Stephen said:

> Decapitalize "The"


> +        * Assumption is that each SPI word will be accomodated in
> +        * ceil (bits_per_word / bits_per_byte)
> +        * and the next SPI word starts at the next byte.
> +        * In such cases, we can fit 1 SPI word per FIFO word so adjust the
> +        * max byte that can be sent per IRQ accordingly.
> +        */
> +       if ((mas->tx_fifo_width % mas->cur_word_len))

In v1 Stephen said:

> Drop extra parenthesis please.


> +               max_bytes = (mas->tx_fifo_depth - mas->tx_wm) *
> +                               ((mas->cur_word_len / BITS_PER_BYTE) + 1);
> +       else
> +               max_bytes = (mas->tx_fifo_depth - mas->tx_wm) * tx_fifo_width;

In v1 Stephen said:

> The above if else needs braces, or it could be written as:
>
>   max_bytes = mas->tx_fifo_depth - mas->tx_wm;
>   if (mas->tx_fifo_width % mas->cur_word_len) {
>     max_bytes *= (mas->cur_word_len / BITS_PER_BYTE) + 1;
>   else
>     max_bytes *= tx_fifo_width;


> +       tx_buf = mas->cur_xfer->tx_buf;
> +       tx_buf += (mas->cur_xfer->len - mas->tx_rem_bytes);

In v1 Stephen said:

> Drop parenthesis.


> +       max_bytes = min_t(int, mas->tx_rem_bytes, max_bytes);

In v1 Stephen said:

> Why isn't max_bytes unsigned?


> +       while (i < max_bytes) {
> +               int j;
> +               u32 fifo_word = 0;
> +               u8 *fifo_byte;
> +               int bytes_per_fifo = tx_fifo_width;
> +               int bytes_to_write = 0;
> +
> +               if ((mas->tx_fifo_width % mas->cur_word_len))

In v1 Stephen said:

> Drop parenthesis.


> +                       bytes_per_fifo =
> +                               (mas->cur_word_len / BITS_PER_BYTE) + 1;
> +               bytes_to_write = min_t(int, max_bytes - i, bytes_per_fifo);

In v1 Stephen said:

> More things can be unsigned?


> +               fifo_byte = (u8 *)&fifo_word;
> +               for (j = 0; j < bytes_to_write; j++)
> +                       fifo_byte[j] = tx_buf[i++];

In v1 Stephen said:

> Why are we doing all this work to fill in a fifo byte at a time? tx_buf
> should be a buffer of bytes that we can iowrite32_rep() with directly.
> And then we could just run iowrite32_rep() with some count of bytes to
> write? I suppose we may run into problems with unaligned size buffers,
> but it sounds like that doesn't happen?

Girish had a response to this and Stephen had another question which
was never answered.  Specifically he asked:

> Have you tested out non-byte aligned word size transfers?

Please answer and also add a comment justifying why we're doing all
this work to fill a fifo a byte at a time.


> +static void geni_spi_handle_rx(struct spi_geni_master *mas)
> +{
> +       int i = 0;
> +       struct geni_se *se = &mas->se;
> +       int fifo_width = mas->tx_fifo_width / BITS_PER_BYTE;
> +       u32 rx_fifo_status = readl_relaxed(se->base + SE_GENI_RX_FIFO_STATUS);
> +       int rx_bytes = 0;
> +       int rx_wc = 0;
> +       u8 *rx_buf;
> +
> +       if (!mas->cur_xfer)
> +               return;

In v1 Stephen said:

> This is an error condition? We should return IRQ_NONE in such a case in
> the irq handler? Or somehow indicate this up that we actually handled an
> rx or not so the irqhandler can do the right thing.


> +       /*
> +        * For non-byte aligned bits-per-word values. (e.g 9)
> +        * The FIFO packing is set to 1 SPI word per FIFO word.
> +        * Assumption is that each SPI word will be accomodated in
> +        * ceil (bits_per_word / bits_per_byte)
> +        * and the next SPI word starts at the next byte.
> +        */
> +       if (!(mas->tx_fifo_width % mas->cur_word_len))
> +               rx_bytes += rx_wc * fifo_width;
> +       else
> +               rx_bytes += rx_wc *
> +                       ((mas->cur_word_len / BITS_PER_BYTE) + 1);
> +       rx_bytes = min_t(int, mas->rx_rem_bytes, rx_bytes);

In v1 Stephen said:

> min_t is preferably avoided.


> +       rx_buf += (mas->cur_xfer->len - mas->rx_rem_bytes);

In v1 Stephen said:

> Drop parenthesis.


> +       while (i < rx_bytes) {
> +               u32 fifo_word = 0;
> +               u8 *fifo_byte;
> +               int bytes_per_fifo = fifo_width;
> +               int read_bytes = 0;
> +               int j;
> +
> +               if ((mas->tx_fifo_width % mas->cur_word_len))

In v1 Stephen said:

> Drop parenthesis.


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
> +               dev_err(&pdev->dev, "Failed to alloc spi struct\n");

In v1 Stephen said:

> We don't need allocation error messages.



> +       platform_set_drvdata(pdev, spi);
> +       spi_geni = spi_master_get_devdata(spi);
> +       spi_geni->dev = &pdev->dev;
> +       spi_geni->se.dev = &pdev->dev;
> +       spi_geni->se.wrapper = dev_get_drvdata(pdev->dev.parent);
> +       se = &spi_geni->se;
> +
> +       spi->bus_num = -1;
> +       spi->dev.of_node = pdev->dev.of_node;

In v1 Mark Brown said:

> This is broken, the virtual SPI device does not exist in DT and this
> might break things.

...though I'm as confused as Girish was.  It seems like all the
drivers do what you're doing...  I didn't dig into the code though.


> +       spi_geni->se.clk = devm_clk_get(&pdev->dev, "se");
> +       if (IS_ERR(spi_geni->se.clk)) {
> +               ret = PTR_ERR(spi_geni->se.clk);
> +               dev_err(&pdev->dev, "Err getting SE Core clk %d\n", ret);
> +               goto spi_geni_probe_err;
> +       }
> +
> +       if (of_property_read_u32(pdev->dev.of_node, "spi-max-frequency",
> +                               &spi->max_speed_hz)) {

In v1 Stephen said:

> Why does this need to come from DT?

Please remove this concept.  No other SPI driver has it.


> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       se->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(se->base)) {
> +               ret = -ENOMEM;
> +               dev_err(&pdev->dev, "Err IO mapping iomem\n");

In v1 Stephen said:

> We don't need these error messages. devm_ioremap_resource() already does
> it.


> +       init_completion(&spi_geni->xfer_done);
> +       pm_runtime_enable(&pdev->dev);
> +       ret = devm_spi_register_master(&pdev->dev, spi);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Failed to register SPI master\n");

In v1 Stephen said:

> Most likely spi_register_master() is going to print what went wrong so
> this print is not useful.


> +static int spi_geni_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *master = platform_get_drvdata(pdev);
> +       struct spi_geni_master *spi_geni = spi_master_get_devdata(master);
> +
> +       geni_se_resources_off(&spi_geni->se);

Why would you need to call geni_se_resources_off()?  Isn't it handled
by pm_runtime?


> +       pm_runtime_put_noidle(&pdev->dev);

I'm curious: why would you have a "put" here?  Won't that result in an
imbalance since you don't exit probe with "get"?  ...or did pm_runtime
throw me for a loop again?


> diff --git a/include/linux/spi/spi-geni-qcom.h b/include/linux/spi/spi-geni-qcom.h
> new file mode 100644
> index 0000000..dc95764
> --- /dev/null
> +++ b/include/linux/spi/spi-geni-qcom.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

In v1 Stephen said:

> Why?


> +/*
> + * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef __SPI_GENI_QCOM_HEADER___
> +#define __SPI_GENI_QCOM_HEADER___
> +
> +struct spi_geni_qcom_ctrl_data {

In v1 Stephen said:

> What's the point of this header file and structure? This driver supports
> board files? Isn't everything DT now?

There was a bunch of discussion in followup threads but no closure and
I still don't understand why we need this.  Please remove it.

One note is that Girish seemed to justify this by saying it's useful
for "inter-transfer delays within a message".  Isn't this just the
"delay_usecs" within a transfer?  I think the answer here is to remove
the header file and structure and if you can later show where it's
used then we can always add it back in.


> +       u32 spi_cs_clk_delay;
> +       u32 spi_inter_words_delay;
> +};
> +
> +#endif /*__SPI_GENI_QCOM_HEADER___*/
> --

I'm not sure where to comment about this, so adding it to the end:

Between v1 and v2 you totally removed all the locking.  Presumably
this is because you didn't want to hold the lock in
handle_fifo_timeout() while waiting for the completion.  IMO taking
the lock out was the wrong thing to do.  You should keep it, but just
drop the lock before wait_for_completion_timeout() and add it back
afterwards.  Specifically you _don't_ want the IRQ and timeout code
stomping on each other.

---

I'll also mention that you just wasted quite a bit of reviewer
resources for me to repeat the refrain "you didn't address comments
from v1".  Reviewer time is precious.  It's better that you wasted my
time than Mark's, but there are still better things for me to do.
Please be more careful.  I realize that this is your first patch
posted but ignoring previous feedback is not a good start.  If you
want to see the v1 discussion, you can easily find it at:

https://patchwork.kernel.org/patch/10379299/


...since I spent so much time checking over what you did vs. v1, I
didn't actually have a chance to review v2 on its own merits.


-Doug
