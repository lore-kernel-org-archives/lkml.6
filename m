Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FA8C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9842075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmHPA4Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9842075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937696AbeFSPRL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:17:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937547AbeFSPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:17:09 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1F720652;
        Tue, 19 Jun 2018 15:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529421428;
        bh=5NjKi9jObOdD0d12IuDQ6OCZQOqMt261Tlk6hFuFS80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TmHPA4TwOczxAIgPaaZ9dsYPO/hKcKTRkqDnBQhcJthH4DCy/zF8/Xc1XBO8Vdys9
         jyjY5Qtohx2jC/SHtFxMzHhsi9UJ0rAMnLy7aXAAddVcRJqa7dOnmoNwxor5bnrT7x
         +bK9DrosSTF9PAHWFKp8wSOlexjpz7FG9+8LO3nA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 933831401E5; Tue, 19 Jun 2018 12:17:06 -0300 (-03)
Date:   Tue, 19 Jun 2018 12:17:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 3/3] perf stat: Remove duplicate event counting
Message-ID: <20180619151706.GJ20477@kernel.org>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-3-tmricht@linux.ibm.com>
 <20180615082124.GG5082@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615082124.GG5082@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 15, 2018 at 10:21:24AM +0200, Jiri Olsa escreveu:
> On Thu, Jun 14, 2018 at 01:48:45PM +0200, Thomas Richter wrote:
> 
> SNIP
> 
> > +static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
> > +				char **new_str)
> > +{
> > +	if (!*old_str)
> > +		goto set_new;
> > +
> > +	if (*new_str) {	/* Have new string, check with old */
> > +		if (strcasecmp(*old_str, *new_str))
> > +			pr_debug("alias %s differs in field '%s'\n",
> > +				 name, field);
> > +		zfree(old_str);
> > +	} else		/* Nothing new --> keep old string */
> > +		return;
> > +set_new:
> > +	*old_str = *new_str;
> > +	*new_str = NULL;
> > +}
> > +
> > +static void perf_pmu_update_alias(struct perf_pmu_alias *old,
> > +				  struct perf_pmu_alias *newalias)
> > +{
> > +	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
> > +	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
> > +			    &newalias->long_desc);
> > +	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
> > +	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
> > +			    &newalias->metric_expr);
> > +	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
> > +			    &newalias->metric_name);
> > +	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
> > +	old->scale = newalias->scale;
> > +	old->per_pkg = newalias->per_pkg;
> > +	old->snapshot = newalias->snapshot;
> > +	memcpy(old->unit, newalias->unit, sizeof(old->unit));
> > +}
> > +
> > +/* Delete an alias entry. */
> > +static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> > +{
> > +	zfree(&newalias->name);
> > +	zfree(&newalias->desc);
> > +	zfree(&newalias->long_desc);
> > +	zfree(&newalias->topic);
> > +	zfree(&newalias->str);
> > +	zfree(&newalias->metric_expr);
> > +	zfree(&newalias->metric_name);
> > +	parse_events_terms__purge(&newalias->terms);
> > +	free(newalias);
> > +}
> > +
> > +/* Merge an alias, search in alias list. If this name is already
> > + * present merge both of them to combine all information.
> > + */
> > +static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
> > +				 struct list_head *alist)
> > +{
> > +	struct perf_pmu_alias *a;
> > +
> > +	list_for_each_entry(a, alist, list) {
> > +		if (!strcasecmp(newalias->name, a->name)) {
> > +			perf_pmu_update_alias(a, newalias);
> > +			perf_pmu_free_alias(newalias);
> > +			return true;
> > +		}
> > +	}
> > +	return false;
> > +}
> 
> ok, I like your change better.. we can rebuilt it to use
> rb tree later when we have this fixed

Ok, can I take this as an Acked-by or Reviewed-by?

- Arnaldo
