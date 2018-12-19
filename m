Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A18C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35D9214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545223805;
	bh=K9mSuHOlpaHFZ3QQo/9hThgRoydMmHXPudghl4rbClQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gsqsswtZrJ5iRTE0OLW3VxHqaEMVvlVclu0EjW4LiVyYyQo1SpWTfTrcK4O/esSXt
	 OgTVw7RWI/BOfHbR/CSaa/pBxfI0ZPO7o2c6eIQLkt6qMupF0uJcjChtkXtT1V9huc
	 jSitRteFG7SJmajKp7E+oeIbopReIbSHWNFwNusY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbeLSMuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:50:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbeLSMuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:50:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E81F21479;
        Wed, 19 Dec 2018 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545223803;
        bh=K9mSuHOlpaHFZ3QQo/9hThgRoydMmHXPudghl4rbClQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VlHjnvNwksLfqohVZl98Weg2CZECFksd4FM2uF0KLpPi8n0U6WgkvQ9le0BmJJsHY
         nyZyliJ/a2SwZ8wh/Gu12lXt0s72BLw/bZZ3wo3KmwTLPxxbLBfZ875Fy5jtcWYlc0
         Gaq/KiQuv4LLS7OHAjmPOy0403SecMRD8PS8nqx4=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AFC4C41B1D; Wed, 19 Dec 2018 09:50:00 -0300 (-03)
Date:   Wed, 19 Dec 2018 09:50:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?iso-8859-1?Q?Cl=E1udio_Gon=E7alves?= <lclaudio@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 35/63] perf trace: Allow specifying a set of events to
 add in perfconfig
Message-ID: <20181219125000.GA16225@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-36-acme@kernel.org>
 <20181219084024.GA18068@danjae.aot.lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181219084024.GA18068@danjae.aot.lge.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 19, 2018 at 05:40:24PM +0900, Namhyung Kim escreveu:
> On Tue, Dec 18, 2018 at 07:07:05PM -0300, Arnaldo Carvalho de Melo wrote:
> > +	if (!strcmp(var, "trace.add_events")) {
> > +		struct trace *trace = arg;
> > +		struct option o = OPT_CALLBACK('e', "event", &trace->evlist, "event",
> > +					       "event selector. use 'perf list' to list available events",
> > +					       parse_events_option);
> > +		err = parse_events_option(&o, value, 0);
 
> It's a bit strange to use parse_events_option() here IMHO.  Why not
> using parse_events() instead?

I just reused what was done a in another place in 'perf trace', will
check and use parse_events() directly, thanks for the suggestion!

- Arnaldo
