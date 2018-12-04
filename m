Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5766C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B9820879
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 23:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD6Fvf4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B9820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeLDXOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:14:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDXOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 18:14:31 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E72420879;
        Tue,  4 Dec 2018 23:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543965270;
        bh=gPiuByVlFZmQjFD8LtFUtv2RfUsm9mDEckea3RbPu50=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iD6Fvf4EByhCq+94ulwiwxqGiDe1q3qPCGCelkz7NxMuwCg2188SzsxdGu/Ogu6it
         tQ0nE822Bjmk8txOmQB+Jw3hLqw815kPwPp2pl91Kx67vIIu6GvTiVhWNS53Kz6z57
         51WlmqGHXQI5fsxKrmGI8B5LkwKUV94ZAFo+fcJE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        collinsd@codeaurora.org, mka@chromium.org, robh@kernel.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181204052119.806-5-rnayak@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
References: <20181204052119.806-1-rnayak@codeaurora.org>
 <20181204052119.806-5-rnayak@codeaurora.org>
Message-ID: <154396526967.88331.13652897075952274639@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/8] soc: qcom: rpmpd: Add support for get/set performance
 state
Date:   Tue, 04 Dec 2018 15:14:29 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajendra Nayak (2018-12-03 21:21:15)
> @@ -221,6 +224,47 @@ static int rpmpd_power_off(struct generic_pm_domain =
*domain)
>         return ret;
>  }
>  =

> +static int rpmpd_set_performance(struct generic_pm_domain *domain,
> +                                unsigned int state)
> +{
> +       int ret =3D 0;
> +       struct rpmpd *pd =3D domain_to_rpmpd(domain);
> +
> +       mutex_lock(&rpmpd_lock);
> +
> +       if (state > MAX_RPMPD_STATE)
> +               goto out;

Does this need to be under the mutex lock? Doesn't look like it.

> +
> +       pd->corner =3D state;
> +
> +       if (!pd->enabled && (pd->key !=3D KEY_FLOOR_CORNER))

Please drop useless parenthesis.

> +               goto out;
> +
> +       ret =3D rpmpd_aggregate_corner(pd);
> +
> +out:
> +       mutex_unlock(&rpmpd_lock);
> +
> +       return ret;
> +}
> +
> +static unsigned int rpmpd_get_performance(struct generic_pm_domain *genp=
d,
> +                                         struct dev_pm_opp *opp)
> +{
> +       struct device_node *np;
> +       unsigned int corner =3D 0;
> +
> +       np =3D dev_pm_opp_get_of_node(opp);
> +       if (of_property_read_u32(np, "qcom,level", &corner)) {
> +               pr_err("%s: missing 'qcom,level' property\n", __func__);

We leak np reference here, assuming dev_pm_opp_get_of_node() returns an
of_node_get() pointer to the caller.

> +               return 0;
> +       }
> +
> +       of_node_put(np);

This same code exists twice. Perhaps a helper needs to exist for
qcom_rpm_get_performance() to pull the number out of the DT.

> +
> +       return corner;
> +}
