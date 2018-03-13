Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeCMUKZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:10:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40125 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932257AbeCMUKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:10:24 -0400
X-Google-Smtp-Source: AG47ELs8kpISUEElnlawI7T1z7lSIr8y/ENKqDiAY8wRbFIEObbrNEX9HmRoSboKR2YF/FEvrA3Uj6Dyq1w95F6drDA=
MIME-Version: 1.0
In-Reply-To: <ce356e4a-31af-4bea-8e75-e484e663f19c@linux.intel.com>
References: <20180313161952.552083-1-arnd@arndb.de> <ce356e4a-31af-4bea-8e75-e484e663f19c@linux.intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 13 Mar 2018 21:10:22 +0100
X-Google-Sender-Auth: 0i9L1T7zZ70MjjH0n4fRRW1ZPas
Message-ID: <CAK8P3a2U+cjWhw86WGsDoEm+iOEwrcqL9hZo0sLxqFMSS=qQww@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] [v2] drm/i915/pmu: avoid -Wmaybe-uninitialized
 warning
To: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 6:46 PM, Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
> On 13/03/2018 16:19, Arnd Bergmann wrote:
>>
>> The conditional spinlock confuses gcc into thinking the 'flags' value
>> might contain uninitialized data:
>>
>> drivers/gpu/drm/i915/i915_pmu.c: In function '__i915_pmu_event_read':
>> arch/x86/include/asm/paravirt_types.h:573:3: error: 'flags' may be used
>> uninitialized in this function [-Werror=maybe-uninitialized]
>
>
> Hm, how does paravirt_types.h comes into the picture?

spin_unlock_irqrestore() calls arch_local_irq_restore()

>> The code is correct, but it's easy to see how the compiler gets confused
>> here. This avoids the problem by pulling the lock outside of the function
>> into its only caller.
>
>
> Is it specific gcc version, specific options, or specific kernel config that
> this happens?

Not gcc version specific (same result with gcc-4.9 through 8, didn't test
earlier versions that are currently broken).

> Strange that it hasn't been seen so far.

It seems to be a relatively rare 'randconfig' combination. Looking at
the preprocessed sources, I find:

static u64 get_rc6(struct drm_i915_private *i915, bool locked)
{

 unsigned long flags;
 u64 val;

 if (intel_runtime_pm_get_if_in_use(i915)) {
  val = __get_rc6(i915);
  intel_runtime_pm_put(i915);
  if (!locked)
   do { do { ({ unsigned long __dummy; typeof(flags) __dummy2;
(void)(&__dummy == &__dummy2); 1; }); do { do { do { ({ unsigned long
__dummy; typeof(flags) __dummy2; (void)(&__dummy == &__dummy2); 1; });
flags = arch_local_irq_save(); } while (0); trace_hardirqs_off(); }
while (0); do { __asm__ __volatile__("": : :"memory"); do { (void)0;
(void)(spinlock_check(&i915->pmu.lock)); } while (0); } while (0); }
while (0); } while (0); } while (0);

  if (val >= i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur) {
   i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = 0;
   i915->pmu.sample[__I915_SAMPLE_RC6].cur = val;
  } else {
   val = i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur;
  }
  if (!locked)
   spin_unlock_irqrestore(&i915->pmu.lock, flags);
 } else {
  struct pci_dev *pdev = i915->drm.pdev;
  struct device *kdev = &pdev->dev;
  unsigned long flags2;
# 455 "/git/arm-soc/drivers/gpu/drm/i915/i915_pmu.c"
  if (!locked)
   do { do { ({ unsigned long __dummy; typeof(flags) __dummy2;
(void)(&__dummy == &__dummy2); 1; }); do { do { do { ({ unsigned long
__dummy; typeof(flags) __dummy2; (void)(&__dummy == &__dummy2); 1; });
flags = arch_local_irq_save(); } while (0); trace_hardirqs_off(); }
while (0); do { __asm__ __volatile__("": : :"memory"); do { (void)0;
(void)(spinlock_check(&i915->pmu.lock)); } while (0); } while (0); }
while (0); } while (0); } while (0);

  do { do { ({ unsigned long __dummy; typeof(flags2) __dummy2;
(void)(&__dummy == &__dummy2); 1; }); do { do { do { ({ unsigned long
__dummy; typeof(flags2) __dummy2; (void)(&__dummy == &__dummy2); 1;
}); flags2 = arch_local_irq_save(); } while (0); trace_hardirqs_off();
} while (0); do { __asm__ __volatile__("": : :"memory"); do { (void)0;
(void)(spinlock_check(&kdev->power.lock)); } while (0); } while (0); }
while (0); } while (0); } while (0);

  if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
   i915->pmu.suspended_jiffies_last =
      kdev->power.suspended_jiffies;

  val = kdev->power.suspended_jiffies -
        i915->pmu.suspended_jiffies_last;
  val += jiffies - kdev->power.accounting_timestamp;

  spin_unlock_irqrestore(&kdev->power.lock, flags2);

  val = jiffies_to_nsecs(val);
  val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
  i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;

  if (!locked)
   spin_unlock_irqrestore(&i915->pmu.lock, flags);
 }
  return val;
}

so it seems that the spin_lock_irqsave() is completely inlined through
a macro while the unlock is not, and the lock contains a memory barrier
(among other things) that might tell the compiler that the state of the
'locked' flag could changed underneath it.

It could also be the problem that arch_local_irq_restore() uses
__builtin_expect() in  PVOP_TEST_NULL(op) when
CONFIG_PARAVIRT_DEBUG is enabled, see

static inline __attribute__((unused))
__attribute__((no_instrument_function))
__attribute__((no_instrument_function)) void
arch_local_irq_restore(unsigned long f)
{
 ({ unsigned long __eax = __eax, __edx = __edx, __ecx = __ecx;; do {
if (__builtin_expect(!!(pv_irq_ops.restore_fl.func == ((void *)0)),
0)) do { do { asm volatile("1:\t" ".byte 0x0f, 0x0b" "\n"
".pushsection __bug_table,\"aw\"\n" "2:\t" ".long " "1b" "\t#
bug_entry::bug_addr\n" "\t" ".long " "%c0" "\t# bug_entry::file\n"
"\t.word %c1" "\t# bug_entry::line\n" "\t.word %c2" "\t#
bug_entry::flags\n" "\t.org 2b+%c3\n" ".popsection" : : "i"
("/git/arm-soc/arch/x86/include/asm/paravirt.h"), "i" (783), "i" (0),
"i" (sizeof(struct bug_entry))); } while (0); do { ; asm volatile("");
__builtin_unreachable(); } while (0); } while (0); } while (0); asm
volatile("" "771:\n\t" "999:\n\t" ".pushsection
.discard.retpoline_safe\n\t" " " ".long" " " " 999b\n\t"
".popsection\n\t" "call *%c[paravirt_opptr];" "\n" "772:\n"
".pushsection .parainstructions,\"a\"\n" " " ".balign 4" " " "\n" " "
".long" " " " 771b\n" "  .byte " "%c[paravirt_typenum]" "\n" "  .byte
772b-771b\n" "  .short " "%c[paravirt_clobber]" "\n" ".popsection\n"
"" : "=a" (__eax), "=d" (__edx), "+r" (current_stack_pointer) :
[paravirt_typenum] "i" ((__builtin_offsetof(struct
paravirt_patch_template, pv_irq_ops.restore_fl.func) / sizeof(void
*))), [paravirt_opptr] "i" (&(pv_irq_ops.restore_fl.func)),
[paravirt_clobber] "i" (((1 << 0) | (1 << 2))), "a" ((unsigned
long)(f)) : "memory", "cc" ); });
}

this seems to frequently confuse gcc, and turning off that NULL check
avoids the warning as well.

If you want to analyze it further, see https://pastebin.com/T2yLRqU5
for the .config file, but I'm pretty sure this is a known problem with gcc
that happens to be very hard to fix.

       Arnd
