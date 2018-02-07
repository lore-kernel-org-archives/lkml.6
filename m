Return-Path: <rolf.neugebauer@docker.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518021120; cv=none;
        d=google.com; s=arc-20160816;
        b=yUx+eKOhiagpUaUwsm+/88ei1zRJfnbeN/IPsmRPv9mKuZv24UjRRReaaqhQNWNn79
         Iycf4eR47l4yXcSv7MKQCozUREcCZ8Axl0mNaeVzC7BmpGLMcLoajNWDbZU+zeqPh5ht
         vt+NRLgt3szV+XM0Zyd70/5EP6ha/M2QcVwY6qyPNnzo4KzS8D8x+XNdwT0qMZKvyH12
         7npIdGeuE9yswQUEY9DI8icN+N1MPD1nDovHoOcdLqow7CNMXpxly9Mr3okNMyUz0Wnk
         kIPtzcs4Ktv33d1tdMBsSca39LPqfUJbDOCmRXBIAwNCgqfsNi76HGaNe4+zvcbyUqqy
         wjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=A7c8H/O+9QgqL/4QOlD3YbZWD7xm7fJvYZp+C8uK7b4=;
        b=h5qhnYG6eyC0zhZ4s+mpkuEqHFGMRUkS+lcHsALjwS7zTGPdQcEYP/KucOkT9FJ/6W
         AZ42Je9fKvoguS1kPjEjY/8DOPw22QgBk+NU/QFfHgeH51gEppML1BQAknEvdEJUtrqf
         XQsgnrCpvBTcP3XMyohcnAYj7gzo8JAkyKkru9pif7st8cs1P+7FWW779pb/TzlXHvHF
         4lh4CUOje85vuk+lsbrVq0bDJYvZn6DdXIVITj/bW34K4S2wVbJCAjDENaJZOfIwrqy0
         CbbP6C5rEwGhfA+LLbz2dzoKUXrzobNjUQIPbaUvRpW0vIXzYR/BOXOWlQA5f+Xw2NUu
         nlvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=TIuXadDn;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@docker.com header.s=google header.b=TIuXadDn;
       spf=pass (google.com: domain of rolf.neugebauer@docker.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=rolf.neugebauer@docker.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=docker.com
X-Google-Smtp-Source: AH8x225UCK1dkrbNosNp1XBmylbmPx8Hk4HPNe11i/iWUQ06AXyMoWVvYHuLcukbvWKnjW+kQitj7xBSMj3n1NZmtWM=
MIME-Version: 1.0
In-Reply-To: <20180207143428.GA31944@kroah.com>
References: <CA+pO-2c6z6uc8EO7LwWkGe3g_ygMwfS=VfQPNHzvS4H7RJOt-w@mail.gmail.com>
 <20180206142444.7xxegyyyfwskwrxl@pd.tnic> <20180207143428.GA31944@kroah.com>
From: Rolf Neugebauer <rolf.neugebauer@docker.com>
Date: Wed, 7 Feb 2018 16:31:59 +0000
Message-ID: <CA+pO-2eiim-6E8VLAV2K3s=pqEv7QcV1f8znLeQWqZh=zKWVVQ@mail.gmail.com>
Subject: Re: x86/microcode/intel: Division by zero panic in 4.9.79 and 4.4.114
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Jia Zhang <zhang.jia@linux.alibaba.com>,
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591660958258362388?=
X-GMAIL-MSGID: =?utf-8?q?1591760514957638478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 7, 2018 at 2:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Feb 06, 2018 at 03:24:44PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 06, 2018 at 02:09:35PM +0000, Rolf Neugebauer wrote:
>> > The backport of 7e702d17ed1 ("x86/microcode/intel: Extend BDW
>> > late-loading further with LLC size check") to 4.9.79 and 4.4.14 causes
>> > a division by zero panic on some single vCPU machine types on Google
>> > Cloud (e.g. g1-small and n1-standard-1):
>>
>> The microcode loader is not supposed to load in a guest.
>>
>> Greg, I guess you need something like this:
>>
>> a15a753539ec ("x86/microcode/AMD: Do not load when running on a hypervisor")
>>
>> I haven't tried whether it applies cleanly though...
>
> It applied cleanly to 4.9 (with some fuzz, but looks clean enough...)
>
> But for 4.4, not at all.  Rolf, any chance you could backport the patch
> there for this issue?  If not, I can add it to my queue, but it might
> take a few days...

The backport was straight forward. I've added it below. If my mailer
(gmail) screws this up let me where I should send it with 'git
send-email'

Rolf

>From 2cca500deea6a2f47dc126bfe3713933d7192c33 Mon Sep 17 00:00:00 2001
From: Borislav Petkov <bp@suse.de>
Date: Sun, 18 Dec 2016 17:44:13 +0100
Subject: [PATCH 1/1] x86/microcode/AMD: Do not load when running on a
 hypervisor

commit a15a753539eca8ba243d576f02e7ca9c4b7d7042 upstream with minor
adjustments.

Doing so is completely void of sense for multiple reasons so prevent
it. Set dis_ucode_ldr to true and thus disable the microcode loader by
default to address xen pv guests which execute the AP path but not the
BSP path.

By having it turned off by default, the APs won't run into the loader
either.

Also, check CPUID(1).ECX[31] which hypervisors set. Well almost, not the
xen pv one. That one gets the aforementioned "fix".

Also, improve the detection method by caching the final decision whether
to continue loading in dis_ucode_ldr and do it once on the BSP. The APs
then simply test that value.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: http://lkml.kernel.org/r/20161218164414.9649-4-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <stable@vger.kernel.org> # 4.4.x
Signed-off-by: Rolf Neugebauer <rolf.neugebauer@docker.com>
---
 arch/x86/kernel/cpu/microcode/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c
b/arch/x86/kernel/cpu/microcode/core.c
index b3e94ef461fd..1b3e0aa4c511 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -44,7 +44,7 @@

 static struct microcode_ops    *microcode_ops;

-static bool dis_ucode_ldr;
+static bool dis_ucode_ldr = true;

 static int __init disable_loader(char *str)
 {
@@ -81,6 +81,7 @@ struct cpu_info_ctx {

 static bool __init check_loader_disabled_bsp(void)
 {
+       u32 a, b, c, d;
 #ifdef CONFIG_X86_32
        const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
        const char *opt     = "dis_ucode_ldr";
@@ -93,8 +94,23 @@ static bool __init check_loader_disabled_bsp(void)
        bool *res = &dis_ucode_ldr;
 #endif

-       if (cmdline_find_option_bool(cmdline, option))
-               *res = true;
+       if (!have_cpuid_p())
+               return *res;
+
+       a = 1;
+       c = 0;
+       native_cpuid(&a, &b, &c, &d);
+
+       /*
+        * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
+        * completely accurate as xen pv guests don't see that CPUID bit set but
+        * that's good enough as they don't land on the BSP path anyway.
+        */
+       if (c & BIT(31))
+               return *res;
+
+       if (cmdline_find_option_bool(cmdline, option) <= 0)
+               *res = false;

        return *res;
 }
@@ -126,9 +142,6 @@ void __init load_ucode_bsp(void)
        if (check_loader_disabled_bsp())
                return;

-       if (!have_cpuid_p())
-               return;
-
        vendor = x86_vendor();
        family = x86_family();

@@ -162,9 +175,6 @@ void load_ucode_ap(void)
        if (check_loader_disabled_ap())
                return;

-       if (!have_cpuid_p())
-               return;
-
        vendor = x86_vendor();
        family = x86_family();

--
2.16.0
