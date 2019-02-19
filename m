Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CFAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D034C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfBSTeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:34:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:7330 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfBSTeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:34:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 11:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="125651311"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 19 Feb 2019 11:34:01 -0800
Received: from [10.254.80.103] (acjohnso-mobl1.amr.corp.intel.com [10.254.80.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E32E858019B;
        Tue, 19 Feb 2019 11:34:00 -0800 (PST)
Subject: Re: [PATCH 05/11] x86 topology: export die_siblings
To:     "Brown, Len" <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <635b2bf8b1151a191cd9299276b75791a818c0c2.1550545163.git.len.brown@intel.com>
 <0d54a56186fb9be7a8f622a4625a41dc600dd7a4.1550545163.git.len.brown@intel.com>
 <59e07a24-dc44-c21b-91d4-ea04e8d0653e@linux.intel.com>
 <1A7043D5F58CCB44A599DFD55ED4C9485C5B75B9@FMSMSX126.amr.corp.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <70ea25e2-6538-77ec-8686-40567e8d362b@linux.intel.com>
Date:   Tue, 19 Feb 2019 14:33:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1A7043D5F58CCB44A599DFD55ED4C9485C5B75B9@FMSMSX126.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/2019 1:43 PM, Brown, Len wrote:
> Thanks for the comments, Kan,
> 
>>> diff --git a/Documentation/cputopology.txt
>>> b/Documentation/cputopology.txt index 287213b4517b..7dd2ae3df233
>>> 100644
>>> --- a/Documentation/cputopology.txt
>>> +++ b/Documentation/cputopology.txt
>>> @@ -56,6 +56,16 @@ core_siblings_list:
>>>    	human-readable list of cpuX's hardware threads within the same
>>>    	die_id.
>>>    
>>> +die_siblings:
>>> +
>>> +	internal kernel map of cpuX's hardware threads within the same
>>> +	physical_package_id.
>>> +
>>> +die_siblings_list:
>>> +
>>> +	human-readable list of cpuX's hardware threads within the same
>>> +	physical_package_id.
>>> +
>>>    book_siblings:
>>>    
>>>    	internal kernel map of cpuX's hardware threads within the same diff
> 
>> Could you please update the document regarding to topology_die_cpumask and topology_core_cpumask in Documentation/x86/topology.txt
>   
> I agree that the top part of this file, as updated above, should document the external sysfs interface...
> 
> I'm less excited about the center of the file trying to document the internal implementation -- as the source code
> is actually more clear than the document, but here is an update, consistent with the existing file.
> Let me know if it does not fully address your comment.
>

Besides the generic document, I think we should update x86 document as 
well, which is in Documentation/x86/topology.txt.

The definition of topology_core_cpumask has to be changed to per die, right?

diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.txt
index 8107b6c..8698a41 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.txt
@@ -105,11 +105,16 @@ The topology of a system is described in the units of:

    Thread-related topology information in the kernel:

-  - topology_core_cpumask():
+  - topology_die_cpumask():

      The cpumask contains all online threads in the package to which a 
thread
      belongs.

+  - topology_core_cpumask():
+
+    The cpumask contains all online threads in the die to which a thread
+    belongs.
+
      The number of online threads is also printed in /proc/cpuinfo 
"siblings."

    - topology_sibling_cpumask():


Thanks,
Kan

> Thanks,
> -Len
> ---
> 
> diff --git a/Documentation/cputopology.txt b/Documentation/cputopology.txt
> index 7dd2ae3..f39c759 100644
> --- a/Documentation/cputopology.txt
> +++ b/Documentation/cputopology.txt
> @@ -102,6 +102,7 @@ these macros in include/asm-XXX/topology.h::
>          #define topology_drawer_id(cpu)
>          #define topology_sibling_cpumask(cpu)
>          #define topology_core_cpumask(cpu)
> +       #define topology_die_cpumask(cpu)
>          #define topology_book_cpumask(cpu)
>          #define topology_drawer_cpumask(cpu)
> 
> @@ -114,10 +115,11 @@ To be consistent on all architectures, include/linux/topology.h
>   provides default definitions for any of the above macros that are
>   not defined by include/asm-XXX/topology.h:
> 
> -1) physical_package_id: -1
> -2) core_id: 0
> -3) sibling_cpumask: just the given CPU
> -4) core_cpumask: just the given CPU
> +1) topology_physical_package_id: -1
> +2) topology_core_id: 0
> +3) topology_sibling_cpumask: just the given CPU
> +4) topology_core_cpumask: just the given CPU
> +5) topology_die_cpumask: just the given CPU
> 
>   For architectures that don't support books (CONFIG_SCHED_BOOK) there are no
>   default definitions for topology_book_id() and topology_book_cpumask().
> 
> 
