Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D7BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4992320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4992320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeHAANQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:13:16 -0400
Received: from www62.your-server.de ([213.133.104.62]:37279 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbeHAANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:13:16 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkdAB-0007Mz-Gj; Wed, 01 Aug 2018 00:30:43 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkdAB-0006gi-Bb; Wed, 01 Aug 2018 00:30:43 +0200
Subject: Re: [PATCH v2] Add BPF_SYNCHRONIZE_MAPS bpf(2) command
To:     Joel Fernandes <joelaf@google.com>, Y Song <ys114321@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
References: <CAADnVQL4twmGF3d26TgLsQJvnqLnM0F6hqL_42DSs95OuZ1y9A@mail.gmail.com>
 <20180731020122.GA22311@joelaf.mtv.corp.google.com>
 <20180731020629.GB22311@joelaf.mtv.corp.google.com>
 <CAH3MdRU5nn5g0bexrLWU3-UrxSJfrVF0-A2v2VJGAeBDKY=+Zg@mail.gmail.com>
 <20180731215651.GA141321@joelaf.mtv.corp.google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f192d7f-5279-5a1a-704a-8cac4f6df0e4@iogearbox.net>
Date:   Wed, 1 Aug 2018 00:30:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180731215651.GA141321@joelaf.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24800/Tue Jul 31 18:43:36 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 11:56 PM, Joel Fernandes wrote:
> On Mon, Jul 30, 2018 at 09:03:18PM -0700, Y Song wrote:
>> On Mon, Jul 30, 2018 at 7:06 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>>> On Mon, Jul 30, 2018 at 07:01:22PM -0700, Joel Fernandes wrote:
>>>> On Sun, Jul 29, 2018 at 06:51:18PM +0300, Alexei Starovoitov wrote:
>>>>> On Thu, Jul 26, 2018 at 7:51 PM, Daniel Colascione <dancol@google.com> wrote:
>>>>>> BPF_SYNCHRONIZE_MAPS waits for the release of any references to a BPF
>>>>>> map made by a BPF program that is running at the time the
>>>>>> BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command is
>>>>>> to provide a means for userspace to replace a BPF map with another,
>>>>>> newer version, then ensure that no component is still using the "old"
>>>>>> map before manipulating the "old" map in some way.
>>>>>>
>>>>>> Signed-off-by: Daniel Colascione <dancol@google.com>
>>>>>> ---
>>>>>>  include/uapi/linux/bpf.h |  9 +++++++++
>>>>>>  kernel/bpf/syscall.c     | 13 +++++++++++++
>>>>>>  2 files changed, 22 insertions(+)
>>>>>>
>>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>>> index b7db3261c62d..5b27e9117d3e 100644
>>>>>> --- a/include/uapi/linux/bpf.h
>>>>>> +++ b/include/uapi/linux/bpf.h
>>>>>> @@ -75,6 +75,14 @@ struct bpf_lpm_trie_key {
>>>>>>         __u8    data[0];        /* Arbitrary size */
>>>>>>  };
>>>>>>
>>>>>> +/* BPF_SYNCHRONIZE_MAPS waits for the release of any references to a
>>>>>> + * BPF map made by a BPF program that is running at the time the
>>>>>> + * BPF_SYNCHRONIZE_MAPS command is issued. The purpose of this command
>>>>>
>>>>> that doesn't sound right to me.
>>>>> such command won't wait for the release of the references.
>>>>> in case of map-in-map the program does not hold
>>>>> the references to inner map (only to outer map).
>>>>
>>>> I didn't follow this completely.
>>>>
>>>> The userspace program is using the inner map per your description of the
>>>> algorithm for using map-in-map to solve the race conditions that this patch
>>>> is trying to address:
>>>>
>>>> If you don't mind, I copy-pasted it below from your netdev post:
>>>>
>>>> if you use map-in-map you don't need extra boolean map.
>>>> 0. bpf prog can do
>>>>    inner_map = lookup(map_in_map, key=0);
>>>>    lookup(inner_map, your_real_key);
>>>> 1. user space writes into map_in_map[0] <- FD of new map
>>>> 2. some cpus are using old inner map and some a new
>>>> 3. user space does sys_membarrier(CMD_GLOBAL) which will do synchronize_sched()
>>>>    which in CONFIG_PREEMPT_NONE=y servers is the same as synchronize_rcu()
>>>>    which will guarantee that progs finished.
>>>> 4. scan old inner map
>>>>
>>>> In step 2, as you mentioned there are CPUs using different inner maps. So
>>>> could you clarify how the synchronize_rcu mechanism will even work if you're
>>>> now saying "program does not hold references to the inner maps"?
>>
>> The program only held references to the outer maps, and the outer map
>> held references to the inner maps. The user space program can add/remove
>> the inner map for a particular outer map while the prog <-> outer-map
>> relationship is not changed.
> 
> My definition of "reference" in this context is protection by rcu_read_lock.
> 
> So I was concerned the above map-in-map access isn't protected as such when
> Alexei said "program doesn't have reference on inner map" in the above steps.
> Maybe I misunderstood what is the meaning of reference here.
> 
> To make the map-in-map thing to work for Chenbo/Lorenzo's usecase, both the
> access of outer map at key=0 and the inner map have to protect by
> rcu_read_lock so that the membarrier call will work.
> 
> So basically step 0 in the steps above should be rcu_read_lock protected to
> satisfy Chenbo/Lorenzo's usecase.
> 
> I know today the entire program is run as preempt disabled (unless something
> changed) so this shouldn't be a problem, but in the future if the verifier is
> doing similar things at a finer grainer level, then the above has to be
> taken into consideration.
> 
> Does that make sense or am I missing something?

All BPF programs are required to run under rcu_read_lock today, so that
assumption holds. Should this ever change in future, then this constraint
of course needs to be taken into consideration.

Thanks,
Daniel
