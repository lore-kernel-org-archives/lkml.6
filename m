Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9315EC6780B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE112075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRlIaHY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE112075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeJLDAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:00:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44711 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeJLDAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:00:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id g2-v6so4629441pgu.11;
        Thu, 11 Oct 2018 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RszhuLDTRrOWMUnxHcSGHA2us5OQtTnsmvX3eARflCA=;
        b=bRlIaHY1WckIkNyBuMjdaGQiY4Jtsv4RiNViZ3EDYhXKq7TKKtofcuxSIXvRwcrZQ+
         ZMEOXBxoYVc4Y881VyiDJQ7552o7N0NFmZrg7q3eS05BOta4ntTEY+NXrzbkQ5MNpxQo
         fecR4ME4HS8PdsSX/t7tykvrIPg5uiPeu3Sk9ZAZ5aVG+cfyZzachy4ynawjnky2PNPd
         ljAlDv9iHSFguCCRU+EE83wmxL1umkzy/8AZtHuEuriWY8p62YBvlG8CJFOT2CDrQ0jG
         CQCV+oEbreJo/wUiuORkcIUrT8r3jcsDycnl//6b20pry6rwpiwAbjgkignYBV/oLrYG
         k6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RszhuLDTRrOWMUnxHcSGHA2us5OQtTnsmvX3eARflCA=;
        b=Tm9XHRY4HSD3u8qwH+hmqEbY8d120KTwXZNtyqAhf1R3fxX/qcPNsXDdLi1NQTlmSd
         4fdeXwrShp4R+AoRs95lnhw4X0wnYKsrlAbEdXVymxyRGLZrcjsT4MkjaKo6dQ9hVklV
         iNY9VRvI61LyBiPheRmck6VTakvNx/qvrswcrIcvF5E8sesksLq56kgTAgleL65WE88P
         sHQda2D/y8BVeOEzHeQnxomxl2PO5bPxGjuq+TgCnlY7EjoEZinj/xi9AhTIf5UmOuiC
         WK8tOblLNH9q22z/lcfKEPJsT7rjdmVxvMkDVdWYXSXlN0bPPAlfDKo4ECcW3TRtb6oe
         8M7A==
X-Gm-Message-State: ABuFfojKvdahgpAN1tCQ4gJsMPyNCM5PbiHWSvHFONl9VegMAkxokHuo
        GTJFtxK+8rkRra+QO94j6dc=
X-Google-Smtp-Source: ACcGV62ujMaaooDldz6TeIeNYkyl+f2NlK6L0We/EHAW8VEqsu5aXXyR0rCXrBWubiZhOT9grBnGSg==
X-Received: by 2002:a62:be1a:: with SMTP id l26-v6mr2926240pff.204.1539286315234;
        Thu, 11 Oct 2018 12:31:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 25-v6sm65406359pfm.36.2018.10.11.12.31.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:31:53 -0700 (PDT)
Date:   Thu, 11 Oct 2018 12:31:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (ina3221) Add operating mode support
Message-ID: <20181011193152.GA4854@roeck-us.net>
References: <20181010043310.30873-1-nicoleotsuka@gmail.com>
 <20181010043310.30873-3-nicoleotsuka@gmail.com>
 <32c22986-544e-aca1-12bf-9080667cf499@roeck-us.net>
 <20181010230906.GB1706@Asurada-Nvidia.nvidia.com>
 <20181010234300.GA25480@roeck-us.net>
 <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011002411.GA10379@Asurada-Nvidia.nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 05:24:12PM -0700, Nicolin Chen wrote:
> Hi Guenter,
> 
> On Wed, Oct 10, 2018 at 04:43:00PM -0700, Guenter Roeck wrote:
> > > > The effort to do all this using CPU cycles would in most if not all cases
> > > > outweigh any perceived power savings. As such, I just don't see the
> > > > practical use case.
> > > 
> > > It really depends on the use case and how often the one-shot gets
> > > triggered. For battery-powered devices, running in the continuous
> > > mode does consume considerable power based on the measurement from
> > > our power folks. If a system is running in a power sensitive mode,
> > > while it still needs to occasionally check the inputs, it could be
> > > a use case for one-shot mode, though it's purely a user decision.
> > > 
> > That would actually be a use case for runtime power management.
> > The power used by a modern sensor chip is miniscule compared
> > to the power consumed by other components in the system,
> > which may explain why no one bothered looking into runtime
> > power management for sensors.
> > 
> > This is also an argument against any device or subsystem specific solution:
> > Users will want to be able to control power consumption for all devices
> > in the system, not just for sensors. A device specific power control
> > mechanism would, from user space perspective, be a nightmare.
> 
> That makes sense to me. Actually we wanted a solution more on the
> driver side so that user space doesn't need to be involved. But our
> downstream solution (switching different modes when certain number
> of CPUs get hot plugged in/out) wasn't accepted years ago by other
> subsystem maintainers, being commented that it's a user decision,
> IIRC. So I thought that having a sysfs node might be a generic way
> for "user decision". But I guess I should have tried to seek for a
> solution in the kernel like runtime PM as you said.
> 
> > > > power-down mode effectively reinvents runtime power management (runtime
> > > > suspend/resume support) and is thus simply unacceptable.
> > > 
> > > Similar to one-shot, if a system is in a low power mode where it
> > > doesn't want to check the inputs anymore, I feel the user space
> > > could at least make the decision to turn on/off the chips, I am
> > > not quite sure if the generic runtime PM system already has this
> > > kind of support though.
> > > 
> > Please look up "runtime power management". It provides the basic
> > mechanism to turn off / disable a device if it is not used. The point
> > here is that the basic mechanism is there, even though it may not
> > be perfect. If it is not perfect, it needs to be improved.
> > Implementing a per-subsystem alternate method would be the wrong
> > approach.
> 
> I have implemented runtime PM suspend/resume in other drivers but
> what I know is that it relies on someone to call get_sync and put
> functions accordingly and it doesn't seem to have built-in system
> level low-power or power-sensitive mode for those use cases that
> I mentioned previously. But I agree with your point and will take
> a closer look.
> 
> One more question here, and this might sound a bit abuse of using
> the existing hwmon ABI: would it sound plausible to you that the
> driver powers down the chip when all three channels get disabled
> via in[123]_enable nodes? :)
> 

I would not call that an abuse, no.

Guenter
