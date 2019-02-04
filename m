Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3658AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDF8214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549291553;
	bh=Fk+lMkx+Qd1tOq1u5028QtQYREV3zn/4c7+TT5oaZ1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IlwY56Aau25l0iZNTqoKJdqF1AQuCQdTd4Qhe8/D+9wBuIhRJdHEgkF0UltlHrkoC
	 3wrr9t1UTLMbArLy4B5AItaFpYBNlmAH/3qvDbRKNOE9s12iHKdrntkitNcVIw1Z4I
	 cFrq1sQBvpuE77h39HeaE+cbX7scrnPt8aZ/IdLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfBDOpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbfBDOpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:45:51 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 829A22087C;
        Mon,  4 Feb 2019 14:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549291550;
        bh=Fk+lMkx+Qd1tOq1u5028QtQYREV3zn/4c7+TT5oaZ1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OcitcuxMZ5OmHLsTlvt6G2njHe0+JsJnrqz6gqzSvGG69OkxX3S1AKDNhXzUZb+Uv
         A/sjc4wEgpfp7UmdaoWNxmMMV2F1oH5ny1PwbNwekJL52ApsW3mRlIFKJZoVzRoSil
         jzysLTIVEvJRBNOz4INZenGRv6/Ydz2tdimbY60E=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EAC034034F; Mon,  4 Feb 2019 11:45:47 -0300 (-03)
Date:   Mon, 4 Feb 2019 11:45:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Nick Clifton <nickc@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] perf tools: Filter out hidden symbols from labels
Message-ID: <20190204144547.GG5593@kernel.org>
References: <20190115135354.11572-1-jolsa@kernel.org>
 <960f0b83-a623-67a6-ab55-d56139d10ba2@redhat.com>
 <20190115173838.GB31411@krava>
 <20190128133526.GD15461@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128133526.GD15461@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jan 28, 2019 at 02:35:26PM +0100, Jiri Olsa escreveu:
> On Tue, Jan 15, 2019 at 06:38:38PM +0100, Jiri Olsa wrote:
> > On Tue, Jan 15, 2019 at 04:13:16PM +0000, Nick Clifton wrote:
> > > > When perf is built with annobin plugin (RHEL8 build) extra symbols
> > > > are added to its binary:
<SNIP>
> > > > +		elf_sym__visibility(sym) != STV_HIDDEN;
> > > 
> > >   Just to be awkward, if you are going to ignore STV_HIDDEN 
> > >   symbols then you should probably also ignore STV_INTERNAL ones
> > >   as well...  Annobin does not generate them, but you never know,
> > >   one day some other tool might create some.
> > 
> > sounds good, thanks
> 
> there were no objections for rfc, sending patch

Thanks, applied to perf/urgent.

- Arnaldo
