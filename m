Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF5C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1BC208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YrU6bjhz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1BC208EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbeGJSj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:39:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732424AbeGJSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CKTn+gcTxZIdSzI7Jn0YCxDEWkjvIue4uJf0b/5ma54=; b=YrU6bjhzZRjUspf+bezuy0Fhn
        JgAKmuvLLaBAcSjCpepL++snQoOVz2MdBsow4Mq6S7DxdG9Q04SLxzhFXMks9Cs2M/K7I4S5CWtUQ
        nEGZ8gqHcSdu+rOtlqWRD+etI56T3Y4aomz984VvoaHoFvMIAenGSWte33CSUwgOwbbck=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcx5l-00028S-3g; Tue, 10 Jul 2018 18:10:25 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fcx5k-0001Rj-6w; Tue, 10 Jul 2018 19:10:24 +0100
Date:   Tue, 10 Jul 2018 19:10:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Girish Mahadevan <girishm@codeaurora.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, boris.brezillon@bootlin.com
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Message-ID: <20180710181024.GF8104@sirena.org.uk>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
 <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kbCYTQG2MZjuOjyn"
Content-Disposition: inline
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
X-Cookie: To teach is to learn.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kbCYTQG2MZjuOjyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 05, 2018 at 03:46:42PM -0600, Girish Mahadevan wrote:

Overall this looks pretty good, but there were a few small issues
(mostly cosmetic):

> +	/*
> +	 * Ensure that the configuration goes through by reading back
> +	 * a register from the IO space.
> +	 */
> +	mb();
> +	mstr_cfg = readl_relaxed((ctrl->base + MSTR_CONFIG));
> +	pm_runtime_put_sync(ctrl->dev);
> +	return ret;

There's no need to use _put_sync() unless you *really* need the put to
go through immediately, if you don't need it then it'll just slow things
down.

> +	wr_cnts = (rd_fifo_status & WR_CNTS_MSK) >> WR_CNTS_SHFT;
> +	fifo_rdy = (rd_fifo_status & FIFO_RDY) ? true : false;
> +
> +	if (!fifo_rdy) {
> +		dev_dbg(ctrl->dev, "%s: Spurious IRQ 0x%x",
> +			__func__, rd_fifo_status);
> +		return IRQ_NONE;
> +	}

Please just use a normal if statement, it's easier to read.

> +	wr_fifo_bytes =
> +	readl_relaxed(ctrl->base + PIO_XFER_STATUS) >> WR_FIFO_BYTES_SHFT;

Just use something like

+	wr_fifo_bytes = readl_relaxed(ctrl->base + PIO_XFER_STATUS)
+				>> WR_FIFO_BYTES_SHFT;

Again, more legible.

> +static irqreturn_t qcom_qspi_irq(int irq, void *dev_id)
> +{
> +	u32 int_status;
> +	struct qcom_qspi *ctrl = dev_id;
> +	irqreturn_t ret = IRQ_HANDLED;
> +
> +	int_status = readl_relaxed(ctrl->base + MSTR_INT_STATUS);
> +	writel_relaxed(int_status, ctrl->base + MSTR_INT_STATUS);
> +
> +	if (int_status & WR_FIFO_EMPTY)
> +		ret = pio_write(ctrl);
> +
> +	if (int_status & RESP_FIFO_RDY)
> +		ret = pio_read(ctrl);

What if both bits are set and return different statuses?

> +static bool qcom_qspi_supports_op(struct spi_mem *mem,
> +				const struct spi_mem_op *op)
> +{
> +	return true;
> +}

So we definitely support all possible ops?

> +static int qcom_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}

If this can be empty it's prboably better to fix the callers so that
they don't need to provide it (looking at the code it seems that this is
already the case so you can just remove it).

--kbCYTQG2MZjuOjyn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltE9o8ACgkQJNaLcl1U
h9Af6AgAhCnYFi9h43XiBkYpYNKmd7XeTJGQ21ygOwJlATmULtetPdNv88OcqPdF
aNde7s8cGb9A218XkK2MtcavF98V2OnBTFWcogmURmkHos4uDKBkCW3UfIgMLL98
KwhE2Tcpv15XCOet9Cfoc/PNG7BurxRBbJnkT9+BhddlFfg9lP3I8y6OMkKqeX/O
Vl3ntT0oChMcR9oLI+KOsKVAmnJs1rF5mM1GGAuyhOZ4l9SgBBJGJHBYJ6Y+0fa+
LOCvPYAcPpybHi5rIoGp1scxIOb7oBR2nQc8SVwGc+1LP+6LITBwt04GbjqDeTQH
U/Yxwzy/SfjpoxU7krZWm/tmihN5LQ==
=IKH9
-----END PGP SIGNATURE-----

--kbCYTQG2MZjuOjyn--
