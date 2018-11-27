Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842B0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611420873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:47:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2611420873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sorico.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbeK0Vob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:44:31 -0500
Received: from mout01.posteo.de ([185.67.36.141]:59166 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbeK0Voa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:44:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D7523160064
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:46:58 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4340pT1znXz6tm7;
        Tue, 27 Nov 2018 11:46:57 +0100 (CET)
Subject: Re: DMA: atmel_serial: Opening and closing the serial device
 repeatedly causes kmalloc-32 slab leak
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        richard.genoud@gmail.com
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Mario Forner <m.forner@be4energy.com>,
        Vinod Koul <vkoul@kernel.org>
References: <22061488.b0eNpyQjWt@linux-7rm0>
 <83753d21-f3c8-c8dd-75d7-741cb597d1a3@sorico.fr>
 <20181127095843.GF19871@piout.net>
From:   Richard Genoud <richard@sorico.fr>
Message-ID: <febddc12-200d-139f-18f0-fcb055951324@sorico.fr>
Date:   Tue, 27 Nov 2018 11:46:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181127095843.GF19871@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 27/11/2018 à 10:58, Alexandre Belloni a écrit :
> Hello Richard,
> 
> On 27/11/2018 10:51:13+0100, richard.genoud@gmail.com wrote:
>> Hi all,
>>
>> I reproduced the memory leak on my board (at91sam9g35-cm) with a 4.20-rc3.
>>
>> It triggered an OOM after a couple of hours running a code like this:
>> #include <sys/types.h>
>> #include <sys/stat.h>
>> #include <fcntl.h>
>> #include <unistd.h>
>>
>>
>> int main(int argc, char **argv)
>> {
>> 	int fd;
>> 	do {
>> 		fd = open("/dev/ttyS1", O_RDONLY);
>> 		close(fd);
>> 	} while (true);
>> 	return 0;
>> }
>>
>> As Mario pointed out, this only happens when atmel,use-dma-{r,t}x are
>> used in the device-tree.
>>
>> Adding:
>> CONFIG_DEBUG_SLAB=y
>> CONFIG_DEBUG_SLAB_LEAK=y
>> Doesn't show anything suspect in /proc/slab_allocators
>>
>> From what I found until now, it's something done in :
>> dma_request_slave_channel();
>> that leaks kmalloc-32
>> Mabe I missed something, but it seems that everything DMA related is
>> deallocated in atmel_release_{tx,rx}_dma().
>>
>> Is this ringing a bell ?
>>
> 
> Yes, this is known issue and it has yet to be worked on.
> 

After a talk on freenode, Alex found the problem.
A patch is on its way.

Thanks !
