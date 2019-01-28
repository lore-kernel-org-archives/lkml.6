Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53125C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238222087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfA1JWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:22:07 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47805 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfA1JWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:22:05 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1go37D-0006Sa-BP; Mon, 28 Jan 2019 10:22:03 +0100
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
 <7a593f3b-0019-c30f-30e8-34eae7b96cf0@pengutronix.de>
 <20190128082313.GA15182@kroah.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <dedfa895-ae7e-9a64-9e89-055ca85cf2e3@pengutronix.de>
Date:   Mon, 28 Jan 2019 10:22:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128082313.GA15182@kroah.com>
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



On 28.01.19 09:23, Greg Kroah-Hartman wrote:
> On Mon, Jan 28, 2019 at 09:05:30AM +0100, Oleksij Rempel wrote:
>>
>>
>> On 10.01.19 17:30, Greg Kroah-Hartman wrote:
>>> On Thu, Jan 10, 2019 at 04:19:53PM +0100, Oleksij Rempel wrote:
>>>>> My gut feel is that if somebody still cares deeply about serial line
>>>>> latency, they should look at trying to see if they can do some of the
>>>>> work directly without the bounce to the workqueue. We use workqueues
>>>>> for a reason, but it's possible that some of it could be avoided at
>>>>> least in special cases... And yours sounds like a special case.
>>>>
>>>> It is for industrial low latency RS-422 based application. The loopback
>>>> test is just easy way to test/reproduce it without additional hardware.
>>>>
>>>> What is good, mainlineable way to implement it?
>>>
>>> What is the real problem your systems are having?  Are they serial-port
>>> limited?  Is latency a big issue?  Trying to tune for a fake workload
>>> isn't the best way to solve anything :)
>>
>> The system in question is a high power laser cutter with live image-based inspection
>> and adjustment of the cutting process. In this setup the RS422 interface is used to
>> control parameters of the laser cutting unit in a tie control loop with the camera.
>> This loops needs to operate at 1000 Hz.
>>
>> The xy-stage moves with a speed of approx. 60m/min, i.e. within 1ms it
>> moves about 1mm. For a high precision control process a jitter of ± 500 us (+/- 0.5mm)
>> is unacceptable.
> 
> Are you using the rt kernel patch for this type of thing?  That should
> bound your jitter at a much more deterministic level.

Yes, I tested it with different linux-rt version with mostly similar results:
         kernel 4.8.15-rt10+
         latency histogram:
             0 ... <     250 usec : 1933104 transmissions
           250 ... <     500 usec : 21339 transmissions
           500 ... <     750 usec : 8952 transmissions
           750 ... <    1000 usec : 6226 transmissions
          1000 ... <    1500 usec : 7688 transmissions
          1500 ... <    2000 usec : 5236 transmissions
          2000 ... <    5000 usec : 11724 transmissions
          5000 ... <   10000 usec : 3588 transmissions
         10000 ... <   50000 usec : 2123 transmissions
         50000 ... < 1000000 usec : 20 transmissions
                  >= 1000000 usec : 0 transmissions

         kernel 4.9.0-rt1+
         latency histogram:
             0 ... <     250 usec : 1950222 transmissions
           250 ... <     500 usec : 15041 transmissions
           500 ... <     750 usec : 5968 transmissions
           750 ... <    1000 usec : 4437 transmissions
          1000 ... <    1500 usec : 6022 transmissions
          1500 ... <    2000 usec : 4185 transmissions
          2000 ... <    5000 usec : 9864 transmissions
          5000 ... <   10000 usec : 2773 transmissions
         10000 ... <   50000 usec : 1462 transmissions
         50000 ... < 1000000 usec : 26 transmissions
                  >= 1000000 usec : 0 transmissions

         4.19.10-rt8
         latency histogram:
             0 ... <     250 usec : 1906861 transmissions
           250 ... <     500 usec : 35271 transmissions
           500 ... <     750 usec : 13103 transmissions
           750 ... <    1000 usec : 9084 transmissions
          1000 ... <    1500 usec : 9434 transmissions
          1500 ... <    2000 usec : 5644 transmissions
          2000 ... <    5000 usec : 12737 transmissions
          5000 ... <   10000 usec : 4511 transmissions
         10000 ... <   50000 usec : 3201 transmissions
         50000 ... < 1000000 usec : 154 transmissions
                  >= 1000000 usec : 0 transmissions


         without extra CPU load the result on kernel 4.19.10-rt8 will be:
         latency histogram:
             0 ... <     250 usec : 1999992 transmissions
           250 ... <     500 usec : 8 transmissions
           500 ... <     750 usec : 0 transmissions
           750 ... <    1000 usec : 0 transmissions
          1000 ... <    1500 usec : 0 transmissions
          1500 ... <    2000 usec : 0 transmissions
          2000 ... <    5000 usec : 0 transmissions
          5000 ... <   10000 usec : 0 transmissions
         10000 ... <   50000 usec : 0 transmissions
         50000 ... < 1000000 usec : 0 transmissions
                  >= 1000000 usec : 0 transmissions
=============================================================


test results with same load and replaced kworker with kthread and assigned an RT priority

         min latency: 0 sec : 75 usec
         max latency: 0 sec : 125 usec
         average latency: 81 usec
         latency measure cycles overall: 79000000
         latency histogram:
             0 ... <     250 usec : 79000000 transmissions
           250 ... <     500 usec : 0 transmissions
           500 ... <     750 usec : 0 transmissions
           750 ... <    1000 usec : 0 transmissions
          1000 ... <    1500 usec : 0 transmissions
          1500 ... <    2000 usec : 0 transmissions
          2000 ... <    5000 usec : 0 transmissions
          5000 ... <   10000 usec : 0 transmissions
         10000 ... <   50000 usec : 0 transmissions
         50000 ... < 1000000 usec : 0 transmissions
                  >= 1000000 usec : 0 transmissions



Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
