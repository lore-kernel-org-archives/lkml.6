Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5390BC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10D5024E64
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10D5024E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751999AbeFXJJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:09:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:1672 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbeFXJJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:09:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 02:09:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,265,1526367600"; 
   d="scan'208";a="51442672"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.231.150]) ([10.255.231.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2018 02:09:42 -0700
Subject: Re: [PATCH V7 35/41] x86/intel_rdt: Create debugfs files for
 pseudo-locking testing
To:     kbuild test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@01.org, "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6b2ea76181099d1b79ccfa7d3be24497ab2d1a45.1529706536.git.reinette.chatre@intel.com>
 <201806232005.zVl35hAb%fengguang.wu@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9fafba22-bd84-dc33-8c95-8856791b9d2d@intel.com>
Date:   Sun, 24 Jun 2018 02:09:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <201806232005.zVl35hAb%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/2018 6:07 AM, kbuild test robot wrote:
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on v4.18-rc1]
> [cannot apply to tip/x86/core tip/auto-latest next-20180622]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Reinette-Chatre/Intel-R-Resource-Director-Technology-Cache-Pseudo-Locking-enabling/20180623-065548
> config: x86_64-randconfig-r0-06231921 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> Note: the linux-review/Reinette-Chatre/Intel-R-Resource-Director-Technology-Cache-Pseudo-Locking-enabling/20180623-065548 HEAD c7e9cf1c60a66a41df4d37856b51360dde846b60 builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c: In function 'pseudo_lock_measure_trigger':
>>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:831:6: error: implicit declaration of function 'copy_from_user' [-Werror=implicit-function-declaration]
>      if (copy_from_user(buf, user_buf, buf_size))
>          ^~~~~~~~~~~~~~

Thank you very much for catching this.

Clearly an issue but I was concerned that my testing did not pick this
up since I do run the ktest.pl patchcheck tests to ensure that each
patch from the series compiled cleanly without introducing a new warning.

Thanks to another test from ktest.pl, config_bisect, I was able to learn
that I did not see this issue because I always have CONFIG_FTRACE=y and
the config used in this test did not set it. This error can be
reproduced when the config contains "# CONFIG_FTRACE is not set".

I assume this is why it took us a while to learn about this problem (a
few versions of the patch series was sent to mailing list with this
content) - since it needed a particular config to be encountered.

Thomas, I am sorry for breaking bisect on x86/cache. To fix this the
appropriate header file needs to be added like a snippet below. I am not
submitting a patch since I assume that this fix needs to be folded into
the culprit ("x86/intel_rdt: Create character device exposing
pseudo-locked region") to restore bisect.

The snippet was created against the culprit patch in an attempt for ease
of merging. Three of the patches that follows it in the series also
modifies that area but in my test it did not cause conflicts when
rebased on top of this change. Please let me know what I can do from my
side to help fix this.

8<-----------------
diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 5851f3e20742..4ce0fe05fd82 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/kthread.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <asm/intel-family.h>
 #include <asm/intel_rdt_sched.h>


Reinette
