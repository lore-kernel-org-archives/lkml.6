Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbeDMTzG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 15:55:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:33135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750839AbeDMTzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 15:55:04 -0400
Date: Fri, 13 Apr 2018 21:54:37 +0200
From: Helge Deller <deller@gmx.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH] parisc: Switch to generic COMPAT_BINFMT_ELF
Message-ID: <20180413195437.GA13605@p100.box>
References: <20180413182904.GA1722@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180413182904.GA1722@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:kGg6ffv4HEvBZvxQbGFfGIUUhKXLwPLUFpVWb7c8RKW84qdmLNw
 5aTffvWWKN9HDdauC5BG1kBkmxta+RWxZw/0zeriWmH9oZKARYZvmdmBKZVTOqSslfKUjBY
 xUQpYxW5Bgrex2pSJWMmf9mG/NCIDuc5rSpTMgWh70C2uw1qBHqlJJgy/2nzeK8hiH/584p
 VohmufgXiEFs/7xvcwnew==
X-UI-Out-Filterresults: notjunk:1;V01:K0:avENVuMin0s=:hgSf8XSYHTMH5mJKAn18SJ
 sXilkci2sbtohwQfdugpC0FQCCtLRZGRixUgVhWMFX8Comzna0g0Ly7Hk4afLERUADf6BVuvC
 3krBvlbcLPytACN5V40DV76Ex8WTdwfMgz9qMDvGCIrVQQAb+/RWrNsMWd0T0pqcWinoix/3f
 42fnj7HVGYhHJ7LWERc3KKv2UXI9WTJQFIV1YFV31ZrxLYSsNfvEao0HzJ7KtoYHeJyoZnmbx
 l32Tp95wPgU7RVfFYCwJiQOWWfwU+uFC4RWR0m+kzbMOY8KPOjvCzekuASLed8PvfpneKiIV4
 gTVIPfO1xjGuFU6x7DY98egxbc9C/RKkhJBLlw5X5bZvPC89qRFVPNOguw9Rwo7MzUppaK0F3
 18C/J4CqQY05DMR4H+P8cqkJc993eQharySgQRy0FQ3mWhEFF5OkYMXUhjtJvsw4jXZMSuysI
 2kKefYZIBz2OZpDxVi/NDDFILjW7vIIxeDfzqHuqsTaDjXAjYHQB9lW7yT7MqDwErxHE+Hy/C
 tLyWuxJWrOJw6WOpgIeWKtoYhFan0ZEImW4Q7UChVfy5fx/0fRycFjmfe7IpBwD2osbKOn/rw
 Tr8uDZgeOU5snO5fB9cEanSta6UjB5R+nn9NsMRS36lUHBqWAlxHf3vWSOYaXhAIEFvRl3+m5
 jScKh2aiJsz0kkKrbV3Ts7wa0kRhwTRq8Zv2sWyoQIcUh7P9nV8pB6+eFbqjEjVEVwgj+GSuP
 ranTDTMP4mtAzWNjBeeBjiQLC4NEQaA7GWRnKBDuZRAkF8MFEsfIZQ6CNG8gtUMB8k8BBGbC8
 YZTevw6fOI0Rptr8ewXvPXGHGq8Tw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Guenter Roeck <linux@roeck-us.net>:
> On Wed, Apr 11, 2018 at 09:09:53AM +0200, Helge Deller wrote:
> > Drop our own compat binfmt implementation in
> > arch/parisc/kernel/binfmt_elf32.c in favour of the generic
> > implementation with CONFIG_COMPAT_BINFMT_ELF.
> > 
> > While cleaning up the dependencies, I noticed that ELF_PLATFORM was strangely
> > defined: On a 32-bit kernel, it was defined to "PARISC", while when running in
> > compat mode on a 64-bit kernel it was defined to "PARISC32". Since it doesn't
> > seem to be used in glibc yet, it's now defined in both cases to "PARISC". In
> > any case, it can be distinguished because it's either a 32-bit or a 64-bit ELF
> > file.
> > 
> > Signed-off-by: Helge Deller <deller@gmx.de>
> 
> This patch results in:
> 
> Building parisc:a500_defconfig ... failed
> --------------
> Error log:
> make[2]: *** No rule to make target 'arch/parisc/kernel/binfmt_elf32.o', needed
> by 'arch/parisc/kernel/built-in.a'.  Stop.
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [arch/parisc/kernel] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
> --------------
> Building parisc:generic-64bit_defconfig ... failed
> --------------
> Error log:
> make[2]: *** No rule to make target 'arch/parisc/kernel/binfmt_elf32.o', needed
> by 'arch/parisc/kernel/built-in.a'.  Stop.
> 
> Indeed, arch/parisc/kernel/binfmt_elf32.o is still listed in Makefile
> for 64-bit builds.
> 
> $ git grep binfmt_elf32.o arch/parisc/
> arch/parisc/kernel/Makefile:obj-$(CONFIG_64BIT) += binfmt_elf32.o sys_parisc32.o signal32.o

You are right.
I got fooled because I still had the binfmt_elf32.o object in my build
directory and so I didn't faced this build error. And even 0-day builds
didn't complained...  

Thanks for testing!

Patch below fixes it.

Helge
---

[PATCH] parisc: Fix missing binfmt_elf32.o build error

Commit 71d577db01a5 ("parisc: Switch to generic COMPAT_BINFMT_ELF")
removed the binfmt_elf32.c source file, but missed to drop the object
file from list of object files the Makefile too, which then results in a
build error.

Fixes: 71d577db01a5 ("parisc: Switch to generic COMPAT_BINFMT_ELF")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>


diff --git a/arch/parisc/kernel/Makefile b/arch/parisc/kernel/Makefile
index eafd06a..e5de34d 100644
--- a/arch/parisc/kernel/Makefile
+++ b/arch/parisc/kernel/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_PA11)	+= pci-dma.o
 obj-$(CONFIG_PCI)	+= pci.o
 obj-$(CONFIG_MODULES)	+= module.o
-obj-$(CONFIG_64BIT)	+= binfmt_elf32.o sys_parisc32.o signal32.o
+obj-$(CONFIG_64BIT)	+= sys_parisc32.o signal32.o
 obj-$(CONFIG_STACKTRACE)+= stacktrace.o
 obj-$(CONFIG_AUDIT)	+= audit.o
 obj64-$(CONFIG_AUDIT)	+= compat_audit.o
