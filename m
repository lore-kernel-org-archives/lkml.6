Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04798C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6972145D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MC2LeCDu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6972145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728168AbeK1Ucl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:32:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39230 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeK1Uck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:32:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id c72so9895806pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MRtn6CpH/sMIVrL0+l/kkrYQzoaAvuMW2WxIEnnlVvg=;
        b=MC2LeCDuBZ/RhRlR9oL+5U/W0inWySbQ8tUo8dPZsRd2Dm2ACAofZ8Mgw4R8+n7xWE
         jOOg8yZ8DV12+hvpoQlm8Hl3G4Qww0Fy8XU76I4J5wCLqa0kufYSwfgt3SXqjrnbpu9k
         qjctnDaaoBzZBCyAv9AyVDZ4Soo2wNu3Yym2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MRtn6CpH/sMIVrL0+l/kkrYQzoaAvuMW2WxIEnnlVvg=;
        b=eT/KSxfRmq3f8zC4cEU4QaPma+Ht77bf1Psvl7PKspE/sTxcL69nYKg3WgxYgKGWuB
         q56KZnHbU5jSk8NHzUtJYkevvTEo9TT526wcatruEMKurxFOrOaDQHpuCBEuMZ4FW0TT
         0Oa5uBzFYupWjTuA9UUVpVNeDmULhtPZt1zM8ztspaoWHDKQlAux6eCiu3BNqzrynkxS
         7/TDFTnkqdD3gYJhm8iIOc6AZoayWSbvjveD+Qp7grUSSLdP7UEFYi1+/9jI0Z7MpPTo
         kTGTI/jXyj/yK1ryQ0JBsgiHDRiGDJD6Rfi4JPFWdWli2LKwidQT+06me0UsvDEwf5Ui
         Tulw==
X-Gm-Message-State: AGRZ1gJ9hawJSPNnBxNrOMGe+kTdJXe66fPmwKfG12zP8zCbU2H94mgI
        svAomec7DDUeAjdDAe4AYNAh3A==
X-Google-Smtp-Source: AJdET5c35/pmOPntUcTomEY633YuKZV7xN9PagmGELEtXnf6WQCU12ZZ5TW2WeP7Vi+1SCMTf2tQLg==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr36756211pfd.224.1543397500878;
        Wed, 28 Nov 2018 01:31:40 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id x19sm8589063pfk.14.2018.11.28.01.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:31:39 -0800 (PST)
Date:   Wed, 28 Nov 2018 15:01:37 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] Documentation: admin-guide: PM: Add cpuidle document
Message-ID: <20181128093137.a5d4kwgfdthlsolw@vireshk-i7>
References: <4064391.AYvOMBeiDo@aspire.rjw.lan>
 <20181128054835.gnhistcfxy25rmwf@vireshk-i7>
 <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hnX512AheTwhpj09+eyiyv6txsgGQcT2afWiB2JjjCzw@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-11-18, 10:11, Rafael J. Wysocki wrote:
> On Wed, Nov 28, 2018 at 6:48 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 26-11-18, 14:11, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Important information is missing from user/admin cpuidle documentation
> > > available today, so add a new user/admin document for cpuidle containing
> > > current and comprehensive information to admin-guide and drop the old
> > > .txt documents it is replacing.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  Documentation/admin-guide/pm/cpuidle.rst       |  603 +++++++++++++++++++++++++
> > >  Documentation/admin-guide/pm/working-state.rst |    1
> > >  Documentation/cpuidle/core.txt                 |   23
> > >  Documentation/cpuidle/sysfs.txt                |   98 ----
> > >  4 files changed, 604 insertions(+), 121 deletions(-)
> >
> > Nice work Rafael. Minor nits below..
> 
> Thanks for the typo fixes.  The spellchecker I have here evidently doesn't work.

I have this in my .vimrc and I am shown these spelling mistakes somewhat
forcefully :)

set spell spelllang=en_us

-- 
viresh
