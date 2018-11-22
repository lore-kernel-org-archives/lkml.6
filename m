Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F073C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C21420820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgzM4365"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C21420820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404643AbeKVQqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 11:46:38 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37724 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404630AbeKVQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 11:46:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id u3-v6so1415752pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 22:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+ONbX0FrbhgwcMg2omFldL10GwV+uxHdg9W1ySf3ZmQ=;
        b=FgzM4365KRdnbyxxnfbMzZu3RmBfZlYCrEOHvd6zgPtsuSIiT407kXumV11zBtSiU+
         y8ZIheKl2XNPZryxSQbZru5NnNtEWAmkV0Si0xbcqZOJ24LDcM16VUwQVGgaobntWHFn
         CQYozxR0zsrWUGW0rIlyVo7I1GAdcBFfwzg+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+ONbX0FrbhgwcMg2omFldL10GwV+uxHdg9W1ySf3ZmQ=;
        b=d5o1yOAQpj+6I40hF4nGq49KKTgxeGQByIZYj4mlRrs0MAU8AA9UlP5kPcLtDJ/rUa
         H92bIhBxpvcwl3/FWSjQEsYi7v6dUQGt073orRTNRCU8QwIwzPOeVQchT8hottiFoEfT
         FufYGTN1kTTEUxY/2kzgfEaOV3Gl6VsN7DuUfR9yvkazPKBEe646AJ6Avj0j2lTz2zsQ
         lm7So8mptp6i/B4JpUXMIfdAAMeQg4IHRUekkutCq3zBDSrsENg/sMYrJoYiEXbCn2ET
         /ff2n6jfB73YBG8uS4GURW0anmEc6r6EWD8u+sbIvmNC4/WwURqQv0QCzYoJQtYHHTyA
         KYDQ==
X-Gm-Message-State: AA+aEWagouD25k4TUJ2IGUDRKr99mnDuaipw1yzvWiPilRGW/PqEbsCi
        njo6wkGh1TA3O/nxBWpjhY2F1w==
X-Google-Smtp-Source: AFSGD/VSbzhpyTI9lsVrVxaDaBRgMhZ4I7NoiXOX0gGI0UHz6VJQlUmR1DPzZeweenzbgHDIXtj4Cw==
X-Received: by 2002:a65:448a:: with SMTP id l10mr8842699pgq.387.1542866923321;
        Wed, 21 Nov 2018 22:08:43 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id y12sm235133pfk.70.2018.11.21.22.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 22:08:41 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:38:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Message-ID: <20181122060839.socq3vuaa4ycftzn@vireshk-i7>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
 <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
 <45c19ad3-6039-9152-6e5a-51a5c062bdf4@codeaurora.org>
 <20181121051718.a5yo3ibhaihgrwra@vireshk-i7>
 <20181121060622.blnlvydbc4wo5y3y@vireshk-i7>
 <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b40a76d-f779-391a-2770-4a3d368679a9@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-18, 11:48, Rajendra Nayak wrote:
> 
> 
> On 11/21/2018 11:36 AM, Viresh Kumar wrote:
> > On 21-11-18, 10:47, Viresh Kumar wrote:
> > > On 21-11-18, 10:34, Rajendra Nayak wrote:
> > > > 
> > > > 
> > > > On 11/5/2018 12:06 PM, Viresh Kumar wrote:
> > > > > Introduce a new helper dev_pm_opp_xlate_performance_state() which will
> > > > > be used to translate from pstate of a device to another one.
> > > > > 
> > > > > Initially this will be used by genpd to find pstate of a master domain
> > > > > using its sub-domain's pstate.
> > > > > 
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > >    drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
> > > > >    include/linux/pm_opp.h |  7 ++++++
> > > > >    2 files changed, 56 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > > > > index 0eaa954b3f6c..010a4268e8dd 100644
> > > > > --- a/drivers/opp/core.c
> > > > > +++ b/drivers/opp/core.c
> > > > > @@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
> > > > >    		dev_err(virt_dev, "Failed to find required device entry\n");
> > > > >    }
> > > > > +/**
> > > > > + * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
> > > > > + * @src_table: OPP table which has dst_table as one of its required OPP table.
> > > > 
> > > > So I have a case where the src_table and dst_table are shared/same. Can you explain how would
> > > > it work in such a case?
> > > 
> > > Can you give the example, as I am finding some issues with such shared
> > > tables. Though the code may work just fine btw.
> > 
> > I may have found the problem you are facing here. Please try this diff
> > and tell me if you hitting it, check this in dmesg.
> 
> Yes, I do seem to be hitting this.

So there are few complexities in the case where an OPP table points to itself in
the required-opp field. I looked at solving it up in the opp core but that gets
more and more messy.

Now there is actually a assumption within the OPP core. Your Mx domain should
get initialized before the Cx domain, as that is when the OPP tables are created
as well. This is because Cx's OPP table will point to Mx's OPP table (doesn't
matter if they share the same table or not) and so Mx's OPP table should come
first.

Can you check if that is already the case for you? If not, please try doing it
and lemme know if it works. It should.

I just want to avoid too much complexity in OPP core without much use.

-- 
viresh
