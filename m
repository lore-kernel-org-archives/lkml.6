Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14931C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1187214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 23:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfA1XWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 18:22:32 -0500
Received: from www62.your-server.de ([213.133.104.62]:44220 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfA1XWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 18:22:32 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1goGEV-0007hv-7t; Tue, 29 Jan 2019 00:22:28 +0100
Received: from [178.197.249.31] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1goGEV-000OWI-16; Tue, 29 Jan 2019 00:22:27 +0100
Subject: Re: [PATCH] bpf/core.c - silence warning messages
To:     Song Liu <liu.song.a23@gmail.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <31468.1548648675@turing-police.cc.vt.edu>
 <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3c8c866f-c665-ff82-a0ab-a4eafd28b20f@iogearbox.net>
Date:   Tue, 29 Jan 2019 00:22:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAPhsuW54z8ao4KOKG9ZjdXus6LTBH2qwAi8LgPFZ_qb_ObKsRg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25339/Mon Jan 28 19:32:47 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28/2019 06:18 PM, Song Liu wrote:
> On Sun, Jan 27, 2019 at 8:43 PM <valdis.kletnieks@vt.edu> wrote:
>>
>> Compiling kernel/bpf/core.c with W=1 causes a flood of warnings:
>>
>> kernel/bpf/core.c:1198:65: warning: initialized field overwritten [-Woverride-init]
>>  1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
>>       |                                                                 ^~~~
>> kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
>>  1087 |  INSN_3(ALU, ADD,  X),   \
>>       |  ^~~~~~
>> kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
>>  1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
>>       |   ^~~~~~~~~~~~
>> kernel/bpf/core.c:1198:65: note: (near initialization for 'public_insntable[12]')
>>  1198 | #define BPF_INSN_3_TBL(x, y, z) [BPF_##x | BPF_##y | BPF_##z] = true
>>       |                                                                 ^~~~
>> kernel/bpf/core.c:1087:2: note: in expansion of macro 'BPF_INSN_3_TBL'
>>  1087 |  INSN_3(ALU, ADD,  X),   \
>>       |  ^~~~~~
>> kernel/bpf/core.c:1202:3: note: in expansion of macro 'BPF_INSN_MAP'
>>  1202 |   BPF_INSN_MAP(BPF_INSN_2_TBL, BPF_INSN_3_TBL),
>>       |   ^~~~~~~~~~~~
>>
>> 98 copies of the above.
>>
>> The attached patch silences the warnings, because we *know* we're overwriting
>> the default initializer. That leaves bpf/core.c with only 6 other warnings,
>> which become more visible in comparison.
> 
> My concern is that this will also mute the warning for other parts of
> bpf/core.c.

Agree, valid concern.

> Maybe we should move bpf_opcode_in_insntable() to a separate file, and mute
> warning for that file?

I think moving in separate file would be overkill, imho. However, lets get
the kdoc and prototype warning fixed.

Thanks,
Daniel
