Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DD16256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A3120890
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 16:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A3120890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeG3RpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 13:45:19 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43281 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbeG3RpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 13:45:19 -0400
Received: from [148.252.241.226] (helo=[10.35.4.113])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fkAjq-0001J8-Pu; Mon, 30 Jul 2018 17:09:38 +0100
Subject: Re: [PATCH v2 4/4] ALSA: usb-audio: Operate UAC3 Power Domains in PCM
 callbacks
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20180719112215.4219-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-1-jorge.sanjuan@codethink.co.uk>
 <20180730092336.18741-5-jorge.sanjuan@codethink.co.uk>
 <s5h8t5sx3x9.wl-tiwai@suse.de>
From:   Jorge <jorge.sanjuan@codethink.co.uk>
Message-ID: <95e003a2-0cc2-6ce1-b330-0a4fa3643386@codethink.co.uk>
Date:   Mon, 30 Jul 2018 17:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5h8t5sx3x9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/07/18 14:13, Takashi Iwai wrote:
> On Mon, 30 Jul 2018 11:23:36 +0200,
> Jorge Sanjuan wrote:
>>
>> Make use of UAC3 Power Domains associated to an Audio Streaming
>> path within the PCM's logic. This means, when there is no audio
>> being transferred (pcm is closed), the host will set the Power Domain
>> associated to that substream to state D1. When audio is being transferred
>> (from hw_params onwards), the Power Domain will be set to D0 state.
>>
>> This is the way the host lets the device know which Terminal
>> is going to be actively used and it is for the device to
>> manage its own internal resources on that UAC3 Power Domain.
>>
>> Note the resume method now sets the Power Domain to D1 state as
>> resuming the device doesn't mean audio streaming will occur.
> 
> I guess we need the power state transition to D0 also in prepare
> callback.  The recovery from suspend doesn't need hw_params call but
> just prepare -> trigger.

Right! Shouldn't it then be enough to just go to D0 on .prepare? I,e.
Move the state transition from .hw_params to .prepare.

Jorge

> 
> One could think of implementing into the trigger, but since the
> transition needs some delay, prepare callback would be a better
> choice, as it seems.
> 
> 
> thanks,
> 
> Takashi
> 

-- 
Jorge Sanjuan, Software Engineer                         Codethink Ltd
http://www.codethink.co.uk/
We respect your privacy.   See https://www.codethink.co.uk/privacy.html
