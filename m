Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E1FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6FD20661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfB0NZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:25:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfB0NZy (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:25:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6167A309CC3A;
        Wed, 27 Feb 2019 13:25:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.18])
        by smtp.corp.redhat.com (Postfix) with SMTP id 518365D6B3;
        Wed, 27 Feb 2019 13:25:52 +0000 (UTC)
Date:   Wed, 27 Feb 2019 14:25:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf diff: Support --time filter option
Message-ID: <20190227132550.GK18893@krava>
References: <1551183069-5931-1-git-send-email-yao.jin@linux.intel.com>
 <1551183069-5931-2-git-send-email-yao.jin@linux.intel.com>
 <20190227092755.GA22793@krava>
 <95a5cba1-b06c-4adb-9c45-ddec5da3b6ee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95a5cba1-b06c-4adb-9c45-ddec5da3b6ee@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 27 Feb 2019 13:25:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 09:04:21PM +0800, Jin, Yao wrote:
> 
> 
> On 2/27/2019 5:27 PM, Jiri Olsa wrote:
> > On Tue, Feb 26, 2019 at 08:11:07PM +0800, Jin Yao wrote:
> > 
> > SNIP
> > 
> > > +	abstime_tmp = abstime_ostr;
> > >   	data__for_each_file(i, d) {
> > > -		d->session = perf_session__new(&d->data, false, &tool);
> > > +		d->session = perf_session__new(&d->data, false, &pdiff.tool);
> > >   		if (!d->session) {
> > >   			pr_err("Failed to open %s\n", d->data.path);
> > >   			ret = -1;
> > >   			goto out_delete;
> > >   		}
> > > +		if (abstime_ostr) {
> > > +			ret = parse_absolute_time(d, &abstime_tmp);
> > > +			if (ret < 0)
> > > +				goto out_delete;
> > > +		} else if (pdiff.time_str) {
> > > +			ret = parse_percent_time(d);
> > > +			if (ret < 0)
> > > +				goto out_delete;
> > > +		} else {
> > > +			pdiff.range_num = 1;
> > 
> > hum, why are we setting range_num to 1 again?
> 
> Yes, that may be not necessary. I will remove this line and test again.
> 
> > 
> > it's really hard to parse this code, maybe
> > it'd be better in separate loop/function
> > that would setup just timestamps..
> > 
> 
> Do you mean the above parsing code should be put in a separate function
> (e.g. parse_time_string in following example)?
> 
> data__for_each_file(i, d) {
> 	....
> 	d->session = perf_session__new(&d->data, false, &pdiff.tool);
> 	....
> 	parse_time_string(...);
> 	ret = perf_session__process_events(d->session);
> 	....
> }

anything that would make this more clear/readable ;-)

thanks,
jirka
