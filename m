Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C88320881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C88320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeGIJ2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:28:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:9757 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754214AbeGIJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:28:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 02:28:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,329,1526367600"; 
   d="scan'208";a="63266133"
Received: from eengestr-old.ld.intel.com (HELO intel.com) ([10.103.238.209])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2018 02:28:27 -0700
Date:   Mon, 9 Jul 2018 10:28:27 +0100
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 04/12] cpufreq: use for_each_if
Message-ID: <20180709092827.GA2841@intel.com>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-4-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-4-daniel.vetter@ffwll.ch>
Organization: Intel Corp UK
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 2018-07-09 10:36:42 +0200, Daniel Vetter wrote:
> Avoids the inverted condition compared to the open coded version.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  include/linux/cpufreq.h | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 882a9b9e34bc..f2028c229b96 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -649,9 +649,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
>  
>  #define cpufreq_for_each_valid_entry(pos, table)			\
>  	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)	\
> -		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
> -			continue;					\
> -		else
> +		for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
>  
>  /*
>   * cpufreq_for_each_valid_entry_idx -     iterate with index over a cpufreq
> @@ -663,9 +661,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
>  
>  #define cpufreq_for_each_valid_entry_idx(pos, table, idx)		\
>  	cpufreq_for_each_entry_idx(pos, table, idx)			\
> -		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
> -			continue;					\
> -		else
> +		for_each_if (pos->frequency == CPUFREQ_ENTRY_INVALID)

Should be `!=` there ^

>  
>  
>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
