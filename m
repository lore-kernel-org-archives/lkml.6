Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74163C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2F20844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 05:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFDZ4h1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F2F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbeIHJqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 05:46:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:47045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbeIHJqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 05:46:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so7934346pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 22:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJCpMmAsSMsAZuHbC3RM1J2E2E/2J6/EivqPn3wdhDs=;
        b=KFDZ4h1mOfK1VWnohBMn1k7W0Syhu4dKifBj1YCrEQyvYoxJ/Ij8OTMfmCofr4QLlo
         g6lmLH4o+y5R4LjtIZzUkBdVMvHum+hUGQ+qnSVC5ZgO7hfeuu281bya7tH22ov7ZdFj
         BNpofQ6FPDysTsonF4VoNUxyx5SnhKPCn80fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJCpMmAsSMsAZuHbC3RM1J2E2E/2J6/EivqPn3wdhDs=;
        b=UAw0HwLk7PiiH4DGUcVVDnx6XWg7hvdVLdA/4vzEK9GNgGrSqL4u6R5fUJ2aipe8+S
         RrkYyPqJn8q1F/CWO2R90BomITcGcCF0o3UkpMh++ki2fuPrIGCK6gcK6DmVLBz6xWaO
         uc0IGxIr9hLM+IRL+sH9gelkt6CREIKUbs9eSNjCKB7yEA0+fRlqNRobAF5ofz+tCUSB
         AdWZ7W7hUi9Zj2dwnh6dbkXaDST7GDSbIZrXvr0J82OWLsppunNw3XMgesuPu9Vse6DM
         Z942zAB1/PXeI/moxzLN92W5FnuOsdcYPs16JAoP1yUSdl8bHbhkMn9MxP7i6Nx5sy6v
         momQ==
X-Gm-Message-State: APzg51B7YKO7JhCisjDa3KJ/WmW8+LopB/npsiKgPAWLRe5+idcqnPnx
        hGi/QWcF5t8tG43LeINNxeCHzw==
X-Google-Smtp-Source: ANB0VdbELknsv06zhhlUpKPB91jBvMiFXwfGxIBe/F7bILq/Vj0BXI94FsGMoPVs4YYfGOIqkV/55A==
X-Received: by 2002:a62:a05:: with SMTP id s5-v6mr12222045pfi.147.1536382931016;
        Fri, 07 Sep 2018 22:02:11 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p1-v6sm12494714pfn.53.2018.09.07.22.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 22:02:10 -0700 (PDT)
Date:   Fri, 7 Sep 2018 22:02:08 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, rteysseyre@gmail.com,
        broonie@kernel.org, linus.walleij@linaro.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] leds: core: Introduce LED pattern trigger
Message-ID: <20180908050208.GY2523@minitux>
References: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a502ec29251c019ddad8f3314ab45fc0f6feaf7.1536027873.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Sep 04:01 PDT 2018, Baolin Wang wrote:

> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
[..]
> +What:		/sys/class/leds/<led>/hw_pattern
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a hardware pattern for the LED, for LED hardware that
> +		supports autonomously controlling brightness over time, according
> +		to some preprogrammed hardware patterns.
> +
> +		Since different LED hardware can have different semantics of
> +		hardware patterns, each driver is expected to provide its own
> +		description for the hardware patterns in their ABI documentation
> +		file.
> +

So, after a full circle we're back at drivers with support for hardware
patterns should have their own ABI for setting that pattern.

The controls for my hardware is:
* a list of brightness values
* the rate of the pattern
* a flag to indicate that the pattern should be played from start
  to end, end to start or start to end to start
* a boolean indicating if the pattern should be played once or repeated
  indefinitely.

Given that the interface now is hw specific, what benefit is there to
attempt to cram these 4 knobs into "hw_pattern"? Or am I allowed to
create additional files for the latter three?

> +What:		/sys/class/leds/<led>/repeat
> +Date:		September 2018
> +KernelVersion:	4.20
> +Description:
> +		Specify a pattern repeat number. 0 means repeat indefinitely.
> +
> +		This file will always return the originally written repeat
> +		number.

I'm still convinced that this will confuse our users and to me it would
be more logical if this denotes the number of times the pattern should
be repeated, with e.g. negative numbers denoting infinite.

In particular I expect to have to explain why my driver expects that you
write 0 in the file named "repeat" to make it repeat and 1 to make it
not repeat.

Regards,
Bjorn
