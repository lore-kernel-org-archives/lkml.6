Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6012C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620A2208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620A2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:13:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:53317 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeGaKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:13:57 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkQ75-0002fC-Na; Tue, 31 Jul 2018 10:34:39 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fkQ75-0000ak-IF; Tue, 31 Jul 2018 10:34:39 +0200
Subject: Re: [PATCH v3] Add BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES bpf(2)
 command
To:     Daniel Colascione <dancol@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Joel Fernandes <joelaf@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>
References: <CAKOZuesQ6GdNTGDFsNi4o8LYzxLBtYZ=Cz4=aZbqqCNia+QFnQ@mail.gmail.com>
 <20180729205835.34850-1-dancol@google.com>
 <e8f6e709-e694-ddad-b61e-d2ce1598dff3@iogearbox.net>
 <CAKOZuesH_LRdt15aXaRQRPSNzN-URTQWgSgr0zLsv8ZKFU9=9Q@mail.gmail.com>
 <20180730172641.7d516231@cakuba.netronome.com>
 <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <67423232-be56-fd47-06e6-394812c2b918@iogearbox.net>
Date:   Tue, 31 Jul 2018 10:34:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAKOZuesNnY8oKimMk+gnUppMgZt92F+razSZCSfHu=xfq+snGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24798/Tue Jul 31 02:44:18 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 02:33 AM, Daniel Colascione wrote:
> On Mon, Jul 30, 2018 at 5:26 PM, Jakub Kicinski
> <jakub.kicinski@netronome.com> wrote:
>> On Mon, 30 Jul 2018 03:25:43 -0700, Daniel Colascione wrote:
>>> On Mon, Jul 30, 2018 at 3:04 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>> Hmm, I don't think such UAPI as above is future-proof. In case we would want
>>>> a similar mechanism in future for other maps, we would need a whole new bpf
>>>> command or reuse BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES as a workaround though
>>>> the underlying map may not even be a map-to-map. Additionally, we don't have
>>>> any map object at hand in the above, so we couldn't make any finer grained
>>>> decisions either. Something like below would be more suitable and leaves room
>>>> for extending this further in future.
>>>
>>> YAGNI.  Your proposed mechanism doesn't add anything under the current
>>> implementation.
>>
>> FWIW in case of HW offload targeting a particular map may allow users
>> to avoid a potentially slow sync with all the devices on the system.
> 
> Sure. But such a thing doesn't exist right now (right?), and we can
> add that more-efficient-in-that-one-case BPF interface when it lands.
> I'd rather keep things simple for now.

I don't see a reason why that is even more complicated. An API command name
such as BPF_SYNCHRONIZE_MAP_TO_MAP_REFERENCES is simply non-generic, and
exposes specific map details (here: map-in-map) into the UAPI whereas it
should reside within a specific implementation instead similar to other ops
we have for maps. If in future other maps would be added that would have
similar mechanisms of inner objects they return to the BPF program, we'll
be adding yet another command just for this. Also, union bpf_attr is extensible,
e.g. additional members could be added in future whenever needed for this
subcommand instead of forcing it to NULL as done here. E.g. having a high-level
one like bpf(BPF_MAP_WAIT, { .map_fd = fd }) could later on also cover the
use-case from Jakub by adding an 'event' member into union bpf_attr where we
could add other map specific wakeups for user space while the current default
of 0 would be BPF_MAP_WAIT_PENDING_REFS (or the like). All I'm saying is to
keep it generic so it can be extended later.
