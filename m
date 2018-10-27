Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4179CC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB7792085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 20:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7792085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJ1Evw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 00:51:52 -0400
Received: from mga14.intel.com ([192.55.52.115]:17890 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbeJ1Evw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 00:51:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2018 13:09:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,433,1534834800"; 
   d="scan'208";a="276147217"
Received: from aemtb0042.gar.corp.intel.com (HELO ellie) ([10.254.186.127])
  by fmsmga006.fm.intel.com with ESMTP; 27 Oct 2018 13:09:44 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso symbols lookup
In-Reply-To: <20181027110541.GA25072@krava>
References: <20181017225501.32150-1-acme@kernel.org> <20181017225501.32150-12-acme@kernel.org> <4c682937-3cee-6974-0970-68610e13ad37@intel.com> <87a7n070tj.fsf@intel.com> <20181027110541.GA25072@krava>
Date:   Sat, 27 Oct 2018 13:09:44 -0700
Message-ID: <87bm7fgnhz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jirka,

Jiri Olsa <jolsa@redhat.com> writes:

> On Fri, Oct 26, 2018 at 04:19:52PM -0700, Vinicius Costa Gomes wrote:
>> Hi,
>> 
>> Adrian Hunter <adrian.hunter@intel.com> writes:
>> 
>> > On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
>> >> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>> >> 
>> >> David reports that:
>> >> 
>> >> <quote>
>> >> Perf has this hack where it uses the kernel symbol map as a backup when
>> >> a symbol can't be found in the user's symbol table(s).
>> >
>> > I don't think this is a complete fix because it exposes new problems.
>> 
>> This commit broke function name resolution for 'perf record -g' for me.
>> 
>> What I mean is, with this commit applied:
>> 
>> $ ./tools/perf/perf record -g -- sleep 1
>> 
>> $ ./tools/perf/perf report
>> 
>> 'perf report' doesn't seem to be able to show the function names of the
>> trace.
>> 
>> If I revert this commit, function names are resolved fine.
>
> that commit just showed up some places where we have the
> ip resolve wrong.. would attached patch fix it for you?

Thank you for your patch.

I can some difference in the output, but I wouldn't say that it's fixed.

Here are some samples, if it's useful somehow:

https://gist.github.com/vcgomes/985626705e0968b973e426964f86a4b0

The "ping" tests were done running

$ sudo ./tools/perf/perf record -g -- ping -f -c 1000 127.0.0.1

And the "sleep" tests were done running

$ sudo ./tools/perf/perf record -g -- /bin/sleep 1


--
Vinicius
