Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161832AbeCAU74 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:59:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34944 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161722AbeCAU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:59:50 -0500
Date: Thu, 1 Mar 2018 20:59:40 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 05/25] ASoC: qcom: qdsp6: Add support to Q6AFE
Message-ID: <20180301205940.GR12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-6-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2018 at 04:58:17PM +0000, srinivas.kandagatla@linaro.org wr=
ote:

> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef __DT_BINDINGS_Q6_AFE_H__
> +#define __DT_BINDINGS_Q6_AFE_H__
> +
> +/* Audio Front End (AFE) Ports */
> +#define AFE_PORT_HDMI_RX	8
> +
> +#endif /* __DT_BINDINGS_Q6_AFE_H__ */

Please use a C++ comment here as well for consistency, it looks more
intentional.

> +config SND_SOC_QDSP6_AFE
> +	tristate
> +	default n
> +

n is the default anyway, no need to specify it (I know some uses already
slipped through here but it'd be better to fix those).

> index 000000000000..0a5af06bb50e
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6afe.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2011-2017, The Linux Foundation
> + * Copyright (c) 2018, Linaro Limited
> + */

Same here with the comment, just make the whole comment a C++ comment
rather than having one comment using both styles.  Similar things apply
elsewhere.

> +/* Port map of index vs real hw port ids */
> +static struct afe_port_map port_maps[AFE_PORT_MAX] =3D {
> +	[AFE_PORT_HDMI_RX] =3D { AFE_PORT_ID_MULTICHAN_HDMI_RX,
> +				AFE_PORT_HDMI_RX, 1, 1},
> +};

Is this not device specific in any way?  It looks likely to be.

> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> +{
> +	struct q6afe_port *p =3D NULL;
> +
> +	spin_lock(&afe->port_list_lock);
> +	list_for_each_entry(p, &afe->port_list, node)
> +		if (p->token =3D=3D token)
> +			break;
> +
> +	spin_unlock(&afe->port_list_lock);

Why do we need to lock the port list, what are we protecting it against?
We don't write here which suggests either there's some kind of race
condition in this lookup or the lock is not doing anything.

> +static int afe_callback(struct apr_device *adev,
> +			struct apr_client_message *data)
> +{
> +	struct q6afe *afe =3D dev_get_drvdata(&adev->dev);
> +	struct aprv2_ibasic_rsp_result_t *res;
> +	struct q6afe_port *port;
> +
> +	if (!data->payload_size)
> +		return 0;
> +
> +	res =3D data->payload;
> +	if (data->opcode =3D=3D APR_BASIC_RSP_RESULT) {
> +		if (res->status) {

Shouldn't we use a switch statement here in case we want to handle
something else?

> +		switch (res->opcode) {
> +		case AFE_PORT_CMD_SET_PARAM_V2:
> +		case AFE_PORT_CMD_DEVICE_STOP:
> +		case AFE_PORT_CMD_DEVICE_START:
> +			afe->state =3D AFE_CMD_RESP_AVAIL;
> +			port =3D afe_find_port(afe, data->token);
> +			if (port)
> +				wake_up(&port->wait);

No locking here?  It seems a bit odd that the AFE global state is being
set to say there's a response available but we wake a specific port.

> +	ret =3D apr_send_pkt(afe->apr, data);
> +	if (ret < 0) {
> +		dev_err(afe->dev, "packet not transmitted\n");
> +		ret =3D -EINVAL;
> +		goto err;

Why squash the error code here?  We don't even print it.

> +	}
> +
> +	ret =3D wait_event_timeout(*wait, (afe->state =3D=3D AFE_CMD_RESP_AVAIL=
),
> +				 msecs_to_jiffies(TIMEOUT_MS));
> +	if (!ret) {
> +		ret =3D -ETIMEDOUT;
> +	} else if (afe->status > 0) {
> +		dev_err(afe->dev, "DSP returned error[%s]\n",
> +		       q6dsp_strerror(afe->status));
> +		ret =3D q6dsp_errno(afe->status);

If we time out here and the DSP delivers a response later it looks like
we'll get data corruption - the DSP will happily deliver the response
into shared state.

> +static int afe_port_start(struct q6afe_port *port,
> +			  union afe_port_config *afe_config)
> +{
> +	struct afe_audioif_config_command config =3D {0,};
> +	struct q6afe *afe =3D port->afe;
> +	int port_id =3D port->id;
> +	int ret, param_id =3D port->cfg_type;
> +
> +	config.port =3D *afe_config;
> +
> +	ret  =3D q6afe_port_set_param_v2(port, &config, param_id,
> +				       sizeof(*afe_config));
> +	if (ret) {
> +		dev_err(afe->dev, "AFE enable for port 0x%x failed %d\n",
> +			port_id, ret);
> +		return ret;
> +	}
> +	return afe_send_cmd_port_start(port);

Why not just inline this function here?  It appears to have only this
user.

> +	int index =3D 0;

We set index to 0...
> +
> +	port_id =3D port->id;
> +	index =3D port->token;

=2E..the unconditionally overwrite it?

> +/**
> + * q6afe_port_start() - Start a afe port
> + *
> + * @port: Instance of port to start
> + *
> + * Return: Will be an negative on packet size on success.
> + */
> +int q6afe_port_start(struct q6afe_port *port)
> +{
> +	return afe_port_start(port, &port->port_cfg);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_port_start);

This is the third level of wrapper for the port start command in this
file.  Do we *really* need all these wrappers?

> +struct q6afe_port *q6afe_port_get_from_id(struct device *dev, int id)
> +{

> +	port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return ERR_PTR(-ENOMEM);

The _port_get_ function is allocating data but...

> +/**
> + * q6afe_port_put() - Release port reference
> + *
> + * @port: Instance of port to put
> + */
> +void q6afe_port_put(struct q6afe_port *port)
> +{
> +	struct q6afe *afe =3D port->afe;
> +
> +	spin_lock(&afe->port_list_lock);
> +	list_del(&port->node);
> +	spin_unlock(&afe->port_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(q6afe_port_put);

=2E..the _port_put() function isn't freeing it.  That seems leaky.  I'm
also a bit worried about this being a spinlock that we're using for
allocation, and not even spin_lock_irqsave().  Presumably this is
protecting against interrupts otherwise we'd not need a spinlock but
for that to work we'd need the _irqsave()? =20

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYabsACgkQJNaLcl1U
h9B9qQf/WATKLGQAmk8TiQplsSUEPDHMqf6jgYzWoXgWRnT06NKKpBZnO9l2rmmz
SsznY8MTqmf42p5w8l602GHRTB1KFc6Qj7sko3A2Bu7KbtQINdWiAtBbk0X6UGyF
LBdgKSW4DM2xttG1FxvmqfBLGBLK0XUUCpjIn0+Z1ZAcAqWC3BmdoYMiy5tHYb13
FIFNTA4ZWI06MMJXG2Xh1utLPJqfAnFhCpLXRyxWXRTyOiXmeeqm/h4n3IrcWXBe
uFAOM34+0UQQ4370eBUWrtU/hQcpx6tqxaKSxIBFZK8VFMm8LXAF9Mi6kaJsjC5n
4lroING3TpBGjikBw5/mjaBvxlq++w==
=DqGK
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--
