Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C0CC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E13182082F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SjbHXnnN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13182082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLCG5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:57:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCG5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:57:18 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so5880015pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H5n0WN2LeDS9m8Uh/o9nn4ufrk55fT2icXqasN9V6LM=;
        b=SjbHXnnNv31Kpa+3lF/4oE+EGWFWPfJGduDjXeYvDaIHORZcKWaMmuU++PXeIWsxqz
         UV15CndAXKVTI/QVQkKt8xvPuuXZZKytu9MtmS4Xu+dfwuZgcwZY7ZnV/4qxwQKItTWY
         e8NOhgWdThWUzs4AN3vXs9OTJq3V84H5Aw/i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H5n0WN2LeDS9m8Uh/o9nn4ufrk55fT2icXqasN9V6LM=;
        b=NZ5aGi2w9QgPSZh+4gLmGz5xaN4okgywVmcR+/nIAzEtr+RbtlL35w2kLjGr/BukXm
         VRpQTRDuMuNf3u0Uc9GvcGuou9TkYvhzAYSvKwJMwa69tpSu0Uu5vpD1NCj6E7hQLlWF
         jhDk31tmSruWt/llFyrB4rw4RiwsdnGrkiduNPOoJNR/o7QJm/GKXsNVR4Bt2hFZX7m3
         w1dzUsMcxDHkKEIPAHPA3qq4fal3eCKAkmo2utZH54dzSLKRIPekfM/Hjo6OVymazvYw
         UWa2+aIriVk66pfn6LD3KE78oQYXx79MgWPPb42WOvwg2kC5okm5RV09+MJP+h4E9kwX
         zxAQ==
X-Gm-Message-State: AA+aEWaAUZA+AwFgTxjoKNfEmIpyN7d9gI7QYqUgEE9XA8gKSmqpnSYf
        JQwwCrh7k948nC3iN8WowvDr6A==
X-Google-Smtp-Source: AFSGD/VlceRRHTHLxR5JeHHyBTwqE2fgls+s4Ow6F3qYdH3PuVh3bB3ws3+fCkx63OpxMsoMPK5GVA==
X-Received: by 2002:a63:d513:: with SMTP id c19mr12317600pgg.287.1543820234407;
        Sun, 02 Dec 2018 22:57:14 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id y29sm18401783pga.59.2018.12.02.22.57.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 22:57:13 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:27:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 3/5] PM / Domains: Save OPP table pointer in genpd
Message-ID: <20181203065711.lugbr3a7uqtasmli@vireshk-i7>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
 <f95b514f7b3b3ab6ac00c9871e91513c9c3a09a3.1543219386.git.viresh.kumar@linaro.org>
 <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrUBwagtfwCezqw2ujPBVVtQNqz4rKgAG0Yyy18FZv+wA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-18, 09:53, Ulf Hansson wrote:
> On Mon, 26 Nov 2018 at 09:10, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > We will need these going forward in hotpath, i.e. from within
> > dev_pm_genpd_set_performance_state().
> 
> Well, as for patch2, please try to be a bit more descriptive of why
> and what this patch does.

    PM / Domains: Save OPP table pointer in genpd
    
    dev_pm_genpd_set_performance_state() will be required to call
    dev_pm_opp_xlate_performance_state() going forward to translate from
    performance state of a sub-domain to performance state of its master.
    And dev_pm_opp_xlate_performance_state() needs pointers to the OPP
    tables of both genpd and its master.
    
    Lets fetch and save them while the OPP tables are added. Fetching the
    OPP tables should never fail as we just added the OPP tables and so add
    a WARN_ON() for such a bug instead of full error paths.
    
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Good enough ?

-- 
viresh
