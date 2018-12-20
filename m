Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3FDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5756221773
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbeLTRNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:13:34 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.144]:27586 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730510AbeLTRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:13:33 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 9F999D31E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 11:13:32 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a1t6gBEvKiQera1t6gGYck; Thu, 20 Dec 2018 11:13:32 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=59006 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ga1t6-000AJm-8E; Thu, 20 Dec 2018 11:13:32 -0600
Subject: Re: [PATCH] ALSA: isa/wavefront: Fix potential Spectre v1
 vulnerabilities
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20181219233143.GA14518@embeddedor> <s5ha7l0obxk.wl-tiwai@suse.de>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <c367ab0f-6b07-fa4f-0e05-0050a02875ae@embeddedor.com>
Date:   Thu, 20 Dec 2018 11:13:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5ha7l0obxk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1ga1t6-000AJm-8E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.106.44]:59006
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/20/18 2:11 AM, Takashi Iwai wrote:
> On Thu, 20 Dec 2018 00:31:43 +0100,
>   Gustavo A. R. Silva  wrote:
>>
>> header->number is indirectly controlled by user-space, hence leading
>> to a potential exploitation of the Spectre variant 1 vulnerability.
>>
>> This issue was detected with the help of Smatch:
>>
>> sound/isa/wavefront/wavefront_synth.c:792 wavefront_send_patch() warn: potential spectre issue 'dev->patch_status' [w] (local cap)
>> sound/isa/wavefront/wavefront_synth.c:819 wavefront_send_program() warn: potential spectre issue 'dev->prog_status' [w] (local cap)
>> sound/isa/wavefront/wavefront_synth.c:1197 wavefront_send_alias() warn: potential spectre issue 'dev->sample_status' [w]
>> sound/isa/wavefront/wavefront_synth.c:1248 wavefront_send_multisample() warn: potential spectre issue 'dev->sample_status' [w]
>> sound/isa/wavefront/wavefront_synth.c:1548 wavefront_synth_control() warn: potential spectre issue 'dev->sample_status' [r] (local cap)
>>
>> Fix this by sanitizing header->number before using it to index
>> dev->patch_status, dev->prog_status and dev->sample_status.
>>
>> Notice that given that speculation windows are large, the policy is
>> to kill the speculation on the first load and not worry if it can be
>> completed with a dependent load/store [1].
>>
>> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Is there any platform with ISA slot that suffers from Spectre?
> 
> 

Do you mean 'any other'?

If so, yeah, I just spotted some Spectre vulns in sound/isa/sb/emu8000.c

I'll send a patch for that.

Thanks
--
Gustavo
