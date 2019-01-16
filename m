Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79997C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4955120657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547654672;
	bh=QEHKnuDT6konLZMzDqiB4AYHn+rVHj/oJh15tXeF584=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ms///mJtyTs501NsZsFb17xdt84LT0dv3pxJC5dkwYajRohTsjlO97sXJ0FaALN++
	 N3LmhzmL6P7bkLk9DvgK5iXnz5JsEMHyjm/1c0OtSo0oGhLOvAr4BK1ELCO2bGXOMH
	 xtGBsw6syNr6eioKaf0hb8aReomTenkLNVCl27lM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405078AbfAPQEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:04:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbfAPQEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:04:30 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8648205C9;
        Wed, 16 Jan 2019 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547654669;
        bh=QEHKnuDT6konLZMzDqiB4AYHn+rVHj/oJh15tXeF584=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFkhegS2xKL/KNhPOYmR7Tju8Gab7gTfgGKbc+62KNv7TjL6Ad0FgNP30FJb89F/P
         bjXc/0pkUjG0bO1EIUtvGrIgSe4uoW9Z+HK78Ahiw4XzGwdzFI0oMZwoC68rcdhr1P
         FICOmHBHCA8eaKaJglgO6X+hQyCLE1+rqxEJj7qs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 617CD41AB5; Wed, 16 Jan 2019 13:04:22 -0300 (-03)
Date:   Wed, 16 Jan 2019 13:04:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Clifton <nickc@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, kernel-team@lge.com
Subject: Re: [RFC] perf tools: Filter out hidden symbols from labels
Message-ID: <20190116160422.GH2243@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115163540.GA20159@kernel.org>
 <20190116043735.GA31070@sejong>
 <35bf274a-f91e-1b4f-398a-dbe6f4105dfd@redhat.com>
 <20190116133117.GA2243@kernel.org>
 <db34cf8a-d929-ffe1-91a5-ed3da0c6df86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db34cf8a-d929-ffe1-91a5-ed3da0c6df86@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 16, 2019 at 03:47:50PM +0000, Nick Clifton escreveu:
> Hi Arnaldo,
> 
> >> Unfortunately the annobin notes will probably not be very helpful as they
> >> only record a minor subset of the typical gcc command line options.
> >> (Specifically: -O, -g, -D_FORTIFY_SOURCE, -D_GLIBCXX_ASSERTIONS, 
> >> -fcf-protection, -fpic (and variants), -fshort-enum, -fstack-clash-protection,
> >> -fstack-protector, -mstackrealign, -fexceptions).
> > 
> > Humm, is -fno-omit-frame-pointer there by any chance? :-)
> 
> Not at the moment, although it could be added.  All of the options 
> mentioned in the above list are recorded because they have an impact
> on the security hardening of the binary.  Other options are ignored
> because, at least for now, they have no security implications.

Would be interestint to have that info, as we could hint the user that
backtraces should be done with something else than '--call-graph fp' :-)

- Arnaldo
