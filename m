Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752194AbeDKAf5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 20:35:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:40568 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751825AbeDKAf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 20:35:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,434,1517904000";
   d="scan'208";a="41057913"
Date: Wed, 11 Apr 2018 08:35:53 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@01.org>
Subject: Re: [lkp-robot] [bisect done] e71e836f46 [ 17.567570] WARNING: CPU:
 0 PID: 1 at arch/x86/include/asm/pgtable.h:540 __change_page_attr_set_clr
Message-ID: <20180411003553.jtmydjialbbgb6hx@wfg-t540p.sh.intel.com>
References: <20180410011232.ooo3u7v7uxkqoz2o@shao2-debian>
 <8b734592-0973-b8e3-a1a7-229cdcd8a529@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8b734592-0973-b8e3-a1a7-229cdcd8a529@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Apr 10, 2018 at 01:59:21PM -0700, Dave Hansen wrote:
>On 04/09/2018 06:12 PM, kernel test robot wrote:
>> +-----------------------------------------------------------------------+------------+------------+------------+------------+
>> |                                                                       | 64c8075940 | e71e836f46 | 0564258fb2 | 87e1e2f51c |
>> +-----------------------------------------------------------------------+------------+------------+------------+------------+
>> | boot_successes                                                        | 35         | 0          | 19         | 11         |
>> | boot_failures                                                         | 0          | 26         |            |            |
>> | WARNING:at_arch/x86/include/asm/pgtable.h:#__change_page_attr_set_clr | 0          | 26         |            |            |
>> | RIP:__change_page_attr_set_clr                                        | 0          | 26         |            |            |
>> +-----------------------------------------------------------------------+------------+------------+------------+------------+
>
>LKP folks, does this mean that the system didn't boot in all the places
>that we saw this warning?  Or does this just say that it *had* the
>warning 26 times?

The 'e71e836f46' column means there are 0 boots (sorry boot_successes
might be a bit confusing) with clean dmesg and 26 boots with
warning/error dmesg. It indicates that WARNING is 100% reproducible.

        boot_successes + boot_failures = total test boots

>I looked into this a bit.  This LKP report points the finger at this
>commit which trips over a new debugging WARN_ON() I added:
>
>[patch 06/11] x86/mm: Remove extra filtering in pageattr code
>
>It's because set_memory_nx() encounters the (unsupported) _PAGE_GLOBAL
>bit while clearing _PAGE_NX.  I never saw this in testing because this
>patch:
>
>[PATCH 10/11] x86/pti: never implicitly clear _PAGE_GLOBAL for kernel image
>
>explicitly clears out _PAGE_GLOBAL long before the set_memory_nx() call.
>So I *think* this is a transient issue resulting in bad ordering of the
>_PAGE_GLOBAL patch set.  I believe it is harmless.

Right. The '0564258fb2' and '87e1e2f51c' columns mean the
'tip/x86/pti' and 'tip/master' branch HEADs boot clean.
So it's a transient warning inside the branch.

Thanks,
Fengguang
