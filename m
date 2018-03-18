Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeCRVma (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 17:42:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34027 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754026AbeCRVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 17:42:27 -0400
X-Google-Smtp-Source: AG47ELvwmsrmDHJ9qVTLj+Kjh3D5mO+QnwmS9iCdcMqlrdloAhTsOTbnHCUf891VrhHSM/Dt6C5i0g==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] of: Respect CONFIG_CMDLINE{,_EXTENED,_FORCE) with no
 chosen node
From: Michael Clark <mjc@sifive.com>
In-Reply-To: <20180318125150.3i54r7i5edefbhfq@rob-hp-laptop>
Date: Sun, 18 Mar 2018 14:42:23 -0700
Cc: Palmer Dabbelt <palmer@sifive.com>, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Trung Tran <trung.tran@ettus.com>, Moritz Fischer <mdf@kernel.org>,
        Wesley Terpstra <wesley@sifive.com>
Message-Id: <B67897DB-4D0F-4653-ADB2-F90760A0267E@sifive.com>
References: <20180314163105.8638-1-palmer@sifive.com>
 <20180318125150.3i54r7i5edefbhfq@rob-hp-laptop>
To: Rob Herring <robh@kernel.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2ILgZo8022723



> On 18/03/2018, at 5:51 AM, Rob Herring <robh@kernel.org> wrote:
> 
> On Wed, Mar 14, 2018 at 09:31:05AM -0700, Palmer Dabbelt wrote:
>> Systems that boot without a chosen node in the device tree should still
>> respect the command lines that are built into the kernel.  This patch
>> avoids bailing out of the command line argument parsing code when there
>> is no chosen node in the device tree.  This is necessary to boot
>> straight to a root file system (ie, without an initramfs)
>> 
>> The intent here is that the only functional change is to copy
>> CONFIG_CMDLINE into data if both of them are valid (ie, CONFIG_CMDLINE
>> is defined and data is non-null) on systems where there is no chosen
>> device tree node.  I don't actually know what the return values do so I
>> just preserved them.
>> 
>> Thanks to Trung and Moritz for finding the bug during our ELC hackathon
>> (and providing the first fix), and Michal for suggesting this fix (which
>> is cleaner than what I was doing).  I've given this very minimal
>> testing: it fixes the RISC-V bug (in conjunction with a patch to move
>> from COMMANDLINE_OVERRIDE to COMMANDLINE_FORCE), still works on systems
>> with and without the chosen node, and builds on ARM64.
>> 
>> CC: Michael J Clark <mjc@sifive.com>
>> CC: Trung Tran <trung.tran@ettus.com>
>> CC: Moritz Fischer <mdf@kernel.org>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>> drivers/of/fdt.c | 14 ++++++++++++--
>> 1 file changed, 12 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 84aa9d676375..60241b1cb024 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -1084,9 +1084,12 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>> 
>> 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);
>> 
>> -	if (depth != 1 || !data ||
>> +	if (!data)
>> +		goto no_data;
> 
> Just "return 0" here.
> 
>> +
>> +	if (depth != 1 ||
>> 	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
>> -		return 0;
>> +		goto no_chosen;
>> 
>> 	early_init_dt_check_for_initrd(node);
>> 
>> @@ -1117,6 +1120,13 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>> 
>> 	/* break now */
>> 	return 1;
>> +
>> +no_chosen:
>> +#ifdef CONFIG_CMDLINE
>> +	strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
> 
> Best case, this is going to needlessly copy the string on every single 
> node that is not /chosen.
> 
> Worst case, I think this changes behavior. For example, first you copy 
> CONFIG_CMDLINE into data, then on a later iteration, you strlcat 
> CONFIG_CMDLINE into data if CONFIG_CMDLINE_EXTEND is enable. There could 
> also be some unintended behavior if data has a string to start with. 
> 
> I'd really like to see this function re-written to just find the /chosen 
> node and then handle each property one by one. The iterating approach is 
> silly. I assume it predates libfdt and we didn't have nice functions to 
> find nodes by path (or any other way).

Thanks very much for the feedback.

I think we had the right intent, which was to fix the issue in the generic device tree code rather than add a arch specific hack. Previously we had code in arch/riscv/kernel/setup.c which would copy the built-in command line but this clashed with the architecture neutral code, which resulted in appending the compiled-in command twice if the chosen node was present in device-tree. I’m adding Wes to the ‘cc as he has recently changed the HiFive Unleased device-tree to include an empty chosen node which is another workaround for the issue.

We weren’t aware that this code was called in a loop for each device-tree node. I guess one possibility is to hoist the CONFIG_CMDLINE code out of early_init_dt_scan_chosen into early_init_dt_scan and have early_init_dt_scan_chosen append bootargs or optionally ignore it if CONFIG_CMDLINE_OVERRIDE is set.

> I'm working on a patch to re-structure this function. Will send it out 
> in the next day.

Thanks!

It seems logical that the architecture neutral code should set the compiled in command-line if CONFIG_CMDLINE_OVERRIDE is set, whether or not a “chosen” node is present. So we would prefer a fix in the device-tree code over an architecture specific workaround. The problem with an architecture specific workaround outside of device-tree code is that it doesn’t know whether the chosen node is present. I had previously submitted a patch to remove the architecture specific command line code because it duplicated code in drivers/of/fdt.c and resulted in the built-in command being appended twice if the chosen node was present. It was only later that we became aware that it was not possible to use the built-in command line if the “chosen” node was not present.

>> +#endif
>> +no_data:
>> +	return 0;
>> }
>> 
>> #ifdef CONFIG_HAVE_MEMBLOCK
>> -- 
>> 2.16.1
