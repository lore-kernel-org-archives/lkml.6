Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE95C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E09AA21531
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW/b8Dbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09AA21531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI0C7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:59:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36961 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbeI0C7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:59:42 -0400
Received: by mail-pf1-f194.google.com with SMTP id x26-v6so200376pfn.4;
        Wed, 26 Sep 2018 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xb8gzcccat0/mPhjrV5iQHaA8C5c0LhWoInQbnZ4Tr8=;
        b=gW/b8DbxBUnlHnc9N2K5EPmTljQmbC2s6RKNBn0lzARM10hMpxL0ysOtSfzXujtq3r
         //TMqkU616c/HanHNS8SzWct8A7UbuplBMJ4JJQlPGaADrH+59KvVQDuIxR7dTYN4D8I
         kTJdY7kM6LuOH1OFmFXUVCqIoM+M0B+kjX3cTnvvAaQFai9Ka0RDNjlQ2BW/0VCr49sG
         hoCJviatf+PqoYekoeOkeoz3u6TyQyihV6x4rzeQd0tGaq5vWfncuQYwYQykWq32CaMY
         NlxMc3DoPN9OV+GLCcgh6PeqQ4wI9nw7PqmapXK/x7GtwYxO1a98pc4herQwRKMTH/LA
         eG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xb8gzcccat0/mPhjrV5iQHaA8C5c0LhWoInQbnZ4Tr8=;
        b=Q5T7A1u3XcyAFoV016RF+EnRyus/Q893cfd5vIlA2HE9RtV0R/8SyAEXS0/8qlOOmG
         LkaLTKdGHPKOkpSR1PAQMK7iGDwZSYtRkkG9R3GP2u4vOqi2X77BrzCQgl0O5VCBPmek
         n0Jtwu8iuM8CPjaUOHRAzQQQ45J4+oB6kGaABhM6tELV+QUFnSq8H5Ln0+6aDB78TUy6
         WyvM3yCPXclI1S4uprrTA/E9CeyIx76jwBJ6UzulPpcY7DXE1Dh92bJfRBKDwQ5BKjyx
         Mk1076H0E7ASyEGHge/ydDqhB66uk66y/RFNHmxOJ00q3NHq+6410hfclnkqh1Z7axsf
         5spg==
X-Gm-Message-State: ABuFfojNZM8U9tTadQgB+ToupodQxFA5FiJH3mK5J/dy039GKbYDv8pR
        iAs9Mw7DNwNQTpdT8bM+VuM=
X-Google-Smtp-Source: ACcGV60CLhwUsmMU2hkYEYvL27eZavtSywXWYDtEVs+28XxlKa6kJ7AHkdKsWqs7CWdmyA0drsDl9w==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr7819420pfb.157.1537994697043;
        Wed, 26 Sep 2018 13:44:57 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g88-v6sm7643pfd.181.2018.09.26.13.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 13:44:56 -0700 (PDT)
Date:   Wed, 26 Sep 2018 13:44:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, corbet@lwn.net, afd@ti.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Add enable sysfs nodes
Message-ID: <20180926204455.GA17035@roeck-us.net>
References: <20180926064245.4091-1-nicoleotsuka@gmail.com>
 <20180926064245.4091-3-nicoleotsuka@gmail.com>
 <0cfe55e1-10d8-ac1f-8b6e-73777074a219@roeck-us.net>
 <20180926180243.GA6329@Asurada-Nvidia.nvidia.com>
 <20180926195817.GA19695@roeck-us.net>
 <20180926202519.GB10595@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926202519.GB10595@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 01:25:20PM -0700, Nicolin Chen wrote:
> Hello,
> 
> On Wed, Sep 26, 2018 at 12:58:17PM -0700, Guenter Roeck wrote:
> > On Wed, Sep 26, 2018 at 11:02:44AM -0700, Nicolin Chen wrote:
> > > On Wed, Sep 26, 2018 at 06:06:32AM -0700, Guenter Roeck wrote:
> > > > On 09/25/2018 11:42 PM, Nicolin Chen wrote:
> > > > > The inX_enable interface allows user space to enable or disable
> > > > > the corresponding channel. Meanwhile, according to hwmon ABI, a
> > > > > disabled channel/sensor should return -ENODATA as a read result.
> > > > > 
> > > > > However, there're configurable nodes sharing the same __show()
> > > > > functions. So this change also adds to check if the attribute is
> > > > > read-only to make sure it's not reading a configuration but the
> > > > > sensor data.
> > >  
> > > > One necessary high level change I don't see below: With this change,
> > > > we should no longer drop a channel entirely if it is disabled from
> > > > devicetree. All channels should be visible but report -ENODATA if
> > > > disabled. In other words, it should be possible for the 'enable' flag
> > > > to override settings in DT.
> > > 
> > > Hmm...I don't feel so convinced here. The status in DT binding isn't
> > > exactly a setting but a physical status: if a hardware design leaves
> > > a channel to be disconnected, I don't really see a point in enabling
> > > it in the runtime. Or maybe you can shed some light on it?
> > > 
> > 
> > You are making an assumption from your use case. It might as well be that
> > some or all channels are disabled in DT by default to conserve power,
> > not because they are disconnected.
> 
> I think I probably should update my DT binding somehow to say it
> explicitly that the property should be only used in cases of the
> physical disconnections, although I feel the current binding "no
> input source" already has the same meaning.
> 
> In my opinion, disabling channels in DT to save power isn't very
> plausible, because it sounds more likely a user decision, while,
> as we know, DT merely describes the hardware design.
> 

I try to avoid making such assumptions. All I know is that I'll have
to deal with the fallout if a single person wants to use the property
differently. This is similar to disabling an entire subsystem in DT
because it isn't used in a specific system - say, a SPI or I2C bus
which has nothing connected on some shipping hardware, even though
the board has a connector for it. Your argument is that one shall
not use the status property do disable loading the driver, and that
one must not remove a set of properties for unused hardware either.
That doesn't sound very realistic to me.

Point is that I don't _know_ how this is going to be used, so I'd
rather keep it flexible.

Guenter

> Otherwise, if we want something like a setting for this purpose,
> we should probably use a different property for DT binding, bool
> type "disable-on-boot" for example.
> 
> > > Meanwhile, I believe the enable nodes are necessary in either way as
> > > users could decide to disable the connected channels, based on their
> > > use cases, to save power.
> > > 
> > Agreed, though I would not say "necessary". "Useful" seems to be more
> > appropriate.
> 
> Yea..
