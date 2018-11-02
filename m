Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7216DC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4429B2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4429B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbeKCBUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:20:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:18125 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbeKCBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:20:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 09:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="270895574"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2018 09:13:00 -0700
Received: from [10.252.30.191] (abudanko-mobl.ccr.corp.intel.com [10.252.30.191])
        by linux.intel.com (Postfix) with ESMTP id 687E15802E4;
        Fri,  2 Nov 2018 09:12:58 -0700 (PDT)
Subject: Re: [PATCH v14 3/3]: perf record: extend trace writing to multi AIO
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        open list <linux-kernel@vger.kernel.org>
References: <d6bd3626-8c7c-ca12-8adf-31fe15726446@linux.intel.com>
 <6295b798-f710-0251-3122-bbb5c694f00e@linux.intel.com>
 <CAPhsuW52Vfsx7gfPppxH_E=6Y6xtMrWzCAx0=aJk0odm_q=ZzA@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fd54bec6-83f0-e585-1087-dbc33da3c519@linux.intel.com>
Date:   Fri, 2 Nov 2018 19:12:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPhsuW52Vfsx7gfPppxH_E=6Y6xtMrWzCAx0=aJk0odm_q=ZzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 01.11.2018 21:30, Song Liu wrote:
> On Sun, Oct 14, 2018 at 11:47 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
<SNIP>
>>
>>
>>  static int nr_cblocks_default = 1;
>>
>>  static int record__aio_parse(const struct option *opt,
>> -                            const char *str __maybe_unused,
>> +                            const char *str,
>>                              int unset)
>>  {
>>         struct record_opts *opts = (struct record_opts *)opt->value;
>>
>> -       if (unset)
>> +       if (unset) {
>>                 opts->nr_cblocks = 0;
>> -       else
>> -               opts->nr_cblocks = nr_cblocks_default;
>> +       } else {
>> +               if (str)
>> +                       opts->nr_cblocks = strtol(str, NULL, 0);
>> +               if (!opts->nr_cblocks)
>> +                       opts->nr_cblocks = nr_cblocks_default;
>> +       }
>>
>>         return 0;
>>  }
>>  #else /* HAVE_AIO_SUPPORT */
<SNIP>
>> @@ -1492,6 +1517,13 @@ static int perf_record_config(const char *var, const char *value, void *cb)
>>                 var = "call-graph.record-mode";
>>                 return perf_default_config(var, value, cb);
>>         }
>> +#ifdef HAVE_AIO_SUPPORT
>> +       if (!strcmp(var, "record.aio")) {
>> +               rec->opts.nr_cblocks = strtol(value, NULL, 0);
>> +               if (!rec->opts.nr_cblocks)
>> +                       rec->opts.nr_cblocks = nr_cblocks_default;
>> +       }
>> +#endif
>>
>>         return 0;
>>  }
>> @@ -1884,8 +1916,8 @@ static struct option __record_options[] = {
>>         OPT_BOOLEAN(0, "dry-run", &dry_run,
>>                     "Parse options then exit"),
>>  #ifdef HAVE_AIO_SUPPORT
>> -       OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
>> -                    NULL, "Enable asynchronous trace writing mode",
>> +       OPT_CALLBACK_OPTARG(0, "aio", &record.opts,
>> +                    &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
>>                      record__aio_parse),
>>  #endif
>>         OPT_END()
>> @@ -2080,6 +2112,8 @@ int cmd_record(int argc, const char **argv)
>>                 goto out;
>>         }
>>
>> +       if (rec->opts.nr_cblocks > 4)
>> +               rec->opts.nr_cblocks = 4;
> nit: I feel this logic belongs to record__aio_parse(). And we should have
> 
> static int nr_cblocks_max = 4;

This looks reasonable.

Thanks,
Alexey

> 
> Other than this
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
