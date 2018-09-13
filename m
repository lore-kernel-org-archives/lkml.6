Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E96C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17539206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 01:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="PI54I1Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17539206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIMG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 02:56:38 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34930 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeIMG4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 02:56:38 -0400
Received: by mail-qk1-f195.google.com with SMTP id f62-v6so2378678qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kMMcs6t9a4FBai9ISvBemyGSg5veEzt5Pg9zYNstaK0=;
        b=PI54I1Mo+d9zKW+sB0FxBFNoV/yd8wE6aWruLvxKyri0R7zRtWzlbhdX8Mhco9fX6+
         6eY55NgPnAMuMmbN9WBinPo2esT8b36v2exGA08YgQiXPzHzyi/dtdPKb6hbm5/r8gLX
         8+z4uiUr6vetS5DDSn0JtypzEWjjaJQd88iraXZV8tveilvhVItEhs46LjhdEJWLcobg
         V2gxccwRNo3PpHMW+WipUsaCcKItoUii8+Wy4TYYkLc83Klfgt5NYykM6O3ytizHuXGx
         41C9CyTEnhRQNkMfgC1gFyEeB9tg+GKwY2vFt5206Il5cPoEl7ceR5Xxii7eV432BSlA
         08fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMMcs6t9a4FBai9ISvBemyGSg5veEzt5Pg9zYNstaK0=;
        b=W2x30jNYKqPCsjoQoSfcUvsTOM52Y8aDQgApuyzEHD/HpjV2fuSbpjiut48LSZny5T
         85MhvmlUdNZH+9/K55GZeKJqc0l/dV9c4JdfkweYIZJ9nIvN2OkRq1mMnQ3qgeINX76U
         iYr4N0h+qp+JMJGE5rFEJ69uPp8Rq9cmEzzvGbroeRkgiYmF5fFnREZ2O7ILMT9FFPxj
         Pt8EkNRcVABYAeGmhANGJGiBNsjd9eiwPWRLfpTNvVbOxn2j9nLc0H0Xy63zrtWLn11L
         W6Yiiw0PxiCaQE1YhDJkVQC7wiDCibIVLukaFvHAawfO4ewRd1CxK5Bv6SNqEl7E3HvW
         8gXQ==
X-Gm-Message-State: APzg51Cx838ZHZq6mziN+aKWYX+cLEsQVLMAmkg09WtsgdxB5Uw4qgEN
        ZxSYfsw0OgWKwMgQZ30bHmtnJA==
X-Google-Smtp-Source: ANB0Vdb6DESGO+QgKUaNpV02zN5z9EeuuQdi/qaAZCwhLGwKwk/ZyeDK74RI85kjRWB90gS7U0n9Pw==
X-Received: by 2002:a37:b006:: with SMTP id z6-v6mr3534125qke.227.1536803365294;
        Wed, 12 Sep 2018 18:49:25 -0700 (PDT)
Received: from localhost (pool-72-69-128-58.nycmny.fios.verizon.net. [72.69.128.58])
        by smtp.gmail.com with ESMTPSA id d10-v6sm1581823qtc.53.2018.09.12.18.49.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 18:49:24 -0700 (PDT)
Date:   Wed, 12 Sep 2018 21:49:23 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Mike Galbraith <efault@gmx.de>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/9] sched: loadavg: consolidate LOAD_INT, LOAD_FRAC,
 CALC_LOAD
Message-ID: <20180913014923.GB2370@cmpxchg.org>
References: <20180828172258.3185-1-hannes@cmpxchg.org>
 <20180828172258.3185-5-hannes@cmpxchg.org>
 <20180912162828.ae336d83e8c467345e70de17@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912162828.ae336d83e8c467345e70de17@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 04:28:28PM -0700, Andrew Morton wrote:
> On Tue, 28 Aug 2018 13:22:53 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > There are several definitions of those functions/macros in places that
> > mess with fixed-point load averages. Provide an official version.
> 
> missed blk-iolatency.c for some reason?

Ah, that callsite came in with this merge window. Thanks for the
fixup.

> --- a/block/blk-iolatency.c~sched-loadavg-consolidate-load_int-load_frac-calc_load-fix
> +++ a/block/blk-iolatency.c
> @@ -512,7 +512,7 @@ static void iolatency_check_latencies(st
>  	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
>  			div64_u64(iolat->cur_win_nsec,
>  				  BLKIOLATENCY_EXP_BUCKET_SIZE));
> -	CALC_LOAD(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
> +	calc_load(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);

The macro used to modify the avg parameter in place, but with the
function we need an explicit assignment to update the variable:

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 335c22317757..8793f1344e11 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -512,7 +512,8 @@ static void iolatency_check_latencies(struct iolatency_grp *iolat, u64 now)
 	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
 			div64_u64(iolat->cur_win_nsec,
 				  BLKIOLATENCY_EXP_BUCKET_SIZE));
-	calc_load(iolat->lat_avg, iolatency_exp_factors[exp_idx], stat.mean);
+	iolat->lat_avg = calc_load(iolat->lat_avg,
+				   iolatency_exp_factors[exp_idx], stat.mean);
 
 	/* Everything is ok and we don't need to adjust the scale. */
 	if (stat.mean <= iolat->min_lat_nsec &&
