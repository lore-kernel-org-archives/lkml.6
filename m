Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26CEFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B8920870
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 21:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+nBDajK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B8920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeJKEzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 00:55:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39859 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeJKEzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 00:55:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so3265963pfe.6;
        Wed, 10 Oct 2018 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KZuvaYjBbjqrbLmi4KfHFfTycMHJQeWev+PsWzx0CI8=;
        b=c+nBDajK01MAK0VqvfjBAceBE0wxWY3bD7c0MovEpH8kxVUokQ95pzeTW0ypE5hwoa
         ugcPgkfQ0HdwLbNhBX6mfaOePeYzNBpR1tj/5O9ZmokJ8b3eab9IrmM8yF/h2ahBcfmh
         f4w3z7/qCEIeLtwsUaupT8fPf1kgK41fhnse6Od5oyVS77Xw+3VJ+uBY1HAJKPGlXQPO
         JlmwLBLQ1JSVYknlnTvzUaFFvQj+bScYnGVz2S7XdXA++S9J1QGZyNx+S6mrMPLl4m/D
         Qkspk0YK7U/pUIrqFMfZoJXacX5Dxg2PZ25Jz8r8cc1SSiORk9xbonJiaxTIiHLMcCkb
         oLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZuvaYjBbjqrbLmi4KfHFfTycMHJQeWev+PsWzx0CI8=;
        b=SLuNjLKllYdA6aJOv0WmJglkpnnBCwJ+BsBjBFjsvJw+KgvvKhLHibhzBCHdI73ZTO
         Il7R+3DD7Smjvm1Z5KbObLszjM1ieg7KR09cfDFaomQmFjImWTONjeH54wXP4rGgVvb1
         He8sST2TdJqjxlcTT0jYWE2Y8DQRPI3RlJQQHktnNQAUFOtczHIHLFX3coZq6bPQJ7Qv
         U4GNoJ/O4NlTaSzzoRFPQnhZrc61rMY6KiZfKdAmGe7Bs5t7w5hx3kLr4k3ZPHj7Zqfs
         ChgUfvmGtNWSEFgbpwFX1dW2+IbKy/a6X4mAyUSOuHb4AcWmNaELB9B7M9dTcEvS/797
         H9yA==
X-Gm-Message-State: ABuFfoj2tbzAS6PacvVSfZX03rRTSzf3UjtZwxCY1h6EG1zDhhGUMljd
        LrkbmurPkuW5f4J09eKJw4c=
X-Google-Smtp-Source: ACcGV60xs24Bqy1Q/NaRwBWcKXS0zBeqQnTyvaNyhz8pSiXq/uAdCgbn1E53DXB7kYPawFe+sUN+CA==
X-Received: by 2002:a63:78cc:: with SMTP id t195-v6mr31212506pgc.329.1539207076480;
        Wed, 10 Oct 2018 14:31:16 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j75-v6sm33082198pfk.125.2018.10.10.14.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 14:31:15 -0700 (PDT)
Date:   Wed, 10 Oct 2018 14:31:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: (core) Add hwmon_mode structure and mode
 sysfs node
Message-ID: <20181010213113.GA21236@roeck-us.net>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-2-nicoleotsuka@gmail.com>
 <2c535925-5b75-75e6-e383-645fdf45f519@roeck-us.net>
 <20181010211356.GA1706@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010211356.GA1706@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolin,

On Wed, Oct 10, 2018 at 02:13:57PM -0700, Nicolin Chen wrote:
> Hi Guenter,
> 
> On Wed, Oct 10, 2018 at 06:08:30AM -0700, Guenter Roeck wrote:
> > > +available_modes The available operating modes of the chip.
> > > +		This should be short, lowercase string, not containing
> > > +		whitespace, or the wildcard character '*'.
> > > +		This attribute shows all the available of the operating modes,
> > > +		for example, "power-down" "one-shot" and "continuous".
> > > +		RO
> > > +
> > > +mode		The current operating mode of the chip.
> > > +		This should be short, lowercase string, not containing
> > > +		whitespace, or the wildcard character '*'.
> > > +		This attribute shows the current operating mode of the chip.
> > > +		Writing a valid string from the list of available_modes will
> > > +		configure the chip to the corresponding operating mode.
> > > +		RW
> > > +
> 
> > This is not a well defined ABI: The modes would be under full and arbitrary
> > control by drivers, and be completely driver dependent. It isn't just the sysfs
> > attribute that makes the ABI, it is also the contents.
> 
> > Also, being able to set the mode itself (for whatever definition of mode)
> > is of questionable value. This is not only for the modes suggested here, but
> > for other possible modes such as comparator mode vs. interrupt mode (which,
> > if configurable, should be via platform data or devicetree node entries).
> > For the modes suggested here, more in the other patch.
> 
> I could foresee an objection here but still wrote the change after
> seeing quite a few drivers (especially TI's chips) share the same
> pattern for operating modes: power-down, one-shot and continuous.
> For example, I could add it to ina3221 driver instead of touching
> the core code, but later I would do the same for the ina2xx driver
> (just received a board having ina230/226.)
> 
Most hardware monitoring chips have the functionality. That doesn't
mean that it makes sense to use/expose it.

> Although I don't mind doing this and will put it to ina3221 driver
> in v2, yet maybe we could think about a better way to abstract it?
> 

My comments to patch 2/2 still apply. Powerdown duplicates existing and
standardized functionality, one-shot mode is not as simple as just enabling
the mode, and I find it quite unlikely to one-shot mode would actually
save any energy.

Thanks,
Guenter
