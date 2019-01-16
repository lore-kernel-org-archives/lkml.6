Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E81D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547645482;
	bh=+j/NMzhkMTSKtfvjPkmFokoaalfkyDTKrxhLoZ5kujc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2AoLycQKrQryndJllttCZQwxyeekHyYr+JR5vcnDIH6B83jYVDm2krz65fyNMFG/w
	 lPdihFtSVyk4DART60AALIYe46H2pjBqM1EFtEjfGRDujNiO/O0/GVwqrHSpl5sMVe
	 jVevXK6Bg2EKg0FQZt73hPcyBZqJuiQxz2p8UgTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393191AbfAPNbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:31:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732780AbfAPNbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:31:20 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6D120675;
        Wed, 16 Jan 2019 13:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547645480;
        bh=+j/NMzhkMTSKtfvjPkmFokoaalfkyDTKrxhLoZ5kujc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rIGCVRmbEXBUPdnD+T1hsAi0DjBXrKHQB1rT+iA2n4SSQO1wGWfvThrI+Hu1IvA/e
         TbcVkrDp3ABnGNH1qlByxqi8Jo2hDwa5HvyZRtbKZWK5QptymJ9jllljCYahSAsuMT
         BBpERIW3L37fVFaISiQTe4nOGHsqp5B+eE68lOMo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5AF3341AB5; Wed, 16 Jan 2019 10:31:17 -0300 (-03)
Date:   Wed, 16 Jan 2019 10:31:17 -0300
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
Message-ID: <20190116133117.GA2243@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115163540.GA20159@kernel.org>
 <20190116043735.GA31070@sejong>
 <35bf274a-f91e-1b4f-398a-dbe6f4105dfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35bf274a-f91e-1b4f-398a-dbe6f4105dfd@redhat.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 16, 2019 at 11:38:30AM +0000, Nick Clifton escreveu:
> Hi Guys,
> 
> 
> >> Humm, it would be nice for perf annotate to show those options when one
> >> navigates the annotation,
> 
> Usually the command line options can also be found in the debug info for
> the executable.  Assuming it has not been stripped, of course.
> 
> One of the advantages of the annobin strategy of using ELF notes is that
> these are not stripped from executables...
> 
> Unfortunately the annobin notes will probably not be very helpful as they
> only record a minor subset of the typical gcc command line options.
> (Specifically: -O, -g, -D_FORTIFY_SOURCE, -D_GLIBCXX_ASSERTIONS, 
> -fcf-protection, -fpic (and variants), -fshort-enum, -fstack-clash-protection,
> -fstack-protector, -mstackrealign, -fexceptions).

Humm, is -fno-omit-frame-pointer there by any chance? :-)
 
> >> Is there any library that gets those
> >> annotations and put them in some linked list that we could use in
> >> tools/perf/?
> 
> Sorry - no such library exists.

No problem...
 
> > If it's just an ELF note, we could parse it directly.

As we already parse some of the ELF notes, like the buildid, so just one
more to read and make available in the TUI somehow, should be handy.

> > https://developers.redhat.com/blog/2018/02/20/annobin-storing-information-binaries/
> 
> Exactly - and what a great blog author that person is ... :-)

:-)

- Arnaldo
