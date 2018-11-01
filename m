Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A618C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C431720843
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C431720843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeKBDNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:13:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:63452 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbeKBDNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:13:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2018 11:09:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,453,1534834800"; 
   d="scan'208";a="104643229"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga001.jf.intel.com with ESMTP; 01 Nov 2018 11:09:20 -0700
Subject: Re: [PATCH i2c-next v9 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
To:     kbuild test robot <lkp@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, Wolfram Sang <wsa@the-dreams.de>,
        Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org,
        James Feist <james.feist@linux.intel.com>,
        linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, kbuild-all@01.org
References: <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
 <201811020154.eziM0emr%fengguang.wu@intel.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <a126e4ca-69a7-ee23-4e87-e8bc4a3657ac@linux.intel.com>
Date:   Thu, 1 Nov 2018 11:09:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201811020154.eziM0emr%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/2018 10:44 AM, kbuild test robot wrote:
> Hi Jae,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on wsa/i2c/for-next]
> [also build test WARNING on v4.19 next-20181101]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/dt-bindings-i2c-Add-bus-timeout-ms-and-retries-properties-as-common-optional/20181031-051152
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: i386-allyesconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>>> drivers/i2c/busses/i2c-aspeed.c:624:210: warning: 'timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
>        if (time_after(jiffies, timeout))
>                                                                                                                                                                                                                       ^
>     drivers/i2c/busses/i2c-aspeed.c:607:16: note: 'timeout' was declared here
>       unsigned long timeout;
>                     ^~~~~~~
> 
> vim +/timeout +624 drivers/i2c/busses/i2c-aspeed.c
> 
>     604	
>     605	static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
>     606	{
>     607		unsigned long timeout;
>     608	
>     609		if (bus->multi_master) {
>     610			might_sleep();
>     611			/* Initialize it only when multi_master is set */
>     612			timeout = jiffies + bus->adap.timeout;

The 'timeout' variable will be initialized only when bus->multi_master
is true to save some OPs in case this variable isn't used. The saved OPs
are not expensive but it makes a meaning because this function is called
very frequently on every master transfer.

>     613		}
>     614	
>     615		for (;;) {
>     616			if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
>     617			      ASPEED_I2CD_BUS_BUSY_STS))
>     618	#if IS_ENABLED(CONFIG_I2C_SLAVE)
>     619				if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
>     620	#endif
>     621					return 0;
>     622			if (!bus->multi_master)
>     623				break;

If bus->multi_master is false then it doesn't fall through so the
'timeout' variable in below will not be used when itself is
uninitialized. Also, bus->multi_master is fixed at probing time and it
doesn't change at runtime so the warning case never happens.

-Jae

>   > 624			if (time_after(jiffies, timeout))
>     625				break;
>     626			usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
>     627				     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
>     628		}
>     629	
>     630		return aspeed_i2c_recover_bus(bus);
>     631	}
>     632	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
