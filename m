Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31ABD20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ABD20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeKZTco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:32:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbeKZTcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:32:43 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 57C73308213B;
        Mon, 26 Nov 2018 08:39:20 +0000 (UTC)
Received: from krava (ovpn-204-234.brq.redhat.com [10.40.204.234])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0DC815D784;
        Mon, 26 Nov 2018 08:39:17 +0000 (UTC)
Date:   Mon, 26 Nov 2018 09:39:17 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Eric Saint Etienne <eric.saint.etienne@oracle.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Darren Kenny <darren.kenny@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: Re: [PATCH] perf symbols: Cannot disassemble some routines when
 debuginfo present
Message-ID: <20181126083917.GA18783@krava>
References: <1542968726-20910-1-git-send-email-eric.saint.etienne@oracle.com>
 <20181123160337.GA5575@krava>
 <3f427959-a41f-4ff4-b095-ef8af11665c9@default>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f427959-a41f-4ff4-b095-ef8af11665c9@default>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 26 Nov 2018 08:39:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 10:24:21AM -0800, Eric Saint Etienne wrote:
> > > +		/*
> > > +		 * When using -ffunction-sections, only .text gets loaded by
> > > +		 * map_groups__find() into al->map. Consequently al->map address
> > > +		 * range encompass the whole code.
> > > +		 *
> > > +		 * But map__load() has just loaded many function maps by
> > > +		 * splitting al->map, which reduced al->map range drastically.
> > > +		 * Very likely the target address is now in one of those newly
> > > +		 * created function maps, so we need to lookup the map again
> > > +		 * to find that new map.
> > > +		 */
> > 
> > hum, so map__load actualy can split the map to create new maps?
> > 
> > cold you please point me to that code? I haven't touch this area for some
> > time and I can't find it
> 
> The split happens in dso_process_kernel_symbol() in symbol-elf.c where we
> call map_groups__find_by_name() to find an existing map, but with
> -ffunction-sections and a symbol belonging to new (function) map, such map
> doesn't exist yet so we end up creating one and adjusting existing maps
> accordingly because adjust_kernel_syms is set. Makes sense?
> 
> As of 4.20-rc3 the call chain is as follows:
> event:c:1573	   map__load()
> map.c:315	   dso__load()
> symobl.c:1528	   dso__load_kernel_sym()
> symbol.c:1896	   dso__load_vmlinux_path()
> 		   (or we directly call dso__load_vmlinux() at line 1892)
> symbol.c:1744	   dso__load_vmlinux()
> symbol.c:1719	   dso__load_sym()
> symbol-elf.c:1090  dso_process_kernel_symbol()

i see, thank for the pointers.. could you please mention
this in your comment and changelog as well?

also to document in the code that it's related to map__load
could you put it to the if contidion, like:

+               if (load_map && (al->addr < al->map->start || al->addr >= al->map->end))


thanks,
jirka
