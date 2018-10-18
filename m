Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66609C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B842145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B842145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeJROVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:21:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:21293 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJROVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:21:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 23:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,395,1534834800"; 
   d="scan'208";a="79653170"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.130]) ([10.237.72.130])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2018 23:22:25 -0700
Subject: Re: [PATCH 11/11] perf tools: Stop fallbacking to kallsyms for vdso
 symbols lookup
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
References: <20181017225501.32150-1-acme@kernel.org>
 <20181017225501.32150-12-acme@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4c682937-3cee-6974-0970-68610e13ad37@intel.com>
Date:   Thu, 18 Oct 2018 09:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181017225501.32150-12-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/18 1:55 AM, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> David reports that:
> 
> <quote>
> Perf has this hack where it uses the kernel symbol map as a backup when
> a symbol can't be found in the user's symbol table(s).

I don't think this is a complete fix because it exposes new problems.  This
code caters for branches from kernel space to user space and vice versa.
That is, since there is only one cpumode so it is certain to be wrong for
either 'ip' or 'addr' when they are not both in the kernel or both in userspace.

> 
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: David Ahern <dsahern@gmail.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-cs7skq9pp0kjypiju6o7trse@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/event.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 0988eb3b844b..bc646185f8d9 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -1561,26 +1561,9 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
>  
>  		return NULL;
>  	}
> -try_again:
> +
>  	al->map = map_groups__find(mg, al->addr);
> -	if (al->map == NULL) {
> -		/*
> -		 * If this is outside of all known maps, and is a negative
> -		 * address, try to look it up in the kernel dso, as it might be
> -		 * a vsyscall or vdso (which executes in user-mode).
> -		 *
> -		 * XXX This is nasty, we should have a symbol list in the
> -		 * "[vdso]" dso, but for now lets use the old trick of looking
> -		 * in the whole kernel symbol list.
> -		 */
> -		if (cpumode == PERF_RECORD_MISC_USER && machine &&
> -		    mg != &machine->kmaps &&
> -		    machine__kernel_ip(machine, al->addr)) {
> -			mg = &machine->kmaps;
> -			load_map = true;
> -			goto try_again;
> -		}
> -	} else {
> +	if (al->map != NULL) {
>  		/*
>  		 * Kernel maps might be changed when loading symbols so loading
>  		 * must be done prior to using kernel maps.
> 

