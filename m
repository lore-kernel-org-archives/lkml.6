Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6836ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720E4214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNnJMOCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720E4214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeITDUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:20:51 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36561 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeITDUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:20:51 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so3359974pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYUnJL8WUAEWL2rUiTVChneVbi+trVBC/SqVpVVN6/8=;
        b=dNnJMOCwyu2vz5U+9Uu4+j6Q59jzbPgDoqSjO7w/TRFUytB7pTihVhj/C4dmcVgTfv
         cH82Z5/Yo9ikYg/IXhBCSbUiYfSxpXsNHyOlcZxJsgwXLPGFmVgxI3zDw9yIgrx5O7zD
         haKMnLVH7CpSkVN+ywaDOrzo7HWHIbnniYM7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYUnJL8WUAEWL2rUiTVChneVbi+trVBC/SqVpVVN6/8=;
        b=NnV7a24S4Cz2OJQNrWPpFubo6RdKijiMUciK5FOm+9ycbOfr4dLJ08yXyFeBcnxCYz
         x+eykkod1jjqkEe+LdLMJtpB3JS/3XM+MgI9L1VzBLjGle37rAepRoEsXnvKwFL/9zKb
         4zdNgkNeTQxq8Qgb7LiR76ROUmgv5S6VCJh65uvFt4Dgo7NZ175rREk8ER2mz9wFCWVJ
         jPqvISsJcluzjHxO5Oa9T49Xrjjw8DWE5T8CBimpwlgA0sIPPhQ9t8MsKEWRkB50jB48
         G802KI9ZgeXxVHTNlVPopuMX7XYPrlmxgHHBKUm3+ZNXNYbTs45POGLe0dnGfOMcU4fw
         nwAQ==
X-Gm-Message-State: APzg51Ac3moJIkDC5ASD1+78355o/qW7j0Y4Fvedb3K2HH2j4mMO9+C3
        /3+b/AlZs36Qj0ReQfVUd78tlA==
X-Google-Smtp-Source: ANB0VdYZaWQZHVgKkpx5wtYsVlsTfl0cHUu5rlCiAoSZV87wnWrxLP5WVm0VJ/PKre1O4l1gKqKjQQ==
X-Received: by 2002:a63:6a06:: with SMTP id f6-v6mr34006729pgc.63.1537393259652;
        Wed, 19 Sep 2018 14:40:59 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id b14-v6sm39617731pfc.178.2018.09.19.14.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 14:40:58 -0700 (PDT)
Date:   Wed, 19 Sep 2018 14:40:58 -0700
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     niklas.cassel@linaro.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using
 dev_pm_opp_remove()
Message-ID: <20180919214058.bp325gyowqyveil2@vireshk-mac-ubuntu>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
 <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
 <87o9ctjyz3.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9ctjyz3.fsf@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-09-18, 17:20, Gregory CLEMENT wrote:
> Hi Viresh,
>  
>  On mer., sept. 12 2018, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > dev_pm_opp_cpumask_remove_table() is going to change in the next commit
> > and will not remove dynamic OPPs automatically. They must be removed
> > with a call to dev_pm_opp_remove().
> 
> So now that mean when adding more than 2 OPPs, we should have the list
> of them available in the driver to be able to remove them, right?

Right. Maybe we will add a separate API to remove all dynamic ones in
one go but I couldn't find any platform which needs to do it right
now.

> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks.

-- 
viresh
