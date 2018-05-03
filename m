Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbeECXi5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:38:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34460 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbeECXiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:38:55 -0400
Date: Fri, 4 May 2018 08:38:49 +0900
From: Mark Brown <broonie@kernel.org>
To: Girish Mahadevan <girishm@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org, dianders@chromium.org,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI
 based QUP
Message-ID: <20180503233849.GF13402@sirena.org.uk>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline
In-Reply-To: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 03, 2018 at 03:34:43PM -0600, Girish Mahadevan wrote:
> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
> Qualcomm Generic Interface (GENI) is a programmable module supporting a
> wide range of serial interfaces including SPI. This driver supports SPI
> operations using FIFO mode of transfer.

This is a DT based driver but there is no binding documentation.
Binding documentation is required for any new DT stuff.

> +       depends on ARCH_QCOM || (ARM && COMPILE_TEST)

Why the ARM dependency?  There's no architecture specific headers
included...

>  obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
>  obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
> +obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
>  obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o

Please keep Kconfig and Makefile alphabetically sorted to reduce
conflicts.

> +static struct spi_master *get_spi_master(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct spi_master *spi = platform_get_drvdata(pdev);
> +
> +	return spi;
> +}

This doesn't look at all driver specific with the current naming but it
actually is given that other drivers may use other driver data so it
should be renamed.  I'm also not clear why it's bouncing through the
platform device, dev_get_drvdata() exists.

> +static int spi_geni_unprepare_message(struct spi_master *spi_mas,
> +					struct spi_message *spi_msg)
> +{
> +	struct spi_geni_master *mas = spi_master_get_devdata(spi_mas);
> +
> +	mas->cur_speed_hz = 0;
> +	mas->cur_word_len = 0;
> +	return 0;
> +}

Is this really useful?  If the driver needs to reconfigure for every
message then it should just do that and not care about the state.  If it
might end up caring about the state anyway that suggests there's some
kind of bug somewhere that's being masked.

> +static int spi_geni_prepare_transfer_hardware(struct spi_master *spi)
> +{
> +	struct spi_geni_master *mas = spi_master_get_devdata(spi);
> +	int ret = 0;
> +	struct geni_se *se = &mas->se;
> +
> +	ret = pm_runtime_get_sync(mas->dev);
> +	if (ret < 0) {

Use auto_runtime_pm.

> +	if (unlikely(!mas->setup)) {
> +		int proto = geni_se_read_proto(se);

Does this really need a likely/unlikely annotation - it shouldn't be any
kind of hot path...  There's a lot of these annotations in the code.

> +		ret = devm_request_irq(mas->dev, mas->irq, geni_spi_isr,
> +			       IRQF_TRIGGER_HIGH, "spi_geni", mas);
> +		if (ret) {
> +			dev_err(mas->dev, "Request_irq failed:%d: err:%d\n",

Why are we dynamically requesting the IRQ outside of probe?  Normally an
interrupt is requested on startup and held through the life of the
device.  I'm also not seeing any sign that it's freed except via devm...

> +	spi->bus_num = of_alias_get_id(pdev->dev.of_node, "spi");

Don't do this, just set bus_num to -1 and let the core assign an ID.

> +	spi->dev.of_node = pdev->dev.of_node;

This is broken, the virtual SPI device does not exist in DT and this
might break things.

> +	pm_runtime_enable(&pdev->dev);
> +	ret = spi_register_master(spi);

No devm?

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrrnYgACgkQJNaLcl1U
h9C0ZAf9HBm4HdgsBUt/v0XEybYkzizuKBtsvq9KvjJC8ngbNW2m0nivSBZu0QYq
DFpJa6p/CjzCbviF7OMFLtNLukR7KLAWrP3JYYUz9AWW0o+5sjCUmxtQQi6wYM7d
hvD0DEDfQ3FkvuCUi2pUaFX6xu6u1t8b+uqC21pR6T2iUA1jLxkuoPbPXN5N98kh
TDXscnglEnMZ0CCc1zia2Rxrr1556BzyjDyU6f7PTjDMBb+zQG70pXE1Ddv+5HkV
ExV5MkOZig+lZqMHrAdoy1u2fI9YNk3KccdQ8hw9FI+vDCaLRTzNSAHeOLvn9w3T
nty8LPMugARReOwVQbWEGSqKnUsH3Q==
=Fbhk
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
