Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADAFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A812075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 12:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7A812075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbeJHTs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 15:48:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJHTs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 15:48:57 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93271C050DFE;
        Mon,  8 Oct 2018 12:37:26 +0000 (UTC)
Received: from krava (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id E32E320165DD;
        Mon,  8 Oct 2018 12:37:24 +0000 (UTC)
Date:   Mon, 8 Oct 2018 14:37:24 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/3]: perf util: map data buffer for preserving
 collected data
Message-ID: <20181008123724.GC18757@krava>
References: <7d42aa80-8e69-44e4-b963-e8ef89df2099@linux.intel.com>
 <0ff162a6-67ab-9e73-8d7e-fa57c932ee45@linux.intel.com>
 <20181008105049.GC17270@krava>
 <43747adb-4591-e0ff-f173-525a5f5d47b4@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43747adb-4591-e0ff-f173-525a5f5d47b4@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 08 Oct 2018 12:37:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 02:55:13PM +0300, Alexey Budankov wrote:
> Hi,
> 
> On 08.10.2018 13:50, Jiri Olsa wrote:
> > On Mon, Oct 08, 2018 at 09:14:29AM +0300, Alexey Budankov wrote:
> >>
> <SNIP>
> >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> >> index f6d1a03c7523..2e90f4ce9214 100644
> >> --- a/tools/perf/Makefile.config
> >> +++ b/tools/perf/Makefile.config
> >> @@ -355,6 +355,11 @@ endif # NO_LIBELF
> >>  
> >>  ifeq ($(feature-glibc), 1)
> >>    CFLAGS += -DHAVE_GLIBC_SUPPORT
> >> +  ifndef NO_AIO
> > 
> > hum, do we need NO_AIO? we have the --aio option to enable that right?
> 
> Right. Enable that *in runtime*.
> 
> > I guess BIONIC does not support aio, but but will it fail when it's
> > compiled in there?
> 
> Please see updated section of the cover letter for more information 
> regarding this. Possible compilation issues is that's why we better 
> have this capability in advance:
>   
>   objdump -T tools/perf/perf | grep aio
> 
>   0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_suspend64
>   0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_return64
>   0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_error64
>   0000000000000000      DF *UND*	0000000000000000  GLIBC_2.2.5 aio_write64
> 
> IMHO, it is worth implementing NO_AIO define.

ok, if there are c libs that won't compile with that,
then sure, we need it

thanks,
jirka
