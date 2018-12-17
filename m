Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558E4C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 245582133F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbeLQPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:43:14 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:56636 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbeLQPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:43:13 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43JQR0671kz1r02K;
        Mon, 17 Dec 2018 16:43:08 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43JQR046XTz1qvRX;
        Mon, 17 Dec 2018 16:43:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 69dz0lGJFhtE; Mon, 17 Dec 2018 16:43:07 +0100 (CET)
X-Auth-Info: uCA/xwTQNCN29wazrd7eps4Mp/jltM6c4caImNMwyI4=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 17 Dec 2018 16:43:07 +0100 (CET)
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Burton <paul.burton@mips.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
 <20181216223510.hxsdotf332ousinh@pburton-laptop>
 <20181217151851.GA21564@kroah.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <52a4b322-5710-1ac0-fa3e-11ed6ef2236d@denx.de>
Date:   Mon, 17 Dec 2018 16:43:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181217151851.GA21564@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/17/2018 04:18 PM, Greg Kroah-Hartman wrote:
> On Sun, Dec 16, 2018 at 10:35:12PM +0000, Paul Burton wrote:
>> Hi Ezequiel,
>>
>> On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
>>> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
>>>> This helps, but it only addresses one part of one of the 4 reasons I
>>>> listed as motivation for my revert. For example serial8250_do_shutdown()
>>>> also clearly intends to disable the FIFOs.
>>>>
>>>
>>> OK. So, let's fix that :-)
>>
>> I already did, or at least tried to, on Thursday [1].
>>
>>> By all means, it would be really nice to push forward and fix the garbage
>>> issue on JZ4780, as well as the transmission issue on AM335x.
>>>
>>> AM335x is a wildly popular platform, and it's not funny to break it.
>>
>> Well, clearly not if it was broken in v4.10 & only just fixed..? And
>> from Marek's commit message the patch in v4.10 doesn't break the whole
>> system just RS485.
>>
>>> So, let's please stop discussing which board we'll break and just fix both.
>>
>> I completely agree that would be ideal and I wrote a patch hoping to do
>> that on Thursday, but didn't get any response on testing. It's late in
>> the cycle hence a revert made sense. Simple as that.
> 
> A revert makes sense now, I'll go queue this up, thanks.

I don't like this for multiple reasons.
1) There is a better patch posted which doesn't break the AM335x and
   clearly identifies and fixes the problem on the JZ4780 / CI20
2) The JZ4780 8250 core is not a standard 8250 core, since it has extra
   bits in the FCR register (like the UME bit, which disables the whole
   UART block), so the revert IMO would break that core too, it just
   hides the breakage. I'm still trying to understand the implications
   of that in detail, but the discussion wasn't quite constructive.

I'd much rather see Ezequiel's patch applied, since that's far less
destructive approach to fixing the problem than the revert.

-- 
Best regards,
Marek Vasut
