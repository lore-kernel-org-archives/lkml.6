Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeCOU2O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 16:28:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:63508 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751557AbeCOU2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 16:28:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,312,1517904000";
   d="scan'208";a="26047757"
Date: Fri, 16 Mar 2018 04:26:02 +0800
From: kbuild test robot <lkp@intel.com>
To: Petr Mladek <pmladek@suse.com>
Cc: kbuild-all@01.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v3] vsprintf: Prevent crash when dereferencing invalid
 pointers
Message-ID: <201803160421.Gpw1xNAf%fengguang.wu@intel.com>
References: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180314140947.rs3b6i5gguzzu5wi@pathway.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16-rc5 next-20180314]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/vsprintf-Prevent-crash-when-dereferencing-invalid-pointers/20180315-214100
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> lib/vsprintf.c:533:16: sparse: Using plain integer as NULL pointer
   lib/vsprintf.c:762:18: sparse: Variable length array is used.
   lib/vsprintf.c:765:38: sparse: cannot size expression
   lib/vsprintf.c:1532:23: sparse: incorrect type in assignment (different base types) @@    expected unsigned long [unsigned] [assigned] flags @@    got  long [unsigned] [assigned] flags @@
   lib/vsprintf.c:1532:23:    expected unsigned long [unsigned] [assigned] flags
   lib/vsprintf.c:1532:23:    got restricted gfp_t [usertype] <noident>

vim +533 lib/vsprintf.c

   522	
   523	static const char *check_pointer_access(const void *ptr)
   524	{
   525		unsigned char byte;
   526	
   527		if (!ptr)
   528			return "(null)";
   529	
   530		if (probe_kernel_read(&byte, ptr, 1))
   531			return "(efault)";
   532	
 > 533		return 0;
   534	}
   535	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
