Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74D5C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46EF620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IifeVxYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46EF620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730965AbeGYToj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:44:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730048AbeGYToj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:44:39 -0400
Received: by mail-pf1-f195.google.com with SMTP id u24-v6so1988282pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m7F+4MkbXWX1uwgpQf0vD/8WFCQ/oNlerITjk70RjiU=;
        b=IifeVxYtBbL/mY2O4GjzhWyRj0lZMGIRFWsIBoq3BGBUsAhckyCu1Mt4MmfdQA9nuk
         0hWCC0Xb7YJAtm7W7jK6Crs6f4+oPUcr1HkK/WqEe5oUBMH5kGby9yVXAS1cFOquApv9
         ZWNDfravOEl7dGXWOGWQv/wCtzeH9DtWPIhnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m7F+4MkbXWX1uwgpQf0vD/8WFCQ/oNlerITjk70RjiU=;
        b=Yujj2dURm1OGzrFnooNAXN6KUjo/pB4LDOClAIkziqFZu4kb/fOfIqjwr+yYfC5ED3
         haxmyZohG+zaZTGluk52wgPbpQY9RdFYwxxWyPH9xI00hSO0bDrjzlDT7XFdRICd3gc7
         gRdC+6ygm9hfYd4pT9W/Q6qiQqB03uOoAtLX11VyeRS7e2/L3vHf70CnWWohUkE5sBRv
         LslrXKhR99CNKE8XjjRuV2e53httuH0o6qqrhgUalLZoX+dPc/Od3vOU1VRdsL79IoDG
         yOxFE6ttTkrqwlllAPzrMJxv8sZExk9hNuNnR+VIbG2pX4Hkl6+6MdZ1M0CSMc4qNkOt
         PPvQ==
X-Gm-Message-State: AOUpUlHJuko3aEI2Arz6A2peO6vonZ0rUfbGeMg+35Pm4TyMu2IyiKXH
        dBcEQ8aUndiymZKeC8j6pLK59A==
X-Google-Smtp-Source: AAOMgpcbc2FVeVpN7wHgMMbg3wSVHwguAVqYX9Tu5qwgMUnLb+LxGISytaA9lo/gGQ1jEphcV9ZvRQ==
X-Received: by 2002:a63:5421:: with SMTP id i33-v6mr21848048pgb.417.1532543506167;
        Wed, 25 Jul 2018 11:31:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id o3-v6sm18001377pgv.53.2018.07.25.11.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 11:31:45 -0700 (PDT)
Date:   Wed, 25 Jul 2018 11:31:44 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
        rtatiya@codeaurora.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 7/7] Bluetooth: hci_qca: Add support for Qualcomm
 Bluetooth chip wcn3990
Message-ID: <20180725183144.GQ129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-8-bgodavar@codeaurora.org>
 <20180723195441.GM129942@google.com>
 <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81c324ee9104508cf5c862de3f697e4c@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 09:25:16PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2018-07-24 01:24, Matthias Kaehlcke wrote:
> > On Fri, Jul 20, 2018 at 07:02:43PM +0530, Balakrishna Godavarthi wrote:
> > > +	 * sometimes we will face communication synchronization issues,
> > > +	 * like reading version command timeouts. In which HCI_SETUP fails,
> > > +	 * to overcome these issues, we try to communicate by performing an
> > > +	 * COLD power OFF and ON.
> > > +	 */
> > > +	for (i = 1; i <= 10 && ret; i++) {
> > 
> > Is it really that bad that more than say 3 iterations might be needed?
> > 
> [Bala]: will restrict to 3 iterations.

Is 3x expected to be enough to 'guarantee' as successful
initialization? Just wondered about the 10x since it suddendly changed
from 1x. What is the failure rate without retries?

Could you provide more information about the 'communication
synchronization issues'? Is the root cause understood? Maybe there is
a better way than retries.

> > > +static void qca_regulator_get_current(struct device *dev,
> > > +				      struct qca_vreg *vregs)
> > > +{
> > > +	char prop_name[32]; /* 32 is max size of property name */
> > > +
> > > +	/* We have different platforms where the load value is controlled
> > > +	 * via PMIC controllers. In such cases load required to power ON
> > > +	 * Bluetooth chips are defined in the PMIC. We have option to set
> > > +	 * operation mode like high or low power modes.
> > > +	 * We do have some platforms where driver need to enable the load
> > > for
> > > +	 * WCN3990. Based on the current property value defined for the
> > > +	 * regulators, driver will decide the regulator output load.
> > > +	 * If the current property for the regulator is defined in the dts
> > > +	 * we will read from dts tree, else from the default load values.
> > > +	 */
> > 
> > Let's make sure we all really understand why this is needed. You
> > mentioned RPMh regulators earlier and said a special value of 1uA
> > would be needed to enable high power mode. Later when I pointed to the
> > RPMh regulator code you agreed that this special value wouldn't make
> > any difference.
> > 
> > Now the defaults are higher:
> > 
> [Bala]: today i got the info from the power teams here, currently in the
> downstream what we have is different wrt to the
>         patch "https://patchwork.kernel.org/patch/10524299/" by David
> Collins.
>         prior to his patch we have different architecture where 1uA will
> change the mode to HPM mode.
>         which is not valid, so 1uA will not work any more. we have go with
> actual current values.

Ok, in any case downstream drivers shouldn't impact the design of
upstream drivers. If there are incompatibilities the BT driver needs
to be hacked in the downstream tree.

>         coming back to reading current values from dts. we have reason for
> it.
>         let us assume that later stages of wcn3990 if we have less current
> values than default values.
>         instead of updating the driver again, we can assign the current no
> in the dts, which we will read.
> 
>         This is how it works.
> 
>         if(current value for the reg is declared in dts tree)
>               consider the current value from the dts.
>         else
>            go with default value.
> 
>       pls let me know if you any queries.

If I understand correctly you describe a hypothetical situation of a
future wcn3990 variant having lower power requirements. I'd say let's
deal with this when these chips actually exist and need to be
supported by Linux. As of now it seems there is no need for current
limits in the DT.

> > > +	if (device_property_read_bool(dev, prop_name))
> > > +		device_property_read_u32(dev, prop_name, &vregs->load_uA);
> > 
> > Why device_property_read_bool()?
> > 
> [Bala]: if the current prop is present we read from dts. else we go with
> default current no's.
>         if block  is used to check whether the property is present in dts or
> not.
>         this is required because before calling _regualtor_get_current() we
> hold the default current in the vregs[].
>         if we skip the read bool here, if the current property is not
> present then the function call of device_property_read_u32() will assign
> zero the vregs[].
>         so we miss the default current values.
> 
>         this how it work if we miss read_bool check
> 
>         //vregs hold default current
>          device_property_read_u32(dev, prop_name, &vregs->load_uA);
>          the above will read the current property value from dts store in
> the vregs.. if the property is missing in dts it will store zero.

Where does of_property_read_u32() set the value to zero when the
property does not exist?

A simple test in a probe function:

{
	u32 v = 123;
	of_property_read_u32(node, "no-such-property", &v);
	printk("DBG: v = %d\n", v);
}

[    7.598366] DBG: v = 123

And looking at the code, of_property_read_u32() ends up in a call to
of_property_read_variable_u32_array():

int of_property_read_variable_u32_array(const struct device_node *np,
			       const char *propname, u32 *out_values,
			       size_t sz_min, size_t sz_max)
{
	size_t sz, count;
	const __be32 *val = of_find_property_value_of_size(np, propname,
						(sz_min * sizeof(*out_values)),
						(sz_max * sizeof(*out_values)),
						&sz);

	if (IS_ERR(val))
		return PTR_ERR(val);

	...
}

i.e. 'out_values' is not modified when the property does not exit.
