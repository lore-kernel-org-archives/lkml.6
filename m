Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F2341C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EAA208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EAA208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756032AbeFOIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:12:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755847AbeFOIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:12:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9751C859C5;
        Fri, 15 Jun 2018 08:12:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5577120283A3;
        Fri, 15 Jun 2018 08:12:43 +0000 (UTC)
Date:   Fri, 15 Jun 2018 10:12:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Paul Clarke <pc@us.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf alias: Rebuild alias expression string to make
 it comparable
Message-ID: <20180615081242.GF5082@krava>
References: <20180614114845.41221-1-tmricht@linux.ibm.com>
 <20180614114845.41221-2-tmricht@linux.ibm.com>
 <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809ff562-511d-26e9-bac3-e8f7b84666e5@us.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 08:12:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 15 Jun 2018 08:12:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 08:53:14AM -0500, Paul Clarke wrote:

SNIP

> > +		if (ret)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 ",");
> > +		if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 "%s=%#x", term->config, term->val.num);
> > +		else if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
> > +			ret += scnprintf(newval + ret, sizeof(newval) - ret,
> > +					 "%s=%s", term->config, term->val.str);
> 
> If we exceed 256, we just suddenly terminate the rebuilding without reporting any issues.
> 
> > +	}
> > +
> >  	alias->name = strdup(name);
> >  	if (dir) {
> >  		/*
> > @@ -285,7 +308,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
> >  		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
> >  	}
> >  	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
> > -	alias->str = strdup(val);
> > +	alias->str = strdup(newval);

hum, how is newval different from val? AFAICS it's the same

jirka
