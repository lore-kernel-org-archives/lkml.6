Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752507AbeEPKoZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:44:25 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:52683 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeEPKoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:44:22 -0400
Subject: =?UTF-8?Q?Re:_[PATCH_v10_00/27]_ARM:_davinci:_convert_to_common_clo?=
 =?UTF-8?B?Y2sgZnJhbWV3b3Jr4oCL?=
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>
CC: Bartosz Golaszewski <brgl@bgdev.pl>,
        David Lechner <david@lechnology.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180509172606.29387-1-david@lechnology.com>
 <CAHCN7xJ6+vmyrTQGYH=pKz5GRf7rLT4otreNgu6TJi_3UAEX5w@mail.gmail.com>
 <CAMRc=MdO0EtzDHp3RF4ym3umWM_KfhvpWHV2+Y3270ygKz9iGw@mail.gmail.com>
 <CAHCN7xJt=tsc2zHWu+6y_2z=+kHdaovh3TD_MJ1+UeUbTdyj8w@mail.gmail.com>
 <CAMpxmJUKGS_wm1O+HJBt2yY=BQ4169ka1p0264O-PJFdGj5Fdg@mail.gmail.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <c16cdbb3-c4a2-b1e3-0804-6bfc4249641d@ti.com>
Date: Wed, 16 May 2018 16:13:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMpxmJUKGS_wm1O+HJBt2yY=BQ4169ka1p0264O-PJFdGj5Fdg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 16 May 2018 01:17 PM, Bartosz Golaszewski wrote:
> 2018-05-16 0:44 GMT+02:00 Adam Ford <aford173@gmail.com>:
>> On Tue, May 15, 2018 at 4:25 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>> 2018-05-14 2:40 GMT+02:00 Adam Ford <aford173@gmail.com>:
>>>> On Wed, May 9, 2018 at 12:25 PM, David Lechner <david@lechnology.com> wrote:
>>>>> This series converts mach-davinci to use the common clock framework.
>>>>>
>>>>> The series works like this, the first 3 patches fix some issues with the clock
>>>>> drivers that have already been accepted into the mainline kernel.
>>>>>
>>>>> Then, starting with "ARM: davinci: pass clock as parameter to
>>>>> davinci_timer_init()", we get the mach code ready for the switch by adding the
>>>>> code needed for the new clock drivers and adding #ifndef CONFIG_COMMON_CLK
>>>>> around the legacy clocks so that we can switch easily between the old and the
>>>>> new.
>>>>>
>>>>> "ARM: davinci: switch to common clock framework" actually flips the switch
>>>>> to start using the new clock drivers. Then the next 8 patches remove all
>>>>> of the old clock code.
>>>>>
>>>>> The final four patches add device tree clock support to the one SoC that
>>>>> supports it.
>>>>>
>>>>> This series has been tested on TI OMAP-L138 LCDK (both device tree and legacy
>>>>> board file).
>>>>>
>>>>
>>>> I am not sure if I did something wrong, but I attempted to build and I
>>>> wasn't able to boot the da850-evm.dtb your repo common-clk-v11,
>>>> however the legacy board file boot was OK.
>>>>
>>>> make davinci_all_defconfig ARCH=arm
>>>> make zImage modules da850-evm.dtb ARCH=arm CROSS_COMPILE=arm-linux- -j8
>>>>
>>>> 3140416 bytes read in 1464 ms (2 MiB/s)
>>>> 20353 bytes read in 15 ms (1.3 MiB/s)
>>>> ## Flattened Device Tree blob at c0600000
>>>>    Booting using the fdt blob at 0xc0600000
>>>>    Loading Device Tree to c7e57000, end c7e5ef80 ... OK
>>>>
>>>> Starting kernel ...
>>>>
>>>> Uncompressing Linux... done, booting the kernel.
>>>>
>>>> (and hang)
>>>>
>>>> If you have some suggestions, I am try them as I get time.
>>>>
>>>> adam
>>>>
>>>
>>> Runs fine on da850-lcdk and dm365-evm. I'll test the da850-evm
>>> tomorrow when I'll have access to it.
>>
>> I set the bootargs to: bootargs=console=ttyS2,115200n8
>> clk_ignore_unused root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait
>>
>> I enabled DEBUG_LL and EARLY_PRINTK, yet when it loads, I only get:

With DEBUG_LL, you dont get any prints "automatically". You need add 
printascii() calls where you need. I use the attached patch which 
patches printk() calls with printascii()[1]

>>
>> ## Flattened Device Tree blob at c0600000
>>    Booting using the fdt blob at 0xc0600000
>>    Loading Device Tree to c7e57000, end c7e5ef35 ... OK
>>
>> Starting kernel ...
>>
>> Uncompressing Linux... done, booting the kernel.
>>
>>
>> I am doing this at my home, so I don't have a debugger for the
>> DA850-EVM.  I am using a SOM that is an AM1808, but I vaguely remember
>> something about enabling a DSP clock somewhere, but I cannot seem to
>> find the e-mail.  I know its counter intuitive that we'd need to
>> enable a clock that runs the DSP since it doesn't exist on the AM1808,
>> but I would have thought the clk_ignore_unused would have worked
>> around that issue.
>>
>> If someone else has a DA850-EVM or suggestions, I'm willing to try
>> them as I have time.
>>
>> adam
> 
> Hi Adam,
> 
> everything works fine for me both when booting the DTB and in legacy
> mode on da850-evm.
> 
> I'm using the following bootargs:
>     ip=dhcp console=ttyS2,115200n8 root=/dev/nfs rw nfsroot=<snip!>,v3
> nfsrootdebug
> 
> Regular davinci_all_defconfig on David's common-clk-v11 branch.

Adam, if you still cannot get it to work, one problem could be that the 
DT size has increased and its being overwritten. You could look at where 
you are loading various binaries. Or append the .dtb to zImage and 
switch on APPENDED_DTB config in kernel.

Thanks,
Sekhar

[1]
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5b5a708..c3419c0 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1488,6 +1488,7 @@ static size_t cont_print_text(char *text, size_t size)
 	return textlen;
 }
 
+void printascii(char *);
 asmlinkage int vprintk_emit(int facility, int level,
 			    const char *dict, size_t dictlen,
 			    const char *fmt, va_list args)
@@ -1552,6 +1553,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 		text_len--;
 		lflags |= LOG_NEWLINE;
 	}
+	printascii(text);
 
 	/* strip kernel syslog prefix and extract log level or control flags */
 	if (facility == 0) {
