Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99528C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E101214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSivZpvR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E101214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbeK0Xdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbeK0Xdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:45 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB2552146F;
        Tue, 27 Nov 2018 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322158;
        bh=rLbZxQ4dkVM31GrIU2ksZxX5RevT3MYmgMGc6aO94tc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSivZpvR8GgbMTMlLnlZomSZAkchppTlgph1Q2BqTkM/rf3HSrrtTIs/IXAGyB5vp
         v+Q9Err6jmIQPhVUqK4+KuUFfiNInGE3pnMEoRBXa/u9dMN1usiNnIwp+FaGNHpfV3
         KnX0C7sJXDHDo8Rm+tpm3HFQEl5WoPRtuVajqMqs=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4976241119; Mon, 26 Nov 2018 15:53:57 -0300 (-03)
Date:   Mon, 26 Nov 2018 15:53:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Eric Saint Etienne <eric.saint.etienne@oracle.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH] perf symbols: Cannot disassemble some routines when
 debuginfo present
Message-ID: <20181126185357.GB18491@kernel.org>
References: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
 <20181123160337.GA5575@krava>
 <3f427959-a41f-4ff4-b095-ef8af11665c9@default>
 <20181126083917.GA18783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126083917.GA18783@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 26, 2018 at 09:39:17AM +0100, Jiri Olsa escreveu:
> On Fri, Nov 23, 2018 at 10:24:21AM -0800, Eric Saint Etienne wrote:
> > > > +		/*
> > > > +		 * When using -ffunction-sections, only .text gets loaded by
> > > > +		 * map_groups__find() into al->map. Consequently al->map address
> > > > +		 * range encompass the whole code.
> > > > +		 *
> > > > +		 * But map__load() has just loaded many function maps by
> > > > +		 * splitting al->map, which reduced al->map range drastically.
> > > > +		 * Very likely the target address is now in one of those newly
> > > > +		 * created function maps, so we need to lookup the map again
> > > > +		 * to find that new map.
> > > > +		 */
> > > 
> > > hum, so map__load actualy can split the map to create new maps?
> > > 
> > > cold you please point me to that code? I haven't touch this area for some
> > > time and I can't find it
> > 
> > The split happens in dso_process_kernel_symbol() in symbol-elf.c where we
> > call map_groups__find_by_name() to find an existing map, but with
> > -ffunction-sections and a symbol belonging to new (function) map, such map
> > doesn't exist yet so we end up creating one and adjusting existing maps
> > accordingly because adjust_kernel_syms is set. Makes sense?
> > 
> > As of 4.20-rc3 the call chain is as follows:
> > event:c:1573	   map__load()
> > map.c:315	   dso__load()
> > symobl.c:1528	   dso__load_kernel_sym()
> > symbol.c:1896	   dso__load_vmlinux_path()
> > 		   (or we directly call dso__load_vmlinux() at line 1892)
> > symbol.c:1744	   dso__load_vmlinux()
> > symbol.c:1719	   dso__load_sym()
> > symbol-elf.c:1090  dso_process_kernel_symbol()
> 
> i see, thank for the pointers.. could you please mention
> this in your comment and changelog as well?
> 
> also to document in the code that it's related to map__load
> could you put it to the if contidion, like:
> 
> +               if (load_map && (al->addr < al->map->start || al->addr >= al->map->end))
> 

Eric, please address Jiri's comments and send a v2, ok?

- Arnaldo
