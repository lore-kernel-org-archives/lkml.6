Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeERJIC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 05:08:02 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54855 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752939AbeERJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 05:07:59 -0400
X-Google-Smtp-Source: AB8JxZqkEmPhbqHtvOF7c2VJv4Ri0duPChfuhlPaNVIUq0R+95oMzq9iFZ1J7gOwRrQ/uTAvj8SfTA==
Date: Fri, 18 May 2018 11:07:55 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH v1 10/11] cpufreq: tegra20: Wrap cpufreq into platform
 driver
Message-ID: <20180518090755.GJ14500@ulmo>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MMMIZFJzhAsRj/+"
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-11-digetx@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MMMIZFJzhAsRj/+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 17, 2018 at 09:00:55PM +0300, Dmitry Osipenko wrote:
> Currently tegra20-cpufreq kernel module isn't getting autoloaded because
> there is no device associated with the module, this is one of two patches
> that resolves the module autoloading. This patch adds a module alias that
> will associate the tegra20-cpufreq kernel module with the platform device,
> other patch will instantiate the actual platform device. And now it makes
> sense to wrap cpufreq driver into a platform driver for consistency.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 116 +++++++++++++++++++-----------
>  1 file changed, 73 insertions(+), 43 deletions(-)
>=20
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-=
cpufreq.c
> index c0a7b5a78aa6..f9d02a28df9e 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -19,7 +19,7 @@
>  #include <linux/clk.h>
>  #include <linux/cpufreq.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/platform_device.h>
> =20
>  static struct cpufreq_frequency_table freq_table[] =3D {
>  	{ .frequency =3D 216000 },
> @@ -33,15 +33,19 @@ static struct cpufreq_frequency_table freq_table[] =
=3D {
>  	{ .frequency =3D CPUFREQ_TABLE_END },
>  };
> =20
> -static struct clk *cpu_clk;
> -static struct clk *pll_x_clk;
> -static struct clk *pll_p_clk;
> -static bool pll_x_prepared;
> +struct tegra20_cpufreq_data {

Nit: I'm not a big fan of _data suffixes because they are completely
redundant. Any data structure by definition hosts data, so I'd just drop
that.

[...]
> @@ -152,55 +161,76 @@ static struct cpufreq_driver tegra_cpufreq_driver =
=3D {
>  	.suspend		=3D cpufreq_generic_suspend,
>  };
> =20
> -static int __init tegra_cpufreq_init(void)
> +static int tegra20_cpufreq_probe(struct platform_device *pdev)
>  {
> +	struct tegra20_cpufreq_data *data;
>  	int err;
> =20
> -	if (!of_machine_is_compatible("nvidia,tegra20"))
> -		return -ENODEV;
> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> =20
> -	cpu_clk =3D clk_get_sys(NULL, "cclk");
> -	if (IS_ERR(cpu_clk))
> -		return PTR_ERR(cpu_clk);
> +	data->cpu_clk =3D clk_get_sys(NULL, "cclk");
> +	if (IS_ERR(data->cpu_clk))
> +		return PTR_ERR(data->cpu_clk);
> =20
> -	pll_x_clk =3D clk_get_sys(NULL, "pll_x");
> -	if (IS_ERR(pll_x_clk)) {
> -		err =3D PTR_ERR(pll_x_clk);
> +	data->pll_x_clk =3D clk_get_sys(NULL, "pll_x");
> +	if (IS_ERR(data->pll_x_clk)) {
> +		err =3D PTR_ERR(data->pll_x_clk);
>  		goto put_cpu;
>  	}
> =20
> -	pll_p_clk =3D clk_get_sys(NULL, "pll_p");
> -	if (IS_ERR(pll_p_clk)) {
> -		err =3D PTR_ERR(pll_p_clk);
> +	data->pll_p_clk =3D clk_get_sys(NULL, "pll_p");
> +	if (IS_ERR(data->pll_p_clk)) {
> +		err =3D PTR_ERR(data->pll_p_clk);
>  		goto put_pll_x;
>  	}
> =20
> +	data->dev =3D &pdev->dev;
> +
> +	tegra_cpufreq_driver.driver_data =3D data;

Couldn't this be embedded into struct tegra20_cpufreq_data? Moving
everything but this into a per-device data structure seems half-baked.

Thierry

--3MMMIZFJzhAsRj/+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr+l+sACgkQ3SOs138+
s6EfsQ/9EYwXMm2wSSXGuFoJ1YQ/7t77vASBT8k9nMqoUKNRlFaIbsFHlCPwKPpv
2ckdTB78HqNena8d6pkcFllRSp7aU8KoSSeuzq55y6ph7Ws1lXwnyv54TuQzpfZq
YTVkPBD8RjFTaJDVDe8fZvzaO8+F/eQjdv7r408u8VErjPm2igotQGLzQLtQZZnt
5E4FVtm+qxlrS1C68PQue/rx5ie/LEe8UzW9Sm2kgsYX7pqdmX1IR8V9ykjSeU7x
JCR7Ubxh7uxreGcf2NffhGQQI8WT8pZE6ORlx5UmZJNWvJPcHENvwtNA8IPP90mF
2De3JokVtEmfQZood6679szPRWjYHzcSCAIzQ2F/p/aE8EfpibQm1fGTcFc92YhV
c35GFOhU2YtKZ3pmPMFde0rW8Wn138y4OnE0tqLkAk0h8ztcJ29HRQy/xSEJYQuf
Pi0ToRk1ag8C0mi64vuBDUsHlfu3OqEm68vPtrHXCJJVq0lpwZQfWsKOd8LAGIj2
k3V+nwDLZVXcw+ML+VQ/7DCgXlTRRo0vCeK5iZi7awgj9JcXNM/Lbe/eZebCdf/u
dONsLMl8a8qoMms1cfvmqtSPJpxd/sEgY897jzSA98LLq0SFBTehRYvuRTJM3uc+
j9e7wy98AI6wp7EfTTbdJecFBgxanpbIqPMYIRoG3a7s6KZwJ5Y=
=hVBn
-----END PGP SIGNATURE-----

--3MMMIZFJzhAsRj/+--
