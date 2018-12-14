Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A618C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8D520811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2XnvjUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F8D520811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeLNKTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:19:47 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42687 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:19:46 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so2527270plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qj0yQYq2rLX9fH4psXTGZM0PTkB8WhxtB8bzxFEfimY=;
        b=c2XnvjUFHgtuL3i03nCgxN0rhvLC5L/V6bMi3IKEW3YXg30I98aYb/GnKSaMcq+0rE
         H/HIkFxhpM0Y+q+h8K4AiqJQN++/KESAyWg16uAYXTT+al1TTSKALcgGMyt9jpERqBJK
         GUfJU5g5ZiMJS+sGfo+H8wSMriooLBS8OU68w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qj0yQYq2rLX9fH4psXTGZM0PTkB8WhxtB8bzxFEfimY=;
        b=kCItxIGndPUc28Efbcw39ZXjkU8j3WLfc581yGSM/qIpprKcvV8vFjbr+196HcToFi
         rKDYAwzbANywszUnQuKVb2yUajT0lBSlKzfiBE078/u/tqYxebP+LGM2ZyC3uy3gPsJN
         mg8PLYGU6tNcgLih4bQr1dKo/cO1s08lrBVuUM5Tw5xxmd6A0NWJO7W+WlRAfmobV1NS
         hzTs96VzXlIFC7hQtIKF5iI+sl3hQXnnAxqstksIKcl5vEGhsGn4EytLH1n8GQ+qniVP
         /4QguhIN7CP3O15anE7EMR3j4LF1LdZ5VywGWo2AAXX/4IgpEdMwbdxtWwAOECAHjWEI
         KFAA==
X-Gm-Message-State: AA+aEWYeHL2ooaTewj5Fcvz/c91y+LZwzR+oU8weWg5ouQ1n1q7HA4NU
        Vh/kAU/JAL86QH4/pe9ku6TB/w==
X-Google-Smtp-Source: AFSGD/XsUAVJJJ31MNb0YN02g6amLML1mzqGxEadMmbctM+bAG5h1oFWVhW15jFoGxvlsiQmZa3KvQ==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr2394427plb.125.1544782785890;
        Fri, 14 Dec 2018 02:19:45 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 202sm11640171pfy.87.2018.12.14.02.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:19:45 -0800 (PST)
Date:   Fri, 14 Dec 2018 15:49:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        niklas.cassel@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
Message-ID: <20181214101943.3hfktljrdu6yw7aq@vireshk-i7>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
 <CAJZ5v0h9WCmBNB2K5pd6Z9VnFK4tcT5uVxmP36wHxqM5SkdXYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h9WCmBNB2K5pd6Z9VnFK4tcT5uVxmP36wHxqM5SkdXYA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-12-18, 11:18, Rafael J. Wysocki wrote:
> On Fri, Dec 14, 2018 at 11:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Hi,
> >
> > This series adds performance state propagation support in genpd core.
> > The propagation happens from the sub-domains to their masters. More
> > details can be found in the individual commit logs.
> >
> > This is tested on hikey960 by faking power domains in such a way that
> > the CPU devices have two power domains and both of them have the same
> > master domain. The CPU device, as well as its power domains have
> > "required-opps" property set and the performance requirement from the
> > CPU eventually configures all the domains (2 sub-domains and 1 master).
> >
> > Based on opp/linux-next branch (which is 4.20-rc1 +
> > multiple-power-domain-support-in-opp-core + some OPP fixes).
> >
> > Rajendra has already tested the previous version of this series and so I
> > have included his Tested-by for all patches.
> 
> I'm assuming that this set will go in via the OPP tree.

Yes.

-- 
viresh
