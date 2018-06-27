Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE013C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740A126569
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 12:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740A126569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934467AbeF0M45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 08:56:57 -0400
Received: from www62.your-server.de ([213.133.104.62]:58625 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932398AbeF0M4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 08:56:55 -0400
Received: from [62.203.87.61] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fYA0A-00084d-FG; Wed, 27 Jun 2018 14:56:50 +0200
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
To:     Okash Khawaja <osk@fb.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20180622205535.c6vjhdwt5er4wc32@kafai-mbp.dhcp.thefacebook.com>
 <20180622142743.2b890d0f@cakuba.netronome.com>
 <20180622225408.jor7lpvsksnwiiec@kafai-mbp.dhcp.thefacebook.com>
 <20180622163200.20564ec4@cakuba.netronome.com>
 <20180623002639.h4qxy7aakypi6t7b@kafai-mbp.dhcp.thefacebook.com>
 <20180626164820.GA12981@w1t1fb>
 <20180626133133.618af1d3@cakuba.netronome.com>
 <20180626222709.fsznwqauxojhhx7v@kafai-mbp.dhcp.thefacebook.com>
 <20180626153559.0511f709@cakuba.netronome.com>
 <23968d53-2895-f0bc-a38c-5bc99e1846ab@iogearbox.net>
 <20180627114737.GA1580@w1t1fb>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0360a47f-1056-3117-31ec-7c3f5d6dbccb@iogearbox.net>
Date:   Wed, 27 Jun 2018 14:56:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180627114737.GA1580@w1t1fb>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24700/Wed Jun 27 06:38:23 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 01:47 PM, Okash Khawaja wrote:
> On Wed, Jun 27, 2018 at 12:34:35PM +0200, Daniel Borkmann wrote:
>> On 06/27/2018 12:35 AM, Jakub Kicinski wrote:
>>> On Tue, 26 Jun 2018 15:27:09 -0700, Martin KaFai Lau wrote:
>>>> On Tue, Jun 26, 2018 at 01:31:33PM -0700, Jakub Kicinski wrote:
>> [...]
>>>>> Implementing both outputs in one series will help you structure your
>>>>> code to best suit both of the formats up front.  
>>>> hex and "formatted" are the only things missing?  As always, things
>>>> can be refactored when new use case comes up.  Lets wait for
>>>> Okash input.
>>>>
>>>> Regardless, plaintext is our current use case.  Having the current
>>>> patchset in does not stop us or others from contributing other use
>>>> cases (json, "bpftool map find"...etc),  and IMO it is actually
>>>> the opposite.  Others may help us get there faster than us alone.
>>>> We should not stop making forward progress and take this patch
>>>> as hostage because "abc" and "xyz" are not done together.
>>>
>>> Parity between JSON and plain text output is non negotiable.
>>
>> Longish discussion and some confusion in this thread. :-) First of all
>> thanks a lot for working on it, very useful! 
> Thanks :)
> 
>> My $0.02 on it is that so far
>> great care has been taken in bpftool to indeed have feature parity between
>> JSON and plain text, so it would be highly desirable to keep continuing
>> this practice if the consensus is that it indeed is feasible and makes
>> sense wrt BTF data. There has been mentioned that given BTF data can be
>> dynamic depending on what the user loads via bpf(2) so a potential JSON
>> output may look different/break each time anyway. This however could all be
>> embedded under a container object that has a fixed key like 'formatted'
>> where tools like jq(1) can query into it. I think this would be fine since
>> the rest of the (non-dynamic) output is still retained as-is and then
>> wouldn't confuse or collide with existing users, and anyone programmatically
>> parsing deeper into the BTF data under such JSON container object needs
>> to have awareness of what specific data it wants to query from it; so
>> there's no conflict wrt breaking anything here. Imho, both outputs would
>> be very valuable.
> Okay I can add "formatted" object under json output.
> 
> One thing to note here is that the fixed output will change if the map
> itself changes. So someone writing a program that consumes that fixed
> output will have to account for his program breaking in future, thus

Yes, that aspect is fine though, any program/script parsing this would need
to be aware of the underlying map type to make sense of it (e.g. per-cpu vs
non per-cpu maps to name one). But that info it could query/verify already
beforehand via bpftool as well (via normal map info dump for a given id).

> breaking backward compatibility anyway as far as the developer is
> concerned :)
> 
> I will go ahead with work on "formatted" object.

Cool, thanks,
Daniel
