Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B61C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5C520817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5C520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbeK1Cau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:30:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:2503 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK1Cau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:30:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 07:32:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,287,1539673200"; 
   d="scan'208";a="114623107"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 07:32:03 -0800
Date:   Tue, 27 Nov 2018 07:32:03 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
Message-ID: <20181127153202.GA27075@linux.intel.com>
References: <cover.1542841400.git.luto@kernel.org>
 <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122084119.GA44720@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 09:41:19AM +0100, Ingo Molnar wrote:
> 
> * Andy Lutomirski <luto@kernel.org> wrote:
> 
> > One of Linus' favorite hobbies seems to be looking at OOPSes and
> > decoding the error code in his head.  This is not one of my favorite
> > hobbies :)
> > 
> > Teach the page fault OOPS hander to decode the error code.  If it's
> > a !USER fault from user mode, print an explicit note to that effect
> > and print out the addresses of various tables that might cause such
> > an error.
> > 
> > With this patch applied, if I intentionally point the LDT at 0x0 and
> > run the x86 selftests, I get:
> > 
> > BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> > HW error: normal kernel read fault
> > This was a system access from user code
> > IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe0000001000 (limit=0x7f)
> > LDTR: 0x50 -- base=0x0 limit=0xfff7
> > TR: 0x40 -- base=0xfffffe0000003000 limit=0x206f
> > PGD 800000000456e067 P4D 800000000456e067 PUD 4623067 PMD 0
> > SMP PTI
> > CPU: 0 PID: 153 Comm: ldt_gdt_64 Not tainted 4.19.0+ #1317
> > Hardware name: ...
> > RIP: 0033:0x401454
> 
> I've applied your series, with one small edit, the following message:
> 
>   > HW error: normal kernel read fault
> 
> will IMHO confuse the heck out of users, thinking that their hardware is 
> broken...
> 
> Yes, the message is accurate, in MM pagefault language it's indeed the HW 
> error code, but it's a language very few people speak.
> 
> So I edited it over to say '#PF error code'. I also applied a few other 
> minor cleanups - see the changelog below.

I responded to the original thread a hair too late...

What about something like this instead of manually handling the case
where error_code==0 so that we get e.g. "[KERNEL] [READ]" instead of
"normal kernel read fault"?  Getting "[PROT] [KERNEL] [READ]" seems
useful.

IMO "[normal kernel read fault]" followed by "This was a system access
from user code" is still confusing.

---
8b29ee4351d5c625aa9ca2765f8da5e Mon Sep 17 00:00:00 2001
From: Sean Christopherson <sean.j.christopherson@intel.com>
Date: Tue, 27 Nov 2018 07:09:57 -0800
Subject: [PATCH] x86/fault: Print "KERNEL" and "READ" for #PF error codes

...and explicitly state that it's a "code" that's being printed.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/mm/fault.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..510e263c256b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
 	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
 	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
-
-	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+	err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
+	err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
+							  "[READ]");
+	pr_alert("#PF error code: %s\n", err_txt);
 
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
-- 
2.19.2

> 
> Let me know if you have any objections.
> 
> Thanks,
> 
> 	Ingo
> 
> ===============>
> From a2aa52ab16efbee40ad118ebac4a5e438f5b43ee Mon Sep 17 00:00:00 2001
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 22 Nov 2018 09:34:03 +0100
> Subject: [PATCH] x86/fault: Clean up the page fault oops decoder a bit
> 
>  - Make the oops messages a bit less scary (don't mention 'HW errors')
> 
>  - Turn 'PROT USER' (which is visually easily confused with PROT_USER)
>    into individual bit descriptors: "[PROT] [USER]".
>    This also makes "[normal kernel read fault]" more apparent.
> 
>  - De-abbreviate variables to make the code easier to read
> 
>  - Use vertical alignment where appropriate.
> 
>  - Add comment about string size limits and the helper function.
> 
>  - Remove unnecessary line breaks.
> 
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/mm/fault.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index f5efbdba2b6d..2ff25ad33233 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -603,10 +603,13 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
>  		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
>  }
>  
> -static void errstr(unsigned long ec, char *buf, unsigned long mask,
> -		   const char *txt)
> +/*
> + * This helper function transforms the #PF error_code bits into
> + * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
> + */
> +static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
>  {
> -	if (ec & mask) {
> +	if (error_code & mask) {
>  		if (buf[0])
>  			strcat(buf, " ");
>  		strcat(buf, txt);
> @@ -614,10 +617,9 @@ static void errstr(unsigned long ec, char *buf, unsigned long mask,
>  }
>  
>  static void
> -show_fault_oops(struct pt_regs *regs, unsigned long error_code,
> -		unsigned long address)
> +show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
>  {
> -	char errtxt[64];
> +	char err_txt[64];
>  
>  	if (!oops_may_print())
>  		return;
> @@ -646,15 +648,21 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
>  		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
>  		 (void *)address);
>  
> -	errtxt[0] = 0;
> -	errstr(error_code, errtxt, X86_PF_PROT, "PROT");
> -	errstr(error_code, errtxt, X86_PF_WRITE, "WRITE");
> -	errstr(error_code, errtxt, X86_PF_USER, "USER");
> -	errstr(error_code, errtxt, X86_PF_RSVD, "RSVD");
> -	errstr(error_code, errtxt, X86_PF_INSTR, "INSTR");
> -	errstr(error_code, errtxt, X86_PF_PK, "PK");
> -	pr_alert("HW error: %s\n", error_code ? errtxt :
> -		 "normal kernel read fault");
> +	err_txt[0] = 0;
> +
> +	/*
> +	 * Note: length of these appended strings including the separation space and the
> +	 * zero delimiter must fit into err_txt[].
> +	 */
> +	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
> +	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
> +	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
> +	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> +	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> +	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> +
> +	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> +
>  	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
>  		struct desc_ptr idt, gdt;
>  		u16 ldtr, tr;
