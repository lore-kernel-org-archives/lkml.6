Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88088C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564B420821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuTdImxh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfBKJzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:55:32 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35464 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKJzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:55:32 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so5031032pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N5drO107h8JpRVW8F2Li8y9/anCFenGRkuwn38Mf3vU=;
        b=XuTdImxhomQXItwpG3yx/Mz4D8+9W9Fd1bvL9/6uxwOrYi2klOuxh8eiWCj56zTVRd
         T2J9hpFKXXmxKiuCSOTpeCzECoZvBVvIj5asarIgco3+gVlslwuUM9RSglkUh/T9/TMn
         sEy2Hu9kN2eTTtkvJrdwNaoLf0sWmaGn5pTgzrBq0Q94nkIwV31WiwNo21voVO8uqn7f
         G9Y1n61JwDN8eOkPZPCRdcKVHT39dh5jnLqxpf3So21HfQoOwpX/L73gQMMvmWyERmhN
         5cQ9EK/mfA++qRu7W6rZVLXV/X5eUpsVtXM/70S503p2IfmJxJTdOfIK5rhmEsfJg5Xw
         bimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N5drO107h8JpRVW8F2Li8y9/anCFenGRkuwn38Mf3vU=;
        b=AllLC8jQW66Khw6BESKgng4lHaGbT7G+AKqwbjMeyJJA+YU+A4axZ3ki+XjocONuIi
         AL6CsF79r/IznrRH1lrdMteSh9LOZMeKGwRVrUT9XOvVseIhgB3agDu3WbYbo15YB+fD
         s5IR0pigrvZ+6ZTzHr7FJY++ju7NsPAyvkvPb4yEXwNBDFonCFHKFLvrsjr4jLD6sruI
         4oskgAr97yHYWeUHi4YZJadkIokxjLBNd9zVMkMzWIq15DCwzQ0Ma6bvV7WQo5ifjDrN
         pEy4A84HBaNd79qtdHkUiogqFeKUs5QCJMukbR52WhcCNFVCf+cYxVAChTHYyusrKmRL
         1iyA==
X-Gm-Message-State: AHQUAuZn5sS146DHCjNiu7GmYJvO7IEIKKUkIQW6EAZ7y7RlTyFgQR0s
        9YFPWRzSklaVoyxniozB1qxCPA==
X-Google-Smtp-Source: AHgI3IZOS3KgGzPF7BP4/jp2IGFs00ns6kxMcEN+xLapU24Tdo6hhxxFC3AnwvHY5fJh4rbaGA3Vnw==
X-Received: by 2002:a62:76c9:: with SMTP id r192mr18730310pfc.251.1549878930112;
        Mon, 11 Feb 2019 01:55:30 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id y20sm15229451pfd.161.2019.02.11.01.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:55:29 -0800 (PST)
Date:   Mon, 11 Feb 2019 15:25:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>, Sudeep.Holla@arm.com
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Message-ID: <20190211095527.5brreiqppn7kk3yt@vireshk-i7>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com>
 <20190211084413.b53qyx6sgkxsjhdv@vireshk-i7>
 <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b4a6c9a-93f9-474f-b8c0-4353a531e128@samsung.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-02-19, 10:52, Marek Szyprowski wrote:
> Hi Viresh,
> 
> On 2019-02-11 09:44, Viresh Kumar wrote:
> > On 07-02-19, 13:22, Marek Szyprowski wrote:
> >> Dear All,
> >>
> >> Recent commit 9ac6cb5fbb17 ("i2c: add suspended flag and accessors for
> >> i2c adapters") added a visible warning for an attempt to do i2c transfer
> >> over a suspended i2c bus. This revealed a long standing issue in the
> >> cpufreq-dt driver, which gives a following warning during system
> >> suspend/resume cycle:
> > Marek,
> >
> > I have sent a patchset which is not directly related to the problem
> > you are facing, but it may solve your problem as a side effect. Can
> > you please see if that works to solve this issue as well ?
> >
> > https://lore.kernel.org/lkml/cover.1549874368.git.viresh.kumar@linaro.org/T/#u
> 
> Thanks for the patch. It indeed solves the problem of the i2c transfer
> in cpu hotplug procedure during system resume, although my resources
> management rewrite is still valid as a way to fix remaining 'todos' in
> the cpufreq-dt driver.

Which remaining todos are you talking about ? Sorry I am not able to
recall :(

-- 
viresh
