Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41581C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F22720855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=newmedia-net.de header.i=@newmedia-net.de header.b="tUpydRvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfBUMuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:50:44 -0500
Received: from webmail.newmedia-net.de ([185.84.6.166]:38662 "EHLO
        webmail.newmedia-net.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfBUMun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=newmedia-net.de; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=zpRRwKjdCn2OaV0fvycbutp0DI4dW4xVbXdDrWDn8Kg=;
        b=tUpydRvh7l87Ccqpt4fS6B6EpzSfB3vg2U3J0pRPrSetHdp7ki9ZzuBsRkJcNdVD0g5a4Hu4Jh8VeeA3t+VY8llICwC8g746T7TiVwTggHXUy924hj9h71C8fjtDA3ag1H4npl7npAAhi6rb2tWB3TmAFUORVPGcFEO0dZakjJ0=;
Subject: Re: [PATCH 4.19 01/24] bridge: do not add port to router list when
 receives query with source 0.0.0.0
To:     Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ying Xu <yinxu@redhat.com>,
        Roopa Prabhu <roopa@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>
References: <20181102182839.725385066@linuxfoundation.org>
 <20181102182839.913422845@linuxfoundation.org>
 <07d315a2-d735-3d8b-686c-9c52acf91bf1@newmedia-net.de>
 <20190217164809.GA24091@kroah.com>
 <7978727a-eacc-779c-771f-f4c3013237f3@newmedia-net.de>
 <0425449f-f6d9-c492-d7c8-ba202db88d26@newmedia-net.de>
 <962f3d1f-23eb-647c-74cb-b277212299e7@cumulusnetworks.com>
 <20190220144653.GJ10051@dhcp-12-139.nay.redhat.com>
From:   Sebastian Gottschall <s.gottschall@newmedia-net.de>
Message-ID: <1e412bab-fb07-4b44-eb42-5a74bec12453@newmedia-net.de>
Date:   Thu, 21 Feb 2019 13:50:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220144653.GJ10051@dhcp-12-139.nay.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [212.111.244.1] (helo=[172.29.0.186])
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@newmedia-net.de>)
        id 1gwnoF-0003mn-Jp; Thu, 21 Feb 2019 13:50:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 20.02.2019 um 15:46 schrieb Hangbin Liu:
>> Could you please include more details about the setup that's broken ?
>> Note that we were warned[1] of potential breakage from this change
> Sorry I missed Linus's reply after Ying Xu replied. I will read it and
> disscuss with Ying Xu.
>
>> after it went in and regardless of the suggestion from the RFC we'll
>> probably have to revert this patch.
>>
>> Ying Xu as author of the patch, any thoughts ?
> No, we are also waiting for more details from Sebastian.

the test scenario is the following. one of my testers of the dd-wrt 
firmware is using a iptv stream from the france isp "orange".
he just bridged the iptv vlan interface which has no ip (the isp doesnt 
provide a ip configuration here) to a bridge and played with igmp 
snooping to avoid flooding of all ports within the same bridge.
he found out that this setting simply does not work with the current 
kernel, but does
if this patch has been removed. we used kernel 4.4 in the test scenario. 
all latest revision.
i was able to reproduce the same problem on kernel 4.9 and 4.14 on a 
different device using a german isp based iptv stream. same effect. 
after reverting the problematic code it worked again.

Sebastian

>
> Thanks
> Hangbin
>
>> Also adding Linus Lüssing to the CC as he was the one who warned against it.
>> Note that the warning was sent as a reply to my breakage fix, but it was intended
>> for the original patch.
>>
>> Thanks,
>>   Nik
>>
>> [1] https://www.mail-archive.com/netdev@vger.kernel.org/msg272944.html
>>
