Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeA3GNz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 01:13:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:49699 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752325AbeA3GNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 01:13:54 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36308432"
Subject: Re: Question about dmesg/sysfs output when retpoline config is
 disabled
To: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>,
        <linux-kernel@vger.kernel.org>
References: <00bcb291-2b99-1122-9eb3-13c191fa3a5b@jp.fujitsu.com>
CC: <dwmw@amazon.co.uk>, <tglx@linutronix.de>, <arjan@linux.intel.com>,
        <mingo@kernel.org>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        <dave.hansen@intel.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f5892721-7528-3647-08fb-f8d10e65ad87@cn.fujitsu.com>
Date: Tue, 30 Jan 2018 14:13:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <00bcb291-2b99-1122-9eb3-13c191fa3a5b@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 8ED7A48AEA1E.AEE24
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Misono-san,

At 01/30/2018 12:52 PM, Misono, Tomohiro wrote:
> Hello,
> 
> I think dmesg/sysfs output messages are not suitable if retpoline config is off:
> 
> I intentionally compiled the kernel 4.15.0 with CONFIG_RETPOLINE=n for test and
> boot it with the following kernel command line option to check dmesg/sysfs:
> 
> (a) no command line option or "spectre_v2=on" or "spectre_v2=auto"
> $ dmesg | grep -i spectre
> [    0.017714] Spectre V2 mitigation: Vulnerable: Minimal generic ASM retpoline
> $ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Minimal generic ASM retpoline
> 
> (b) "spectre_v2=off"
> $ dmesg | grep -i spectre
> [    0.017002] Spectre V2 mitigation: disabled on command line.
> $ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Vulnerable
> 
> (c) "spectre_v2=retpoline"
> $ dmesg | grep -i spectre
> [    0.018002] Spectre V2 mitigation: kernel not compiled with retpoline; no mitigation available!
> $ cat /sys/devices/system/cpu/vulnerabilities/spectre_v2
> Vulnerable
> 
> I think the output of (c) is correct for this case, or are these outputs actually right?
> 
> Also, the output of (a) is the same with following condition:
>   (1) CONFIG_RETPOLINE=n, and
>   (2) CONFIG_RETPOLINE=y but the compiler did not support retpoline
> These cannot be distinguished unless option of (c) is explicitly used.
> 

+Cc maintainers and x86 mail list... first.

IMO, Selecting 'on' or 'auto' to "spectre_v2=" should also consider the
setting of the CONFIG_RETPOLINE configuration option.

So, check if CONFIG_RETPOLINE is y before setup CPU capability.

Thanks,
	dou.

--------------8<-----------------------------
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 390b3dc3d438..10188f856099 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -193,8 +193,9 @@ static void __init spectre_v2_select_mitigation(void)
         case SPECTRE_V2_CMD_FORCE:
                 /* FALLTRHU */
         case SPECTRE_V2_CMD_AUTO:
-               goto retpoline_auto;
-
+               if (IS_ENABLED(CONFIG_RETPOLINE))
+                       goto retpoline_auto;
+               break;
         case SPECTRE_V2_CMD_RETPOLINE_AMD:
                 if (IS_ENABLED(CONFIG_RETPOLINE))
                         goto retpoline_amd;

> Regards,
> Tomohiro Misono
> 
> 
> 
> 
