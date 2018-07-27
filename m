Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D463C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47FF20883
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:16:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47FF20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbeG0DgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:36:06 -0400
Received: from www62.your-server.de ([213.133.104.62]:39443 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeG0DgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:36:06 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fisIt-0006hY-FV; Fri, 27 Jul 2018 04:16:27 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fisIt-000X4D-4a; Fri, 27 Jul 2018 04:16:27 +0200
Subject: Re: [PATCH v2] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        wangnan0@huawei.com
References: <20180725072126.2232-1-tmricht@linux.ibm.com>
 <20180725184835.5d37bef4@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <08b6ed57-40a4-7468-b78d-f2a2c5ab10a8@iogearbox.net>
Date:   Fri, 27 Jul 2018 04:16:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180725184835.5d37bef4@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24786/Fri Jul 27 02:41:39 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 03:48 AM, Jakub Kicinski wrote:
> On Wed, 25 Jul 2018 09:21:26 +0200, Thomas Richter wrote:
>> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")
> 
> Hmm.. are you sure it's not 531b014e7a2f ("tools: bpf: make use of
> reallocarray") that caused the issue?  That commit made us switch from
> XSI-compliant to GNU-specific strerror_r() implementation..
> 
> /me checks
> 
> Yes it looks like 531b014e7a2f~ builds just fine.
> 
> Daniel, did you try to apply v1 to the bpf tree?  Perhaps there is a
> confusion about the trees here, if this is caused by my recent change
> it's a bpf-next material.  strerror() works, but strerror_r() seems
> nicer, so perhaps we could keep it if the patch worked in bpf-next?

Yeah indeed, the issue is only in bpf-next. When I compile libbpf from
bpf tree with the below flags then it's all good.

Agree that we should rather use strerror_r() given this is a library.

>> causes a compiler error when building the perf tool in the linux-next tree.
>> I compile it using a FEDORA 28 installation, my gcc compiler version:
>> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>>
>> The file that causes the error is tools/lib/bpf/libbpf.c
>>
>> Here is the error message:
[...]
>> @@ -2334,7 +2331,7 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>>  	__u64 data_tail = header->data_tail;
>>  	__u64 data_head = header->data_head;
>>  	void *base, *begin, *end;
>> -	int ret;
>> +	int ret = 0;
>>  
>>  	asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
>>  	if (data_head == data_tail)
> 
> This looks like a separate issue.  The ret variable should really be
> enum bpf_perf_event_ret, so could you please initialize it to one of the
> values of this enum?
> 
> The uninitilized condition can only happen if (data_head != data_tail)
> but at the same time (data_head % size == data_tail % size) which
> should never really happen...  Perhaps initializing to
> LIBBPF_PERF_EVENT_ERROR would make sense?
> 
> Or better still adding:
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index f732237610e5..fa5a25945f19 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2289,6 +2289,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>  
>         begin = base + data_tail % size;
>         end = base + data_head % size;
> +       if (being == end)
> +               return LIBBPF_PERF_EVENT_ERROR;

Sounds good to me.

>         while (begin != end) {
>                 struct perf_event_header *ehdr;
> 

