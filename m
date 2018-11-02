Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F24C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A653A20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A653A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeKBTc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 15:32:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbeKBTc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 15:32:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CF54369D3;
        Fri,  2 Nov 2018 10:26:19 +0000 (UTC)
Received: from krava (unknown [10.40.205.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8F24518B96;
        Fri,  2 Nov 2018 10:26:17 +0000 (UTC)
Date:   Fri, 2 Nov 2018 11:26:16 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf script doesn't dump a normal call trace
Message-ID: <20181102102616.GC5458@krava>
References: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_dNN34=5V3qtk3_vBzKNts55ACR4c-erPafgNuAQ-eRuw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 02 Nov 2018 10:26:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 03:36:13PM +0900, Xin Long wrote:
> On upstream kernel(4.19) or RHEL-8 kernel(4.18.0):
> 
> # perf record -e 'skb:consume_skb' -ag
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.612 MB perf.data (634 samples) ]
> 
> # perf script
> swapper     0 [009] 274370.117711: skb:consume_skb: skbaddr=0xffff962c591d5b00
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> kworker/9:1-eve   926 [009] 274370.117729: skb:consume_skb:
> skbaddr=0xffff962c591d5b00
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> kworker/9:1-eve   926 [009] 274370.117732: skb:consume_skb:
> skbaddr=0xffff962c591d4900
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> swapper     0 [009] 274370.145528: skb:consume_skb: skbaddr=0xffff962c591d4900
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> kworker/9:1-eve   926 [009] 274370.145545: skb:consume_skb:
> skbaddr=0xffff962c591d4900
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> kworker/9:1-eve   926 [009] 274370.145547: skb:consume_skb:
> skbaddr=0xffff962c591d5b00
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])
> 
> swapper     0 [009] 274370.173443: skb:consume_skb: skbaddr=0xffff962c591d5b00
>         ffffffffa4abe534 consume_skb+0x64 ([kernel.kallsyms])

I can see that on upstream as well, probably something within
tracepoint entry code, because I have it working nicely when
from kprobe, like:

[root@ibm-x3650m4-02 perf]# ./perf probe 'consume_skb'
[root@ibm-x3650m4-02 perf]# ./perf record -g -e probe:consume_skb* -aR ^C

jirka
