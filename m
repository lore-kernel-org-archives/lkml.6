Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCD7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B910A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978586;
	bh=q249P9TV9KBP89WhGVH96NjSxj/xQlMiHaiCeODYXkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LzBboRdPpWGvQZaIvpycW+3eoTRlXn4q79tTcVpBgCt7o52n1bR+B1SlUbNJzZl6E
	 xQPAG0n0N5AEBQuYR1r7cjBtAFKJIqoDwG7+EcZ1qIBXIyoi+O45XGvOcrV1Q/0dX5
	 JtzoRK16JlIBf7CFIEaR2W7m+ELa4kE6JRdxWXsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbfAHUQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbfAHUQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:16:25 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD5020675;
        Tue,  8 Jan 2019 20:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546978583;
        bh=q249P9TV9KBP89WhGVH96NjSxj/xQlMiHaiCeODYXkY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVrPFRwpyxuasllqDLWeEncmpfLkhyQX4569wdSk2YPJbdsUWTAXWdCbwtXISOfnT
         khnyGJkzry+E5NR6jeXfifqFviX/41H1Lkj+PTizvkvu2N9tPGY0JewhJDLjvKL/xp
         l7OxOExLVP+XkA8PW1h4dVvd3DHUZmOs9qLsLB6U=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F391D40355; Tue,  8 Jan 2019 17:16:19 -0300 (-03)
Date:   Tue, 8 Jan 2019 17:16:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 perf, bpf-next 3/7] perf, bpf: introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20190108201619.GG28965@kernel.org>
References: <20181220182904.4193196-1-songliubraving@fb.com>
 <20181220182904.4193196-4-songliubraving@fb.com>
 <20190108184116.GC30894@hirez.programming.kicks-ass.net>
 <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77A478D9-F36F-443A-BBFD-F0C1FFE0DD90@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 08, 2019 at 07:10:20PM +0000, Song Liu escreveu:
> > On Jan 8, 2019, at 10:41 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, Dec 20, 2018 at 10:29:00AM -0800, Song Liu wrote:
> >> @@ -986,9 +987,35 @@ enum perf_event_type {
> >> 	 */
> >> 	PERF_RECORD_KSYMBOL			= 17,
> >> 
> >> +	/*
> >> +	 * Record bpf events:
> >> +	 *  enum perf_bpf_event_type {
> >> +	 *	PERF_BPF_EVENT_UNKNOWN		= 0,
> >> +	 *	PERF_BPF_EVENT_PROG_LOAD	= 1,
> >> +	 *	PERF_BPF_EVENT_PROG_UNLOAD	= 2,
> >> +	 *  };
> >> +	 *
> >> +	 * struct {
> >> +	 *	struct perf_event_header	header;
> >> +	 *	u16				type;
> >> +	 *	u16				flags;
> >> +	 *	u32				id;
> >> +	 *	u8				tag[BPF_TAG_SIZE];
> >> +	 *	struct sample_id		sample_id;
> >> +	 * };
> >> +	 */
> >> +	PERF_RECORD_BPF_EVENT			= 18,

> > It was suggested to allow pinning modules/programs to avoid this
> > situation, but that of course has other undesirable effects, such as a
> > trivial DoS.
> > 
> > A truly horrible hack would be to include an open filedesc in the event
> > that needs closing to release the resource, but I'm sorry for even
> > suggesting that **shudder**.
> > 
> > Do we have any sane ideas?
> 
> How about we gate the open filedesc solution with an option, and limit
> that option for root only? If this still sounds hacky, maybe we should
> just ignore when short-living programs are missed?

Short lived short programs could go in the event? Short lived long
events.. One could ask for max number of bytes of binary?

The smallest kernel modules are 16KB, multiple of PAGE_SIZE:

[acme@quaco perf]$ cat /proc/modules | sort -k2 -nr | tail
ebtable_nat 16384 1 - Live 0x0000000000000000
ebtable_filter 16384 1 - Live 0x0000000000000000
crct10dif_pclmul 16384 0 - Live 0x0000000000000000
crc32_pclmul 16384 0 - Live 0x0000000000000000
coretemp 16384 0 - Live 0x0000000000000000
btrtl 16384 1 btusb, Live 0x0000000000000000
btbcm 16384 1 btusb, Live 0x0000000000000000
arc4 16384 2 - Live 0x0000000000000000
acpi_thermal_rel 16384 1 int3400_thermal, Live 0x0000000000000000
ac97_bus 16384 1 snd_soc_core, Live 0x0000000000000000
[acme@quaco perf]$

On a Fedora 29 I have these here, all rather small:

# bpftool prog
13: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-04T14:40:32-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
14: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-04T14:40:32-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
15: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-04T14:40:32-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
16: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-04T14:40:32-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
17: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-04T14:40:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
18: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-04T14:40:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
21: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-04T14:40:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
22: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-04T14:40:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
[root@quaco IRPF2018]#


Running 'perf trace' with its BPF augmenter get these two more:

158: tracepoint  name sys_enter  tag 12504ba9402f952f  gpl
	loaded_at 2019-01-08T17:12:39-0300  uid 0
	xlated 512B  jited 374B  memlock 4096B  map_ids 118,117,116
159: tracepoint  name sys_exit  tag c1bd85c092d6e4aa  gpl
	loaded_at 2019-01-08T17:12:39-0300  uid 0
	xlated 256B  jited 191B  memlock 4096B  map_ids 118,117
[root@quaco ~]#

A PERF_RECORD_MMAP gets as its payload up to PATH_MAX - sizeof(u64).

So for a class of programs, shoving it together with the
PERF_RECORD_MMAP like event may be enough?

You started the shuddering suggestions... ;-)

- Arnaldo
