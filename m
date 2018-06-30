Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EF9C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BC927F64
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BC927F64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936675AbeF3ABe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 20:01:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:11832 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936131AbeF3ABd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 20:01:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 17:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="54022848"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga006.jf.intel.com with ESMTP; 29 Jun 2018 17:01:32 -0700
Date:   Fri, 29 Jun 2018 17:00:51 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v2 2/4] x86/split_lock: Align x86_capability to unsigned
 long to avoid split locked access
Message-ID: <20180630000051.GC68178@romley-ivt3.sc.intel.com>
References: <1530282807-66555-1-git-send-email-fenghua.yu@intel.com>
 <1530282807-66555-3-git-send-email-fenghua.yu@intel.com>
 <ae0b8cb1-a8a9-f0ef-3c20-f4fe4b9b6f4a@intel.com>
 <alpine.DEB.2.21.1806291824010.1595@nanos.tec.linutronix.de>
 <20180629190346.GO18979@romley-ivt3.sc.intel.com>
 <alpine.DEB.2.21.1806292148510.1595@nanos.tec.linutronix.de>
 <20180629203844.GA68178@romley-ivt3.sc.intel.com>
 <8fdfb671-f223-163b-12cd-3c97d94f91b4@intel.com>
 <alpine.DEB.2.21.1806292334180.1595@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806292334180.1595@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 11:44:44PM +0200, Thomas Gleixner wrote:
> On Fri, 29 Jun 2018, Dave Hansen wrote:
> 
> > On 06/29/2018 01:38 PM, Fenghua Yu wrote:
> > > How to handle data that is used in generic code which can be used on
> > > non-Intel platform? For exmple, if I do this change for struct efi in
> > > include/linux/efi.h because set_bit() sets bits in efi.flags:
> > > -       unsigned long flags;
> > > +       unsigned long flags __aligned(unsigned long);
> > >  } efi;
> > > 
> > > People may argue that the alignment unnecessarily increases size of 'efi'
> > > on non-Intel platform which doesn't have split lock issue. Do we care this
> > > argument?
> > 
> > Unaligned memory accesses are bad, pretty much universally.  This is a
> > general good practice that we should have been doing anyway.  Let folks
> > complain.  Don't let it stop you.
> > 
> > Also, look at the size of that structure.  Look at how many pointers it
> > has.  Do you think *anyone* is going to complain about an extra 4 bytes
> > in a 400-byte structure?
> 
> But in the above case the compiler does already the right thing. Why?
> Because struct members are aligned to their natural alignment unless the
> struct is explicitely marked 'packed'. In that case the programmer has to
> take care of the alignment.
> 
> Just look at it with pahole:
> 
> 	struct efi_memory_map      memmap;               /*   280    56 */
> 
> 	/* XXX last struct has 7 bytes of padding */
> 
> 	/* --- cacheline 5 boundary (320 bytes) was 16 bytes ago --- */
> 	long unsigned int          flags;                /*   336     8 */
> 
> The issue with the capability arrays is that the data type is u32 which has
> the natural alignment of 4 byte, while unsigned long has 8 byte on 64bit.
> 
> So just slapping blindly aligned(unsigned long) to anything which is
> accessed by locked instructions is pointless.
> 

Thank you for you education!

Below is part of the future patches that are supposed to fix more potential
split lock issues.

Could you please take a look and see if the changes are in the
right direction before I move further?

diff --git a/arch/x86/boot/cpuflags.h b/arch/x86/boot/cpuflags.h
index 2e20814d3ce3..ca62c3784f9a 100644
--- a/arch/x86/boot/cpuflags.h
+++ b/arch/x86/boot/cpuflags.h
@@ -9,7 +9,7 @@ struct cpu_features {
 	int level;		/* Family, or 64 for x86-64 */
 	int family;		/* Family, always */
 	int model;
-	u32 flags[NCAPINTS];
+	u32 flags[NCAPINTS] __aligned(unsigned long);
 };
 
 extern struct cpu_features cpu;
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 8c7b3e5a2d01..24eac32b039d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -133,7 +133,7 @@ struct mce_log_buffer {
 	char signature[12]; /* "MACHINECHECK" */
 	unsigned len;	    /* = MCE_LOG_LEN */
 	unsigned next;
-	unsigned flags;
+	unsigned flags __aligned(unsigned long);
 	unsigned recordlen;	/* length of struct mce */
 	struct mce entry[MCE_LOG_LEN];
 };
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..fe681c695638 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -488,8 +488,8 @@ static const char *table_lookup_model(struct cpuinfo_x86 *c)
 	return NULL;		/* Not found */
 }
 
-__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS];
-__u32 cpu_caps_set[NCAPINTS + NBUGINTS];
+__u32 cpu_caps_cleared[NCAPINTS + NBUGINTS] __aligned(unsigned long);
+__u32 cpu_caps_set[NCAPINTS + NBUGINTS] __aligned(unsigned long);
 
 void load_percpu_segment(int cpu)
 {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 56add823f190..e1a3c17945b5 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -963,7 +963,7 @@ extern struct efi {
 	efi_reset_system_t *reset_system;
 	efi_set_virtual_address_map_t *set_virtual_address_map;
 	struct efi_memory_map memmap;
-	unsigned long flags;
+	unsigned long flags __aligned(unsigned long);
 } efi;
 
 extern struct mm_struct efi_mm;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5c91108846db..30b1f173d3ca 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -885,7 +885,7 @@ struct file {
 	void			*f_security;
 #endif
 	/* needed for tty driver, and maybe others */
-	void			*private_data;
+	void			*private_data __aligned(unsigned long);
 
 #ifdef CONFIG_EPOLL
 	/* Used by fs/eventpoll.c to link all the hooks to this file */

