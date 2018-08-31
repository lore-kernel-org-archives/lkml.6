Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118DAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C842083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 21:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Re/8oNl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C842083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeIABhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:37:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40168 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeIABhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:37:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so1496445pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 14:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/f5SiH+Yy2X5f3966YUM2eezMueZQZmUk5qNGdziboE=;
        b=Re/8oNl10P5IXbW4uC3Rt8THA7WdwcjtwfO1JlDgs330XwHA1T+X7J/ullGYMLUd6a
         7Z6GX/kLphzp2DRbeMHjRLZhT9G5JlpYr5fIkrGBVANN445ov7EptOJq/ZQ+0kkKyS6V
         JxQy2G+JA5sZOpkyXZLV3yO6d9GaqH8D104Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/f5SiH+Yy2X5f3966YUM2eezMueZQZmUk5qNGdziboE=;
        b=FBjgX/HQwhcIoWN/0BC2Wn6k0z9v+wsBxzK0U6v17xqxk++T7VW0sRoufSkf0/PpSP
         sYePN9Yk2PA/zRoe9toAYq6juJwHEFCH1t3atlL/MKBo1tn/VJ/mAzJE+UUUiDLGgWzY
         GuRJLoHkue3uD60HxWhG7ubMUubFUqWr7Kf/+5bHBqZVwXTSie7krc/hx0WDE8ggXuMc
         20eTzTPQIGl/YcUJxBOFt971d8WBAhbqxRLRsscNhWCOQ76qCWPBDRN2bF5AXkIEsHLa
         Ae508hEL94RYzP1k5/u7YJBkC45zxGMyNUZy04R1gsBKZVh0VfUJT3hUkJd6o8dAS82U
         Rtog==
X-Gm-Message-State: APzg51C4Q5AyFC490rjhNL6HFFme0ociCURGy6m6MLkOwrMk+PiJZB6I
        qYc1YaI5rShpELvIWoXfz4Tqcg==
X-Google-Smtp-Source: ANB0Vdb0TbmolKqyQnr89k7z/DZwjZ9o3pktO3C3ebNG5HtUZb1u50K32DPHnGsEJzVNR7+WdTZtwg==
X-Received: by 2002:a63:1413:: with SMTP id u19-v6mr16252108pgl.247.1535750897133;
        Fri, 31 Aug 2018 14:28:17 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id p19-v6sm13728595pgh.60.2018.08.31.14.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 14:28:15 -0700 (PDT)
Date:   Fri, 31 Aug 2018 14:28:12 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Message-ID: <20180831212810.GA151891@ban.mtv.corp.google.com>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
 <20180815221601.GB24830@rob-hp-laptop>
 <20180831012656.GB67271@ban.mtv.corp.google.com>
 <44c7fc7a-9c1c-e894-f27f-5320c061aafc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c7fc7a-9c1c-e894-f27f-5320c061aafc@linaro.org>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Fri, Aug 31, 2018 at 09:43:30AM +0100, Srinivas Kandagatla wrote:

> On 31/08/18 02:26, Brian Norris wrote:
> > > Seems to me that nvmem needs to be extended to allow providers to
> > > retrieve and interpret data. Not everything is at some fixed offset and
> > > size. Something like this is valid dts:
> > > 
> > > nvmem = <&phandle> "a-string";
> > > 
> 
> There has been some discussion on extending nvmem support to MTD and non-DT
> users in https://patchwork.kernel.org/cover/10562365/
> 
> One of the thing which we discussed in this thread is adding compatible
> strings to cells mainly to
> 1> Differentiate between actual cells and partitions for MTD case.

I'm not particularly worried about the MTD case. As I mentioned earlier,
while VPD is stored on flash (and could be exposed as an MTD), coreboot
places these tables in memory, and we currently just read them from
there instead of from flash.

> 2> Allow provider specific bindings for each cell, in VPD instance key
> string & value length could be one them.

I'm not sure we'd need to have a binding for value length -- VPD encodes
the length itself, and for many properties, the length is understood by
both sides anyway (2x6 bytes for a MAC address).

> This means that we would endup adding xlate callback support to the
> nvmem_config.

OK, but that's not in the current series, correct?

> AFAIU, From consumer side old bindings should still work!

I'm still trying to wrap my head around all the existing and proposed
behaviors of nvmem, but I see a few things lacking (IIUC):

(1) for the new "lookup" method, you would only support a single MAC
    address, identified by looking up for "mac-address" -- this means
    you can't support two devices (e.g., we have systems with VPD
    entries for "ethernet_mac0" and "etherent_mac1")
(2) the consumer API isn't very flexible -- it assumes that the data you
    read out of an NVMEM cell is directly usable as a MAC address; this
    fails for VPD, because VPD uses ASCII encoding. To resolve this,
    you'd need the consumer/provider relationship to know something
    about the data type -- to know that we should decode the ASCII
    values

> From non-dt or ACPI side these cells can be parsed by the provider driver
> and add it to the nvmem_config.

I think that might work, except for the above problems. But perhaps I'm
misreading.

> Does this make sense? Or Did I miss anything obvious ?
> 
> 
> > > But that's pretty uncommon (I can't think of a binding that actually
> > > uses that). Perhaps the provider has an array of keys defined and the
> > > consumer just provides the index.
> > In the case of VPD, all keys are 0-terminated strings (there's also a
> > length field, but the key is still 0-terminated), so that scheme could
> > work. (I'm not sure an indexed provider is extremely relevant right now,
> > although it probably could be supported if I expand the of_nvmem
> > retrieval to support a generic of_xlate() override anyway.) The
> > information represented is almost the same as in my proposal, except that:

@Rob:
I forgot about problem (2) above -- NVMEM is not very expressive about
the *type* of information. My proposal makes it explicit that the
provider is presenting MAC addresses. To make a generic VPD NVMEM
provider, I'd need to do ASCII decoding on some fields but not on
others.

Brian

> > (a) now I have to give the VPD a phandle -- so far, I've avoided that,
> >      as it's just an auto-enumerated device underneath the
> >      /firmware/coreboot device (see drivers/firmware/google/vpd.c)
> > (b) this is no longer directly useful to ACPI systems -- I'm not
> >      actually sure how (if at all) nvmem provider/consumer is supposed to
> >      work there
> > 
> > But maybe this isn't really that useful to ACPI, and it's sufficient to
> > just have fwnode_get_mac_address() call of_get_nvmem_mac_address() when
> > we're using DT.
> > 
> > > Or we could do '<key>-nvmem = <&phandle>', but parsing that is a bit
> > > more complicated.
> > That doesn't seem to have much advantage to me.
