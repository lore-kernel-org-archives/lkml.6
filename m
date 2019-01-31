Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9470CC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608462087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 07:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArXC18Mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfAaHWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 02:22:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39879 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 02:22:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1086738pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 23:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vVl+lLcWQpKtbwDrqxfRh34Za3XoEN0DnU0jE/RFY0=;
        b=ArXC18Mu0+uRBs5/VHHNkVmIvr+XR4U+2TLYANFrRzhaXZMBS0zN7obb5lr03S4kTC
         26rX//ASmC03SY5wRbgyD9yrxIXh0ZNooD9cUw0/tFVW+N3KsmtiZfhPUYYDgV3UQlzc
         MHLGxHIxtvGDuwf4w7kgpSuxn8/Kt9VbSlpkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vVl+lLcWQpKtbwDrqxfRh34Za3XoEN0DnU0jE/RFY0=;
        b=gyRWBAZTTqyWwu33g8lIfbm2dg6bzBVWtzBWIr3BE6Nj5DQQKmN/FLbw1u/pDBL0x5
         D3LMmOgBHmkXrbABegiG0lt6TXZQZp5XXjdPWEsY111SmfmAeZIGJiwOt74igDhvStCh
         lMi37JQz8o2AIqlQAj8eVVKIU9t3HRKgPMl6C4mnZGzVkp6LPvGK3QLksHBovSDdljWw
         Y7sln1H+cn8NBH2PsWkzivkaeSwpVFVVYBkN2EzizZDGT5o+B/xWZ/kXBmIgmAq9zwQk
         biAVhxczpkW9sT8wpOVBmWSTep+kYmPNEpWTHXOFpsDQLtfExUjstSqKpq/K6lUDIiIq
         dn7Q==
X-Gm-Message-State: AJcUukeoC4NNFtfJCWy89HODQ75eTj8MYYhj+qVhyMcx6x3XnG/uX19e
        XS8x711mB+r/XbAjJsX+yX9FSg==
X-Google-Smtp-Source: ALg8bN5plNepkLA3iyEjfxM/iCvuVR1MYLneESjJvoV2icC7HjSzSu2MtouMhfXr+UrBBAOewTHHbw==
X-Received: by 2002:a17:902:8607:: with SMTP id f7mr32815399plo.123.1548919333636;
        Wed, 30 Jan 2019 23:22:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id m67sm5427287pfm.73.2019.01.30.23.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 23:22:11 -0800 (PST)
Date:   Thu, 31 Jan 2019 12:52:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Quentin Perret <quentin.perret@arm.com>, sudeep.holla@arm.com,
        rjw@rjwysocki.net, nm@ti.com, sboyd@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com
Subject: Re: [PATCH v2 1/5] PM / OPP: Introduce a power estimation helper
Message-ID: <20190131072209.nhbgid3cystvr2p5@vireshk-i7>
References: <20190130170506.20450-1-quentin.perret@arm.com>
 <20190130170506.20450-2-quentin.perret@arm.com>
 <20190130190703.GM81583@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130190703.GM81583@google.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-19, 11:07, Matthias Kaehlcke wrote:
> On Wed, Jan 30, 2019 at 05:05:02PM +0000, Quentin Perret wrote:
> > +static int __maybe_unused _get_cpu_power(unsigned long *mW, unsigned long *kHz,
> > +					 int cpu)
> 
> why __maybe_unused?

Yeah, it isn't required I think. He probably added it for the case
where CONFIG_ENERGY_MODEL=n, but even then an inline routine is
defined which will accept it as argument and wouldn't do anything with
it. Had it been a macro, we would have required __maybe_unused but not
now.

-- 
viresh
