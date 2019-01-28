Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC5DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 774E620855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="X+EBiYWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfA1RZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:25:16 -0500
Received: from mout01.posteo.de ([185.67.36.65]:56612 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbfA1RZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:25:14 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 50DB716005D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 18:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1548696311; bh=73wo2EizwjgJieNSVPR9D53sKY2XisMDGFbCR2FPscg=;
        h=Date:From:To:Cc:Subject:From;
        b=X+EBiYWCDxx9FlXU/VpTLh5aijonu8T4FUo2+ozy/xizc5Tjv8Hwo8LRA9yLgMSxY
         mFMSafOcUgX/O3cCVaQoMmcG6OJDVmZVbzDteEepMVdTXHQ86A5u93lSG+/ZGWjw2k
         XEcVCzjIp7vtas3kuN7IByrdEu2+3kMRUlrXEw+OOw1bd1rh3Mtgje2f8f3VYL2kqS
         hZe3mWKb88fb1bM/nBPJX1hSaOIicrmimdE8okhEfL2Z1AdYCfyHQEHl92KU3TwRmc
         hgE+9cDiuThJpvnCmzkBjtO+EC3C92XAyKeesgez07AHuYeQpx2ZaFNHHYO4QxrlOe
         4wrWgwT15OHOg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43pGjL43Cwz6tmD;
        Mon, 28 Jan 2019 18:25:10 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jan 2019 18:25:10 +0100
From:   Martin Kepplinger <martink@posteo.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jslaby@suse.com, linux-kernel@vger.kernel.org,
        Manfred Schlaegl <manfred.schlaegl@ginzinger.com>,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH] tty: increase the default flip buffer limit to 2*640K
In-Reply-To: <20190128165318.GA16213@kroah.com>
References: <20190128163843.688-1-martink@posteo.de>
 <20190128165318.GA16213@kroah.com>
Message-ID: <9a8ab1dffec11a4f9d98240d836bf45a@posteo.de>
X-Sender: martink@posteo.de
User-Agent: Posteo Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.01.2019 17:53 schrieb Greg KH:
> On Mon, Jan 28, 2019 at 05:38:43PM +0100, Martin Kepplinger wrote:
>> From: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>> 
>> The default value for this was 64K. We increase this by a factor of
>> 10 to 640K to prevent data loss when using fast serial interfaces.
> 
> What fast serial interface are you using where you run into this limit?

RS485 without flow-control. At speeds of 1Mbit/s an upwards we've run
into problems such as applications being too slow to read out this 
buffer
(on embedded devices based on imx53 or imx6).

If you want to write transmitted data to a slow SD card and thus have
realtime requirements, this limit can become a problem.

That shouldn't be the case and 640K buffers fix such problems for us.

> 
>> Since this value is only a maximum limit for allocation and isn't used
>> by default, this change has minimal effect on systems with slow 
>> interfaces.
> 
> So what systems does it affect?

This was misleading, sorry. This has no effect on systems that currently
run fine I _think_. If transmission is slow enough, applications and 
hardware
can keep up and increasing this limit won't have any effect.

It only _allows_ to allocate more than 2*64K in cases we currently fail 
to
allocate anything despite having memory available.

> 
>> Signed-off-by: Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
>> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
>> ---
>> 
>> Is there any reason for this _limit_ to be as small as 64K?
> 
> Historical mostly from what I can tell.
> 
> thanks,

thanks for having a look,

                                 martin

