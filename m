Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB902075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB902075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbeGRNpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:45:43 -0400
Received: from www62.your-server.de ([213.133.104.62]:48548 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbeGRNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:45:43 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1ffmBJ-00069x-1X; Wed, 18 Jul 2018 15:07:49 +0200
Received: from [62.203.87.61] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1ffmBI-000AbC-Lu; Wed, 18 Jul 2018 15:07:48 +0200
Subject: Re: [PATCH v2 bpf 3/5] bpf: bpf_prog_array_free() should take a
 generic non-rcu pointer
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Alexei Starovoitov <ast@kernel.org>
References: <20180713194114.2711-1-guro@fb.com>
 <20180713194114.2711-3-guro@fb.com>
 <41b5f919-3155-5bd4-2774-84efd58650e2@iogearbox.net>
 <20180716225715.GB3898@castle.DHCP.thefacebook.com>
 <1a40b0a8-7440-f2d2-d743-64901b5d1bfe@iogearbox.net>
 <20180717225520.GA15643@castle.DHCP.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <90bc1d99-da1b-065a-cd4f-457b7f17a533@iogearbox.net>
Date:   Wed, 18 Jul 2018 15:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180717225520.GA15643@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24760/Tue Jul 17 06:40:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 12:55 AM, Roman Gushchin wrote:
> On Wed, Jul 18, 2018 at 12:38:50AM +0200, Daniel Borkmann wrote:
>> On 07/17/2018 12:57 AM, Roman Gushchin wrote:
>>> On Tue, Jul 17, 2018 at 12:30:18AM +0200, Daniel Borkmann wrote:
>>>> On 07/13/2018 09:41 PM, Roman Gushchin wrote:
>>>>> bpf_prog_array_free() should take a generic non-rcu pointer
>>>>> as an argument, as freeing the objects assumes that we're
>>>>> holding an exclusive rights on it.
>>>>>
>>>>> rcu_access_pointer() can be used to convert a __rcu pointer to
>>>>> a generic pointer before passing it to bpf_prog_array_free(),
>>>>> if necessary.
>>>>>
>>>>> This patch eliminates the following sparse warning:
>>>>> kernel/bpf/core.c:1556:9: warning: incorrect type in argument 1 (different address spaces)
>>>>> kernel/bpf/core.c:1556:9:    expected struct callback_head *head
>>>>> kernel/bpf/core.c:1556:9:    got struct callback_head [noderef] <asn:4>*<noident>
>>>>>
>>>>> Fixes: 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")
>>>>> Signed-off-by: Roman Gushchin <guro@fb.com>
>>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>>> ---
>>>>>  drivers/media/rc/bpf-lirc.c |  6 +++---
>>>>>  include/linux/bpf.h         |  2 +-
>>>>>  kernel/bpf/cgroup.c         | 11 ++++++-----
>>>>>  kernel/bpf/core.c           |  5 ++---
>>>>>  kernel/trace/bpf_trace.c    |  8 ++++----
>>>>>  5 files changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
>>>>> index fcfab6635f9c..509b262aa0dc 100644
>>>>> --- a/drivers/media/rc/bpf-lirc.c
>>>>> +++ b/drivers/media/rc/bpf-lirc.c
>>>>> @@ -135,7 +135,7 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
>>>>>  		goto unlock;
>>>>>  
>>>>>  	rcu_assign_pointer(raw->progs, new_array);
>>>>> -	bpf_prog_array_free(old_array);
>>>>> +	bpf_prog_array_free(rcu_access_pointer(old_array));
>>>>
>>>> Taking this one as an example, why can't we already do the rcu_dereference() on the
>>>> 'old_array = raw->progs' where we fetch the old_array initially? Then we also wouldn't
>>>> need the rcu_access_pointer() on bpf_prog_array_free() and yet another rcu_dereference()
>>>> inside the bpf_prog_array_copy() from your later patch?
>>>
>>> We can, but then we have to change bpf_prog_array_copy() args annotation,
>>> and also all places, where it's called.
>>> IMO, basically all local variables and function args marked as __rcu
>>> should be not marked as RCU, but fixing them all is beyond this patchset.
>>
>> Right, agree, the __rcu markings seem somewhat arbitrary. :-( I think we need to
>> investigate this a bit deeper and do a proper audit on the whole bpf prog array's
>> RCU handling (probably won't get to it in next two weeks but put onto backlog just
>> in case it's still unresolved till then). That said, given this has been there for
>> quite a while and it's rc5 now, I think we could start out on bpf-next with the
>> obvious candidates which should be okay even if it ends up bigger.
> 
> Totally agree.
> 
>> First two from this series we could already take in if you prefer.
> 
> That would be nice!

Ok, done, applied 1+2 to bpf-next, thanks Roman!
