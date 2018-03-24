Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752754AbeCXXTN (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:19:13 -0400
Received: from sauhun.de ([88.99.104.3]:44876 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752174AbeCXXTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:19:12 -0400
Date: Sun, 25 Mar 2018 00:19:10 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jassisinghbrar@gmail.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 2/2] i2c: add support for Socionext SynQuacer I2C
 controller
Message-ID: <20180324231910.unzvwty3xia4mqu2@ninjato>
References: <20180302083123.7259-1-ard.biesheuvel@linaro.org>
 <20180302083123.7259-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xdoxo5t6zpkvtr52"
Content-Disposition: inline
In-Reply-To: <20180302083123.7259-3-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xdoxo5t6zpkvtr52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ard,

> +static int synquacer_i2c_master_start(struct synquacer_i2c *i2c,
> +				      struct i2c_msg *pmsg)
> +{
> +	unsigned char bsr, bcr;
> +
> +	if (pmsg->flags & I2C_M_RD)
> +		writeb((pmsg->addr << 1) | 1,
> +		       i2c->base + SYNQUACER_I2C_REG_DAR);
> +	else
> +		writeb(pmsg->addr << 1,
> +		       i2c->base + SYNQUACER_I2C_REG_DAR);

writeb(i2c_8bit_addr_from_msg(pmsg), i2c->base + SYNQUACER_I2C_REG_DAR);

?

> +static int synquacer_i2c_master_recover(struct synquacer_i2c *i2c)
> +{

This is the bus recovery mechanism with toggling SCL pulses, right?
That should be implemented using a 'struct i2c_bus_recovery_info' and
the core helpers.

> +static int synquacer_i2c_doxfer(struct synquacer_i2c *i2c,
> +				struct i2c_msg *msgs, int num)
> +{
> +	unsigned char bsr;
> +	unsigned long timeout, bb_timeout;
> +	int ret;
> +
> +	if (i2c->is_suspended)
> +		return -EBUSY;
> +
> +	synquacer_i2c_hw_init(i2c);
> +	bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
> +	if (bsr & SYNQUACER_I2C_BSR_BB) {
> +		dev_err(i2c->dev, "cannot get bus (bus busy)\n");
> +		return -EBUSY;
> +	}
> +
> +	init_completion(&i2c->completion);

reinit_completion? And init_completion() in probe()?

> +	/* ensure the stop has been through the bus */
> +	bb_timeout = jiffies + HZ;
> +	do {
> +		bsr = readb(i2c->base + SYNQUACER_I2C_REG_BSR);
> +		if (!(bsr & SYNQUACER_I2C_BSR_BB))
> +			return 0;
> +	} while (time_before(jiffies, bb_timeout));

Busy looping for one second? And won't the bus_free detection at the
beginning of a transfer do?

> +static int synquacer_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> +			      int num)
> +{
> +	struct synquacer_i2c *i2c;
> +	int retry;
> +	int ret;
> +
> +	if (!msgs)
> +		return -EINVAL;
> +	if (num <= 0)
> +		return -EINVAL;

Hmm, this should be done by the core. I am surprised it doesn't do that yet :/

> +
> +	i2c = i2c_get_adapdata(adap);
> +	i2c->timeout_ms = calc_timeout_ms(i2c, msgs, num);
> +
> +	dev_dbg(i2c->dev, "calculated timeout %d ms\n", i2c->timeout_ms);
> +
> +	for (retry = 0; retry < adap->retries; retry++) {
> +
> +		ret = synquacer_i2c_doxfer(i2c, msgs, num);
> +		if (ret != -EAGAIN)
> +			return ret;
> +
> +		dev_dbg(i2c->dev, "Retrying transmission (%d)\n", retry);
> +
> +		synquacer_i2c_master_recover(i2c);

Recovery is only when SDA is stuck low, held by a client. That is
nothing you should do just on any error.

If you want the driver in v4.17, I'd suggest to drop
synquacer_i2c_master_recover() now and add it incrementally later, using
the existing recovery infrastructure. The rest is only minor stuff and
needs not much further discussion IMO.

Regards,

   Wolfram


--xdoxo5t6zpkvtr52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq23OoACgkQFA3kzBSg
KbbwJxAAm1FGeUzbmwo/o5Mrx6xfwUvV0CusEuugDltUu63t94EiXXtvhe1bupY/
XY7G9DFuWiM8VvOHRpxrje257Cl4kw0G1dn8IMQQRXUWNei8ToLH6fZtC4pQI9t/
LalMLb1vIiP+qo67ERMb288IrjtyQvNWiSuvUczKombvjyCeTvp1oTvRUdiuqv6+
KYLXDPzjeyGWk7MSuePKLS2qukTk1A4byJqGxIoJtZGWCUyalbwTZzFnm9f/mntT
isFRx+HpV2sBopn71wYpYOtnKfswR8kH004DLB6AWMz/12qpGFPqAyK23dP3A/hP
Pd9QEYpcR5skFDbl/jZtbuAJ6sG5DVDQliyJA4g2x87kBB9CbB1Y3rCvXIOyWRBm
mCGb2TBp+dDjQ7EAJ0AwYjT6uoJN8X/czCoBVsu8693ZQ+q4d8DuGFmcan6JJ4z/
msr0wurlcQmOvbS5bKmYH4kkTFsUW3lM3WZ2H2a6gUbxKVKXy99rX4jJIlil5Ttg
DEDqEbJcCbYxCTO2W0zmwZFFE/E4lGzY/A9UQ0cmI7mz/l8ih+E+HTPy6LwdUvLy
kVsBOp1wavQNYgvnZRb1nfp3bwgA8Pyzy/MCR7GRWN0v4Kqxh05HaxC1cY3IDhXj
ynUK3H0bhZLVx6+7HcZOstpatEtOLLxRxdov7P8fnkraKzKIDdM=
=SoKr
-----END PGP SIGNATURE-----

--xdoxo5t6zpkvtr52--
