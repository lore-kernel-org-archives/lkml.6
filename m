Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932489AbeCMKD7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:03:59 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:30073 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeCMKD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:03:57 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w2DA3lF7012222
X-Nifty-SrcIP: [209.85.217.173]
X-Google-Smtp-Source: AG47ELsb4DHeXL8EvHxmDARlOU5k4iFP/PscZGA80njKRM0h9tH1kWpkd3eDnWJLvVGzGxsBKJegRG4PLJaxCK9GNo0=
MIME-Version: 1.0
In-Reply-To: <20180312225945.GA29113@vmlxhi-102.adit-jv.com>
References: <1520697119-17483-1-git-send-email-yamada.masahiro@socionext.com> <20180312225945.GA29113@vmlxhi-102.adit-jv.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 13 Mar 2018 19:03:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNASif6a4T8KB+MBCeeHv7amHeReApyjWuvo3sOMevgHtig@mail.gmail.com>
Message-ID: <CAK7LNASif6a4T8KB+MBCeeHv7amHeReApyjWuvo3sOMevgHtig@mail.gmail.com>
Subject: Re: [PATCH v3] kconfig: make unmet dependency warnings readable
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>, Petr Vorel <pvorel@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-13 7:59 GMT+09:00 Eugeniu Rosca <erosca@de.adit-jv.com>:
> Hi Masahiro,
>
> Some "final polishing" review comments. Feel free to pick/drop them at
> your will.
>
> On Sun, Mar 11, 2018 at 12:51:59AM +0900, Masahiro Yamada wrote:
>> Currently, the unmet dependency warnings end up with endlessly long
>> expressions, most of which are false positives.
>>
>> Here is test code to demonstrate how it currently works.
>>
>> [Test Case]
>>
>>   config DEP1
>>           def_bool y
>>
>>   config DEP2
>>           bool "DEP2"
>>
>>   config A
>>           bool "A"
>>           select E
>>
>>   config B
>>           bool "B"
>>           depends on DEP2
>>           select E
>>
>>   config C
>>           bool "C"
>>           depends on DEP1 && DEP2
>>           select E
>>
>>   config D
>>           def_bool n
>>           select E
>>
>>   config E
>>           bool
>>           depends on DEP1 && DEP2
>>
>> [Result]
>>
>>   $ make config
>>   scripts/kconfig/conf  --oldaskconfig Kconfig
>>   *
>>   * Linux Kernel Configuration
>>   *
>>   DEP2 (DEP2) [N/y/?] (NEW) n
>>   A (A) [N/y/?] (NEW) y
>>   warning: (A && B && D) selects E which has unmet direct
>>   dependencies (DEP1 && DEP2)
>>
>> Here, I see some points to be improved.
>>
>> First, '(A || B || D)' would make more sense than '(A && B && D)'.
>> I am not sure if this is intentional, but expr_simplify_unmet_dep()
>> turns OR expressions into AND, like follows:
>>
>>         case E_OR:
>>                 return expr_alloc_and(
>>
>> Second, we see false positives.  'A' is a real unmet dependency.
>> 'B' is false positive because 'DEP1' is fixed to 'y', and 'B' depends
>> on 'DEP2'.  'C' was correctly dropped by expr_simplify_unmet_dep().
>> 'D' is also false positive because it has no chance to be enabled.
>> Current expr_simplify_unmet_dep() cannot avoid those false positives.
>>
>> After all, I decided to use the same helpers as used for printing
>> reverse dependencies in the help.
>>
>> With this commit, unreadable warnings in the real world:
>>
>> $ make ARCH=score allyesconfig
>> scripts/kconfig/conf  --allyesconfig Kconfig
>> warning: (HWSPINLOCK_QCOM && AHCI_MTK && STMMAC_PLATFORM && DWMAC_IPQ806X
>> && DWMAC_LPC18XX && DWMAC_OXNAS && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMA
>> C_STI && TI_CPSW && PINCTRL_GEMINI && PINCTRL_OXNAS && PINCTRL_ROCKCHIP &&
>>  PINCTRL_DOVE && PINCTRL_ARMADA_37XX && PINCTRL_STM32 && S3C2410_WATCHDOG
>> && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK && RTC_DRV_AT91SAM9 && LP
>> C18XX_DMAMUX && VIDEO_OMAP4 && COMMON_CLK_GEMINI && COMMON_CLK_ASPEED && C
>> OMMON_CLK_NXP && COMMON_CLK_OXNAS && COMMON_CLK_BOSTON && ATMEL_ST && QCOM
>> _ADSP_PIL && QCOM_Q6V5_PIL && QCOM_GSBI && ATMEL_EBI && ST_IRQCHIP && RESE
>> T_IMX7 && PHY_HI6220_USB && PHY_RALINK_USB && PHY_ROCKCHIP_PCIE && PHY_DA8
>> XX_USB) selects MFD_SYSCON which has unmet direct dependencies (HAS_IOMEM)
>> warning: (PINCTRL_AT91 && PINCTRL_AT91PIO4 && PINCTRL_OXNAS && PINCTRL_PIS
>> TACHIO && PINCTRL_PIC32 && PINCTRL_MESON && PINCTRL_NOMADIK && PINCTRL_MTK
>>  && PINCTRL_MT7622 && GPIO_TB10X) selects OF_GPIO which has unmet direct d
>> ependencies (GPIOLIB && OF && HAS_IOMEM)
>> warning: (FAULT_INJECTION_STACKTRACE_FILTER && LATENCYTOP && LOCKDEP) sele
>> cts FRAME_POINTER which has unmet direct dependencies (DEBUG_KERNEL && (CR
>> IS || M68K || FRV || UML || SUPERH || BLACKFIN || MN10300 || METAG) || ARC
>> H_WANT_FRAME_POINTERS)
>>
>> will be turned into:
>>
>> $ make ARCH=score allyesconfig
>> scripts/kconfig/conf  --allyesconfig Kconfig
>>
>> WARNING: unmet direct dependencies detected for MFD_SYSCON
>>  Depends on:
>
> Here imho `Depends on [n]:` is more inline with the "Selected by [y|m]"
> family, but this could be subjective. `[n]` might be helpful for long
> direct dependencies, like seen below for FRAME_POINTER. No strong
> preference about it.


I did so.

I took into consideration 'Depends on [m]' case too.
I inserted another patch before this.


>>     HAS_IOMEM [=n]
>
> Adding a minus in front of expression, i.e. `  - HAS_IOMEM [=n]`
> is probably more inline with how reverse dependencies are printed.

I did not take this.
The expression for 'depends on' is not so long, so we expect a single
line for this.
Itemization is generally used when we expect multiple lines, IMHO.


>>  Selected by [y]:
>
> Shifting this line to the right by one space symbol would resemble the
> `make menuconfig` output. No strong preference about it.

I did so.

>>   - PINCTRL_STM32 [=y] && PINCTRL [=y] && (ARCH_STM32 || COMPILE_TEST [=y])
>> && OF [=y]
>>   - RTC_DRV_AT91SAM9 [=y] && RTC_CLASS [=y] && (ARCH_AT91 || COMPILE_TEST
>> [=y])
>>   - ATMEL_ST [=y] && GENERIC_CLOCKEVENTS [=y]
>>   - RESET_IMX7 [=y] && RESET_CONTROLLER [=y]
>>   - PHY_HI6220_USB [=y] && (ARCH_HISI && ARM64 || COMPILE_TEST [=y])
>>   - PHY_RALINK_USB [=y] && (RALINK || COMPILE_TEST [=y])
>>   - PHY_ROCKCHIP_PCIE [=y] && (ARCH_ROCKCHIP && OF [=y] || COMPILE_TEST
>> [=y])
>>
>> WARNING: unmet direct dependencies detected for OF_GPIO
>>  Depends on:
>
> Likewise, shifting the above line to the right by one space would make
> it similar to what's generated by `make menuconfig`.

I did so.


>>     GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
>>  Selected by [y]:
>>   - PINCTRL_MTK [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
>> [=y]) && OF [=y]
>>   - PINCTRL_MT7622 [=y] && PINCTRL [=y] && (ARCH_MEDIATEK || COMPILE_TEST
>> [=y]) && OF [=y] && (ARM64 || COMPILE_TEST [=y])
>>
>> WARNING: unmet direct dependencies detected for FRAME_POINTER
>>  Depends on:
>>     DEBUG_KERNEL [=y] && (CRIS || M68K || FRV || UML || SUPERH || BLACKFIN
>>  || MN10300 || METAG) || ARCH_WANT_FRAME_POINTERS [=n]
>>  Selected by [y]:
>>   - LATENCYTOP [=y] && DEBUG_KERNEL [=y] && STACKTRACE_SUPPORT [=y] &&
>> PROC_FS [=y] && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM_UNWIND &&
>> !ARC && !X86
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
>> ---
>>
>> Changes in v3:
>>   - Remove unused expr_get_leftmost_symbol()
>>   - Move error message to the same line as 'WARNING'
>>   - update test case
>>
>> Changes in v2:
>>   - update test case
>>
>>  scripts/kconfig/expr.c   | 42 ------------------------------------------
>>  scripts/kconfig/expr.h   |  1 -
>>  scripts/kconfig/symbol.c | 34 ++++++++++++++++++++++------------
>>  3 files changed, 22 insertions(+), 55 deletions(-)
>>
>> diff --git a/scripts/kconfig/expr.c b/scripts/kconfig/expr.c
>> index 49376e1..e1a39e9 100644
>> --- a/scripts/kconfig/expr.c
>> +++ b/scripts/kconfig/expr.c
>> @@ -1137,48 +1137,6 @@ static int expr_compare_type(enum expr_type t1, enum expr_type t2)
>>       return 0;
>>  }
>>
>> -static inline struct expr *
>> -expr_get_leftmost_symbol(const struct expr *e)
>> -{
>> -
>> -     if (e == NULL)
>> -             return NULL;
>> -
>> -     while (e->type != E_SYMBOL)
>> -             e = e->left.expr;
>> -
>> -     return expr_copy(e);
>> -}
>> -
>> -/*
>> - * Given expression `e1' and `e2', returns the leaf of the longest
>> - * sub-expression of `e1' not containing 'e2.
>> - */
>> -struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2)
>> -{
>> -     struct expr *ret;
>> -
>> -     switch (e1->type) {
>> -     case E_OR:
>> -             return expr_alloc_and(
>> -                 expr_simplify_unmet_dep(e1->left.expr, e2),
>> -                 expr_simplify_unmet_dep(e1->right.expr, e2));
>> -     case E_AND: {
>> -             struct expr *e;
>> -             e = expr_alloc_and(expr_copy(e1), expr_copy(e2));
>> -             e = expr_eliminate_dups(e);
>> -             ret = (!expr_eq(e, e1)) ? e1 : NULL;
>> -             expr_free(e);
>> -             break;
>> -             }
>> -     default:
>> -             ret = e1;
>> -             break;
>> -     }
>> -
>> -     return expr_get_leftmost_symbol(ret);
>> -}
>> -
>>  void expr_print(struct expr *e,
>>               void (*fn)(void *, struct symbol *, const char *),
>>               void *data, int prevtoken)
>> diff --git a/scripts/kconfig/expr.h b/scripts/kconfig/expr.h
>> index 8dbf2a4..94a383b 100644
>> --- a/scripts/kconfig/expr.h
>> +++ b/scripts/kconfig/expr.h
>> @@ -305,7 +305,6 @@ struct expr *expr_transform(struct expr *e);
>>  int expr_contains_symbol(struct expr *dep, struct symbol *sym);
>>  bool expr_depends_symbol(struct expr *dep, struct symbol *sym);
>>  struct expr *expr_trans_compare(struct expr *e, enum expr_type type, struct symbol *sym);
>> -struct expr *expr_simplify_unmet_dep(struct expr *e1, struct expr *e2);
>>
>>  void expr_fprint(struct expr *e, FILE *out);
>>  struct gstr; /* forward */
>> diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
>> index 0f7eba7..8b13c16 100644
>> --- a/scripts/kconfig/symbol.c
>> +++ b/scripts/kconfig/symbol.c
>> @@ -333,6 +333,26 @@ static struct symbol *sym_calc_choice(struct symbol *sym)
>>       return def_sym;
>>  }
>>
>> +static void sym_warn_unmet_dependency(struct symbol *sym)
>
> Based on the current naming pattern of kconfig functions:
>
> $> ctags -x --c-types=f scripts/kconfig/*.c | cut -d' ' -f1 | grep dep
> dep_stack_insert
> dep_stack_remove
> expr_depends_symbol
> expr_gstr_print_revdep
> expr_simplify_unmet_dep
> file_write_dep
> menu_add_dep
> sym_check_choice_deps
> sym_check_deps
> sym_check_expr_deps
> sym_check_sym_deps
>
> You could also consider below variants:
> * sym_warn_unmet_dep()
> * sym_warn_unmet_deps()
> * sym_warn_unmet_dirdep()


I chose sym_warn_unmet_dep().


Thanks!


>> +{
>> +     struct gstr gs = str_new();
>> +
>> +     str_printf(&gs,
>> +                "\nWARNING: unmet direct dependencies detected for %s\n"
>> +                " Depends on:\n"
>> +                "    ",
>> +                sym->name);
>> +     expr_gstr_print(sym->dir_dep.expr, &gs);
>> +     str_printf(&gs, "\n");
>> +
>> +     expr_gstr_print_revdep(sym->rev_dep.expr, &gs, yes,
>> +                            " Selected by [y]:\n");
>> +     expr_gstr_print_revdep(sym->rev_dep.expr, &gs, mod,
>> +                            " Selected by [m]:\n");
>> +
>> +     fputs(str_get(&gs), stderr);
>> +}
>> +
>>  void sym_calc_value(struct symbol *sym)
>>  {
>>       struct symbol_value newval, oldval;
>> @@ -414,18 +434,8 @@ void sym_calc_value(struct symbol *sym)
>>                               }
>>                       }
>>               calc_newval:
>> -                     if (sym->dir_dep.tri == no && sym->rev_dep.tri != no) {
>> -                             struct expr *e;
>> -                             e = expr_simplify_unmet_dep(sym->rev_dep.expr,
>> -                                 sym->dir_dep.expr);
>> -                             fprintf(stderr, "warning: (");
>> -                             expr_fprint(e, stderr);
>> -                             fprintf(stderr, ") selects %s which has unmet direct dependencies (",
>> -                                     sym->name);
>> -                             expr_fprint(sym->dir_dep.expr, stderr);
>> -                             fprintf(stderr, ")\n");
>> -                             expr_free(e);
>> -                     }
>> +                     if (sym->dir_dep.tri == no && sym->rev_dep.tri != no)
>> +                             sym_warn_unmet_dependency(sym);
>>                       newval.tri = EXPR_OR(newval.tri, sym->rev_dep.tri);
>>               }
>>               if (newval.tri == mod &&
>> --
>> 2.7.4
>>
>
> Best regards,
> Eugeniu.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
