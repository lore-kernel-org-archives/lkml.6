Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D32EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6E120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbfA2LjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:39:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:29672 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbfA2LjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:39:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 03:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="295339176"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 29 Jan 2019 03:39:03 -0800
Received: from [10.125.252.22] (abudanko-mobl.ccr.corp.intel.com [10.125.252.22])
        by linux.intel.com (Postfix) with ESMTP id 85BB658042B;
        Tue, 29 Jan 2019 03:39:01 -0800 (PST)
Subject: Re: [PATCH v2 0/4] perf: enable compression of record mode trace to
 save storage space
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b834df0e-26b5-3f8c-7a43-18f675fb7434@linux.intel.com>
 <20190129104543.GJ4344@kernel.org> <20190129105337.GA17762@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <de604869-4d2e-689c-39ba-368d444c809a@linux.intel.com>
Date:   Tue, 29 Jan 2019 14:39:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190129105337.GA17762@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 29.01.2019 13:53, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 29, 2019 at 11:45:43AM +0100, Arnaldo Carvalho de Melo escreveu:
>> Em Mon, Jan 28, 2019 at 09:40:28AM +0300, Alexey Budankov escreveu:
>>> The patch set implements runtime trace compression for record mode and 
>>> trace file decompression for report mode. Zstandard API [1] is used for 
>>> compression/decompression of data that come from perf_events kernel 
>>
>> Interesting, wasn't aware of this zstd library, I wonder if we can add
>> it and switch the other compression libraries we link against, so that
>> we're not adding one more library to the dep list of perf but removing
>> some instead, do you think this would be possible?

Replacing of incorporated compression APIs was not evaluated or tested in 
the scope of this patch set work. However according to their numbers in the 
docs and the numbers that we have got during testing Zstd API outperforms 
the exiting compression libraries as in terms of speed as in terms of 
compression ratio (at least libz). Backward compatibility needs to be taken
into account so that old perf files would open by newer perf tool versions.

-Alexey

>>
>>   $ ldd ~/bin/perf | wc -l
>>   30
>>   $ ldd ~/bin/perf | grep z
>> 	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f3dcc356000)
>> 	libz.so.1 => /lib64/libz.so.1 (0x00007f3dcb2aa000)
>> 	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f3dcb218000)
>>   $
>>
>> Humm, from the github page it says:
>>
>> -----
>> The project is provided as an open-source dual BSD and GPLv2 licensed C
>> library, and a command line utility producing and decoding .zst, .gz,
>> .xz and .lz4 files. Should your project require another programming
>> language, a list of known ports and bindings is provided on Zstandard
>> homepage.
>> -----
>>
>> So it would cover just liblzma and libz, right?
> 
> Nevermind;
> 
> [acme@quaco perf]$ zstdcat ~/git/perf/perf-5.0.0-rc2.tar.xz
> zstd: /home/acme/git/perf/perf-5.0.0-rc2.tar.xz: xz/lzma file cannot be uncompressed (zstd compiled without HAVE_LZMA) -- ignored
> 
> So it handles those formats, _if_ linked with those libraries, duh.
> 
> - Arnaldo
> 
