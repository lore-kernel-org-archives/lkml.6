Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B198C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0498A2147C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfBYKYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:24:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:3431 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfBYKYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:24:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 02:24:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,411,1544515200"; 
   d="scan'208";a="124990832"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga007.fm.intel.com with ESMTP; 25 Feb 2019 02:24:10 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1gyDQf-00081P-LS; Mon, 25 Feb 2019 12:24:09 +0200
Date:   Mon, 25 Feb 2019 12:24:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        me@jue.yt, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
        wsa@the-dreams.de
Subject: Re: [PATCH v5 0/3] i2c: at91: slave mode support
Message-ID: <20190225102409.GQ9224@smile.fi.intel.com>
References: <20190222092522.4913-1-ludovic.desroches@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222092522.4913-1-ludovic.desroches@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 10:25:19AM +0100, Ludovic Desroches wrote:
> [Ludovic Desroches: see Changes section]
> 
> Based on the discussion we had on the i2c-linux list [1], I wrote a patch for
> AT91 hardware and tried to fulfill the Linux I2C slave interface description
> [2] as good as possible. This enables aforementioned hardware to act as an I2C
> slave that can be accessed by a remote I2C master.
> 
> I have tested this patchset successfully on an ATSAMA5D27.
> 
>                                  ^  3.3V   ^  3.3V
>     +-----------------------+    |         |         +-----------------------+
>     | Slave: ATSAMA5D27     |   +-+       +-+        | Master: ATSAMA5D35    |
>     | with i2c-slave-eeprom |   | | 100k  | | 100k   | with i2cset           |
>     +-------------------+-+-+   +-+       +-+        +-+-+-------------------+
>                         | |      |         |           | |
>                         | +------+---------|---(SDA)---+ |
>                         +------------------+---(SCL)-----+
> 
>     Schematic: Connection of slave and master with 100kOhm pullup resistors.
> 
> On the master the following BASH script has been used to stress the slave.
> 
>         root@emblinux:~# cat ./stress.sh

>         #!/bin/bash

Not everybody has bash in their environments. See below, how easily to switch
to regular shell.

#!/bin/sh

>         I=0
>         while true
>         do
>                 if i2cset -y -r 1 0x64 0 $I w | grep mismatch
>                 then
>                         echo "$(date): Error in transmission ${I}"
>                 fi

>                 ((I++))

I=$(($I+1))

>                 if [ $I -eq 65536 ]
>                 then
>                         I=0
>                         echo "$(date): Sent 65536 transmissions"
>                 fi

This one can be optimized to

for I in $(seq 65536); do
...
done

>         done
> 
> After running the script for some time I had the following output. To me this
> looks promising :)
> 
>         root@emblinux:~# ./stress.sh
>         Thu Nov  9 13:58:45 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 14:35:20 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:12:11 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 15:49:04 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 16:26:00 CTE 2017: Sent 65536 transmissions
>         Thu Nov  9 17:03:07 UTC 2017: Sent 65536 transmissions
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.
>         Thu Nov  9 17:40:15 UTC 2017: Sent 65536 transmissions
> 
>         If you have some hardware with an at91-i2c interface included at hand, I really
>         would appreciate if you can run the test script on your hardware and test this
>         driver.

-- 
With Best Regards,
Andy Shevchenko


