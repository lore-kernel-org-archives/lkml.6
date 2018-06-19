Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EC6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7620693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CB7620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030366AbeFSSYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:24:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38760 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966449AbeFSSYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57F3C87903;
        Tue, 19 Jun 2018 18:24:21 +0000 (UTC)
Received: from krava (ovpn-204-55.brq.redhat.com [10.40.204.55])
        by smtp.corp.redhat.com (Postfix) with SMTP id B1CC22156880;
        Tue, 19 Jun 2018 18:24:19 +0000 (UTC)
Date:   Tue, 19 Jun 2018 20:24:18 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH 3/3] perf stat: Remove duplicate event counting
Message-ID: <20180619182418.GB1926@krava>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-3-tmricht@linux.ibm.com>
 <20180615082124.GG5082@krava>
 <20180619151706.GJ20477@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619151706.GJ20477@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 18:24:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 19 Jun 2018 18:24:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:17:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 15, 2018 at 10:21:24AM +0200, Jiri Olsa escreveu:
> > On Thu, Jun 14, 2018 at 01:48:45PM +0200, Thomas Richter wrote:
> > 
> > SNIP
> > 
> > > +static void perf_pmu_assign_str(char *name, const char *field, char **old_str,
> > > +				char **new_str)
> > > +{
> > > +	if (!*old_str)
> > > +		goto set_new;
> > > +
> > > +	if (*new_str) {	/* Have new string, check with old */
> > > +		if (strcasecmp(*old_str, *new_str))
> > > +			pr_debug("alias %s differs in field '%s'\n",
> > > +				 name, field);
> > > +		zfree(old_str);
> > > +	} else		/* Nothing new --> keep old string */
> > > +		return;
> > > +set_new:
> > > +	*old_str = *new_str;
> > > +	*new_str = NULL;
> > > +}
> > > +
> > > +static void perf_pmu_update_alias(struct perf_pmu_alias *old,
> > > +				  struct perf_pmu_alias *newalias)
> > > +{
> > > +	perf_pmu_assign_str(old->name, "desc", &old->desc, &newalias->desc);
> > > +	perf_pmu_assign_str(old->name, "long_desc", &old->long_desc,
> > > +			    &newalias->long_desc);
> > > +	perf_pmu_assign_str(old->name, "topic", &old->topic, &newalias->topic);
> > > +	perf_pmu_assign_str(old->name, "metric_expr", &old->metric_expr,
> > > +			    &newalias->metric_expr);
> > > +	perf_pmu_assign_str(old->name, "metric_name", &old->metric_name,
> > > +			    &newalias->metric_name);
> > > +	perf_pmu_assign_str(old->name, "value", &old->str, &newalias->str);
> > > +	old->scale = newalias->scale;
> > > +	old->per_pkg = newalias->per_pkg;
> > > +	old->snapshot = newalias->snapshot;
> > > +	memcpy(old->unit, newalias->unit, sizeof(old->unit));
> > > +}
> > > +
> > > +/* Delete an alias entry. */
> > > +static void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
> > > +{
> > > +	zfree(&newalias->name);
> > > +	zfree(&newalias->desc);
> > > +	zfree(&newalias->long_desc);
> > > +	zfree(&newalias->topic);
> > > +	zfree(&newalias->str);
> > > +	zfree(&newalias->metric_expr);
> > > +	zfree(&newalias->metric_name);
> > > +	parse_events_terms__purge(&newalias->terms);
> > > +	free(newalias);
> > > +}
> > > +
> > > +/* Merge an alias, search in alias list. If this name is already
> > > + * present merge both of them to combine all information.
> > > + */
> > > +static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
> > > +				 struct list_head *alist)
> > > +{
> > > +	struct perf_pmu_alias *a;
> > > +
> > > +	list_for_each_entry(a, alist, list) {
> > > +		if (!strcasecmp(newalias->name, a->name)) {
> > > +			perf_pmu_update_alias(a, newalias);
> > > +			perf_pmu_free_alias(newalias);
> > > +			return true;
> > > +		}
> > > +	}
> > > +	return false;
> > > +}
> > 
> > ok, I like your change better.. we can rebuilt it to use
> > rb tree later when we have this fixed
> 
> Ok, can I take this as an Acked-by or Reviewed-by?

yes

jirka
