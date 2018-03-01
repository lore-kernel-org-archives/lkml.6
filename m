Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162044AbeCAVYX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:24:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161479AbeCAVYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:24:16 -0500
Date: Thu, 1 Mar 2018 21:24:02 +0000
From: Mark Brown <broonie@kernel.org>
To: srinivas.kandagatla@linaro.org
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
Subject: Re: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to Q6ADM
Message-ID: <20180301212402.GT12864@sirena.org.uk>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3T2jnoiI0lx9XXvh"
Content-Disposition: inline
In-Reply-To: <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3T2jnoiI0lx9XXvh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla@linaro.org wrote:

> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
> +				  int copp_idx)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +
> +	spin_unlock(&adm->copps_list_lock);

We've again got this use of spinlocks here but no IRQ safety - what
exactly is going on with the locking?  In general all of the locking in
this stuff is raising very serious alarm bells with me, I don't
understand what is being protected against what and there's some very
obvious bugs.  We could probably use some documentation about what the
locking is supposed to be doing.

> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {

> +		copp->id = open->copp_id;
> +		wake_up(&copp->wait);
> +	}
> +	break;
> +	default:

This indentation is confusing.

> +static struct copp *adm_find_matching_copp(struct q6adm *adm,
> +					   int port_id, int topology,
> +					   int mode, int rate, int channel_mode,
> +					   int bit_width, int app_type)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_id == c->afe_port) && (topology == c->topology) &&
> +		    (mode == c->mode) && (rate == c->rate) &&
> +		    (bit_width == c->bit_width) && (app_type == c->app_type)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +	spin_unlock(&adm->copps_list_lock);
> +
> +	c = adm_alloc_copp(adm, port_id);

So really this is a find or allocate operation...

> +	if (IS_ERR_OR_NULL(c))
> +		return ERR_CAST(c);
> +
> +	mutex_lock(&c->lock);
> +	c->refcnt = 0;

Why do we need to lock the thing we just allocated but didn't yet
initialize, and surely if something can find it before we finished
initializing we have a race condition?

> +	copp = adm_find_matching_copp(adm, port_id, topology, perf_mode,
> +				      rate, channel_mode, bit_width, app_type);
> +
> +	/* Create a COPP if port id are not enabled */
> +	if (copp->refcnt == 0) {
> +		ret = q6adm_device_open(adm, copp, port_id, path, topology,
> +				  channel_mode, bit_width, rate);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	mutex_lock(&copp->lock);
> +	copp->refcnt++;
> +	mutex_unlock(&copp->lock);

There's an obvious race here between checking the reference count and
incrementing it - something might drop a reference before we increment
it which would be bad.  I'm also not clear when we'd want multiple
things using a single COPP.

> +	mutex_lock(&copp->lock);
> +	copp->refcnt--;
> +	mutex_unlock(&copp->lock);
> +	if (!copp->refcnt) {

This locking is also broken.

--3T2jnoiI0lx9XXvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYb3EACgkQJNaLcl1U
h9C11Af+NLrkXf6H6aaT6ysSq6f3xzPiWQdmYMfCaA2XSy3Lbp7dz1UE2/hsL+fz
V08/WtJ4otq95fnwSdeehWvJLO92GETYkOhSqpSLzp9xfQWtuQls660BoxAWoths
ZOQmWr9F2gg/wOj7TFOQ+jvB8fczjrrxGu60l69AG6oJzRHwjJVxIvYixhpR59x9
6lfOXcoRphcsUNWV4DA7MVnYDB2JbwbYtTAh+kmaBmnYSnVKmHQfUIX5zZHRYNaz
gOs74lmMCrG6MDPtjmTzpJ1Pmyq9HRDQ8OlrQ4ObWAL7R+rDYJZs7oWr3yIJres0
4vT3/g1/FYYz1E5V3gM4DqkahLHRqQ==
=VY1a
-----END PGP SIGNATURE-----

--3T2jnoiI0lx9XXvh--
