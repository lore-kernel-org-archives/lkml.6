Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752624AbeCXWnf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 18:43:35 -0400
Received: from sauhun.de ([88.99.104.3]:44588 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752216AbeCXWnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 18:43:33 -0400
Date: Sat, 24 Mar 2018 23:43:32 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i2c: i2c-stm32f7: Add 10-bit address support
Message-ID: <20180324224332.apsixpklrgtelak7@ninjato>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-2-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qyhavai5wehuyvdj"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-2-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qyhavai5wehuyvdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:48:55PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds support for 10-bit device address for STM32F7 I2C
>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Out of curiosity: how did you test this patch? I never managed to find a
10-bit client (except for an SoC with 10-bit slave mode).

> ---
>   Version history:
>      v1:
>         * Initial
>      v2:
> ---
> ---
>  drivers/i2c/busses/i2c-stm32f7.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-st=
m32f7.c
> index f273e28..ae0d15c 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -65,7 +65,12 @@
>  #define STM32F7_I2C_CR2_NACK			BIT(15)
>  #define STM32F7_I2C_CR2_STOP			BIT(14)
>  #define STM32F7_I2C_CR2_START			BIT(13)
> +#define STM32F7_I2C_CR2_HEAD10R			BIT(12)
> +#define STM32F7_I2C_CR2_ADD10			BIT(11)
>  #define STM32F7_I2C_CR2_RD_WRN			BIT(10)
> +#define STM32F7_I2C_CR2_SADD10_MASK		GENMASK(9, 0)
> +#define STM32F7_I2C_CR2_SADD10(n)		(((n) & \
> +						STM32F7_I2C_CR2_SADD10_MASK))
>  #define STM32F7_I2C_CR2_SADD7_MASK		GENMASK(7, 1)
>  #define STM32F7_I2C_CR2_SADD7(n)		(((n) & 0x7f) << 1)
> =20
> @@ -176,14 +181,14 @@ struct stm32f7_i2c_timings {
> =20
>  /**
>   * struct stm32f7_i2c_msg - client specific data
> - * @addr: 8-bit slave addr, including r/w bit
> + * @addr: 8-bit or 10-bit slave addr, including r/w bit
>   * @count: number of bytes to be transferred
>   * @buf: data buffer
>   * @result: result of the transfer
>   * @stop: last I2C msg to be sent, i.e. STOP to be generated
>   */
>  struct stm32f7_i2c_msg {
> -	u8 addr;
> +	u16 addr;
>  	u32 count;
>  	u8 *buf;
>  	int result;
> @@ -629,8 +634,15 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2c_=
dev *i2c_dev,
>  		cr2 |=3D STM32F7_I2C_CR2_RD_WRN;
> =20
>  	/* Set slave address */
> -	cr2 &=3D ~STM32F7_I2C_CR2_SADD7_MASK;
> -	cr2 |=3D STM32F7_I2C_CR2_SADD7(f7_msg->addr);
> +	cr2 &=3D ~(STM32F7_I2C_CR2_HEAD10R | STM32F7_I2C_CR2_ADD10);
> +	if (msg->flags & I2C_M_TEN) {
> +		cr2 &=3D ~STM32F7_I2C_CR2_SADD10_MASK;
> +		cr2 |=3D STM32F7_I2C_CR2_SADD10(f7_msg->addr);
> +		cr2 |=3D STM32F7_I2C_CR2_ADD10;
> +	} else {
> +		cr2 &=3D ~STM32F7_I2C_CR2_SADD7_MASK;
> +		cr2 |=3D STM32F7_I2C_CR2_SADD7(f7_msg->addr);
> +	}
> =20
>  	/* Set nb bytes to transfer and reload if needed */
>  	cr2 &=3D ~(STM32F7_I2C_CR2_NBYTES_MASK | STM32F7_I2C_CR2_RELOAD);
> @@ -798,7 +810,7 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i2c_a=
dap,
> =20
>  static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
>  }
> =20
>  static struct i2c_algorithm stm32f7_i2c_algo =3D {
> --=20
> 2.7.4
>=20

--qyhavai5wehuyvdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq21JQACgkQFA3kzBSg
KbbTfA/+NyOduO5HWmywdlcLg1bw0BTUzMhsljNhgtDIbbfTQFzNBPCwFV4kImwB
5VY1rCTwdMJJ1qo8Lp66tqb0ifSRngB+r/MKsyuYc597cemP0pH72trqBVmW6RJN
Eiad24F7xI5JkOEfwAhuBbnulPwWMmYyE8nJSMHG6wGU3PfsnMAyyNydNkCl6yxq
yHlDZMy8wWhGNc5IV2FVrXL5owWWmezETL/lLKKylRHTZYQHiuqaOayJVPAIQyE3
ZZCkJnvGf9cm/kes1C5UE5Ncu7MRUETzUsSarVT+MHnz5iY8mj7TKr12B/gcHrOb
U5fzZJ2fOBCo6Sv0gjZM/hC2TEEewhEZlojVPsa/cyxAypuacmqHF/E4PD2oBAfC
dTdI85YjCbOzpkPiqoa7NaXN9vEQKWYGbFSSqIZwE2TEkcZEJto90xuzDDIBLqmm
/LHByutuJEGlaBz4OV7rUU1kTtYkynbKBRAR7jPRcX6J33/rVc0K4kktFxo/xEz4
VFABvJBpJlJ6rFSCdcGfY+Wx8xN1HMS8bmdpIf4GNYEazJy/ZPvcbqSB5U1Sp0o+
0VJnYvL0VRTBQJsXgDGkgEKQ5lqe+xQhKRrcFD8dQhsNV5Ns/nnG3fT1HwILM0FJ
axrdQuYnI//6o2lyygreBjOZbxGCRLPc6rdi5H0NUmpSuIrvEF8=
=1AhT
-----END PGP SIGNATURE-----

--qyhavai5wehuyvdj--
