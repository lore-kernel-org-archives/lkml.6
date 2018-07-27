Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CEC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E69C20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E69C20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389292AbeG0Uy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:54:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:56673 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388467AbeG0Uy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:54:28 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj8S9-0000nV-7y; Fri, 27 Jul 2018 21:31:05 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj8S8-00054A-Ty; Fri, 27 Jul 2018 21:31:05 +0200
Subject: Re: [PATCH] perf build: Build error in libbpf missing initialization
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Thomas Richter <tmricht@linux.ibm.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com
References: <20180727082126.87530-1-tmricht@linux.ibm.com>
 <20180727105923.2d5da6aa@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c8409ab8-69df-17f4-9da3-610c60143d9a@iogearbox.net>
Date:   Fri, 27 Jul 2018 21:31:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180727105923.2d5da6aa@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24788/Fri Jul 27 18:45:51 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 07:59 PM, Jakub Kicinski wrote:
> On Fri, 27 Jul 2018 10:21:26 +0200, Thomas Richter wrote:
>> In linux-next tree compiling the perf tool with additional make flags
>> "EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
>> causes a compiler error. It is the warning
>> 	'variable may be used uninitialized'
>> which is treated as error:
>>
>> I compile it using a FEDORA 28 installation, my gcc compiler version:
>> gcc (GCC) 8.0.1 20180324 (Red Hat 8.0.1-0.20)
>>
>> The file that causes the error is tools/lib/bpf/libbpf.c
>>
>> Here is the error message:
>>
>> [root@p23lp27] # make V=1 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
>> [...]
>> Makefile.config:849: No openjdk development package found, please
>>    install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
>> Warning: Kernel ABI header at 'tools/include/uapi/linux/if_link.h'
>>         differs from latest version at 'include/uapi/linux/if_link.h'
>>   CC       libbpf.o
>> libbpf.c: In function ‘bpf_perf_event_read_simple’:
>> libbpf.c:2342:6: error: ‘ret’ may be used uninitialized in this
>> 			function [-Werror=maybe-uninitialized]
>>   int ret;
>>       ^
>> cc1: all warnings being treated as errors
>> mv: cannot stat './.libbpf.o.tmp': No such file or directory
>> /home6/tmricht/linux-next/tools/build/Makefile.build:96: recipe for target 'libbpf.o' failed
>>
>> Fix this warning and add an addition check at the beginning
>> of the while loop.
>>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>
>> Suggested-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> 
> Ah, you already sent this, LGTM, thanks Thomas!
> 
>>  tools/lib/bpf/libbpf.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 73465caa33ba..66965ca96113 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -2349,6 +2349,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
>>  
>>  	begin = base + data_tail % size;
>>  	end = base + data_head % size;
>> +	if (begin == end)
>> +		return LIBBPF_PERF_EVENT_ERROR;
>>  
>>  	while (begin != end) {
>>  		struct perf_event_header *ehdr;

One question though, any objections to go for something like the below instead?
I doubt we ever hit this in a 'normal' situation, and given we already test for
the begin and end anyway, we could just avoid the extra test altogether. I could
change it to the below if you're good as well (no need to resend anything):

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d881d37..1aafdbe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2273,8 +2273,8 @@ bpf_perf_event_read_simple(void *mem, unsigned long size,
        volatile struct perf_event_mmap_page *header = mem;
        __u64 data_tail = header->data_tail;
        __u64 data_head = header->data_head;
+       int ret = LIBBPF_PERF_EVENT_ERROR;
        void *base, *begin, *end;
-       int ret;

        asm volatile("" ::: "memory"); /* in real code it should be smp_rmb() */
        if (data_head == data_tail)

Thanks,
Daniel
