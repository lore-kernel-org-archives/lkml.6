Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A6DC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB4F20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aae6PN5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB4F20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeLFQKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:10:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFQKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:10:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id n190so1561878wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P+N3XANXwak6co/c8fNynu7T4eKz/PqGFkBBi9bwGo0=;
        b=Aae6PN5ofQ+YD5XUJttSLSD5PL4v7+t1MIacgdrz5XL3WMK1a9X4rjSHrtSXa+a6NS
         GyLd+FHWdmQ/SBCBBSBRpu9wr9TUpx51tsnfBPyd2yQz8E+UyiV/LjPJbPH8htQ3Q5OF
         KWFOcDDVxPZ8OtmtgZ9nMNSO3SZMcrOJ0rZhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P+N3XANXwak6co/c8fNynu7T4eKz/PqGFkBBi9bwGo0=;
        b=Lmb6Wc510OBmvAyhvUZoYsbR0izifm6E/siGjnRjdMAMelqKbGBLQ/V3/71iWl+neW
         7JAY94U3V7KAfH5UCY6YVJhlKgbC9GUHGs/OGsjPpRr57t50YGbAI5t4/Ehta3dGLmq9
         964aw/gpcIsXihoBpTX1uyT9tlCo2Ees/Sobp4AbnGz25Lam++Kh9QPBlypjjhUpo9A5
         3+itw82USwcOhC+vQgdjO1vlF4H7+1YWWcmdGPuz1cNgnKXGQLtB4Q4kHQti9vwxGX5P
         aEw1PuNYK1+ItblNwqjog2mhcPms6DUdd/uxinV1tPdpNBhPF7UmcvLBfvYiA7vklYNp
         Xcng==
X-Gm-Message-State: AA+aEWbZ+QJY8lx3qcRv79C9+utzZf3IAvHCJR2jty+2nIAEibi9Dua7
        JvMcwQusPkZQ4LO7mmb9mRV90g==
X-Google-Smtp-Source: AFSGD/W7nV5//clGouek8OXQBn9tC5Qq/fcLwZWnNA5F3TJwGYqMXxyGHStcrreGytYtsYPaJY2azw==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr20911623wmb.40.1544112615447;
        Thu, 06 Dec 2018 08:10:15 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id g129sm1384898wmf.39.2018.12.06.08.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:10:14 -0800 (PST)
Date:   Thu, 6 Dec 2018 16:10:11 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Cc:     Joe Perches <joe@perches.com>,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
Message-ID: <20181206161011.hkjjzdtfzd2hthos@holly.lan>
References: <20181205165621.5805-1-michel@daenzer.net>
 <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
 <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
 <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
 <e7859ce4b8417b094604d9ab4740d338730e38bf.camel@perches.com>
 <d2a1f009-b2c7-240d-7e1c-e48a08d8ac7d@daenzer.net>
 <61385d4cb6c9d990427349849d0af28faa3b67af.camel@perches.com>
 <747d6c1b-8c0a-8168-bd1e-e969839ff5be@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <747d6c1b-8c0a-8168-bd1e-e969839ff5be@daenzer.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 03:41:16PM +0100, Michel Dänzer wrote:
> On 2018-12-06 1:23 p.m., Joe Perches wrote:
> > On Thu, 2018-12-06 at 12:52 +0100, Michel Dänzer wrote:
> >> In contrast to the 2b case, the pr_debug output isn't visible by default
> >> with 1b, so the latter doesn't fit "always produce output" either.
> > 
> > I think you are mistaken here.
> 
> Still puzzled as to what you're hoping to achieve with that kind of
> language. None of the confusion about this patch has been on my part. :)
> 
> 
> > Adding #define DEBUG as Chris did enables pr_debug output
> > and is your 1b.
> > 
> > Perhaps your default console logging level is set to a
> > non-default value.
> 
> I have CONFIG_DYNAMIC_DEBUG enabled in my kernels. The problem addressed
> by this patch is that messages from drm_debug_printer are visible by
> default (case 2b), whereas they shouldn't be (case 2a, like 1b).

When enabled (either dynamically or statically) pr_debug() will emit
output at KERN_DEBUG level regardless of whether CONFIG_DYNAMIC_DEBUG
is defined or not.

Thus unless you change additional settings (either dynamically or
statically) then debug messages should not be shown on the console
because the default settings filter KERN_DEBUG messages. However they
are available via dmesg and system loggers (syslogd, journal, etc).

The patch proposed will change the behaviour of the debug messages
w.r.t. system loggers based on whether the user has enabled
CONFIG_DYNAMIC_DEBUG or not, violating the principle of least surprise.


Daniel.
