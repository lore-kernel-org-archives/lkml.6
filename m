Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeBTVoy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 16:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:53004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeBTVow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 16:44:52 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8679521795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jeyu@kernel.org
Date: Tue, 20 Feb 2018 22:44:46 +0100
From: Jessica Yu <jeyu@kernel.org>
To: Matthew Garrett <mjg59@google.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Make kernel taint on invalid module signatures
 configurable
Message-ID: <20180220214444.otkqiaknej72d7ua@redbean>
References: <20170807195027.13192-1-mjg59@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20170807195027.13192-1-mjg59@google.com>
X-OS: Linux redbean 4.14.16-200.fc26.x86_64 x86_64
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Matthew Garrett [07/08/17 12:50 -0700]:
>The default kernel behaviour is for unsigned or invalidly signed modules
>to load without warning. Right now, If CONFIG_MODULE_SIG is enabled the
>kernel will be tainted in this case. Distributions may wish to enable
>CONFIG_MODULE_SIG in order to permit signature enforcement, but may not
>wish to alter the behaviour of the kernel in the situation where
>signature enforcement is not required. Add a new kernel configuration
>option to allow the default behaviour to be toggled, and add a kernel
>parameter in order to allow tainting to be enabled at runtime.

It would be great if you could you expand on or add excerpts from our
discussion to the commit message, explaining why distros don't want
the unsigned taint in certain situations (what issues is it causing?),
and especially why CONFIG_MODULE_SIG remains enabled in both use cases
(reusing configs, distros not having the bandwidth to repackage
kernels for slightly modified configs).

>Signed-off-by: Matthew Garrett <mjg59@google.com>
>---
>
>Rusty, with luck this makes it clearer what I'm trying to achieve here.
>
> Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
> Documentation/admin-guide/module-signing.rst    | 13 +++++++++----
> init/Kconfig                                    | 13 ++++++++++++-
> kernel/module.c                                 |  7 ++++++-
> 4 files changed, 33 insertions(+), 6 deletions(-)
>
>diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>index d9c171ce4190..7ea1e9aeb7d8 100644
>--- a/Documentation/admin-guide/kernel-parameters.txt
>+++ b/Documentation/admin-guide/kernel-parameters.txt
>@@ -2291,6 +2291,12 @@
> 			Note that if CONFIG_MODULE_SIG_FORCE is set, that
> 			is always true, so this option does nothing.
>
>+	module.sig_taint
>+			[KNL] When CONFIG_MODULE_SIG is set, this means
>+			that modules without (valid) signatures will taint the
>+			kernel on load. Note that if CONFIG_MODULE_SIG_TAINT is
>+			set, that is always true, so this option does nothing.
>+

I'm wondering now if we should call the param unsigned_taint? Or
taint_on_unsigned? With sig_taint I'm initially not sure what the
parameter is trying to convey.

> 	module_blacklist=  [KNL] Do not load a comma-separated list of
> 			modules.  Useful for debugging problem modules.
>
>diff --git a/Documentation/admin-guide/module-signing.rst b/Documentation/admin-guide/module-signing.rst
>index 27e59498b487..96709b93c606 100644
>--- a/Documentation/admin-guide/module-signing.rst
>+++ b/Documentation/admin-guide/module-signing.rst
>@@ -52,10 +52,11 @@ This has a number of options available:
>      This specifies how the kernel should deal with a module that has a
>      signature for which the key is not known or a module that is unsigned.
>
>-     If this is off (ie. "permissive"), then modules for which the key is not
>-     available and modules that are unsigned are permitted, but the kernel will
>-     be marked as being tainted, and the concerned modules will be marked as
>-     tainted, shown with the character 'E'.
>+     If this is off (ie. "permissive"), then modules for which the key
>+     is not available and modules that are unsigned are permitted. If
>+     ``CONFIG_MODULE_SIG_TAINT`` is enabled or the sig_taint parameter is
>+     set the kernel will be marked as being tainted, and the concerned
>+     modules will be marked as tainted, shown with the character 'E'.
>
>      If this is on (ie. "restrictive"), only modules that have a valid
>      signature that can be verified by a public key in the kernel's possession
>@@ -266,6 +267,10 @@ for which it has a public key.   Otherwise, it will also load modules that are
> unsigned.   Any module for which the kernel has a key, but which proves to have
> a signature mismatch will not be permitted to load.
>
>+If ``CONFIG_MODULE_SIG_TAINT`` is enabled or module.sig_taint=1 is
>+supplied on the kernel command line, the kernel will be tainted if an
>+invalidly signed or unsigned module is loaded.
>+
> Any module that has an unparseable signature will be rejected.
>
>
>diff --git a/init/Kconfig b/init/Kconfig
>index 8514b25db21c..ffad18a3e890 100644
>--- a/init/Kconfig
>+++ b/init/Kconfig
>@@ -1749,12 +1749,23 @@ config MODULE_SIG
> 	  debuginfo strip done by some packagers (such as rpmbuild) and
> 	  inclusion into an initramfs that wants the module size reduced.
>
>+config MODULE_SIG_TAINT
>+	bool "Taint the kernel on unsigned or incorrectly signed module load"
>+	default y
>+	depends on MODULE_SIG
>+	help
>+	  Taint the kernel if an unsigned or untrusted kernel module is loaded.
>+	  If this option is enabled, the kernel will be tainted on an attempt
>+	  to load an unsigned module or signed modules for which we don't have
>+	  a key.
>+

Same for here, although I understand that you were trying to keep the
naming convention consistent. Maybe MODULE_UNSIGNED_TAINT is a bit
more descriptive? I think MODULE_SIG_TAINT and sig_taint sound a bit
ambiguous (are you tainting on signed modules? unsigned modules?)
without looking at the description, but this is purely a matter of
taste/preference.

> config MODULE_SIG_FORCE
> 	bool "Require modules to be validly signed"
> 	depends on MODULE_SIG
> 	help
> 	  Reject unsigned modules or signed modules for which we don't have a
>-	  key.  Without this, such modules will simply taint the kernel.
>+	  key. Without this, such modules will be loaded successfully but will
>+	  (if MODULE_SIG_TAINT is set) taint the kernel.
>
> config MODULE_SIG_ALL
> 	bool "Automatically sign all modules"
>diff --git a/kernel/module.c b/kernel/module.c
>index 40f983cbea81..70c2edc5693c 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -278,6 +278,11 @@ static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
> module_param(sig_enforce, bool_enable_only, 0644);
> #endif /* !CONFIG_MODULE_SIG_FORCE */
>
>+static bool sig_taint = IS_ENABLED(CONFIG_MODULE_SIG_TAINT);
>+#ifndef CONFIG_MODULE_SIG_TAINT
>+module_param(sig_taint, bool_enable_only, 0644);
>+#endif /* !CONFIG_MODULE_SIG_TAINT */
>+
> /* Block module loading/unloading? */
> int modules_disabled = 0;
> core_param(nomodule, modules_disabled, bint, 0);
>@@ -3660,7 +3665,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
>
> #ifdef CONFIG_MODULE_SIG
> 	mod->sig_ok = info->sig_ok;
>-	if (!mod->sig_ok) {
>+	if (!mod->sig_ok && sig_taint) {
> 		pr_notice_once("%s: module verification failed: signature "
> 			       "and/or required key missing - tainting "
> 			       "kernel\n", mod->name);
>-- 
>2.14.0.rc1.383.gd1ce394fe2-goog
>
