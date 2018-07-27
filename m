Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1F2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BA420673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BA420673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbeG0Tw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 15:52:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:37864 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388836AbeG0Tw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 15:52:56 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj7Uo-0004Ug-Jv; Fri, 27 Jul 2018 20:29:46 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fj7Uo-000RsU-9J; Fri, 27 Jul 2018 20:29:46 +0200
Subject: Re: [PATCH v2] perf build: Build error in libbpf with
 EXTRA_CFLAGS="-Wp,-D_FORTIFY_SOURCE=2 -O2"
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     ast@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        wangnan0@huawei.com
References: <20180725072126.2232-1-tmricht@linux.ibm.com>
 <20180725184835.5d37bef4@cakuba.netronome.com>
 <08b6ed57-40a4-7468-b78d-f2a2c5ab10a8@iogearbox.net>
 <325e3d58-89fb-1b50-8865-22c6f372671a@linux.ibm.com>
 <20180727105757.2d851920@cakuba.netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d3bed01d-2a85-e5bf-aea2-c5e5b7cbff61@iogearbox.net>
Date:   Fri, 27 Jul 2018 20:29:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180727105757.2d851920@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24788/Fri Jul 27 18:45:51 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/27/2018 07:57 PM, Jakub Kicinski wrote:
> On Fri, 27 Jul 2018 09:22:03 +0200, Thomas-Mich Richter wrote:
>> On 07/27/2018 04:16 AM, Daniel Borkmann wrote:
>>> On 07/26/2018 03:48 AM, Jakub Kicinski wrote:  
>>>> On Wed, 25 Jul 2018 09:21:26 +0200, Thomas Richter wrote:  
>>>>> commit a5b8bd47dcc57 ("bpf tools: Collect eBPF programs from their own sections")  
>>>>
>>>> Hmm.. are you sure it's not 531b014e7a2f ("tools: bpf: make use of
>>>> reallocarray") that caused the issue?  That commit made us switch from
>>>> XSI-compliant to GNU-specific strerror_r() implementation..
>>>>
>>>> /me checks
>>>>
>>>> Yes it looks like 531b014e7a2f~ builds just fine.
>>>>
>>>> Daniel, did you try to apply v1 to the bpf tree?  Perhaps there is a
>>>> confusion about the trees here, if this is caused by my recent change
>>>> it's a bpf-next material.  strerror() works, but strerror_r() seems
>>>> nicer, so perhaps we could keep it if the patch worked in bpf-next?  
>>>
>>> Yeah indeed, the issue is only in bpf-next. When I compile libbpf from
>>> bpf tree with the below flags then it's all good> 
>>> Agree that we should rather use strerror_r() given this is a library.  
>>
>> Are you sure to stick with strerror_r? I ask because it is the only
>> occurence of strerror_r in this file. All other error messages use strerror
>> as in:
>> pr_warning("failed to create map (name: '%s'): %s\n",
>>                                    map->name,
>>                                    strerror(errno));
>>
>> $ fgrep strerror tools/lib/bpf/libbpf.c
>>                                         strerror(errno));
>>           issue I try to solve--->  strerror_r(-err, errmsg, sizeof(errmsg));
>>                                    map->name, strerror(errno), errno);
>>                                    strerror(errno));
>>         pr_warning("load bpf program failed: %s\n", strerror(errno));
>>                 pr_warning("failed to statfs %s: %s\n", dir, strerror(errno));
>>                 pr_warning("failed to pin program: %s\n", strerror(errno));
>>                 pr_warning("failed to mkdir %s: %s\n", path, strerror(-err));
>>                 pr_warning("failed to pin map: %s\n", strerror(errno));
>> $
>>
>> The next issue with strerror_r is to assign the return value to a variable.
>> Then we end up with variable set but not used:
>> libbpf.c: In function ‘bpf_object__elf_collect’:
>> libbpf.c:809:35: error: variable ‘cp’ set but not used [-Werror=unused-but-set-variable]
>>      char errmsg[STRERR_BUFSIZE], *cp;
>>                                    ^
>> cc1: all warnings being treated as errors
> 
>        The GNU-specific strerror_r() returns a pointer to a string  containing
>        the  error  message.  This may be either a pointer to a string that the
>        function stores in buf, or a pointer to some (immutable) static  string
>        (in which case buf is unused).  If the function stores a string in buf,
>        then at most buflen bytes are stored (the string may  be  truncated  if
>        buflen is too small and errnum is unknown).  The string always includes
>        a terminating null byte ('\0').
> 
> IOW you gotta use the return value.
> 
>> Here is the source:
>>                        if (err) {
>>                                 char errmsg[STRERR_BUFSIZE], *cp;
>>
>>                                 cp = strerror_r(-err, errmsg, sizeof(errmsg));
>>                                 pr_warning("failed to alloc program %s (%s): %s",
>>                                            name, obj->path, errmsg);
>>                         }
>>
>> To fix this requires something like:
>>                                pr_warning("failed to alloc program %s (%s): %s",
>>                                            name, obj->path, cp);
> 
> This looks correct.
> 
>> And after pr_warning() is done, the local array errmsg is deleted.
>>
>> A lot of overkill in my opinion, unless I miss something.
> 
> IMO using potentially mutli-thread unsafe functions in a library is not
> optimal, we should strive to convert the other instances of strerror()
> rather than move the other way.

Yeah, fully agree. We should convert the other ones as well over to use
strerror_r().

Thanks,
Daniel
