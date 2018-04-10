Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752068AbeDJU72 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 16:59:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:59278 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeDJU70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 16:59:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="190440055"
Subject: Re: [lkp-robot] [bisect done] e71e836f46 [ 17.567570] WARNING: CPU: 0
 PID: 1 at arch/x86/include/asm/pgtable.h:540 __change_page_attr_set_clr
To: kernel test robot <lkp@intel.com>
References: <20180410011232.ooo3u7v7uxkqoz2o@shao2-debian>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8b734592-0973-b8e3-a1a7-229cdcd8a529@linux.intel.com>
Date: Tue, 10 Apr 2018 13:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410011232.ooo3u7v7uxkqoz2o@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 06:12 PM, kernel test robot wrote:
> +-----------------------------------------------------------------------+------------+------------+------------+------------+
> |                                                                       | 64c8075940 | e71e836f46 | 0564258fb2 | 87e1e2f51c |
> +-----------------------------------------------------------------------+------------+------------+------------+------------+
> | boot_successes                                                        | 35         | 0          | 19         | 11         |
> | boot_failures                                                         | 0          | 26         |            |            |
> | WARNING:at_arch/x86/include/asm/pgtable.h:#__change_page_attr_set_clr | 0          | 26         |            |            |
> | RIP:__change_page_attr_set_clr                                        | 0          | 26         |            |            |
> +-----------------------------------------------------------------------+------------+------------+------------+------------+

LKP folks, does this mean that the system didn't boot in all the places
that we saw this warning?  Or does this just say that it *had* the
warning 26 times?

I looked into this a bit.  This LKP report points the finger at this
commit which trips over a new debugging WARN_ON() I added:

[patch 06/11] x86/mm: Remove extra filtering in pageattr code

It's because set_memory_nx() encounters the (unsupported) _PAGE_GLOBAL
bit while clearing _PAGE_NX.  I never saw this in testing because this
patch:

[PATCH 10/11] x86/pti: never implicitly clear _PAGE_GLOBAL for kernel image

explicitly clears out _PAGE_GLOBAL long before the set_memory_nx() call.
So I *think* this is a transient issue resulting in bad ordering of the
_PAGE_GLOBAL patch set.  I believe it is harmless.

If anyone is encountering real issues, please speak up.
