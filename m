Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FDE20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FDE20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393335AbeKVTmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:42:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53630 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731655AbeKVTmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:42:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E7AE80F79;
        Thu, 22 Nov 2018 09:03:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id B08D663F88;
        Thu, 22 Nov 2018 09:03:36 +0000 (UTC)
Date:   Thu, 22 Nov 2018 10:03:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Wangnan (F)" <wangnan0@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: perf tools: remove option --tail-synthesize ?
Message-ID: <20181122090335.GA15953@krava>
References: <89AC26A9-5A18-4608-8889-9C3C9C1C69D3@fb.com>
 <20181121131156.GG6248@kernel.org>
 <da87afd6-c291-2049-5e0b-a02512122806@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da87afd6-c291-2049-5e0b-a02512122806@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 22 Nov 2018 09:03:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:50:15AM +0800, Wangnan (F) wrote:
> 
> 
> On 2018/11/21 21:11, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Nov 21, 2018 at 07:45:28AM +0000, Song Liu escreveu:
> >> Hi,
> >>
> >> I found perf-record --tail-synthesize without --overwrite breaks symbols
> >> for perf-script, perf-report, etc. For example:
> >>
> >> [root@]# ~/perf record -ag --tail-synthesize -- sleep 1
> >> [ perf record: Woken up 1 times to write data ]
> >> [ perf record: Captured and wrote 1.129 MB perf.data (3531 samples) ]
> >> [root@]# ~/perf script | head
> >> swapper     0 [000] 1250675.051971:          1 cycles:ppp:
> >>         ffffffff81009e15 [unknown] ([unknown])
> >>         ffffffff81196b19 [unknown] ([unknown])
> >>         ffffffff81196579 [unknown] ([unknown])
> >>         ffffffff81110ca7 [unknown] ([unknown])
> >>         ffffffff81a01f4a [unknown] ([unknown])
> >>         ffffffff81a017bf [unknown] ([unknown])
> >>         ffffffff8180e17a [unknown] ([unknown])
> >>
> >> perf-record with --overwrite does NOT have this issue.
> >>
> >> After digging into this, I found this issue is introduced by commit
> >> a73e24d240bc136619d382b1268f34d75c9d25ce.
> >>
> >> Reverting this commit does fix this issue. However, on a second thought,
> >> I feel it is probably better just drop --tail-synthesize, as it doesn't
> >> make much sense without --overwrite. All we need is to do tail_synthesize
> >> when --overwrite is set.
> >>
> 
> Some cases we use --overwrite without --tail-synthesize. How about setting
> --tail-synthesize when selecting --overwrite by default, throw a warning
> when --overwrite is not set and leave a --no-tail-synthesize option?

sounds good to me

thanks,
jirka
