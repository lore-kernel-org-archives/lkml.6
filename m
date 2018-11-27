Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE0C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26B7208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26B7208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbeK0U4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:56:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33520 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbeK0U4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:56:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A9EBA207A8; Tue, 27 Nov 2018 10:58:53 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7808E206D8;
        Tue, 27 Nov 2018 10:58:43 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:58:43 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     richard.genoud@gmail.com
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Vinod Koul <vinod.koul@intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, dmaengine@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Mario Forner <m.forner@be4energy.com>
Subject: Re: DMA: atmel_serial: Opening and closing the serial device
 repeatedly causes kmalloc-32 slab leak
Message-ID: <20181127095843.GF19871@piout.net>
References: <22061488.b0eNpyQjWt@linux-7rm0>
 <83753d21-f3c8-c8dd-75d7-741cb597d1a3@sorico.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83753d21-f3c8-c8dd-75d7-741cb597d1a3@sorico.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

On 27/11/2018 10:51:13+0100, richard.genoud@gmail.com wrote:
> Hi all,
> 
> I reproduced the memory leak on my board (at91sam9g35-cm) with a 4.20-rc3.
> 
> It triggered an OOM after a couple of hours running a code like this:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> 
> 
> int main(int argc, char **argv)
> {
> 	int fd;
> 	do {
> 		fd = open("/dev/ttyS1", O_RDONLY);
> 		close(fd);
> 	} while (true);
> 	return 0;
> }
> 
> As Mario pointed out, this only happens when atmel,use-dma-{r,t}x are
> used in the device-tree.
> 
> Adding:
> CONFIG_DEBUG_SLAB=y
> CONFIG_DEBUG_SLAB_LEAK=y
> Doesn't show anything suspect in /proc/slab_allocators
> 
> From what I found until now, it's something done in :
> dma_request_slave_channel();
> that leaks kmalloc-32
> Mabe I missed something, but it seems that everything DMA related is
> deallocated in atmel_release_{tx,rx}_dma().
> 
> Is this ringing a bell ?
> 

Yes, this is known issue and it has yet to be worked on.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
