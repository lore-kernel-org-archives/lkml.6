Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932426AbeDWTcB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:32:01 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44762 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932122AbeDWTb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:31:56 -0400
X-Google-Smtp-Source: AIpwx4/V8ltPBqlcQJP0zd6bboHUZPunD4tlEpvIgXti61kT4ESyrk5ajOx4Vl76m3MLoulqVAPTY+btX2+lTDxSzQ0=
MIME-Version: 1.0
In-Reply-To: <a21ced59-8cf6-b8e0-2305-fb9d040dfc5c@infradead.org>
References: <20180408194424.8719-1-malat@debian.org> <a21ced59-8cf6-b8e0-2305-fb9d040dfc5c@infradead.org>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 23 Apr 2018 21:31:34 +0200
X-Google-Sender-Auth: 0cXaPauKmTKjtqvbjTkM_Iw2ovg
Message-ID: <CA+7wUsz6m14gCd79NKzKbad1e+1P_=t1-B4na7g5ob16ORQ_8g@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm/radix: add missing braces for single statement block
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3NJWJ7B001578

On Sun, Apr 8, 2018 at 10:34 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 04/08/2018 12:44 PM, Mathieu Malaterre wrote:
>> In commit 7a22d6321c3d ("powerpc/mm/radix: Update command line parsing for
>> disable_radix") an `if` statement was added for a possible empty body
>> (prom_debug).
>>
>> Fix the following warning, treated as error with W=1:
>>
>>   arch/powerpc/kernel/prom_init.c:656:46: error: suggest braces around empty body in an ‘if’ statement [-Werror=empty-body]
>>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>  arch/powerpc/kernel/prom_init.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
>> index 5ae153b97d0a..f0e802495530 100644
>> --- a/arch/powerpc/kernel/prom_init.c
>> +++ b/arch/powerpc/kernel/prom_init.c
>> @@ -652,8 +652,9 @@ static void __init early_cmdline_parse(void)
>>               } else
>>                       prom_radix_disable = true;
>>       }
>> -     if (prom_radix_disable)
>> +     if (prom_radix_disable) {
>>               prom_debug("Radix disabled from cmdline\n");
>
> Looks like the macro for #prom_debug() should be fixed instead.

Well if I try instead:

@@ -101,9 +101,9 @@ int of_workarounds;
 } while (0)

 #ifdef DEBUG_PROM
-#define prom_debug(x...) prom_printf(x)
+#define prom_debug(x...) do { prom_printf(x); } while (0)
 #else
-#define prom_debug(x...)
+#define prom_debug(x...) do { } while (0)
 #endif


the checkpatch script returns:

WARNING: Single statement macros should not use a do {} while (0) loop
#33: FILE: arch/powerpc/kernel/prom_init.c:104:
+#define prom_debug(x...) do { prom_printf(x); } while (0)


So I suspect we cannot do much better than my original patch unfortunately.

>> +     }
>>  }
>>
>>  #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
>>
>
>
> --
> ~Randy
