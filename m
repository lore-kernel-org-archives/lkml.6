Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F59206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YyxycS+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfAIVzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:55:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39287 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfAIVzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:55:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so4274343pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 13:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Eexg7PVaWivfk6O8RpcNpABcP7SUyAO8ggltxz0kD4=;
        b=YyxycS+A6kHhY/smYW8YVW88s4fESVwA+Rk8PyUVOFtLrKp/uZZc7qY38CGAvD8YWk
         kJsvQwVhkUwZ0dtxPFkGrecc7JCxc3ydJy6owmGHGaeu0bVEbn6nOGyHX/ePbzd1ltBQ
         8Zdl7NP0T+HU/DCDGtGVaVU9cn7SFqeZhgnOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Eexg7PVaWivfk6O8RpcNpABcP7SUyAO8ggltxz0kD4=;
        b=Zq8//Yc7xX0Ecqju0D55BGRUwhU3htlJG3mdBdGzhalMXDT74xCP5pU8/aPIahK4NX
         H38QSsn/M8/ADXeEi9Dz3CxXWOAyYC2RNQ4gDQHOtWwH4UYx5Ubgq9Q9Mh3UpckkPZTX
         q4wzmIW8mbKoDH8E+Jymmcf33KLujpNqRuBcbx+XPj2vpDWoIBCLKoS2is4tqnB3Z94d
         cFH2o/h+vmDlcW3SWoDja/pYZbtxGg97b5SUIJVJ7Gytp51sOqSqk5Z+6TUxO+sI1/r0
         pToypxmIhNkYuSm9Gq7IjhHVG2n6+LGv+m46VJTJGttM9nQ+87IPSj5xHoLTFWV0ZY6Z
         A2XA==
X-Gm-Message-State: AJcUukcA1JnrZEGSiT6i02PYo5JmBkgpQsorAagTMnqbLd8dOTlcHma5
        wM/+F5r2kmbxnfgPgV+xgIxquQ==
X-Google-Smtp-Source: ALg8bN6PFVdS8Eb60ystXNAKSJ/BHSVn8lSYXSdG61hO3iuK45wychvyitXu4MoVIprT1LJoJyjcLA==
X-Received: by 2002:a62:ed0f:: with SMTP id u15mr7458365pfh.188.1547070938587;
        Wed, 09 Jan 2019 13:55:38 -0800 (PST)
Received: from google.com ([2620:15c:202:1:534:b7c0:a63c:460c])
        by smtp.gmail.com with ESMTPSA id a18sm97849291pgj.30.2019.01.09.13.55.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:55:37 -0800 (PST)
Date:   Wed, 9 Jan 2019 13:55:34 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>,
        Chris Lew <clew@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: remoteproc: qcom: Add firmware
 bindings for Q6V5
Message-ID: <20190109215532.GA178267@google.com>
References: <20181228044819.5697-1-sibis@codeaurora.org>
 <20181228044819.5697-2-sibis@codeaurora.org>
 <20190103233014.GA181833@google.com>
 <20190103235043.GA195759@google.com>
 <20190104000145.GJ31596@builder>
 <20190104001158.GA200069@google.com>
 <20190105015430.GA67838@google.com>
 <CAL_JsqLbMNB6EzYCzmq5PBc9EvVmYifsoJBwymV621h385Hv0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLbMNB6EzYCzmq5PBc9EvVmYifsoJBwymV621h385Hv0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:22:30AM -0600, Rob Herring wrote:
> On Fri, Jan 4, 2019 at 7:54 PM Brian Norris <briannorris@chromium.org> wrote:
> > To add to my thoughts, since I think maybe Sibi was a little unclear of
> > my thoughts:
> >
> > One of my primary concerns with the existing approach is that it's
> > basically a complete free-for-all. We should have some minimal standards
> > (enforced in code) such that our DTB can never point us at something
> > like /lib/firmware/<other-vendor>/foo.bin (or /lib/firmware/modem.mdt;
> > or lots of other bad examples). This could probably be done simply by
> > always prefixing 'qcom/' (I don't remember -- does request_firmware()
> > follow '..'? e.g., 'firmware-name = "../bar/foo.bin"'.)
> 
> We can write a schema to enforce some of this:
> 
> firmware-name:
>   pattern: "^\w.*"

Are DT schemas ready to use/enforce? Or would this currently just be a
suggestion? I'm out of the loop. But I guess that would be interesting.

> And you can have a device specific schema to enforce a subdir and/or
> filename(s).
> 
> I tend to think we should not put part of the path in drivers. No real
> good reason other than we already allow that for other users of
> 'firmware-name'.

OK. (I was surprised you accepted paths at all. But if we're going down
that road... *shrug*)

> > As a bonus: it would be very nice if we can provide a little more
> > structure by default, and avoid arbitrary hierarchy in the DTS. That's
> > where I brought up ath10k's "variant" as an example; if we can use
> > 'compatible' to capture most of this particular Hexagon core's
> > properties, then we only leave a single level of variability to the DTS.
> 
> Some bindings use compatible to determine/construct the firmware name.
> If you want to restrict things, then that's probably how you should do
> it IMO.

We already have reasons up-thread for why we can't get this exclusively
from compatible.

But if we were to partially construct and/or validate paths using
compatible, then the time to do that is now. As soon as this is merged
without such validation, then we're stuck.

Given the above, it seems like maybe the best we can do is put a
recommendation into a DT schema pattern.

Brian
