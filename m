Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbeCTRHy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 13:07:54 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:33760 "EHLO
        mail2.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752271AbeCTRHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 13:07:50 -0400
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
To: Liran Alon <LIRAN.ALON@ORACLE.COM>,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <0d84d286-9965-45cb-93c8-379ca1b2441e@default>
 <87tvta67gl.fsf@xmission.com> <5AB13A86.9010607@ORACLE.COM>
Cc: shmulik.ladkani@gmail.com, netdev@vger.kernel.org, mrv@mojatatu.com,
        daniel@iogearbox.net, davem@davemloft.net,
        linux-kernel@vger.kernel.org, yuval.shaia@ORACLE.COM,
        idan.brown@ORACLE.COM
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <d031d870-27c0-3fde-7ab8-bf65f6c9d910@candelatech.com>
Date: Tue, 20 Mar 2018 10:07:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.0
MIME-Version: 1.0
In-Reply-To: <5AB13A86.9010607@ORACLE.COM>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/20/2018 09:44 AM, Liran Alon wrote:
>
>
> On 20/03/18 18:24, ebiederm@xmission.com wrote:
>>
>> I don't believe the current behavior is a bug.
>>
>> I looked through the history.  Basically skb_scrub_packet
>> started out as the scrubbing needed for crossing network
>> namespaces.
>>
>> Then tunnels which needed 90% of the functionality started
>> calling it, with the xnet flag added.  Because the tunnels
>> needed to preserve their historic behavior.
>>
>> Then dev_forward_skb started calling skb_scrub_packet.
>>
>> A veth pair is supposed to give the same behavior as a cross-over
>> cable plugged into two local nics.  A cross over cable won't
>> preserve things like the skb mark.  So I don't see why anyone would
>> expect a veth pair to preserve the mark.
>
> I disagree with this argument.
>
> I think that a skb crossing netns is what simulates a real packet crossing physical computers. Following your argument, why would skb->mark should be preserved
> when crossing netdevs on same netns via routing? But this does today preserve skb->mark.
>
> Therefore, I do think that skb->mark should conceptually only be scrubbed when crossing netns. Regardless of the netdev used to cross it.

It should be scrubbed in VETH as well.  That is one way to make virtual routers.  Possibly
the newer VRF features will give another better way to do it, but you should not break
things that used to work.

Now, if you want to add a new feature that allows one to configure the kernel (or VETH) for
a new behavior, then that might be something to consider.

>> Right now I don't see the point of handling packets that don't cross
>> network namespace boundaries specially, other than to preserve backwards
>> compatibility.

Well, backwards compat is a big deal all by itself!

Thanks,
Ben

>>
>> Eric
>>
>
>


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
