Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426128AbeCBKDZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:03:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53534 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424492AbeCBKC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:02:59 -0500
Date: Fri, 2 Mar 2018 11:02:54 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ivan Gorinov <ivan.gorinov@intel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v3 1/3] x86: devicetree: call early_init_dt_verify()
In-Reply-To: <20180301230616.GA48498@intel.com>
Message-ID: <alpine.DEB.2.21.1803021020130.1803@nanos.tec.linutronix.de>
References: <20180301230616.GA48498@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Ivan Gorinov wrote:

$subject: x86: devicetree: call early_init_dt_verify()

1) x86 uses the x86/subsys prefix format, i.e. this should be x86/devicetree

2) Sentence after the colon starts with an uppercase letter

3) The patch subject should be precise and descriptive about the scope of
   the patch. What you have is:

   Call early_init_dt_verify()

   That describes what the patch does and does not give any hint about why
   and what kind of change that is.

   So something like

   x86/devicetree: Initialize device tree before usage

   would clearly spell out that this is a fix for a real problem and not
   just some new call to a random function

> Call to early_init_dt_verify() is required to prepare DTB data.

This is missing a reference to the commit which made early_init_dt_verify()
mandatory. This is important for two reasons:

1) The reviewer can find the relevant change easily and verify that your
   patch is doing the right thing.

2) If the patch needs to be tagged for stable then this is required to
   find the scope of how far backporting should go.

> It was called from arch/arm and arch/powerpc, but not arch/x86.

Was? It's still called. What you want to say is that the change which made
this mandatory missed to fixup the x86 implementation.

> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  arch/x86/kernel/devicetree.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index 25de5f6..44189ee 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -278,6 +278,7 @@ static void __init x86_flattree_get_config(void)
>  		map_len = size;
>  	}
>  
> +	early_init_dt_verify(dt);
>  	unflatten_and_copy_device_tree();
>  	early_memunmap(dt, map_len);

This is just a duct tape, really. The code above that already sets
initial_boot_param in order to make of_get_flat_dt_size() work.

But that's mindless hackery as early_init_dt_verify() sets it again to the
same value. So what you really want is to make of_get_flat_dt_size() take a
parameter which points to the memory containing the FDT and retrieve the
size without fiddling with initial_boot_param. Something like the below.
That patch wants to be split into two parts:

 1) Change of_get_flat_dt_size()

 2) Add early_init_dt_verify()

Thanks,

	tglx

8<---------------
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -270,14 +270,15 @@ static void __init x86_flattree_get_conf
 
 	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
 
-	initial_boot_params = dt = early_memremap(initial_dtb, map_len);
-	size = of_get_flat_dt_size();
+	dt = early_memremap(initial_dtb, map_len);
+	size = of_get_flat_dt_size(dt);
 	if (map_len < size) {
 		early_memunmap(dt, map_len);
-		initial_boot_params = dt = early_memremap(initial_dtb, size);
+		dt = early_memremap(initial_dtb, size);
 		map_len = size;
 	}
 
+	early_init_dt_verify(dt);
 	unflatten_and_copy_device_tree();
 	early_memunmap(dt, map_len);
 }
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -778,10 +778,11 @@ unsigned long __init of_get_flat_dt_root
 
 /**
  * of_get_flat_dt_size - Return the total size of the FDT
+ * @fdt:	Pointer to the memory containing the FDT
  */
-int __init of_get_flat_dt_size(void)
+int __init of_get_flat_dt_size(void *fdt)
 {
-	return fdt_totalsize(initial_boot_params);
+	return fdt_totalsize(fdt);
 }
 
 /**
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -66,7 +66,7 @@ extern const void *of_get_flat_dt_prop(u
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern int of_flat_dt_match(unsigned long node, const char *const *matches);
 extern unsigned long of_get_flat_dt_root(void);
-extern int of_get_flat_dt_size(void);
+extern int of_get_flat_dt_size(void *fdt);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
