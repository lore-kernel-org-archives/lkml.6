Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3067ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BE420852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BE420852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:07:50 -0400
Received: from www62.your-server.de ([213.133.104.62]:34137 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388139AbeGWXHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:07:50 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fhiwR-00051Z-Fy; Tue, 24 Jul 2018 00:04:31 +0200
Received: from [99.0.85.34] (helo=localhost.localdomain)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fhiwR-000DFE-1r; Tue, 24 Jul 2018 00:04:31 +0200
Subject: Re: bisected: 4.18-rc* regression: x86-32 troubles (with timers?)
To:     Meelis Roos <mroos@linux.ee>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>
References: <alpine.LRH.2.21.1807041414080.3671@math.ut.ee>
 <CAK8P3a1RkNc_kShHBJ6QENrQheQi=C93DmnknC1S_uJDcTDqww@mail.gmail.com>
 <alpine.LRH.2.21.1807051254050.21817@math.ut.ee>
 <alpine.LRH.2.21.1807151803010.17406@math.ut.ee>
 <CAK8P3a2NtB_FmiSjrzZb=HoshEzo+MP2xwafC3QcMg79rffipg@mail.gmail.com>
 <alpine.LRH.2.21.1807161948380.27791@math.ut.ee>
 <alpine.LRH.2.21.1807162200180.27791@math.ut.ee>
 <alpine.LRH.2.21.1807202339490.8506@math.ut.ee>
 <alpine.LRH.2.21.1807210154100.8506@math.ut.ee>
 <CAK8P3a19pCbn5Ns0jVqGTiSmGj4AOgjWL0CQtAA-sYRqY4Gvjw@mail.gmail.com>
 <32227088-7754-c160-8046-e860f42ca91c@iogearbox.net>
 <alpine.LRH.2.21.1807232322430.11834@math.ut.ee>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4a48811d-4094-ee4c-33ca-2cf0446a6313@iogearbox.net>
Date:   Tue, 24 Jul 2018 00:04:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1807232322430.11834@math.ut.ee>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24776/Mon Jul 23 18:44:17 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 10:34 PM, Meelis Roos wrote:
>>>> Now this seems more relevant:
>>>>
>>>> mroos@rx100s2:~/linux$ nice git bisect good
>>>> 24dea04767e6e5175f4750770281b0c17ac6a2fb is the first bad commit
>>>> commit 24dea04767e6e5175f4750770281b0c17ac6a2fb
>>>> Author: Daniel Borkmann <daniel@iogearbox.net>
>>>> Date:   Fri May 4 01:08:23 2018 +0200
>>>>
>>>>     bpf, x32: remove ld_abs/ld_ind
>>>>
>>>>     Since LD_ABS/LD_IND instructions are now removed from the core and
>>>>     reimplemented through a combination of inlined BPF instructions and
>>>>     a slow-path helper, we can get rid of the complexity from x32 JIT.
>>>
>>> This does seem much more likely than the previous bisection, given
>>> that you ended up in an x86-32 specific commit (the subject says x32,
>>> but that is a mistake). I also checked that systemd indeed does
>>> call into bpf in a number of places, possibly for the journald socket.
>>>
>>> OTOH, it's still hard to tell how that commit can have ended up
>>> corrupting the clock read function in systemd. To cross-check,
>>> could you try reverting that commit on the latest kernel and see
>>> if it still works?
>>
>> I would be curious as well about that whether revert would make it
>> work. What's the value of sysctl net.core.bpf_jit_enable ? Does it
>> change anything if you set it to 0 (only interpreter) or 1 (JIT
>> enabled). Seems a bit strange to me that bisect ended at this commit
>> given the issue you have. The JIT itself was also new in this window
>> fwiw. In any case some more debug info would be great to have.
> 
> net.core.bpf_jit_enable is 1.
> 
> Since it breaks bootup, I can not easily change the value at runtime (it 
> would be postfactum). Do you mean changing the 
> CONFIG_BPF_JIT_ALWAYS_ON=y option?

Yeah if you chance it to N, and don't have any fixed /etc/sysctl.conf
setting, then you'll boot up with interpreter first (net.core.bpf_jit_enable
as 0). Curious whether that works just fine for you.

> Anyway, I started compile of v4.18-rc5 that was the latest I tested, 
> with the commit in question reverted. Will see if I can test tomorrow 
> morning. But I will leave tomorrow for a week and can only test further 
> things if they happen to boot fine (no manual reboot possible for a 
> week).

Ok, thanks, please keep us posted on the outcome with the revert. Right
now I would doubt it's related resp. changes anything on the issue, but
lets see.

Thanks,
Daniel
