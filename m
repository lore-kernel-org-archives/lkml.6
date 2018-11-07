Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84D4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CD62081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CD62081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lucaceresoli.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731454AbeKHCzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:55:55 -0500
Received: from srv-hp10-72.netsons.net ([94.141.22.72]:51199 "EHLO
        srv-hp10-72.netsons.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHCzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:55:54 -0500
Received: from [109.168.11.45] (port=34112 helo=[192.168.101.125])
        by srv-hp10.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <luca@lucaceresoli.net>)
        id 1gKRYv-00Dcff-Dj; Wed, 07 Nov 2018 18:24:17 +0100
Subject: Re: [PATCH v4 3/4] media: i2c: Add MAX9286 driver
To:     kieran.bingham+renesas@ideasonboard.com,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org
Cc:     devicetree@vger.kernel.org, sakari.ailus@iki.fi,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>
References: <20181102154723.23662-1-kieran.bingham@ideasonboard.com>
 <20181102154723.23662-4-kieran.bingham@ideasonboard.com>
 <bfae74db-aa54-32b3-966b-b8d17f2e366b@ideasonboard.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <898b4698-c3c3-9d38-e117-6a4274ba2ca4@lucaceresoli.net>
Date:   Wed, 7 Nov 2018 18:24:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bfae74db-aa54-32b3-966b-b8d17f2e366b@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srv-hp10.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: srv-hp10.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: srv-hp10.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

thanks for the clarification. One additional note below.

On 07/11/18 16:06, Kieran Bingham wrote:
> Hi Luca
> 
> <Top posting for new topic>
> 
>> <lucaceresoli> kbingham: hi, I'm looking at your GMSL v4 patches
>> <lucaceresoli> kbingham: jmondi helped me in understanding parts of it, but I still have a question
>> <lucaceresoli> kbingham: are the drivers waiting for the established link before the remote chips are accessed? where?
> 
> I'm replying here rather than spam the IRC channel with a big paste.
> It's also a useful description to the probe sequence, so I've kept it
> with the driver posting.
> 
> I hope the following helps illustrate the sequences which are involved:
> 
> max9286_probe()
>  - max9286_i2c_mux_close() # Disable all links
>  - max9286_configure_i2c # Configure early communication settings
>  - max9286_init():
>    - regulator_enable() # Power up all cameras
>    - max9286_setup() # Most link setup is done here.
>    ... Set up v4l2/async/media-controller endpoints
>    - max9286_i2c_mux_init() # Start configuring cameras:
>      - i2c_mux_alloc() # Create our mux device
>      - for_each_source(dev, source)
>            i2c_mux_add_adapter() # This is where sensors get probed.
> 
> So yes sensors are only communicated with once the link is brought up as
> much as possible.

For the records, an additional bit of explanation I got from Kieran via IRC.

The fact that link is already up when the sensors are probed is due to
the fact that the power regulator has a delay of *8 seconds*. This is
intended, because there's an MCU on the camera modules that talks on the
I2C bus during that time, and thus the drivers need to wait after it's done.

This delay happens before max9286_setup() is called.

> Because the sensors are i2c devices on the i2c_mux - they are not probed
> until their adapters are created and added.
> 
> At this stage the i2c-mux core framework will iterate all the devices
> described by the DT for that adapter.
> 
> As each one is probed - the i2c_mux framework will call
> max9286_i2c_mux_select() and enable only the single link.
> 
> This allows us to configure each camera independently
> 
> (which is essential because they are all configured to the same i2c
> address by default at power on)
> 
> 
> Hope this helps, and feel free to ask if you have any more questions.
-- 
Luca
