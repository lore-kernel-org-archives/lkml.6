Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2636C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8422520854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kSH5ZBTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeILQDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:03:48 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51255 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeILQDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:03:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so1906441wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 03:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xrH6dVLhCsdLWxODDvqoG3fI8uQvRp2Y1RW+Vl20AuY=;
        b=kSH5ZBTbeAGNMsr/yVRlr2VTcxqLo42kAVyBZtOz90k1/9FVdnZ3M4SlckjuE1DUEz
         wp52CGUzXUXw+/ZhVFtF16MjOWVUwqmUXexBjP73DOKbjtN75PZWBp16BKNETGbQ7TrV
         kT39FeR6zOQoH+BkQCdWvFHw8joku616ZNeEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xrH6dVLhCsdLWxODDvqoG3fI8uQvRp2Y1RW+Vl20AuY=;
        b=DItF29NhTADKf8W1Qo/sqa58NliF7vNLmNKd5mnt7SD+5s9LVFA7UQOUgG9UIKIlAH
         yFM7cC2M1cWEmaeYauTf6IuplYvV1nzGWQKZCS+rlf+/sSRkGb3+MDH+qzgxLa53XXcA
         Ro0tU9Oc9jnHNyJZFvcGkAjN3abx7bG/DZC6MJQjPm9mLju+i3aXQo+DnFUcZpmVgrJU
         CMr/5gCp1fgHMwj+NndPgLjtoyNGMehpkWggyedowIj6t4nP2ctTbozSKnC/Ef1klRvf
         qODmm3x4PZnxNaKURVbzOZXTIEkNQFzfKRmo+hblL/FcIsmhkKN9gJSWOGrwYw9pdJ7T
         5e9w==
X-Gm-Message-State: APzg51Cue5FhmGHNzNUrkIDx0GypKPDB/jScEE+XCxfLGkMscA79vN+R
        G2tJqgT9B+ZuvyB1inWLZIcPG7BIstqG5kDw
X-Google-Smtp-Source: ANB0VdZYA4bkEIZGwdYiAYyj4y8Uidd0dXQjcJI2FM+LY84eJ4kF/xIxgxn7T9Vwne3PO5w9zh/pjQ==
X-Received: by 2002:a1c:dd05:: with SMTP id u5-v6mr1223232wmg.107.1536749984316;
        Wed, 12 Sep 2018 03:59:44 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id q16-v6sm414649wrn.41.2018.09.12.03.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 03:59:43 -0700 (PDT)
Date:   Wed, 12 Sep 2018 11:59:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
Message-ID: <20180912105941.GS4185@dell>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018, Srinivas Kandagatla wrote:

> 
> 
> On 12/09/18 09:58, Lee Jones wrote:
> > > > > +static const struct mfd_cell wcd9335_devices[] = {
> > > > > +	{ .name = "wcd9335-codec", },
> > > > > +};
> > > > Are there more devices to come?
> > > > 
> > > Yes, that is the plan, we are kind of limited in hardware setup to test few
> > > things like soundwire controller. We are exploring other ways to test these.
> > I normally don't accept MFDs with just one device enabled.  Since it's
> > not really an MFD (M == Multi) until it has more than one function.
> > 
> 
> WCD9335 Codec hw itself has multiple hw blocks.
> 
> If the issue is about adding more entries to mfd cells then we should be
> able to add below entry:
> 
> 	{ .name = "wcd9335-soundwire-controller", },
> 
> Actual driver for soundwire controller is not something We can test with
> regular dragon boards, it needs special hw for smart speakers. Once we have
> that we can test and post the drivers for that.
> 
> Otherwise
> 
> Are you suggesting that I move everything to  sound/soc/codecs and then back
> to mfd once soundwire controller driver is added?

My preference would be for you to add at least one other (tested)
device.  However, in your case I know where you live, so I can throw
tomatoes at your house if you don't upstream more device support
promptly! ;)

When will you be enabling more devices?  If the answer is 'never',
then creating an MFD is a waste of time.

> > [...]
> > 
> > > > > +	struct device_node *ifc_dev_np;
> > > > ifc isn't very forthcoming.  Any way you can improve the name?
> > > ifc was suggested in dt bindings by Rob,  I can proably rename to
> > > interface_node.
> > ifc is a horrible variable name - just sayin'.
> > 
> > [...]
> > 
> > > > > +	ret = wcd9335_bring_up(wcd);
> > > > So the device_status call-back brings up the hardware?
> > > > 
> > > device status reports the device status at runtime. We can not communicate
> > > with the device until it is up, enumerated by slimbus and a logical address
> > > is assigned to it. So the best place to initialize it is in status callback
> > > where all the above are expected to be done.
> > Right, I understand what's happening.  I just think the semantics are
> > wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
> > status and it ends up initiating a start-up sequence.  Just from a
> > purist's point of view (I understand that it "works"), it's not good
> > practice.
> > 
> > > Probe is expected to setup the external configurations like regulators/pins
> > > and so on which gets the device out of reset and ready to be enumerated by
> > > the slimbus controller.
> > I suggest fully starting the device in probe() is a better approach.
> > 
> Its catch-22 situation, without device being powered up and reset correctly
> there is no way to enumerate it.

Isn't power-up and reset also done in probe()?

What am I missing?

> > [...]
> > 
> > > > > +struct wcd9335 {
> > > > > +	int version;
> > > > > +	int intr1;
> > > > What's this?  If I have to ask, it's probably not a good name.
> > > > 
> > > This is a hardware pin name for interrupt line 1.
> > I don't see how this is used, so it's difficult for me to advise
> > fully, but I find this confusing.  Pin name/number?  Shouldn't this be
> > handed by Pinctrl?
> > 
> This is represented as proper irq line in dt via  pintrl irq controller.

So why can't it just be 'irq' like most of the time?

What is the 1 in reference to?  Will there be a 2?

> > intr1 could be quite ambiguous.  Especually as the '1' could easily be
> > read as an 'l'.  Suggest that 'irq1' or 'irq_1' or 'irq_one'.
> 
> I can change this to something more readable in next version or may be I can
> even remove it may be just use a local variable.

If it's possible for it to be a local variable, then it should not be
placed in device data.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
