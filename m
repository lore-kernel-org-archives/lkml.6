Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032998AbeCAQfx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:35:53 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37979 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032742AbeCAQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:35:51 -0500
X-Google-Smtp-Source: AG47ELvPK98PjDxYgLVB/QsVyyPKpKgcF8Cro6z85nHfW+ForoG4q3/9hWUT3ym5AqHQoc79xua98zlA7sMxHQ+15tw=
MIME-Version: 1.0
In-Reply-To: <20180301151359.GC13722@bhelgaas-glaptop.roam.corp.google.com>
References: <cover.1519882849.git.jan.kiszka@siemens.com> <8527c92b2e2920b8cd9096ddcbbb6d0f4004eb69.1519882849.git.jan.kiszka@siemens.com>
 <20180301151359.GC13722@bhelgaas-glaptop.roam.corp.google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 18:35:50 +0200
Message-ID: <CAHp75VcmGCAARtuL5xBNWRN7SLcoh_Gxfkf1shgktTKTDjHn9Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] x86: Consolidate PCI_MMCONFIG configs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>,
        x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jailhouse-dev@googlegroups.com, linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 5:13 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Mar 01, 2018 at 06:40:47AM +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Since e279b6c1d329 ("x86: start unification of arch/x86/Kconfig.*"), we
>> have two PCI_MMCONFIG entries, one from the original i386 and another
>> from x86_64. This consolidates both entries into a single one.
>>
>> The logic for x86_32, where this option was not under user control,
>> remains identical. On x86_64, PCI_MMCONFIG becomes additionally
>> configurable for SFI systems even if ACPI was disabled. This just
>> simplifies the logic without restricting the configurability in any way.
>
> Thanks for mentioning this difference.  It's probably trivial, but if
> you have any other reason to respin this series, I would split this
> into two patches:
>
>   - allow PCI_MMCONFIG on x86_64 with SFI
>   - consolidate PCI_MMCONFIG with no logical change at all
>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>
> But either way,
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>

If you going to respin I would suggest one more trivia

Split long depends on to two lines, like
-      depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY ||
PCI_GOOLPC || PCI_GOMMCONFIG))
+      depends on PCI
+      depends on X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC
|| PCI_GOMMCONFIG)

...

      depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY ||
PCI_GOMMCONFIG))
+     depends on PCI && (ACPI || SFI)
+     depends on X86_64 || (PCI_GOANY || PCI_GOMMCONFIG)

(perhaps in a separate change)

>> ---
>>  arch/x86/Kconfig | 9 +++------
>>  1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eb7f43f23521..aef9d67ac186 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2641,8 +2641,9 @@ config PCI_DIRECT
>>       depends on PCI && (X86_64 || (PCI_GODIRECT || PCI_GOANY || PCI_GOOLPC || PCI_GOMMCONFIG))
>>
>>  config PCI_MMCONFIG
>> -     def_bool y
>> -     depends on X86_32 && PCI && (ACPI || SFI) && (PCI_GOMMCONFIG || PCI_GOANY)
>> +     bool "Support mmconfig PCI config space access" if X86_64
>> +     default y
>> +     depends on PCI && (ACPI || SFI) && (X86_64 || (PCI_GOANY || PCI_GOMMCONFIG))
>>
>>  config PCI_OLPC
>>       def_bool y
>> @@ -2657,10 +2658,6 @@ config PCI_DOMAINS
>>       def_bool y
>>       depends on PCI
>>
>> -config PCI_MMCONFIG
>> -     bool "Support mmconfig PCI config space access"
>> -     depends on X86_64 && PCI && ACPI
>> -
>>  config PCI_CNB20LE_QUIRK
>>       bool "Read CNB20LE Host Bridge Windows" if EXPERT
>>       depends on PCI
>> --
>> 2.13.6
>>



-- 
With Best Regards,
Andy Shevchenko
