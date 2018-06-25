Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BF3C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E6C260E7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E6C260E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755735AbeFYUdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:33:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:59905 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeFYUdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:33:54 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 13:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,271,1526367600"; 
   d="scan'208";a="52817891"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga006.jf.intel.com with ESMTP; 25 Jun 2018 13:33:53 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 3C2BC300D79; Mon, 25 Jun 2018 13:33:53 -0700 (PDT)
Date:   Mon, 25 Jun 2018 13:33:53 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 4/4 v3] perf stat: Add transaction flag (-T) support for
 s390
Message-ID: <20180625203353.GC19456@tassilo.jf.intel.com>
References: <20180625125856.20262-1-tmricht@linux.ibm.com>
 <20180625145247.GY20477@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625145247.GY20477@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +bool metricgroup__has_metric(const char *metric)
> > +{
> > +	struct pmu_events_map *map = perf_pmu__find_map(NULL);
> > +	struct pmu_event *pe;
> > +	int i;
> > +
> > +	if (!map)
> > +		return false;
> > +
> > +	for (i = 0; ; i++) {
> > +		pe = &map->table[i];
> > +
> > +		if (!pe->name && !pe->metric_group && !pe->metric_name)
> > +			break;
> > +		if (!pe->metric_expr)
> > +			continue;
> > +		if (match_metric(pe->metric_group, metric) ||
> > +		    match_metric(pe->metric_name, metric))

Why both the group and the metric?

I would just match the metric_name

Otherwise it's impossible to have a group called "transaction"

With that fixed it's ok for me.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
