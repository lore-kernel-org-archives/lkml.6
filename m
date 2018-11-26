Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB37CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8079E21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yIoCcBuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8079E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbeK0Xdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbeK0Xdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:43 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A73D5208E4;
        Tue, 27 Nov 2018 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322155;
        bh=5wfzqkuEgNVo5BjfJWGam44RxPiqvfW5xmVSFOFUrZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yIoCcBuB/czwz0G1UvuIVKDlur0ewk1MRSSLRkMBxSwuIVxNrYCeCULhYcta2xIgs
         2Ux2LSGOyinz+u/8A4o69z7nTAt5uEPvCYE1BDmGjN9VjdVrPDxpaSaQi73J32ZIoI
         RSJOfAKfZvXRqcQ4NxM1Eu84S4CzM2FsUKCgD/Ho=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4778141117; Mon, 26 Nov 2018 15:49:16 -0300 (-03)
Date:   Mon, 26 Nov 2018 15:49:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu
Subject: Re: [PATCH] perf stat: fix csv mode column output for non-cgroup
 events
Message-ID: <20181126184916.GD5518@kernel.org>
References: <1541587845-9150-1-git-send-email-eranian@google.com>
 <20181122035811.GD5468@redhat.com>
 <20181122090835.GB15953@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122090835.GB15953@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 22, 2018 at 10:08:35AM +0100, Jiri Olsa escreveu:
> On Thu, Nov 22, 2018 at 01:58:11AM -0200, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 07, 2018 at 02:50:45AM -0800, Stephane Eranian escreveu:
> > > When using the -x option, perf stat prints csv-style output
> > > with one event per line.  For each event, it prints the count,
> > > the unit, the event name, the cgroup, and a bunch of other event
> > > specific fields (such as insn per cycles).
> > > 
> > > When you use csv-style mode, you expect a normalized output where
> > > each event is printed with the same number of fields regardless of
> > > what it is so it can easily be imported into a spreadsheet or parsed.
> > > For instance, if an event does not have a unit, then print an empty field
> > > for it. Although this approach was implemented for the unit, it was not
> > > for the cgroup.  When mixing cgroup and non-cgroup events, then non-cgroup
> > > events would not show an empty field, instead the next field was printed,
> > > make columns not line up correctly.
> > > 
> > > This patch fixes the cgroup output issues by forcing an empty field
> > > for non-cgroup events as soon as one event has cgroup.
> > 
> > Looks sane, that nr_cgroups global variable at some point has to go to
> > the evlist, but that is not introduced by this patch, Jiri, are you ok
> > with it as well?
> 
> yep, looks good, sry I missed it
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
