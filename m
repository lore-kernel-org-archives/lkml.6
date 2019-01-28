Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3422C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EE620880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfA1IFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:05:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39317 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfA1IFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:05:33 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1go1vA-00057Q-MI; Mon, 28 Jan 2019 09:05:32 +0100
Subject: Re: [PATCH v1 3/3] drivers/tty: increase priority for
 tty_buffer_worker
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
References: <20190110101232.9398-1-o.rempel@pengutronix.de>
 <20190110101232.9398-4-o.rempel@pengutronix.de>
 <CAADWXX_G7X6QkNuqnpMyr+MGP+nUhqPaifJrfC=m57mhJu2jdg@mail.gmail.com>
 <20190110151953.qpat4t7lat6plfk6@pengutronix.de>
 <20190110163030.GB19693@kroah.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de>
Date:   Mon, 28 Jan 2019 09:05:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190110163030.GB19693@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.01.19 17:30, Greg Kroah-Hartman wrote:
> On Thu, Jan 10, 2019 at 04:19:53PM +0100, Oleksij Rempel wrote:
>>> My gut feel is that if somebody still cares deeply about serial line
>>> latency, they should look at trying to see if they can do some of the
>>> work directly without the bounce to the workqueue. We use workqueues
>>> for a reason, but it's possible that some of it could be avoided at
>>> least in special cases... And yours sounds like a special case.
>>
>> It is for industrial low latency RS-422 based application. The loopback
>> test is just easy way to test/reproduce it without additional hardware.
>>
>> What is good, mainlineable way to implement it?
> 
> What is the real problem your systems are having?  Are they serial-port
> limited?  Is latency a big issue?  Trying to tune for a fake workload
> isn't the best way to solve anything :)

The system in question is a high power laser cutter with live image-based inspection
and adjustment of the cutting process. In this setup the RS422 interface is used to
control parameters of the laser cutting unit in a tie control loop with the camera.
This loops needs to operate at 1000 Hz.

The xy-stage moves with a speed of approx. 60m/min, i.e. within 1ms it
moves about 1mm. For a high precision control process a jitter of ± 500 us (+/- 0.5mm)
is unacceptable.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
