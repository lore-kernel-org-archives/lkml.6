Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeCYSQG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 14:16:06 -0400
Received: from www.zeus03.de ([194.117.254.33]:53690 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753700AbeCYSQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 14:16:03 -0400
Date: Sun, 25 Mar 2018 20:16:00 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] i2c: i2c-stm32f7: Add slave support
Message-ID: <20180325181600.vehqe3xcx55qxtd7@katana>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="excxurdfha6xlwgo"
Content-Disposition: inline
In-Reply-To: <1521650940-11651-3-git-send-email-pierre-yves.mordret@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--excxurdfha6xlwgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 21, 2018 at 05:48:56PM +0100, Pierre-Yves MORDRET wrote:
> This patch adds slave support for I2C controller embedded in STM32F7 SoC
>=20
> Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@gmail.com>
> Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>

Looks OK from a first look. What kind of tests did you do?


> ---
>   Version history:
>      v1:
>         * Initial
>      v2:
> ---
> ---
>  drivers/i2c/busses/Kconfig       |   1 +
>  drivers/i2c/busses/i2c-stm32f7.c | 434 +++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 429 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index e2954fb..118b9be 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -964,6 +964,7 @@ config I2C_STM32F4
>  config I2C_STM32F7
>  	tristate "STMicroelectronics STM32F7 I2C support"
>  	depends on ARCH_STM32 || COMPILE_TEST
> +	select I2C_SLAVE
>  	help
>  	  Enable this option to add support for STM32 I2C controller embedded
>  	  in STM32F7 SoCs.
> diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-st=
m32f7.c
> index ae0d15c..9bf676e 100644
> --- a/drivers/i2c/busses/i2c-stm32f7.c
> +++ b/drivers/i2c/busses/i2c-stm32f7.c
> @@ -35,6 +35,8 @@
>  /* STM32F7 I2C registers */
>  #define STM32F7_I2C_CR1				0x00
>  #define STM32F7_I2C_CR2				0x04
> +#define STM32F7_I2C_OAR1			0x08
> +#define STM32F7_I2C_OAR2			0x0C
>  #define STM32F7_I2C_TIMINGR			0x10
>  #define STM32F7_I2C_ISR				0x18
>  #define STM32F7_I2C_ICR				0x1C
> @@ -42,6 +44,7 @@
>  #define STM32F7_I2C_TXDR			0x28
> =20
>  /* STM32F7 I2C control 1 */
> +#define STM32F7_I2C_CR1_SBC			BIT(16)
>  #define STM32F7_I2C_CR1_ANFOFF			BIT(12)
>  #define STM32F7_I2C_CR1_ERRIE			BIT(7)
>  #define STM32F7_I2C_CR1_TCIE			BIT(6)
> @@ -57,6 +60,11 @@
>  						| STM32F7_I2C_CR1_NACKIE \
>  						| STM32F7_I2C_CR1_RXIE \
>  						| STM32F7_I2C_CR1_TXIE)
> +#define STM32F7_I2C_XFER_IRQ_MASK		(STM32F7_I2C_CR1_TCIE \
> +						| STM32F7_I2C_CR1_STOPIE \
> +						| STM32F7_I2C_CR1_NACKIE \
> +						| STM32F7_I2C_CR1_RXIE \
> +						| STM32F7_I2C_CR1_TXIE)
> =20
>  /* STM32F7 I2C control 2 */
>  #define STM32F7_I2C_CR2_RELOAD			BIT(24)
> @@ -74,7 +82,34 @@
>  #define STM32F7_I2C_CR2_SADD7_MASK		GENMASK(7, 1)
>  #define STM32F7_I2C_CR2_SADD7(n)		(((n) & 0x7f) << 1)
> =20
> +/* STM32F7 I2C Own Address 1 */
> +#define STM32F7_I2C_OAR1_OA1EN			BIT(15)
> +#define STM32F7_I2C_OAR1_OA1MODE		BIT(10)
> +#define STM32F7_I2C_OAR1_OA1_10_MASK		GENMASK(9, 0)
> +#define STM32F7_I2C_OAR1_OA1_10(n)		(((n) & \
> +						STM32F7_I2C_OAR1_OA1_10_MASK))
> +#define STM32F7_I2C_OAR1_OA1_7_MASK		GENMASK(7, 1)
> +#define STM32F7_I2C_OAR1_OA1_7(n)		(((n) & 0x7f) << 1)
> +#define STM32F7_I2C_OAR1_MASK			(STM32F7_I2C_OAR1_OA1_7_MASK \
> +						| STM32F7_I2C_OAR1_OA1_10_MASK \
> +						| STM32F7_I2C_OAR1_OA1EN \
> +						| STM32F7_I2C_OAR1_OA1MODE)
> +
> +/* STM32F7 I2C Own Address 2 */
> +#define STM32F7_I2C_OAR2_OA2EN			BIT(15)
> +#define STM32F7_I2C_OAR2_OA2MSK_MASK		GENMASK(10, 8)
> +#define STM32F7_I2C_OAR2_OA2MSK(n)		(((n) & 0x7) << 8)
> +#define STM32F7_I2C_OAR2_OA2_7_MASK		GENMASK(7, 1)
> +#define STM32F7_I2C_OAR2_OA2_7(n)		(((n) & 0x7f) << 1)
> +#define STM32F7_I2C_OAR2_MASK			(STM32F7_I2C_OAR2_OA2MSK_MASK \
> +						| STM32F7_I2C_OAR2_OA2_7_MASK \
> +						| STM32F7_I2C_OAR2_OA2EN)
> +
>  /* STM32F7 I2C Interrupt Status */
> +#define STM32F7_I2C_ISR_ADDCODE_MASK		GENMASK(23, 17)
> +#define STM32F7_I2C_ISR_ADDCODE_GET(n) \
> +				(((n) & STM32F7_I2C_ISR_ADDCODE_MASK) >> 17)
> +#define STM32F7_I2C_ISR_DIR			BIT(16)
>  #define STM32F7_I2C_ISR_BUSY			BIT(15)
>  #define STM32F7_I2C_ISR_ARLO			BIT(9)
>  #define STM32F7_I2C_ISR_BERR			BIT(8)
> @@ -82,14 +117,17 @@
>  #define STM32F7_I2C_ISR_TC			BIT(6)
>  #define STM32F7_I2C_ISR_STOPF			BIT(5)
>  #define STM32F7_I2C_ISR_NACKF			BIT(4)
> +#define STM32F7_I2C_ISR_ADDR			BIT(3)
>  #define STM32F7_I2C_ISR_RXNE			BIT(2)
>  #define STM32F7_I2C_ISR_TXIS			BIT(1)
> +#define STM32F7_I2C_ISR_TXE			BIT(0)
> =20
>  /* STM32F7 I2C Interrupt Clear */
>  #define STM32F7_I2C_ICR_ARLOCF			BIT(9)
>  #define STM32F7_I2C_ICR_BERRCF			BIT(8)
>  #define STM32F7_I2C_ICR_STOPCF			BIT(5)
>  #define STM32F7_I2C_ICR_NACKCF			BIT(4)
> +#define STM32F7_I2C_ICR_ADDRCF			BIT(3)
> =20
>  /* STM32F7 I2C Timing */
>  #define STM32F7_I2C_TIMINGR_PRESC(n)		(((n) & 0xf) << 28)
> @@ -99,6 +137,7 @@
>  #define STM32F7_I2C_TIMINGR_SCLL(n)		((n) & 0xff)
> =20
>  #define STM32F7_I2C_MAX_LEN			0xff
> +#define STM32F7_I2C_MAX_SLAVE			0x2
> =20
>  #define STM32F7_I2C_DNF_DEFAULT			0
>  #define STM32F7_I2C_DNF_MAX			16
> @@ -209,6 +248,11 @@ struct stm32f7_i2c_msg {
>   * @f7_msg: customized i2c msg for driver usage
>   * @setup: I2C timing input setup
>   * @timing: I2C computed timings
> + * @slave: list of slave devices registered on the I2C bus
> + * @slave_running: slave device currently used
> + * @slave_dir: transfer direction for the current slave device
> + * @master_mode: boolean to know in which mode the I2C is running (maste=
r or
> + * slave)
>   */
>  struct stm32f7_i2c_dev {
>  	struct i2c_adapter adap;
> @@ -223,6 +267,10 @@ struct stm32f7_i2c_dev {
>  	struct stm32f7_i2c_msg f7_msg;
>  	struct stm32f7_i2c_setup setup;
>  	struct stm32f7_i2c_timings timing;
> +	struct i2c_client *slave[STM32F7_I2C_MAX_SLAVE];
> +	struct i2c_client *slave_running;
> +	u32 slave_dir;
> +	bool master_mode;
>  };
> =20
>  /**
> @@ -288,6 +336,11 @@ static inline void stm32f7_i2c_clr_bits(void __iomem=
 *reg, u32 mask)
>  	writel_relaxed(readl_relaxed(reg) & ~mask, reg);
>  }
> =20
> +static void stm32f7_i2c_disable_irq(struct stm32f7_i2c_dev *i2c_dev, u32=
 mask)
> +{
> +	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1, mask);
> +}
> +
>  static int stm32f7_i2c_compute_timing(struct stm32f7_i2c_dev *i2c_dev,
>  				      struct stm32f7_i2c_setup *setup,
>  				      struct stm32f7_i2c_timings *output)
> @@ -572,6 +625,9 @@ static void stm32f7_i2c_read_rx_data(struct stm32f7_i=
2c_dev *i2c_dev)
>  	if (f7_msg->count) {
>  		*f7_msg->buf++ =3D readb_relaxed(base + STM32F7_I2C_RXDR);
>  		f7_msg->count--;
> +	} else {
> +		/* Flush RX buffer has no data is expected */
> +		readb_relaxed(base + STM32F7_I2C_RXDR);
>  	}
>  }
> =20
> @@ -669,14 +725,250 @@ static void stm32f7_i2c_xfer_msg(struct stm32f7_i2=
c_dev *i2c_dev,
>  	/* Configure Start/Repeated Start */
>  	cr2 |=3D STM32F7_I2C_CR2_START;
> =20
> +	i2c_dev->master_mode =3D true;
> +
>  	/* Write configurations registers */
>  	writel_relaxed(cr1, base + STM32F7_I2C_CR1);
>  	writel_relaxed(cr2, base + STM32F7_I2C_CR2);
>  }
> =20
> -static void stm32f7_i2c_disable_irq(struct stm32f7_i2c_dev *i2c_dev, u32=
 mask)
> +static bool stm32f7_i2c_is_addr_match(struct i2c_client *slave, u32 addc=
ode)
>  {
> -	stm32f7_i2c_clr_bits(i2c_dev->base + STM32F7_I2C_CR1, mask);
> +	u32 addr;
> +
> +	if (!slave)
> +		return false;
> +
> +	if (slave->flags & I2C_CLIENT_TEN) {
> +		/*
> +		 * For 10-bit addr, addcode =3D 11110XY with
> +		 * X =3D Bit 9 of slave address
> +		 * Y =3D Bit 8 of slave address
> +		 */
> +		addr =3D slave->addr >> 8;
> +		addr |=3D 0x78;
> +		if (addr =3D=3D addcode)
> +			return true;
> +	} else {
> +		addr =3D slave->addr & 0x7f;
> +		if (addr =3D=3D addcode)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void stm32f7_i2c_slave_start(struct stm32f7_i2c_dev *i2c_dev)
> +{
> +	struct i2c_client *slave =3D i2c_dev->slave_running;
> +	void __iomem *base =3D i2c_dev->base;
> +	u32 mask;
> +	u8 value =3D 0;
> +
> +	if (i2c_dev->slave_dir) {
> +		/* Notify i2c slave that new read transfer is starting */
> +		i2c_slave_event(slave, I2C_SLAVE_READ_REQUESTED, &value);
> +
> +		/*
> +		 * Disable slave TX config in case of I2C combined message
> +		 * (I2C Write followed by I2C Read)
> +		 */
> +		mask =3D STM32F7_I2C_CR2_RELOAD;
> +		stm32f7_i2c_clr_bits(base + STM32F7_I2C_CR2, mask);
> +		mask =3D STM32F7_I2C_CR1_SBC | STM32F7_I2C_CR1_RXIE |
> +		       STM32F7_I2C_CR1_TCIE;
> +		stm32f7_i2c_clr_bits(base + STM32F7_I2C_CR1, mask);
> +
> +		/* Enable TX empty, STOP, NACK interrupts */
> +		mask =3D  STM32F7_I2C_CR1_STOPIE | STM32F7_I2C_CR1_NACKIE |
> +			STM32F7_I2C_CR1_TXIE;
> +		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
> +
> +	} else {
> +		/* Notify i2c slave that new write transfer is starting */
> +		i2c_slave_event(slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> +
> +		/* Set reload mode to be able to ACK/NACK each received byte */
> +		mask =3D STM32F7_I2C_CR2_RELOAD;
> +		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR2, mask);
> +
> +		/*
> +		 * Set STOP, NACK, RX empty and transfer complete interrupts.*
> +		 * Set Slave Byte Control to be able to ACK/NACK each data
> +		 * byte received
> +		 */
> +		mask =3D  STM32F7_I2C_CR1_STOPIE | STM32F7_I2C_CR1_NACKIE |
> +			STM32F7_I2C_CR1_SBC | STM32F7_I2C_CR1_RXIE |
> +			STM32F7_I2C_CR1_TCIE;
> +		stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
> +	}
> +}
> +
> +static void stm32f7_i2c_slave_addr(struct stm32f7_i2c_dev *i2c_dev)
> +{
> +	void __iomem *base =3D i2c_dev->base;
> +	u32 isr, addcode, dir, mask;
> +	int i;
> +
> +	isr =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
> +	addcode =3D STM32F7_I2C_ISR_ADDCODE_GET(isr);
> +	dir =3D isr & STM32F7_I2C_ISR_DIR;
> +
> +	for (i =3D 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +		if (stm32f7_i2c_is_addr_match(i2c_dev->slave[i], addcode)) {
> +			i2c_dev->slave_running =3D i2c_dev->slave[i];
> +			i2c_dev->slave_dir =3D dir;
> +
> +			/* Start I2C slave processing */
> +			stm32f7_i2c_slave_start(i2c_dev);
> +
> +			/* Clear ADDR flag */
> +			mask =3D STM32F7_I2C_ICR_ADDRCF;
> +			writel_relaxed(mask, base + STM32F7_I2C_ICR);
> +			break;
> +		}
> +	}
> +}
> +
> +static int stm32f7_i2c_get_slave_id(struct stm32f7_i2c_dev *i2c_dev,
> +				    struct i2c_client *slave, int *id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +		if (i2c_dev->slave[i] =3D=3D slave) {
> +			*id =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(i2c_dev->dev, "Slave 0x%x not registered\n", slave->addr);
> +
> +	return -ENODEV;
> +}
> +
> +static int stm32f7_i2c_get_free_slave_id(struct stm32f7_i2c_dev *i2c_dev,
> +					 struct i2c_client *slave, int *id)
> +{
> +	struct device *dev =3D i2c_dev->dev;
> +	int i;
> +
> +	/*
> +	 * slave[0] supports 7-bit and 10-bit slave address
> +	 * slave[1] supports 7-bit slave address only
> +	 */
> +	for (i =3D 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +		if (i =3D=3D 1 && (slave->flags & I2C_CLIENT_PEC))
> +			continue;
> +		if (!i2c_dev->slave[i]) {
> +			*id =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(dev, "Slave 0x%x could not be registered\n", slave->addr);
> +
> +	return -EINVAL;
> +}
> +
> +static bool stm32f7_i2c_is_slave_registered(struct stm32f7_i2c_dev *i2c_=
dev)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +		if (i2c_dev->slave[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool stm32f7_i2c_is_slave_busy(struct stm32f7_i2c_dev *i2c_dev)
> +{
> +	int i, busy;
> +
> +	busy =3D 0;
> +	for (i =3D 0; i < STM32F7_I2C_MAX_SLAVE; i++) {
> +		if (i2c_dev->slave[i])
> +			busy++;
> +	}
> +
> +	return i =3D=3D busy;
> +}
> +
> +static irqreturn_t stm32f7_i2c_slave_isr_event(struct stm32f7_i2c_dev *i=
2c_dev)
> +{
> +	void __iomem *base =3D i2c_dev->base;
> +	u32 cr2, status, mask;
> +	u8 val;
> +	int ret;
> +
> +	status =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
> +
> +	/* Slave transmitter mode */
> +	if (status & STM32F7_I2C_ISR_TXIS) {
> +		i2c_slave_event(i2c_dev->slave_running,
> +				I2C_SLAVE_READ_PROCESSED,
> +				&val);
> +
> +		/* Write data byte */
> +		writel_relaxed(val, base + STM32F7_I2C_TXDR);
> +	}
> +
> +	/* Transfer Complete Reload for Slave receiver mode */
> +	if (status & STM32F7_I2C_ISR_TCR || status & STM32F7_I2C_ISR_RXNE) {
> +		/*
> +		 * Read data byte then set NBYTES to receive next byte or NACK
> +		 * the current received byte
> +		 */
> +		val =3D readb_relaxed(i2c_dev->base + STM32F7_I2C_RXDR);
> +		ret =3D i2c_slave_event(i2c_dev->slave_running,
> +				      I2C_SLAVE_WRITE_RECEIVED,
> +				      &val);
> +		if (!ret) {
> +			cr2 =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_CR2);
> +			cr2 |=3D STM32F7_I2C_CR2_NBYTES(1);
> +			writel_relaxed(cr2, i2c_dev->base + STM32F7_I2C_CR2);
> +		} else {
> +			mask =3D STM32F7_I2C_CR2_NACK;
> +			stm32f7_i2c_set_bits(base + STM32F7_I2C_CR2, mask);
> +		}
> +	}
> +
> +	/* NACK received */
> +	if (status & STM32F7_I2C_ISR_NACKF) {
> +		dev_dbg(i2c_dev->dev, "<%s>: Receive NACK\n", __func__);
> +		writel_relaxed(STM32F7_I2C_ICR_NACKCF, base + STM32F7_I2C_ICR);
> +	}
> +
> +	/* STOP received */
> +	if (status & STM32F7_I2C_ISR_STOPF) {
> +		/* Disable interrupts */
> +		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_XFER_IRQ_MASK);
> +
> +		if (i2c_dev->slave_dir) {
> +			/*
> +			 * Flush TX buffer in order to not used the byte in
> +			 * TXDR for the next transfer
> +			 */
> +			mask =3D STM32F7_I2C_ISR_TXE;
> +			stm32f7_i2c_set_bits(base + STM32F7_I2C_ISR, mask);
> +		}
> +
> +		/* Clear STOP flag */
> +		writel_relaxed(STM32F7_I2C_ICR_STOPCF, base + STM32F7_I2C_ICR);
> +
> +		/* Notify i2c slave that a STOP flag has been detected */
> +		i2c_slave_event(i2c_dev->slave_running, I2C_SLAVE_STOP, &val);
> +
> +		i2c_dev->slave_running =3D NULL;
> +	}
> +
> +	/* Address match received */
> +	if (status & STM32F7_I2C_ISR_ADDR)
> +		stm32f7_i2c_slave_addr(i2c_dev);
> +
> +	return IRQ_HANDLED;
>  }
> =20
>  static irqreturn_t stm32f7_i2c_isr_event(int irq, void *data)
> @@ -685,6 +977,13 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, vo=
id *data)
>  	struct stm32f7_i2c_msg *f7_msg =3D &i2c_dev->f7_msg;
>  	void __iomem *base =3D i2c_dev->base;
>  	u32 status, mask;
> +	int ret;
> +
> +	/* Check if the interrupt if for a slave device */
> +	if (!i2c_dev->master_mode) {
> +		ret =3D stm32f7_i2c_slave_isr_event(i2c_dev);
> +		return ret;
> +	}
> =20
>  	status =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
> =20
> @@ -706,11 +1005,16 @@ static irqreturn_t stm32f7_i2c_isr_event(int irq, =
void *data)
>  	/* STOP detection flag */
>  	if (status & STM32F7_I2C_ISR_STOPF) {
>  		/* Disable interrupts */
> -		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
> +		if (stm32f7_i2c_is_slave_registered(i2c_dev))
> +			mask =3D STM32F7_I2C_XFER_IRQ_MASK;
> +		else
> +			mask =3D STM32F7_I2C_ALL_IRQ_MASK;
> +		stm32f7_i2c_disable_irq(i2c_dev, mask);
> =20
>  		/* Clear STOP flag */
>  		writel_relaxed(STM32F7_I2C_ICR_STOPCF, base + STM32F7_I2C_ICR);
> =20
> +		i2c_dev->master_mode =3D false;
>  		complete(&i2c_dev->complete);
>  	}
> =20
> @@ -743,7 +1047,7 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, vo=
id *data)
>  	struct stm32f7_i2c_msg *f7_msg =3D &i2c_dev->f7_msg;
>  	void __iomem *base =3D i2c_dev->base;
>  	struct device *dev =3D i2c_dev->dev;
> -	u32 status;
> +	u32 mask, status;
> =20
>  	status =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
> =20
> @@ -761,8 +1065,14 @@ static irqreturn_t stm32f7_i2c_isr_error(int irq, v=
oid *data)
>  		f7_msg->result =3D -EAGAIN;
>  	}
> =20
> -	stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
> +	/* Disable interrupts */
> +	if (stm32f7_i2c_is_slave_registered(i2c_dev))
> +		mask =3D STM32F7_I2C_XFER_IRQ_MASK;
> +	else
> +		mask =3D STM32F7_I2C_ALL_IRQ_MASK;
> +	stm32f7_i2c_disable_irq(i2c_dev, mask);
> =20
> +	i2c_dev->master_mode =3D false;
>  	complete(&i2c_dev->complete);
> =20
>  	return IRQ_HANDLED;
> @@ -808,14 +1118,126 @@ static int stm32f7_i2c_xfer(struct i2c_adapter *i=
2c_adap,
>  	return (ret < 0) ? ret : num;
>  }
> =20
> +static int stm32f7_i2c_reg_slave(struct i2c_client *slave)
> +{
> +	struct stm32f7_i2c_dev *i2c_dev =3D i2c_get_adapdata(slave->adapter);
> +	void __iomem *base =3D i2c_dev->base;
> +	struct device *dev =3D i2c_dev->dev;
> +	u32 oar1, oar2, mask;
> +	int id, ret;
> +
> +	if (slave->flags & I2C_CLIENT_PEC) {
> +		dev_err(dev, "SMBus PEC not supported in slave mode\n");
> +		return -EINVAL;
> +	}
> +
> +	if (stm32f7_i2c_is_slave_busy(i2c_dev)) {
> +		dev_err(dev, "Too much slave registered\n");
> +		return -EBUSY;
> +	}
> +
> +	ret =3D stm32f7_i2c_get_free_slave_id(i2c_dev, slave, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
> +		ret =3D clk_enable(i2c_dev->clk);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable clock\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (id =3D=3D 0) {
> +		/* Configure Own Address 1 */
> +		oar1 =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR1);
> +		oar1 &=3D ~STM32F7_I2C_OAR1_MASK;
> +		if (slave->flags & I2C_CLIENT_TEN) {
> +			oar1 |=3D STM32F7_I2C_OAR1_OA1_10(slave->addr);
> +			oar1 |=3D STM32F7_I2C_OAR1_OA1MODE;
> +		} else {
> +			oar1 |=3D STM32F7_I2C_OAR1_OA1_7(slave->addr);
> +		}
> +		oar1 |=3D STM32F7_I2C_OAR1_OA1EN;
> +		i2c_dev->slave[id] =3D slave;
> +		writel_relaxed(oar1, i2c_dev->base + STM32F7_I2C_OAR1);
> +	} else if (id =3D=3D 1) {
> +		/* Configure Own Address 2 */
> +		oar2 =3D readl_relaxed(i2c_dev->base + STM32F7_I2C_OAR2);
> +		oar2 &=3D ~STM32F7_I2C_OAR2_MASK;
> +		if (slave->flags & I2C_CLIENT_TEN) {
> +			ret =3D -EOPNOTSUPP;
> +			goto exit;
> +		}
> +
> +		oar2 |=3D STM32F7_I2C_OAR2_OA2_7(slave->addr);
> +		oar2 |=3D STM32F7_I2C_OAR2_OA2EN;
> +		i2c_dev->slave[id] =3D slave;
> +		writel_relaxed(oar2, i2c_dev->base + STM32F7_I2C_OAR2);
> +	} else {
> +		ret =3D -ENODEV;
> +		goto exit;
> +	}
> +
> +	/* Enable ACK */
> +	stm32f7_i2c_clr_bits(base + STM32F7_I2C_CR2, STM32F7_I2C_CR2_NACK);
> +
> +	/* Enable Address match interrupt, error interrupt and enable I2C  */
> +	mask =3D STM32F7_I2C_CR1_ADDRIE | STM32F7_I2C_CR1_ERRIE |
> +		STM32F7_I2C_CR1_PE;
> +	stm32f7_i2c_set_bits(base + STM32F7_I2C_CR1, mask);
> +
> +	return 0;
> +
> +exit:
> +	if (!(stm32f7_i2c_is_slave_registered(i2c_dev)))
> +		clk_disable(i2c_dev->clk);
> +
> +	return ret;
> +}
> +
> +static int stm32f7_i2c_unreg_slave(struct i2c_client *slave)
> +{
> +	struct stm32f7_i2c_dev *i2c_dev =3D i2c_get_adapdata(slave->adapter);
> +	void __iomem *base =3D i2c_dev->base;
> +	u32 mask;
> +	int id, ret;
> +
> +	ret =3D stm32f7_i2c_get_slave_id(i2c_dev, slave, &id);
> +	if (ret)
> +		return ret;
> +
> +	WARN_ON(!i2c_dev->slave[id]);
> +
> +	if (id =3D=3D 0) {
> +		mask =3D STM32F7_I2C_OAR1_OA1EN;
> +		stm32f7_i2c_clr_bits(base + STM32F7_I2C_OAR1, mask);
> +	} else {
> +		mask =3D STM32F7_I2C_OAR2_OA2EN;
> +		stm32f7_i2c_clr_bits(base + STM32F7_I2C_OAR2, mask);
> +	}
> +
> +	i2c_dev->slave[id] =3D NULL;
> +
> +	if (!(stm32f7_i2c_is_slave_registered(i2c_dev))) {
> +		stm32f7_i2c_disable_irq(i2c_dev, STM32F7_I2C_ALL_IRQ_MASK);
> +		clk_disable(i2c_dev->clk);
> +	}
> +
> +	return 0;
> +}
> +
>  static u32 stm32f7_i2c_func(struct i2c_adapter *adap)
>  {
> -	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR;
> +	return I2C_FUNC_I2C | I2C_FUNC_SMBUS_EMUL | I2C_FUNC_10BIT_ADDR |
> +		I2C_FUNC_SLAVE;
>  }
> =20
>  static struct i2c_algorithm stm32f7_i2c_algo =3D {
>  	.master_xfer =3D stm32f7_i2c_xfer,
>  	.functionality =3D stm32f7_i2c_func,
> +	.reg_slave =3D stm32f7_i2c_reg_slave,
> +	.unreg_slave =3D stm32f7_i2c_unreg_slave,
>  };
> =20
>  static int stm32f7_i2c_probe(struct platform_device *pdev)
> --=20
> 2.7.4
>=20

--excxurdfha6xlwgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq351sACgkQFA3kzBSg
KbYlog//YMBDjsujBLCu/jovHUVS6R0H2wd9Dgo61BBiVdHvLhGM+TQOQgirgX6q
KCLrwsu9eyGA9ejV0hT7sF+5L5K7VC6/0wdAvDVsqkVUNvn8p+OQY8StMO00FXjP
+4qmBeepnr5qrPdEjybxhIkRbBLFfKNhBzCvMdylDywRYH3AYZUEswXtU7MSh2fn
XbeedeF0pcjudGnr1fQfWBV7djcQyGiWwSY82KTqbpxy6awWAUFHpXmZq9jI19Zn
iCYmICCdaxCFMZDZTGNFVCYxaoBLBmNWn29sukTWGWf4uXypMZKrayzZiCCNTsVG
uvnMEWH3uSzT6jl2IB1sjVFzF8VRffkKAk+VFbJC1eghG+Z26vhG75+HvOosrn9O
e0ZcO741bPorJVWEG1ID7k3mXmKEQOy+yExas2ohpqLUPNAI1ih6RpjxaL/MOQsv
VJU1XsXWnHLKBeDtss+Nra5JuVfj4aFjUzHoP4j/eEOz0qeLm5rft9tO+xm//6fl
gWsg0QEBXLN5v9npTqoMcyGj0UzRTb9hTWsUkIhzQtAtuGk6Jf2H+RhoT0KW4uOa
O78sNslcJdE4k87SaAI2CxshOKDJYb49sFSV0+KsDjAdvN4Llf2WJ5m5qJOrfG7/
2xJ0JyvUqrhAga+sDjaEsILGKO2h0GcBUwKE6qFGFYHi7ePcBho=
=d6Fj
-----END PGP SIGNATURE-----

--excxurdfha6xlwgo--
