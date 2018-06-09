Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id j3FCI/L2G1t2eAAAmS7hNA
	; Sat, 09 Jun 2018 15:49:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F08E608C8; Sat,  9 Jun 2018 15:49:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0091B608B8;
	Sat,  9 Jun 2018 15:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0091B608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=owl.eu.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbeFIPsv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:48:51 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46389 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932530AbeFIPss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:48:48 -0400
X-Originating-IP: 96.22.60.141
Received: from localhost (modemcable141.60-22-96.mc.videotron.ca [96.22.60.141])
        (Authenticated sender: hle@owl.eu.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id ADC1C60003;
        Sat,  9 Jun 2018 15:48:45 +0000 (UTC)
Date: Sat, 9 Jun 2018 11:48:42 -0400
From: Hugo Lefeuvre <hle@owl.eu.com>
To: Valentin Vidic <Valentin.Vidic@CARNet.hr>
Cc: devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
Message-ID: <20180609154842.GB1826@hle-laptop.local>
References: <20180602175649.GA2816@hle-laptop.local>
 <20180607124216.GA2329@hle-laptop.local>
 <20180609081244.GP14048@gavran.carpriv.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609081244.GP14048@gavran.carpriv.carnet.hr>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > After discussing this issue on the kernel newbies mailing list[0] we
> > came to the conclusion that it is very unlikely that pi433_release and
> > pi433_ioctl would ever run concurrently in this case. This is also
> > true for read/write. Unless one can find a situation where this might
> > happen, I think we should not add this potentially unnecessary lock.
> 
> Yes, so we should than drop the TODO comment on this issue?

Well, after taking a closer look it appears that I misunderstood the
TODO.

What this TODO means is that we might run into a whole world of issues
if the device is _removed_ while we're running ioctl or I guess pretty
much any function that accesses the struct pi433_device.

So the issue doesn't come from pi433_release and pi433_ioctl running
concurrently, but rather pi433_ioctl and pi433_remove. Whether this
situation is likely to happen or not is another question which I am
currently taking a look at.

Also, during my work on this driver I found what I'd consider as another
issue: In pi433_ioctl we execute

case PI433_IOC_WR_TX_CFG:
        if (copy_from_user(&instance->tx_cfg, argp,
                   sizeof(struct pi433_tx_cfg)))
            return -EFAULT;
        break;

without any synchronization. What if two ioctl syscalls are called with
command PI433_IOC_WR_TX_CFG ? instance->tx_cfg might get corrupt unless
copy_from_user provides some kind of synchronization, right ?

I have prepared a patch but couldn't test it because I don't have test
devices.

-- 
             Hugo Lefeuvre (hle)    |    www.owl.eu.com
4096/ 9C4F C8BF A4B0 8FC5 48EB 56B8 1962 765B B9A8 BACA
