Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDD0ECDE44
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5BA2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD5BA2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbeJaH7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:59:52 -0400
Received: from mga09.intel.com ([134.134.136.24]:37157 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbeJaH7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:59:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 16:04:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,446,1534834800"; 
   d="scan'208";a="87651086"
Received: from yoojae-mobl1.amr.corp.intel.com (HELO [10.7.153.143]) ([10.7.153.143])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2018 16:04:24 -0700
Subject: Re: [PATCH i2c-next v9 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Wolfram Sang <wsa@the-dreams.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        openbmc@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Feist <james.feist@linux.intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
References: <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
 <201810310601.Odxb7qSY%fengguang.wu@intel.com>
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <f5d3d3a3-daa3-fef7-853a-2b543fce0379@linux.intel.com>
Date:   Tue, 30 Oct 2018 16:04:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201810310601.Odxb7qSY%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/2018 3:22 PM, kbuild test robot wrote:
> Hi Jae,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on wsa/i2c/for-next]
> [also build test WARNING on v4.19 next-20181030]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/dt-bindings-i2c-Add-bus-timeout-ms-and-retries-properties-as-common-optional/20181031-051152
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=8.1.0 make.cross ARCH=xtensa
> 
> Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
> http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings
> 
> All warnings (new ones prefixed by >>):
> 
>     In file included from include/linux/ktime.h:25,
>                      from include/linux/rcutiny.h:28,
>                      from include/linux/rcupdate.h:209,
>                      from include/linux/srcu.h:33,
>                      from include/linux/notifier.h:16,
>                      from include/linux/clk.h:17,
>                      from drivers/i2c/busses/i2c-aspeed.c:13:
>     drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>>> include/linux/jiffies.h:108:15: warning: 'timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
>        ((long)((b) - (a)) < 0))
>                    ^
>     drivers/i2c/busses/i2c-aspeed.c:607:16: note: 'timeout' was declared here
>       unsigned long timeout;
>                     ^~~~~~~
> --
>     In file included from include/linux/ktime.h:25,
>                      from include/linux/rcutiny.h:28,
>                      from include/linux/rcupdate.h:209,
>                      from include/linux/srcu.h:33,
>                      from include/linux/notifier.h:16,
>                      from include/linux/clk.h:17,
>                      from drivers/i2c//busses/i2c-aspeed.c:13:
>     drivers/i2c//busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>>> include/linux/jiffies.h:108:15: warning: 'timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
>        ((long)((b) - (a)) < 0))
>                    ^
>     drivers/i2c//busses/i2c-aspeed.c:607:16: note: 'timeout' was declared here
>       unsigned long timeout;
>                     ^~~~~~~
> 
> vim +/timeout +108 include/linux/jiffies.h
> 
> ^1da177e Linus Torvalds   2005-04-16   91
> ^1da177e Linus Torvalds   2005-04-16   92  /*
> ^1da177e Linus Torvalds   2005-04-16   93   *	These inlines deal with timer wrapping correctly. You are
> ^1da177e Linus Torvalds   2005-04-16   94   *	strongly encouraged to use them
> ^1da177e Linus Torvalds   2005-04-16   95   *	1. Because people otherwise forget
> ^1da177e Linus Torvalds   2005-04-16   96   *	2. Because if the timer wrap changes in future you won't have to
> ^1da177e Linus Torvalds   2005-04-16   97   *	   alter your driver code.
> ^1da177e Linus Torvalds   2005-04-16   98   *
> ^1da177e Linus Torvalds   2005-04-16   99   * time_after(a,b) returns true if the time a is after time b.
> ^1da177e Linus Torvalds   2005-04-16  100   *
> ^1da177e Linus Torvalds   2005-04-16  101   * Do this with "<0" and ">=0" to only test the sign of the result. A
> ^1da177e Linus Torvalds   2005-04-16  102   * good compiler would generate better code (and a really good compiler
> ^1da177e Linus Torvalds   2005-04-16  103   * wouldn't care). Gcc is currently neither.
> ^1da177e Linus Torvalds   2005-04-16  104   */
> ^1da177e Linus Torvalds   2005-04-16  105  #define time_after(a,b)		\
> ^1da177e Linus Torvalds   2005-04-16  106  	(typecheck(unsigned long, a) && \
> ^1da177e Linus Torvalds   2005-04-16  107  	 typecheck(unsigned long, b) && \
> 5a581b36 Paul E. McKenney 2013-07-27 @108  	 ((long)((b) - (a)) < 0))
> ^1da177e Linus Torvalds   2005-04-16  109  #define time_before(a,b)	time_after(b,a)
> ^1da177e Linus Torvalds   2005-04-16  110
> 
> :::::: The code at line 108 was first introduced by commit
> :::::: 5a581b367b5df0531265311fc681c2abd377e5e6 jiffies: Avoid undefined behavior from signed overflow
> 
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

This is a false warning.

The 'timeout' local variable will be initialized properly if it's gonna
be used when the multi-master property is set.

-Jae
