Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717BEC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF4221473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2UoqpFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF4221473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeJFEsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:48:16 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJFEsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:48:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id 30-v6so7407093plb.10;
        Fri, 05 Oct 2018 14:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8gOChbtKZqdtik70w/F41RnTDSxYpINqRzI3UEg16c=;
        b=H2UoqpFxHSFrm+aZGXqzeOXoxn96zj63aFdKrxslWYM+VwqM0NysAAJNnKVeLrqcob
         ecAyQoUt4SLeKBCOtn1a07X2X/x1vzoz4bHR3NsLYh73sWKIwIofBJdhqZOa/zLz928n
         504efhEC5YrNGzbRqSjmc85/WU4Tcrdl6elKuvIT8JbSKhny/UURewWN8NBfYzA85i8g
         T71KnVx5NykGdL0hiMfxe5G9f/rocwPNbRkGxQphaL2vjipc4JKoJzhKn0TZ4vsQ/3Tv
         vU1m4T4GnW706DSJwJ+FkuR6+UexdE60OSX6NNnxv82sD6WtNh7c4TLtIU/3GqaYW9tr
         gufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8gOChbtKZqdtik70w/F41RnTDSxYpINqRzI3UEg16c=;
        b=ULj0PdAsMsxr1J750KYUMLrrEx0HdrEh2/hNcHwcsMldw7DWpwUI2nfrfqY9IU4zJG
         1pSVVi7h28N336Jp8KHiNiZVxtCkfuZ2AotxAMotLfHId1aXPteLaE/qzIjINfa3faPk
         ObMLOdYL/LnGYlmhn8Hfd1Lvc+6KJz/DnYHQ6A+uxLOctIslc4Tq3fkhmJ9DOBGMwFcd
         nFsA3zsA4qvRIE8vlRbnl83lyxXsnv7ReDn2RNf003IJlklOUZ8l1gWgz7rfsaL8voAW
         NpBNBru9m8dS4NdQgyyS9XgBFL0u7K/o1e4LJ4bHXhvS/q8GFBFwtioW5GT1qJXEXxFZ
         nWuw==
X-Gm-Message-State: ABuFfojGdZpDLPEcS0J98l9teWBdOvsSsRsDAxacDExI8cyw42oT64+a
        kAzdm09WNkwaaFSUtp8JOTU=
X-Google-Smtp-Source: ACcGV60a+BlSv3Q5YhzDKfChrAeMBYGvr8l3RDBRoKxDgi5CyfyGK110EKteJfri8QKIW/Q+/jz24w==
X-Received: by 2002:a17:902:6102:: with SMTP id t2-v6mr12984047plj.278.1538776057622;
        Fri, 05 Oct 2018 14:47:37 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 70-v6sm13515636pfz.27.2018.10.05.14.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 14:47:36 -0700 (PDT)
Date:   Fri, 5 Oct 2018 14:47:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20181005214734.GC215120@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
 <20180925121927.GL11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925121927.GL11965@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Tue, Sep 25, 2018 at 03:19:27PM +0300, Heikki Krogerus wrote:
> On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> > I think we are talking about totally different use cases and that is why
> > we are having hard time coming to a mutually agreeable solution. Could
> > you please describe in more detail what you would like to achieve,
> > and preferably show how it is described now with DT and/or ACPI, so that
> > I have a better frame of reference.
> 
> Yes, of course. Sorry.
> 
> USB ports are devices that usually the USB controller drivers register
> (or actually the USB core code). They are represented in both ACPI and
> DT as child nodes of the controller device node. The USB connector OF
> node is defined in file
> Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> In short, the controller drivers will request handle to a child node
> that represents a port, and only after that register the actual port
> device.
> 
> The drivers I'm looking at currently are the USB Type-C port
> controller drivers and the port manager (in Greg's usb-next or
> linux-next):
> 
>         drivers/usb/typec/tcpm/tcpci.c
>         drivers/usb/typec/tcpm/fusb302.c
>         drivers/usb/typec/tcpm/tcpm.c
> 
> The goal is simply to get rid of the platform data as usual, and
> ideally so that we don't need any extra code in order to support the
> "legacy" platforms.

Are these actually used on any of the "legacy" platforms? I fetched
linux-next today, but I do not actually see anything in
drivers/usb/typec touching platform data...

In the context of the connector, even before we descend to child nodes
details, how do you propose implementing references between fwnodes?
Especially since the other node (in case you complementing existing
topology) may be ACPI or DT instance?

I want to say that "You aren't gonna need it" for what you are asking
here and we can actually split it apart if and when we actually want to
separate creation of pset-backed device nodes and instantiating
corresponding device structures.

Thanks.

-- 
Dmitry
