Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E554C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC48320989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C5vyRBng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfBYEbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:31:53 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38091 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfBYEbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:31:53 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so3871418pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 20:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rYf2LhY7n8Vfj8pnEn/byn20/glTL8uacNOUrzp+1js=;
        b=C5vyRBngGsD1YNkkMnIJbty0MiFAEOCzzES0BqHIuNeLG/viUNI3E5wkM/5ORBK69b
         iDTZe+D14k66ap705UQCD85b25/hS4Xks1I4R0ZitDyI9xfi3iLn40RjvWuSzGnmgdxB
         ZudsoaYjWYJxRSojBNlDpKmmRkoGID8/8eodwoGskOUo7FLKv9MToeeV54Qgyc19jCZ5
         oTb63OGHL3HchVlHT0xtOIm6K88Ld0kVc5xPf2aP0bkh1oJhwqqgAJtKTmYENJzIz9gt
         DRAl9JFEslDMsecfwpPfrJ8toeg4Jc+De+hQ6/9axQYZrRz/YqwalPt/FGZWg7jSIMTY
         /isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rYf2LhY7n8Vfj8pnEn/byn20/glTL8uacNOUrzp+1js=;
        b=U9PnTpyzbzwWSV5FSSuD/FEtDmZ/fspMWOdrQ5hWgvHHsS86BmdaQnFfA3JeXZIaaZ
         Jg4dH3FsGXgNAaRADuhpX7jLJIP1xOltULyO1JjKZEZ89a+chN8UNZG/lwe8IZz+mcD2
         HUFCTAw39za+Y85q/VwFp4RGvns4g8CKB5VsBx3/+BeZiIjJetBOoKeRqQhftlxtW6DH
         wMO6spfsjZ4xBUVGUkTLhAnuvmOBxdxXcwqIPwnoBL/CwWVpkAsf5Bo/hFWaKhXT3l73
         dQu2r8UwFoXFjo4mCt2kTXISp4rdpq76RcyAHAl7+BN6AK3tjFmob+gMzrJv1SY3RQ97
         mrmg==
X-Gm-Message-State: AHQUAuYHCSmwH3Cuee16ZEF7e9QWwLsAnoxRNOnWQdz3vuU4luY8R6tR
        Rs5KmLdrrUp7pB2LAArP11kqoQ==
X-Google-Smtp-Source: AHgI3Ib7eUbwCDI24sIF77wPUq9/qrgGCoIuRxWzRQ5KHrLzEL+6w3fTsDvo7LOtcfnS6AFzgtG6FA==
X-Received: by 2002:a63:1266:: with SMTP id 38mr16919043pgs.388.1551069112075;
        Sun, 24 Feb 2019 20:31:52 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id 4sm19227580pft.96.2019.02.24.20.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 20:31:51 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:01:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org,
        juri.lelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 4/5] cpufreq: Register notifiers with the PM QoS
 framework
Message-ID: <20190225043149.bfl5vdb57xaaje2w@vireshk-i7>
References: <cover.1550748118.git.viresh.kumar@linaro.org>
 <e6969d79643c87af24895d508e5c6f7462b1c758.1550748118.git.viresh.kumar@linaro.org>
 <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222114446.cmwoe7tanxvf2gxh@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-19, 11:44, Qais Yousef wrote:
> Hi Verish
> 
> On 02/21/19 16:59, Viresh Kumar wrote:
> 
> [...]
> 
> > @@ -2239,6 +2314,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  			      struct cpufreq_policy *new_policy)
> >  {
> >  	struct cpufreq_governor *old_gov;
> > +	struct device *cpu_dev = get_cpu_device(policy->cpu);
> > +	unsigned long min, max;
> >  	int ret;
> >  
> >  	pr_debug("setting new policy for CPU %u: %u - %u kHz\n",
> > @@ -2253,11 +2330,23 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
> >  	if (new_policy->min > new_policy->max)
> >  		return -EINVAL;
> >  
> > +	min = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MIN_FREQUENCY);
> > +	max = dev_pm_qos_read_value(cpu_dev, DEV_PM_QOS_MAX_FREQUENCY);
> > +
> > +	if (min > new_policy->min)
> > +		new_policy->min = min;
> > +	if (max < new_policy->max)
> > +		new_policy->max = max;
> > +
> 
> Assuming for example min and max range from 1-10, and thermal throttles max to
> 5 using pm_qos to deal with temporary thermal pressure. But shortly after
> a driver thinks that max shouldn't be greater than 7 for one reason or another.
> 
> What will happen after thermal pressure removes its constraint? Will we still
> remember the driver's request and apply it so max is set to 7 instead of 10?

Once everything comes via PM QoS, it will remember all the presently available
requests and choose a target min/max frequency based on that.

But even with this patchset, with half stuff done with PM QoS and half done with
cpufreq notifiers, it should still work that way only.

-- 
viresh
