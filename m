Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C23C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B0421735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:29:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B0421735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeHTWqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:46:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:51194 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:46:39 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1frps1-0007Ph-SY; Mon, 20 Aug 2018 21:29:45 +0200
Received: from [178.197.248.15] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1frps1-0004gX-NY; Mon, 20 Aug 2018 21:29:45 +0200
Subject: Re: Allocation failure with subsequent kernel crash
To:     whiteheadm@acm.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>
References: <CAP8WD_YEyxKOimMrGk+5Db8DpNfqQL84-2xLXbe53jiY_FoPrQ@mail.gmail.com>
 <CAADnVQJjqLY3iFy2y5mb+oMR=VHS8HS_KXa0wm1HO3v0ayvrkw@mail.gmail.com>
 <CAP8WD_ba1k6uxSFQ00QtW0L23jzjSFw93YpEq+010zKE5sT27g@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <05825446-e8aa-a983-3fc6-4dc8e81cba57@iogearbox.net>
Date:   Mon, 20 Aug 2018 21:29:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAP8WD_ba1k6uxSFQ00QtW0L23jzjSFw93YpEq+010zKE5sT27g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.1/24860/Mon Aug 20 18:47:04 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On 08/20/2018 08:03 AM, tedheadster wrote:
> On Mon, Aug 20, 2018 at 1:22 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> I don't remember vzalloc issues that was fixed in this area.
>> 4.14 kernel is quite old. Since then syzbot found few mem
>> related bugs that were fixed.
>> please try to reproduce on the latest tree.
> 
> Alexei,
>   I get this panic with two very recent kernels: 4.18.0 and 4.17.14. I
> do not think this has been fixed. I am still trying to bisect it, but
> sometimes it takes 5 hours for the panic to occur.

I've been looking into it a bit today and still am. Given you've seen
this on x86_32 and also on older kernels, I presume JIT was not involved
(/proc/sys/net/core/bpf_jit_enable is 0). Do you run any specific workload
until you trigger this (e.g. fuzzer on BPF), or any specific event that
triggers at that time after ~5hrs? Or only systemd on idle machine? Have
you managed to reproduce this also elsewhere? Bisect seems indeed painful
but would help tremendously; perhaps also dumping the BPF insns that are
loaded at that point in time.

Thanks a lot,
Daniel

> - Matthew Whitehead
> 

