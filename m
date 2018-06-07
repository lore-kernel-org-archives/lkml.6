Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +8UtGKWCGFviQgAAmS7hNA
	; Thu, 07 Jun 2018 01:00:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9AD946089E; Thu,  7 Jun 2018 01:00:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1E402605BD;
	Thu,  7 Jun 2018 01:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E402605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeFGBA3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:00:29 -0400
Received: from mga11.intel.com ([192.55.52.93]:40678 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752295AbeFGBA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:00:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2018 18:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,485,1520924400";
   d="scan'208";a="54597682"
Received: from yjin15-mobl.ccr.corp.intel.com (HELO [10.239.161.30]) ([10.239.161.30])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jun 2018 18:00:26 -0700
Subject: Re: [PATCH v2 2/3] perf script python: Add more PMU fields
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kan Liang <kan.liang@intel.com>
References: <1527843663-32288-1-git-send-email-yao.jin@linux.intel.com>
 <1527843663-32288-3-git-send-email-yao.jin@linux.intel.com>
 <20180606183657.GI24381@kernel.org>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <08e12673-848e-eedb-fb01-38fb9f760c8b@linux.intel.com>
Date: Thu, 7 Jun 2018 09:00:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606183657.GI24381@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/2018 2:36 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 01, 2018 at 05:01:02PM +0800, Jin Yao escreveu:
> 
> <SNIP>
> 
>> +static int get_symoff(struct symbol *sym, struct addr_location *al,
>> +		      bool print_off, char *bf, int size)
>> +{
>> +	unsigned long offset;
>> +
>> +	if (!sym || !sym->name)
>> +		return scnprintf(bf, size, "%s", "[unknown]");
> 
>    52    54.22 ubuntu:17.04                  : FAIL gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
> 
>    CC       /tmp/build/perf/util/scripting-engines/trace-event-python.o
> util/scripting-engines/trace-event-python.c:534:20: error: address of array 'sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>          if (!sym || !sym->name)
>                      ~~~~~~^~~~
> 1 error generated.
> mv: cannot stat '/tmp/build/perf/util/scripting-engines/.trace-event-python.o.tmp': No such file or directory
> /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/scripting-engines/trace-event-python.o' failed
> make[5]: *** [/tmp/build/perf/util/scripting-engines/trace-event-python.o] Error 1
> 
> Because:
> 
> struct symbol {
>          struct rb_node  rb_node;
>          u64             start;
>          u64             end;
>          u16             namelen;
> <SNIP>
>          char            name[0];
> };
> 
> It sym->name is not a pointer, in symbol's constructor we have:
> 
> struct symbol *symbol__new(u64 start, u64 len, u8 binding, u8 type, const char *name)
> {
>          size_t namelen = strlen(name) + 1;
>          struct symbol *sym = calloc(1, (symbol_conf.priv_size +
>                                          sizeof(*sym) + namelen));
>          if (sym == NULL)
>                  return NULL;
> <SNIP>
>          sym->namelen = namelen - 1;
>          memcpy(sym->name, name, namelen);
> 
>          return sym;
> }
> 
> So it is at least 1 char long, the test above should be:
> 
> 	if (!sym || !sym->name[0])
> 		return scnprintf(bf, size, "%s", "[unknown]");
> 
> I'm fixing this up here.
> 
> - Arnaldo
> 

Oh, yes, my mistake, very sorry about that.

Thanks for helping me to fix this.

Thanks
Jin Yao
