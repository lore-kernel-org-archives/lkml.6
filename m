Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B676C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C9620664
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 21:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C9620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeJ2F4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:56:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeJ2F4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:56:07 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 805EAC0C0F8C;
        Sun, 28 Oct 2018 21:10:17 +0000 (UTC)
Received: from krava (ovpn-204-78.brq.redhat.com [10.40.204.78])
        by smtp.corp.redhat.com (Postfix) with SMTP id CA92C1047ADB;
        Sun, 28 Oct 2018 21:10:09 +0000 (UTC)
Date:   Sun, 28 Oct 2018 22:10:08 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso
 symbols lookup
Message-ID: <20181028211008.GA3145@krava>
References: <20181017225501.32150-1-acme@kernel.org>
 <20181017225501.32150-12-acme@kernel.org>
 <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
 <87a7n070tj.fsf@intel.com>
 <20181027110541.GA25072@krava>
 <87bm7fgnhz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bm7fgnhz.fsf@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 28 Oct 2018 21:10:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 01:09:44PM -0700, Vinicius Costa Gomes wrote:
> Hi Jirka,
> 
> Jiri Olsa <jolsa@redhat.com> writes:
> 
> > On Fri, Oct 26, 2018 at 04:19:52PM -0700, Vinicius Costa Gomes wrote:
> >> Hi,
> >> 
> >> Adrian Hunter <adrian.hunter@intel.com> writes:
> >> 
> >> > On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
> >> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >> >> 
> >> >> David reports that:
> >> >> 
> >> >> <quote>
> >> >> Perf has this hack where it uses the kernel symbol map as a backup when
> >> >> a symbol can't be found in the user's symbol table(s).
> >> >
> >> > I don't think this is a complete fix because it exposes new problems.
> >> 
> >> This commit broke function name resolution for 'perf record -g' for me.
> >> 
> >> What I mean is, with this commit applied:
> >> 
> >> $ ./tools/perf/perf record -g -- sleep 1
> >> 
> >> $ ./tools/perf/perf report
> >> 
> >> 'perf report' doesn't seem to be able to show the function names of the
> >> trace.
> >> 
> >> If I revert this commit, function names are resolved fine.
> >
> > that commit just showed up some places where we have the
> > ip resolve wrong.. would attached patch fix it for you?
> 
> Thank you for your patch.
> 
> I can some difference in the output, but I wouldn't say that it's fixed.
> 
> Here are some samples, if it's useful somehow:
> 
> https://gist.github.com/vcgomes/985626705e0968b973e426964f86a4b0
> 
> The "ping" tests were done running
> 
> $ sudo ./tools/perf/perf record -g -- ping -f -c 1000 127.0.0.1
> 
> And the "sleep" tests were done running
> 
> $ sudo ./tools/perf/perf record -g -- /bin/sleep 1

ugh, I tried with 'sudo ./perf record -g' and it looks
like it matter to callchains if there's a workload

Adrian said he's preparing complex patch for this
let's wait for his changes

thanks,
jirka
