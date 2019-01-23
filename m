Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6AFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BCF21855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxRQ+rCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbfAWSwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:52:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39741 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfAWSwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:52:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1609227pld.6;
        Wed, 23 Jan 2019 10:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TNXWEwgmCAyVKAXNNQya/meKe2jV5qxqAUnl8C3LiXk=;
        b=nxRQ+rCr2+GoOxtyIXqeM3Kke51pIf2NU7eB1+8vfCB5ZShYLmaNPUHZmj5WTQBT+H
         THIm/oQLEKn9wik55ofihWVlzoD0dtxppu7nFkpk3M/4pQJB4kDxX0xDybnLu27aZt3M
         BG1Ai7M/ktJCDLoTN8FqOQUOJpL3Fjmq7ss0s1MiB044tLY3vb0eX61HdRM5Br07w2Z3
         xfAwSKA75OsedocP4DOSCbY+MlBCE+em01uQhZp29pTxVpO5Kuf/lQ0EAxhdjU5cTVcn
         dP83BdWT299ADEah5ZfFKmUkvI1vYgEL4wXIy8J9I057QDij3lDTAgXLa/soG6J3mT6X
         AYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TNXWEwgmCAyVKAXNNQya/meKe2jV5qxqAUnl8C3LiXk=;
        b=oRrX1BYxfWS0hgwLRB9JjQARGsLfeq2yDJKL1Eg8O10d469egVQ5TWeEMT3XFbMg7b
         sQHMvZH44by0Rm3vcIPMl8xsvTf7FjTkmrzTlegNeZDUUlnTYkoq59CCwOC6FrLmjA91
         dGrz7phr0B1Y9blHWKHWyXqpsJ1twZ57thuNhDCwK7R4m08PSZ3GBcTKxoPlLKI94z+L
         e2NsZA6LixsoAW3Qr8J6XOZ7uqsW/oDZCletkg5MM1ZoLuX4x83cxcfqHAPda3XBYGw6
         f0wV13WD+Y1QX+Ww0jNROmfG6c4n//RbyCkA7TySD04wzLXya+6eeUYI4fstk81v8Llm
         oDyw==
X-Gm-Message-State: AJcUukezT45prc5nNTPQVFaNz7TRpZfO1OAUCOKXASF3HcOHU7KqT9n8
        HnrIYEdNXiNkznjj0IZxhPs=
X-Google-Smtp-Source: ALg8bN67v7WMz1F36MXIgHapCmJkhxPxScMJKPrpjgd0k4iNQs/dSOkNDpvOXk2JiYxrVwlM9sk9yA==
X-Received: by 2002:a17:902:bd4a:: with SMTP id b10mr3422918plx.232.1548269540652;
        Wed, 23 Jan 2019 10:52:20 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m11sm30605660pgh.51.2019.01.23.10.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:52:20 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:52:18 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nick Crews <ncrews@chromium.org>
Cc:     linux-kernel@vger.kernel.org, sjg@chromium.org, sre@kernel.org,
        linux-input@vger.kernel.org, groeck@chromium.org,
        dlaurie@chromium.org, Nick Crews <ncrews@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v4 7/9] platform/chrome: Add EC properties
Message-ID: <20190123185218.GB179701@dtor-ws>
References: <20190123183325.92946-1-ncrews@chromium.org>
 <20190123183325.92946-8-ncrews@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123183325.92946-8-ncrews@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:33:23AM -0700, Nick Crews wrote:
> From: Nick Crews <ncrews@google.com>
> 
> A Property is typically a data item that is stored to NVRAM.
> Each of these data items has an index associated with it
> known as the Property ID (PID). The Property ID is
> used by the system BIOS (and EC) to refer to the Property.
> Properties may have variable lengths. Many features are
> implemented primarily by EC Firmware with system BIOS
> just supporting user configuration via BIOS SETUP and/or
> SMBIOS changes. In order to implement many of these types of
> features the user configuration information is saved to and
> retrieved from the EC. The EC stores this configuration
> information to NVRAM and then can use it while the system
> BIOS is not running or during early boot. Although this
> is a typical scenario there may be other reasons to store
> information in the EC NVRAM instead of the System NVRAM.
> Most of the property services do not have a valid failure
> condition, so this field can be ignored. For items that
> are write once, a failure is returned when a second
> write is attempted.
> 
> Add a get and set interface for EC properties.
> properties live within the "properties" directory.
> Most of the added properties are boolean, but this also
> provides the interface for non-boolean properties,
> which will be used late for scheduling power routines.

We have proper interfaces for many of the options below (i.e. mic mute
led can be expressed via LED subsystem and controlled via
/sys/class/led/...), wlan is should be controlled by rfkil if we decide
to go that road, etc.

Thanks.

-- 
Dmitry
