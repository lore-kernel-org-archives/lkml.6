Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C369ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A0C205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhrfOJTM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A0C205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeGRGeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:34:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38458 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbeGRGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:34:36 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so1671460pff.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TZzn958P/+n+ZtFqM5A3uH8D/X1QLQrXbxhn+TRcQLI=;
        b=FhrfOJTM6OAXYdUwJZJRagoJOJzxs0jA4A9OQkGF/eZ3/AFRXZ6KlGssXPM0Fqwol7
         zrVxNJBMcIpXwmkXqsv/nCtrK12Xl8BcGCcPz/WOGcOnwudzNpdp/pDjSjoAsdYXwjYv
         eWaAW/FJcdB7nv2OHdxVq10dkvcQdBDtrIgEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TZzn958P/+n+ZtFqM5A3uH8D/X1QLQrXbxhn+TRcQLI=;
        b=o+aUItP5EVf87uuDg9EhNtjbnu6TeEf+5yHTDio9jC7/UN0YTnlc/+XEfF+nTGTiVr
         e1Bxu0F5EEl9pUzlB3lqDSyECjKrIvlEO/xt72bTyzKx5StbH3keevq7K7p/NWX/vupn
         Mwd2Yl8GVzD1Szk49nusiSd8VwIiBiASETfmUtOyfDZeJdED056dVg+FMttu7BxQo1EG
         G3soPpgFtEQgg+2fHkR4qgj48RYOL8lEmFZZBD5GD4ylcgekcKZM3iyzV9UOPpfYk9zT
         t6qlwkHCQjW8q4tbonvoHCIAeFNyDbIC1EKck/NFFf5v8weecJERT7Mw9oLvNpyUyHF6
         QDPw==
X-Gm-Message-State: AOUpUlFau+F/8vOqbDh+ClOQ8dvEaEdCKJSJFsQcew5wx9edZuhIlQ/3
        nDC058qDZGJYSDli16T621AaTA==
X-Google-Smtp-Source: AAOMgpf2u5VDBRz5xUW5gQFwdVOWqxeg1pp+LM8laISJw5yXpuxXdTjbcCuN1nGMtOvxH+f7K9pO6w==
X-Received: by 2002:a63:4e22:: with SMTP id c34-v6mr379891pgb.6.1531893507358;
        Tue, 17 Jul 2018 22:58:27 -0700 (PDT)
Received: from localhost ([122.171.235.75])
        by smtp.gmail.com with ESMTPSA id f5-v6sm5654356pga.58.2018.07.17.22.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 22:58:26 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:28:25 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>
Cc:     arm@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        ionela.voinescu@arm.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        chris.redpath@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] arm64: dts: hisilicon: Add missing cooling device
 properties for CPUs
Message-ID: <20180718055825.nrh7wk3cfuvib2ng@vireshk-i7>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
 <5B09A0B4.2080400@hisilicon.com>
 <5B09A5B4.4050904@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B09A5B4.4050904@hisilicon.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-18, 19:21, Wei Xu wrote:
> Hi Viresh,
> 
> On 2018/5/26 19:00, Wei Xu wrote:
> > Hi Viresh,
> > 
> > On 2018/5/25 6:40, Viresh Kumar wrote:
> >> The cooling device properties, like "#cooling-cells" and
> >> "dynamic-power-coefficient", should either be present for all the CPUs
> >> of a cluster or none. If these are present only for a subset of CPUs of
> >> a cluster then things will start falling apart as soon as the CPUs are
> >> brought online in a different order. For example, this will happen
> >> because the operating system looks for such properties in the CPU node
> >> it is trying to bring up, so that it can register a cooling device.
> >>
> >> Add such missing properties.
> >>
> >> Do minor rearrangement as well to keep ordering consistent.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > Thanks!
> > Applied to the hisilicon fix tree.
> 
> Sorry for the noise!
> It seems this patch is still under discussion.
> I will drop it firstly.

Wei, can you please apply it again now that all the discussions are
over ?

-- 
viresh
