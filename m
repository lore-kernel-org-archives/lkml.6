Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510D7C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040AB24623
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040AB24623
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934541AbeF0RrI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:47:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753232AbeF0RrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:47:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4D0081A8E54;
        Wed, 27 Jun 2018 17:47:05 +0000 (UTC)
Received: from redhat.com (ovpn-120-46.rdu2.redhat.com [10.10.120.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B27C61C672;
        Wed, 27 Jun 2018 17:47:02 +0000 (UTC)
Date:   Wed, 27 Jun 2018 14:47:01 -0300
From:   "Herton R. Krzesinski" <herton@redhat.com>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     mhocko@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Miles Chen <miles.chen@mediatek.com>,
        Paul Burton <paul.burton@mips.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-mm@vger.kernel.org, aquini@redhat.com, lwoodman@redhat.com,
        n-horiguchi@ah.jp.nec.com
Subject: Re: Kernel crash after "mm: initialize pages on demand during boot"
Message-ID: <20180627174701.tq5rkzjh6cw2cpmb@dhcppc10>
References: <20180626204152.fyb5wzdduif2h5sg@dhcppc10>
 <20180627071925.GA32348@dhcp22.suse.cz>
 <CAGM2reaQYYrAP1mAWw4tV9+9z1pmnu5kOJj_g-O-kadqYrkx3w@mail.gmail.com>
 <20180627133843.rqzlfrn4sabftkn4@dhcppc10>
 <CAGM2rebOhcpzzzoqmSfGNz5UdSCs4athvp8nQVm0TqdtaonCeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGM2rebOhcpzzzoqmSfGNz5UdSCs4athvp8nQVm0TqdtaonCeA@mail.gmail.com>
User-Agent: NeoMutt/20180512
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 17:47:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Wed, 27 Jun 2018 17:47:06 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'herton@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:06:14AM -0400, Pavel Tatashin wrote:
> On Wed, Jun 27, 2018 at 10:15 AM Herton R. Krzesinski <herton@redhat.com> wrote:
> > Thanks, I'll try it. It'll probably work since I tried memory_reserve
> > but "hacking" it at e820__register_nosave_regions, anyway I'll confirm
> > it here.
> 
> If it works, please send the new "Reserved but unavailable" value from dmesg:
> [    0.000000] Reserved but unavailable: 103 pages

It worked, I don't see the oops with the patch. Here is the relevant
parts of dmesg (with memblock=debug):

[    0.000000] found SMP MP-table at [mem 0x000fce40-0x000fce4f] mapped at [(____ptrval____)]
[    0.000000] memblock_reserve: [0x00000000000fce40-0x00000000000fce4f] smp_scan_config+0xb1/0xf5
[    0.000000] memblock_reserve: [0x00000000000fcc20-0x00000000000fcdd3] smp_scan_config+0xc8/0xf5
[    0.000000] memblock_reserve: [0x0000000039494000-0x00000000394a0fff] setup_arch+0x5b7/0xcb0
[    0.000000] memblock_reserve: [0x0000000000000000-0x0000000000000fff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_add: [0x0000000000001000-0x000000000009a3ff] e820__memblock_setup+0x6d/0x9d
[    0.000000] memblock_reserve: [0x000000000009a400-0x000000000009ffff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x00000000000a0000-0x00000000000dffff] e820__memblock_setup+0x44/0x9d
[    0.000000] memblock_reserve: [0x00000000000e0000-0x00000000000fffff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_add: [0x0000000000100000-0x000000007f3e4fff] e820__memblock_setup+0x6d/0x9d
[    0.000000] memblock_reserve: [0x000000007f3e5000-0x000000007f42cfff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x000000007f42d000-0x000000007f433fff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x000000007f434000-0x000000007f504fff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x000000007f505000-0x000000007f50ffff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x000000007f510000-0x000000007f535fff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x000000007f536000-0x000000007f578fff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_add: [0x000000007f579000-0x000000007f7fffff] e820__memblock_setup+0x6d/0x9d
[    0.000000] memblock_reserve: [0x000000007f800000-0x00000000dfffffff] e820__memblock_setup+0x44/0x9d
[    0.000000] memblock_reserve: [0x00000000e0000000-0x00000000efffffff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x00000000f0000000-0x00000000fed1bfff] e820__memblock_setup+0x44/0x9d
[    0.000000] memblock_reserve: [0x00000000fed1c000-0x00000000fed3ffff] e820__memblock_setup+0x66/0x9d
[    0.000000] memblock_reserve: [0x00000000fed40000-0x00000000feffffff] e820__memblock_setup+0x44/0x9d
[    0.000000] memblock_reserve: [0x00000000ff000000-0x00000000ffffffff] e820__memblock_setup+0x66/0x9d
[    0.000000] MEMBLOCK configuration:
[    0.000000]  memory size = 0x000000007f605400 reserved size = 0x0000000086935c00
[    0.000000]  memory.cnt  = 0x3
[    0.000000]  memory[0x0]     [0x0000000000001000-0x0000000000099fff], 0x0000000000099000 bytes flags: 0x0
[    0.000000]  memory[0x1]     [0x0000000000100000-0x000000007f3e4fff], 0x000000007f2e5000 bytes flags: 0x0
[    0.000000]  memory[0x2]     [0x000000007f579000-0x000000007f7fffff], 0x0000000000287000 bytes flags: 0x0
[    0.000000]  reserved.cnt  = 0x6
[    0.000000]  reserved[0x0]   [0x0000000000000000-0x0000000000000fff], 0x0000000000001000 bytes flags: 0x0
[    0.000000]  reserved[0x1]   [0x000000000009a400-0x00000000000fffff], 0x0000000000065c00 bytes flags: 0x0
[    0.000000]  reserved[0x2]   [0x000000002f6bd000-0x0000000033b56fff], 0x000000000449a000 bytes flags: 0x0
[    0.000000]  reserved[0x3]   [0x0000000037a00000-0x00000000394a0fff], 0x0000000001aa1000 bytes flags: 0x0
[    0.000000]  reserved[0x4]   [0x000000007f3e5000-0x000000007f578fff], 0x0000000000194000 bytes flags: 0x0
[    0.000000]  reserved[0x5]   [0x000000007f800000-0x00000000ffffffff], 0x0000000080800000 bytes flags: 0x0
...
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x000000007f7fffff]
[    0.000000]   Normal   empty
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000007f3e4fff]
[    0.000000]   node   0: [mem 0x000000007f579000-0x000000007f7fffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000007f7fffff]
[    0.000000] On node 0 totalpages: 521733
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3993 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 8096 pages used for memmap
[    0.000000]   DMA32 zone: 517740 pages, LIFO batch:31
[    0.000000] Reserved but unavailable: 2555 pages

> 
> Thank you,
> Pavel

-- 
[]'s
Herton
