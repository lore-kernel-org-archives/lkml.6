Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25598C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E1920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 00:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfACAoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 19:44:34 -0500
Received: from mga01.intel.com ([192.55.52.88]:5086 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfACAoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 19:44:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 16:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="122814579"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga002.jf.intel.com with ESMTP; 02 Jan 2019 16:44:34 -0800
Subject: Re: [LKP] bea5b158ff BUG: kernel reboot-without-warning in
 boot-around-mounting-root stage
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
References: <20190102011512.GF17624@shao2-debian>
 <20190102095844.GB14448@kroah.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <728637bb-3ffe-d19a-4ca9-5abe1617e12a@intel.com>
Date:   Thu, 3 Jan 2019 08:44:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20190102095844.GB14448@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 05:58 PM, Greg Kroah-Hartman wrote:
> On Wed, Jan 02, 2019 at 09:15:12AM +0800, kernel test robot wrote:
>> Greetings,
>>
>> 0day kernel testing robot got the below dmesg and the first bad commit is
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>
>> commit bea5b158ff0da9c7246ff391f754f5f38e34577a
>> Author:     Rob Herring <robh@kernel.org>
>> AuthorDate: Thu Aug 11 10:20:58 2016 -0500
>> Commit:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> CommitDate: Wed Aug 31 15:13:55 2016 +0200
>>
>>      driver core: add test of driver remove calls during probe
>>      
>>      In recent discussions on ksummit-discuss[1], it was suggested to do a
>>      sequence of probe, remove, probe for testing driver remove paths. This
>>      adds a kconfig option for said test.
>>      
>>      [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-August/003459.html
>>      
>>      Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>      Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Signed-off-by: Rob Herring <robh@kernel.org>
>>      Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> cebf8fd169  driver core: fix race between creating/querying glue dir and its cleanup
>> bea5b158ff  driver core: add test of driver remove calls during probe
>> e1ef035d27  Merge tag 'armsoc-defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
>> 6a1d293238  Add linux-next specific files for 20181224
>> +----------------------------------------------------------------------+------------+------------+------------+---------------+
>> |                                                                      | cebf8fd169 | bea5b158ff | e1ef035d27 | next-20181224 |
>> +----------------------------------------------------------------------+------------+------------+------------+---------------+
>> | boot_successes                                                       | 31         | 0          | 0          | 0             |
>> | boot_failures                                                        | 0          | 11         | 11         | 7             |
>> | BUG:kernel_reboot-without-warning_in_boot-around-mounting-root_stage | 0          | 11         | 11         | 7             |
>> +----------------------------------------------------------------------+------------+------------+------------+---------------+
>>
>> [   14.073515] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>> [   14.095297] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
>> [   14.177113] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
>> [   14.256672] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
>> [   14.278578] console [ttyS0] disabled
>> BUG: kernel reboot-without-warning in boot-around-mounting-root stage
>>
>>
>>                                                            # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
>> git bisect start v4.9 v4.8 --
> You are testing the 4.9 kernel release here?
>
> A commit from 2016 is a "problem"?  Are you sure this is still an issue?

I'm very sorry for the old commit report, we're testing latest code,
and the robot shouldn't track old commits. we'll fix it.

Best Regards,
Rong Chen

>
> thanks,
>
> greg k-h

