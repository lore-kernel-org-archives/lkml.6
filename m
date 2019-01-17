Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53ACC20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547733975;
	bh=SsWxhxaxDR/vyYbcsqTxAr1KLx7QJt7dP/vJPe25yf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jOdFTMR2je3eXCOgadOkVvi1qqbu1Q9wH2lNC/+Zr0rWsCpBqlU6JraUO0zLGJ9BK
	 BsMh8jenIMwlZw313udBP2kP9g1HF7Fbkn6KVxin6xVtH9Eincxeq+wtYc7MC9HdCU
	 YsHw6dWWRSPD1u40IPDS9Yzf/HDJWKpi4/vHXofc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfAQOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQOGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:06:13 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A1120652;
        Thu, 17 Jan 2019 14:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547733972;
        bh=SsWxhxaxDR/vyYbcsqTxAr1KLx7QJt7dP/vJPe25yf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KGuezXPViu2jzq20ika8rMvyrZ+Usv++K3UpbGqt9z4KI2hFTe54XEhOG5OkqSv0c
         4MLuzGKipTOOgwre/Bkqh6Q2d8ThSi+hujV/uMGbUUwNbzkYt7JoBTN5GCVx5iScCj
         z+gYbMaaO/EXI1nn4e4DYSQ3rbDWdRyFqgBmSR2I=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ECE9741AB5; Thu, 17 Jan 2019 11:06:09 -0300 (-03)
Date:   Thu, 17 Jan 2019 11:06:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH perf/urgent] perf tools: Fix crash in ordered_events__free
Message-ID: <20190117140609.GA5823@kernel.org>
References: <20190117113017.12977-1-jolsa@kernel.org>
 <CAPhsuW78Xk3kK208RMmV6HuwpGmhqX+6Jg=rd3A12LCp7HqFOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW78Xk3kK208RMmV6HuwpGmhqX+6Jg=rd3A12LCp7HqFOQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 17, 2019 at 06:03:04AM -0800, Song Liu escreveu:
> On Thu, Jan 17, 2019 at 3:54 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Song Liu reported crash in perf record:
> >
> > > #0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
> > > #1  0x0000000000500196 in ordered_events.reinit ()
> > > #2  0x00000000004fe413 in perf_session.process_events ()
> > > #3  0x0000000000440431 in cmd_record ()
> > > #4  0x00000000004a439f in run_builtin ()
> > > #5  0x000000000042b3e5 in main ()"
> >
> > This can happen when we get out of the buffers during
> > event processing. The subsequent ordered_events__free
> > assumes the oe->buffer != NULL and crashes. Adding
> > the check to prevent that.
> >
> > Cc: Stephane Eranian <eranian@google.com>
> > Fixes: d5ceb62b3654 ("perf ordered_events: Add 'struct ordered_events_buffer' layer")
> > Reported-by: Song Liu <liu.song.a23@gmail.com>
> > Link: http://lkml.kernel.org/n/tip-914bml5kabz2m9mbywd7el9l@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>
> 
> Thanks again for the fix!

Thanks, applied to acme/perf/urgent,

- Arnaldo
