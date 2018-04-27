Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeD0W7Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 18:59:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39274 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759215AbeD0W7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 18:59:14 -0400
X-Google-Smtp-Source: AB8JxZqmluyUib21rr/4hfHoBvFLqKWxzSE8Zrmzo/Q8MpqK+F2FoTTk3r81uOXIdrupEn0OL4RFRA==
Subject: Re: Linux messages full of `random: get_random_u32 called from`
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>
References: <d92d049a-8810-a765-d57a-2a7a805fadaf@gmail.com>
 <20180426050056.GF18803@thunk.org>
 <b902d9f5-300e-2611-289d-f6d49dd43f11@gmail.com>
 <20180426073255.GH18803@thunk.org>
 <b6aa3fac-a768-e27d-3070-00d929ebc245@gmail.com>
 <20180426192524.GD5965@thunk.org>
 <2add15cb-2113-0504-a732-81255ea61bf5@gmail.com>
 <20180426235630.GG5965@thunk.org>
 <3eb5761e-7b25-4178-0560-fba5eb43ce6a@gmail.com>
 <20180427201036.GL5965@thunk.org>
From: Sultan Alsawaf <sultanxda@gmail.com>
Message-ID: <450cdbd9-4eae-2f0f-e9d3-7603e5dbd655@gmail.com>
Date: Fri, 27 Apr 2018 15:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427201036.GL5965@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 26, 2018 at 10:20:44PM -0700, Sultan Alsawaf wrote:
>> I noted at least 20,000 mmc interrupts before I intervened in the boot process to provide entropy
>> myself. That's just for mmc, so I'm sure there were even more interrupts elsewhere. Is 20k+ interrupts
>> really not sufficient?
> How did you determine that there were 20,000 mmc interrupts before you
> had logged in?  Did you have access to the machine w/o having access
> to the login prompt?
>
> I can send a patch (see attached) that will spew large amounts of logs
> as each interrupt comes in and the entropy pool is getting intialized.
> That's how I test things on QEMU, and Jann did something similar on a
> (physical) test machine, so I'm pretty confident that if you were
> getting interrupts, it would result in them contributing into the
> pool.
>
> You will need a serial console, or build a kernel with a much larger
> dmesg buffer, since if you really are getting that many interrupts it
> will cause a lot of log spew.  
>> There are lots of other sources of entropy available as well, like
>> the ever-changing CPU frequencies reported by any recent Intel chip
>> (i.e., they report precision down to 1 kHz).
> That's something we could look at, but the problem is if there is some
> systemd unit during early boot that blocks waiting for the entropy
> pool to be initalized, the system will come to a dead halt, and even
> the CPU frequency shifts will probably not move much --- just as there
> weren't any interrupts while some system startup on the boot path
> wedges the system startup waiting for entropy.
>
> This is why ultimately, we do need to attack this problem from both
> ends, which means teaching userspace programs to only request
> cryptographic-grade randomness when it is really needed --- and most
> of the time, if the user has not logged in yet, you probably don't
> need cryptographic-grade randomness....
>
> 						- Ted
>
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index cd888d4ee605..69bd29f039e7 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -916,6 +916,10 @@ static void crng_reseed(struct crng_state *crng, struct entropy_store *r)
>  		__u32	key[8];
>  	} buf;
>  
> +	if (crng == &primary_crng)
> +		pr_notice("random: crng_reseed primary from %px\n", r);
> +	else
> +		pr_notice("random: crng_reseed crng %px from %px\n", crng, r);
>  	if (r) {
>  		num = extract_entropy(r, &buf, 32, 16, 0);
>  		if (num == 0)
> @@ -1241,6 +1245,10 @@ void add_interrupt_randomness(int irq, int irq_flags)
>  	fast_pool->pool[2] ^= ip;
>  	fast_pool->pool[3] ^= (sizeof(ip) > 4) ? ip >> 32 :
>  		get_reg(fast_pool, regs);
> +	if (crng_init < 2)
> +		pr_notice("random: add_interrupt(cycles=0x%08llx, now=%ld, "
> +			  "irq=%d, ip=0x%08lx)\n",
> +			  cycles, now, irq, _RET_IP_);
>  
>  	fast_mix(fast_pool);
>  	add_interrupt_bench(cycles);
> @@ -1282,6 +1290,9 @@ void add_interrupt_randomness(int irq, int irq_flags)
>  
>  	/* award one bit for the contents of the fast pool */
>  	credit_entropy_bits(r, credit + 1);
> +	if (crng_init < 2)
> +		pr_notice("random: batched into pool in stage %d, bits now %d",
> +			  crng_init, ENTROPY_BITS(r));
>  }
>  EXPORT_SYMBOL_GPL(add_interrupt_randomness);

I dumped the contents of /proc/interrupts to dmesg using the attached patch I threw together,
and then waited a sufficient amount of time before introducing entropy myself in order to ensure
that the interrupt readings were not contaminated by user-provided interrupts.

Here is the interesting snippet from my dmesg:
[   30.689076] /proc/interrupts dump: 
               |            CPU0       CPU1       CPU2       CPU3       
                  0:          6          0          0          0   IO-APIC    2-edge      timer
                  8:          0          0          1          0   IO-APIC    8-edge      rtc0
                  9:          0        533          0          0   IO-APIC    9-fasteoi   acpi
                 10:          0          0          0          0   IO-APIC   10-edge      tpm0
                 29:          0          0          0          0   IO-APIC   29-fasteoi   intel_sst_driver
                 36:        203          0          0          0   IO-APIC   36-fasteoi   808622C1:04
                 37:          0        264          0          0   IO-APIC   37-fasteoi   808622C1:05
                 42:          0          0          0          0   IO-APIC   42-fasteoi   dw:dmac-1
                 43:          0          0          0          0   IO-APIC   43-fasteoi   dw:dmac-1
                 45:          0          0          0      11402   IO-APIC   45-fasteoi   mmc0
                168:          0          0          1          0  chv-gpio   95  rt5645
                182:          0          0          0          9  chv-gpio   17  i8042
                183:          0          0          0          0  chv-gpio   18  ELAN0000:00
                230:          0          0          0          0  chv-gpio   15  ACPI:Event
                310:          0          0          0          0   PCI-MSI 458752-edge      PCIe PME, pciehp
                311:          0          0          0          0   PCI-MSI 462848-edge      PCIe PME
                312:          0        520          0          0   PCI-MSI 327680-edge      xhci_hcd
                313:        940          0          0          0   PCI-MSI 32768-edge      i915
                314:          0        137          0          0   PCI-MSI 1048576-edge      iwlwifi
                315:          0          0          0         70   PCI-MSI 442368-edge      snd_hda_intel:card0
                NMI:          0          0          0          0   Non-maskable interrupts
                LOC:       4419       4014       4590       4564   Local timer interrupts
                SPU:          0          0          0          0   Spurious interrupts
                PMI:          0          0          0          0   Performance monitoring interrupts
                IWI:          1          0          0          0   IRQ work interrupts
                RTR:          0          0          0          0   APIC ICR read retries
                RES:       1562       1235       1647        796   Rescheduling interrupts
                CAL:       1220       1340       1466       1477   Function call interrupts
                TLB:         27         18         20         17   TLB shootdowns
                TRM:          0          0          0          0   Thermal event interrupts
                THR:          0          0          0          0   Threshold APIC interrupts
                MCE:          0          0          0          0   Machine check exceptions
                MCP:          1          1          1          1   Machine check polls
                ERR:          0
                MIS:          0
                PIN:          0          0          0          0   Posted-interrupt notification event
                NPI:          0          0          0          0   Nested posted-interrupt event
                PIW:          0          0          0          0   Posted-interrupt wakeup event
               |
[   81.698372] random: crng init done

Looks like there were 11,000 mmc interrupts 30 seconds into boot. When I measured 20,000, it was a few
minutes into boot, so that is why there is a disparity. Do also note that crng init completed 50 seconds
after the /proc/interrupts dump, so 11k+ interrupts clearly didn't do the trick. If you want, I can dump out
/proc/interrupts when the "random: crng init done" message is printed.

And here is the full dmesg: https://hastebin.com/isujicenev.vbs

Sultan

>From 79576697e3ca631c88ea784d837672ef34a24e42 Mon Sep 17 00:00:00 2001
From: Sultan Alsawaf <sultanxda@gmail.com>
Date: Fri, 27 Apr 2018 15:46:18 -0700
Subject: [PATCH] Print out /proc/interrupts to kmsg ~30s after boot

---
 fs/proc/Makefile           |  1 +
 fs/proc/interrupts_print.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c     |  2 +-
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 fs/proc/interrupts_print.c

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..9bd462cec4ec 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -33,3 +33,4 @@ proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+obj-y += interrupts_print.o
diff --git a/fs/proc/interrupts_print.c b/fs/proc/interrupts_print.c
new file mode 100644
index 000000000000..4981dca3b828
--- /dev/null
+++ b/fs/proc/interrupts_print.c
@@ -0,0 +1,42 @@
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/workqueue.h>
+
+#define BUF_MAX_LEN (10000)
+
+static struct delayed_work intr_print_dwork;
+
+static void print_out_interrupts(struct work_struct *work)
+{
+	char *buf;
+	int fd, i;
+
+	buf = kzalloc(BUF_MAX_LEN, GFP_KERNEL);
+	if (!buf)
+		return;
+
+	fd = sys_open("/proc/interrupts", O_RDONLY, 0444);
+	if (fd < 0)
+		goto free_buf;
+
+	for (i = 0; i < BUF_MAX_LEN - 1; i++) {
+		if (sys_read(fd, buf + i, 1) != 1)
+			break;
+	}
+	sys_close(fd);
+
+	printk("/proc/interrupts dump: \n|%s|\n", buf);
+
+free_buf:
+	kfree(buf);
+}
+
+static int __init intr_print_init(void)
+{
+	INIT_DELAYED_WORK(&intr_print_dwork, print_out_interrupts);
+	schedule_delayed_work(&intr_print_dwork,
+		msecs_to_jiffies(30 * MSEC_PER_SEC));
+
+	return 0;
+}
+device_initcall(intr_print_init);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index f274fbef821d..2d3151ce5f24 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -428,7 +428,7 @@ static u64 clear_seq;
 static u32 clear_idx;
 
 #define PREFIX_MAX		32
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
+#define LOG_LINE_MAX		(10000)
 
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
-- 
2.14.1
