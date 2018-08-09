Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6415C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7187F21B32
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 08:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="EQm3pTx4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7187F21B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbeHILNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:13:23 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:52201 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbeHILNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SRuVrdpwxT3oI12KDLL4JztXEkubOahLp+YZFWkRy/Y=; b=EQm3pTx4M8/xBvpWLi8IBpczRm
        oXwBdczjh/FkqwcTzkWwh7cbFWlIhZ7vfRnhSL+Tj5H3HUcj3HOYMLvdNZQSWt1QLuJoS5JwSi5IR
        I812gU53XW7SM8rSSGGwGTMIL14ycZogtSnO1ZvTCe8vOKGoNd8/JAzBvoCGAoNbrZRd1dd6CvnfP
        N5hIQ77a3gin/1oeHoRbR5vWZ/tXizctHFEAAJPws0p8/VXrFlv5liD5e/yRuqLJtgLFzrA369kPA
        +QVG+S4NGqrbc5boLoQgzbXTQ+1qcrs4a3wNC3D4PWy9PqDqcAROXxwt1mIZ8cishEK4Kb9zZMCfH
        KWUpKu1g==;
Received: from [193.209.96.43] (helo=[10.21.26.144])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fngdE-0007PI-1J; Thu, 09 Aug 2018 11:49:20 +0300
Subject: Re: [PATCH v3 3/8] mailbox: Add transmit done by blocking option
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        ", linux-arm-kernel"@lists.infradead.org,
        srv_heupstream <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
 <20180702114033.15654-4-mperttunen@nvidia.com>
 <CABb+yY0_dKC_cYFwwb-aeRgrx=sjv=8VLP=C6DJEecFf=v+mkQ@mail.gmail.com>
 <907bac36-0c54-8f38-0f5e-f59196d414c6@kapsi.fi>
 <afc8a305-79ea-2194-0af0-919bbb8f675e@kapsi.fi>
 <CABb+yY2mpNV186=M2anmZANgMOra4JM7ybyUT4yCxhqAG6-AZg@mail.gmail.com>
 <b5a91f9e-c3ff-371c-d355-4a5e8a147796@kapsi.fi>
 <CABb+yY3Ng+rbKRYXTncfHKv6HXBW5hHjMKDpepz31MxpE9bwRQ@mail.gmail.com>
 <a57fccaa-fcfe-6611-45a5-8c224f4ee2b6@kapsi.fi>
Message-ID: <b3045f85-eacb-a5ec-1690-b9c63d0f3373@kapsi.fi>
Date:   Thu, 9 Aug 2018 11:49:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a57fccaa-fcfe-6611-45a5-8c224f4ee2b6@kapsi.fi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 193.209.96.43
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's my current code:

https://github.com/cyndis/linux/commits/wip/t194-tcu-4

"fixup! mailbox: tegra-hsp: Add support for shared mailboxes" splits up 
the controller into two. "tegra-hsp: use polling" changes it to use polling.

There are two lines in the top patch with comments:

- at the end of tegra_hsp_mailbox_send_data, I left a "while 
(!tegra_hsp_mailbox_last_tx_done(chan));". Without it I wasn't able to 
see even a few garbled characters in the output.

- as mentioned, if I enable tx_block on the client side, I get a BUG: 
scheduling while atomic. I assume this gets printed through the earlycon 
as it's printing out correctly.

Thanks,
Mikko

On 08.08.2018 17:46, Mikko Perttunen wrote:
> On 08/08/2018 05:39 PM, Jassi Brar wrote:
>> On Wed, Aug 8, 2018 at 8:04 PM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
>>>
>>>
>>> On 08/08/2018 05:10 PM, Jassi Brar wrote:
>>>>
>>>> On Wed, Aug 8, 2018 at 5:08 PM, Mikko Perttunen <cyndis@kapsi.fi> 
>>>> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 04.08.2018 13:45, Mikko Perttunen wrote:
>>>>>>
>>>>>>
>>>>>> On 08/03/2018 03:54 PM, Jassi Brar wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Jul 2, 2018 at 5:10 PM, Mikko Perttunen 
>>>>>>> <mperttunen@nvidia.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Add a new TXDONE option, TXDONE_BY_BLOCK. With this option, the
>>>>>>>> send_data function of the mailbox driver is expected to block until
>>>>>>>> the message has been sent. The new option is used with the Tegra
>>>>>>>> Combined UART driver to minimize unnecessary overhead when
>>>>>>>> transmitting
>>>>>>>> data.
>>>>>>>>
>>>>>>> 1) TXDONE_BY_BLOCK flag :-
>>>>>>>            Have you tried setting the flag
>>>>>>> mbox_chan->mbox_client->tx_block
>>>>>>> ?
>>>>>>
>>>>>>
>>>>>>
>>>>>> No - I suppose I should have done that. I'm a bit concerned about
>>>>>> overhead
>>>>>> as send_data may be called thousands of times per second, so I 
>>>>>> tried to
>>>>>> make
>>>>>> it as close as possible to the downstream driver that just pokes the
>>>>>> mailbox
>>>>>> register directly.
>>>>>
>>>>>
>>>>>
>>>>> I tried using polling in the mailbox framework. Some printing is done
>>>>> from
>>>>> atomic context so it seems tx_block cannot be used -
>>>>> wait_for_completion_timeout understandably does not work in atomic
>>>>> context.
>>>>> I also tried without tx_block, in which case I got some horribly 
>>>>> garbled
>>>>> output, but "Try increasing MBOX_TX_QUEUE_LEN" was readable there.
>>>>>
>>>>> Any opinions?
>>>>>
>>>> The problems arise because your hardware (SM) supports TXDONE_BY_POLL,
>>>> but your client drives it by TXDONE_BY_ACK because the older DB
>>>> channels are so.
>>>>
>>>> Please populate SM channels as a separate controller than DB.
>>>> The DB controller, as is, run by ACK method.
>>>> The SM controller should be run by polling, i.e, set txdone_poll =
>>>> true and the poll period small enough. The virtual tty client driver
>>>> should be able to safely set tx_block from appropriate context.
>>>>
>>>
>>> Sorry, I should have clarified that I already split up the 
>>> controllers. The
>>> SM controller has txdone_poll = true. I didn't adjust txpoll_period so I
>>> guess it's zero.
>>>
>> Can you please share your code (controller and client) ? Maybe offline
>> if you wish.
>>
> 
> I'll upload a git branch tomorrow -- I'm not at the machine with the 
> code now.
> 
> Mikko
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
