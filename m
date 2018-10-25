Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14066ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA22075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIuAY5VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFA22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeJYTo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:44:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727308AbeJYTo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:44:58 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D81BA2075D;
        Thu, 25 Oct 2018 11:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465960;
        bh=8eCAFtS3OEr+w/IQgXAQ8+ULC7/p1fVM8Joz0csrUDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIuAY5VI81zLaP63GKZ1BY8pS2Di1s4aUiaUYHrIoW6u3SXv6EQQEBZKlonzLiBwj
         s3+sQdN9SmQustMBEnEJTzbY438xDb6EhqOXZHfmLJAxQOq0Lb+QCkCZpc299lWf3O
         0X+XmrE7Ph7pd1OPImJshf7aDlWPCxV4795ZMjlQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id CC0D1142C5F; Thu, 25 Oct 2018 08:12:37 -0300 (-03)
Date:   Thu, 25 Oct 2018 08:12:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
Message-ID: <20181025111237.GA3782@kernel.org>
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com>
 <20181015101748.GB29504@krava>
 <f61f8e1f-c411-923f-96bc-c8075a3a698c@linux.intel.com>
 <20181025085439.GA4722@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025085439.GA4722@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 25, 2018 at 10:54:39AM +0200, Jiri Olsa escreveu:
> On Thu, Oct 25, 2018 at 10:59:36AM +0300, Alexey Budankov wrote:
> > Hi,
> > 
> > On 15.10.2018 13:17, Jiri Olsa wrote:
> > > On Mon, Oct 15, 2018 at 09:26:09AM +0300, Alexey Budankov wrote:
> > >>
> > >> Currently in record mode the tool implements trace writing serially. 
> > >> The algorithm loops over mapped per-cpu data buffers and stores 
> > >> ready data chunks into a trace file using write() system call.
> > >>
> > >> At some circumstances the kernel may lack free space in a buffer 
> > >> because the other buffer's half is not yet written to disk due to 
> > >> some other buffer's data writing by the tool at the moment.
> > >>
> > >> Thus serial trace writing implementation may cause the kernel 
> > >> to loose profiling data and that is what observed when profiling 
> > >> highly parallel CPU bound workloads on machines with big number 
> > >> of cores.
> > >>
> > >> Experiment with profiling matrix multiplication code executing 128 
> > >> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> > >> demonstrates data loss metrics value of 98%:
> > >>
> > >> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
> > >>     --call-graph dwarf,1024 --user-regs=IP,SP,BP --switch-events \
> > >>     -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
> > >>     matrix.gcc
> > > 
> > > I ran above on 24 cpu server and could not see the gain,
> > > but I guess I'd need much bigger server to see that
> > > 
> > > anyway, the code is now nicely separated, and given the
> > > advertised results below I have no objections
> > > 
> > > Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > Is the plan Jiri mentioned earlier to have it as a stand alone patch kit 
> > or upstream the changes into mainline?
> 
> I haven't heard from Arnaldo yet, but I'd like to have this merged in

I'll try and go over it today.

- Arnaldo
