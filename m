Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F20C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE82082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE82082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeH3LoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:44:21 -0400
Received: from bastet.se.axis.com ([195.60.68.11]:59095 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeH3LoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:44:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id BB1BA18422;
        Thu, 30 Aug 2018 09:43:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id IkWEEoQsYbHM; Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 841A418494;
        Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D731A064;
        Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DB9A1A05D;
        Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 520E43131;
        Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 4ED44801F9; Thu, 30 Aug 2018 09:43:27 +0200 (CEST)
Date:   Thu, 30 Aug 2018 09:43:27 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] kmemleak: Add option to print warnings to dmesg
Message-ID: <20180830074327.ivjq6g25lw7kpz2l@axis.com>
References: <20180827083821.7706-1-vincent.whitchurch@axis.com>
 <20180827151641.59bdca4e1ea2e532b10cd9fd@linux-foundation.org>
 <20180828101412.mb7t562roqbhsbjw@axis.com>
 <20180828102621.yawpcrkikhh4kagv@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828102621.yawpcrkikhh4kagv@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 11:26:22AM +0100, Catalin Marinas wrote:
> On Tue, Aug 28, 2018 at 12:14:12PM +0200, Vincent Whitchurch wrote:
> > On Mon, Aug 27, 2018 at 03:16:41PM -0700, Andrew Morton wrote:
> > > On Mon, 27 Aug 2018 10:38:21 +0200 Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> > > > +config DEBUG_KMEMLEAK_WARN
> > > > +	bool "Print kmemleak object warnings to log buffer"
> > > > +	depends on DEBUG_KMEMLEAK
> > > > +	help
> > > > +	  Say Y here to make kmemleak print information about unreferenced
> > > > +	  objects (including stacktraces) as warnings to the kernel log buffer.
> > > > +	  Otherwise this information is only available by reading the kmemleak
> > > > +	  debugfs file.
> > > 
> > > Why add the config option?  Why not simply make the change for all
> > > configs?
> > 
> > No particular reason other than preserving the current behaviour for
> > existing users.  I can remove the config option if Catalin is fine with
> > it.
> 
> IIRC, in the early kmemleak days, people complained about it being to
> noisy (the false positives rate was also much higher), so the default
> behaviour was changed to monitor (almost) quietly with the details
> available via debugfs. I'd like to keep this default behaviour but we
> could have a "verbose" command via both debugfs and kernel parameter (as
> we do with "off" and "on"). Would this work for you?

Either a config option or a parameter are usable for me.  How about
something like this?  It can be enabled with kmemleak.verbose=1 or "echo
1 > /sys/module/kmemleak/parameters/verbose":

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 9a3fc905b8bd..ab1b599202bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -593,15 +593,6 @@ config DEBUG_KMEMLEAK_DEFAULT_OFF
 	  Say Y here to disable kmemleak by default. It can then be enabled
 	  on the command line via kmemleak=on.
 
-config DEBUG_KMEMLEAK_WARN
-	bool "Print kmemleak object warnings to log buffer"
-	depends on DEBUG_KMEMLEAK
-	help
-	  Say Y here to make kmemleak print information about unreferenced
-	  objects (including stacktraces) as warnings to the kernel log buffer.
-	  Otherwise this information is only available by reading the kmemleak
-	  debugfs file.
-
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
 	depends on DEBUG_KERNEL && !IA64
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 22662715a3dc..c91d43738596 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -86,6 +86,7 @@
 #include <linux/seq_file.h>
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
 #include <linux/stacktrace.h>
@@ -236,6 +237,9 @@ static int kmemleak_skip_disable;
 /* If there are leaks that can be reported */
 static bool kmemleak_found_leaks;
 
+static bool kmemleak_verbose;
+module_param_named(verbose, kmemleak_verbose, bool, 0600);
+
 /*
  * Early object allocation/freeing logging. Kmemleak is initialized after the
  * kernel allocator. However, both the kernel allocator and kmemleak may
@@ -1618,9 +1622,10 @@ static void kmemleak_scan(void)
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
-#ifdef CONFIG_DEBUG_KMEMLEAK_WARN
-			print_unreferenced(NULL, object);
-#endif
+
+			if (kmemleak_verbose)
+				print_unreferenced(NULL, object);
+
 			new_leaks++;
 		}
 		spin_unlock_irqrestore(&object->lock, flags);
