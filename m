Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C659C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3FB20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOLjtSx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD3FB20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393175AbeKVTTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:19:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36303 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbeKVTTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:19:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so8360599wrr.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5J1NWJTIOGSnhYUyb1liFmmp+KVqGObtf+tRRqjm+Cc=;
        b=VOLjtSx3A8cY19qhxRGvO6f69N/9Epxj/lnGe3qunw7CVgA8fuai7JEPlhqDjmpzAs
         nBd3dCclCnt7sfTEi4H68d4YJzD9WxyP+eROcAjk5+vbVUI1bpueUrrm8cgHXmRl2YVH
         1+15aUPIupNsDBsCYu9DAdVlkbDZlIUPX4cdqYELzhsT+hIbUtZ0skuHRwxl5XSDOpei
         YslytPzyVZ1PF07paxIirwfjIUcMK8o8z3DT7CrhuyP7X+azCTJ3M/LY5hOQwDVNuIPO
         KxVz+GWmFT/9mjGmEBG1n/Cs1hPbWBe2dBQTRuMrOXugmM078K3p9kxRyRB+253YM/v7
         Hi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5J1NWJTIOGSnhYUyb1liFmmp+KVqGObtf+tRRqjm+Cc=;
        b=bRKXX73Ej4+19l8E8HzlYixcaQAXplG7uinxfy++jiHMhSJHEnVlHtl1qy0PYSyges
         BDQBW1YR0vNBfhQZ9VAWO+Mv0QZykLMa3kbyCggMMGrdJmfBQuoYXLIOC0FdN/bOxeOy
         Z0rglZyOQOkOvdgjBijZ/XVRvq7YDwYgZGtFhoDhi6jcg8FFW1qd0iQs4pPDgU3Pbp7m
         hNmrZ2RxVdgfX0tnYXF+NO5qF89kc+BEejryfdqcIE7Ec85zqxi7OYZakETz0AIQQCnF
         zRygB+XTKbvOp8ARLTmSvoxRO3LguTcWtTm5EhMLklbCwQRPGtSMP2hS+GjpHeWULZYR
         u19Q==
X-Gm-Message-State: AA+aEWaiR/yW+9UXxLCWTDir0WMb7rUgf9W44J6M+jU57b/GTSuchzqd
        X/tVgXrn65bs1ZRqY1Tzp4nIlusc
X-Google-Smtp-Source: AFSGD/XFpNHIq+S4J7hCaImd5NEL40LOoyw7ZsNUblF0QEMjJ4S2ty59S8MuGOmvtRI98eUhG5YqVw==
X-Received: by 2002:adf:800b:: with SMTP id 11-v6mr9251349wrk.106.1542876082534;
        Thu, 22 Nov 2018 00:41:22 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v62-v6sm3536602wme.3.2018.11.22.00.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 00:41:21 -0800 (PST)
Date:   Thu, 22 Nov 2018 09:41:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
Message-ID: <20181122084119.GA44720@gmail.com>
References: <cover.1542841400.git.luto@kernel.org>
 <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@kernel.org> wrote:

> One of Linus' favorite hobbies seems to be looking at OOPSes and
> decoding the error code in his head.  This is not one of my favorite
> hobbies :)
> 
> Teach the page fault OOPS hander to decode the error code.  If it's
> a !USER fault from user mode, print an explicit note to that effect
> and print out the addresses of various tables that might cause such
> an error.
> 
> With this patch applied, if I intentionally point the LDT at 0x0 and
> run the x86 selftests, I get:
> 
> BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
> HW error: normal kernel read fault
> This was a system access from user code
> IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe0000001000 (limit=0x7f)
> LDTR: 0x50 -- base=0x0 limit=0xfff7
> TR: 0x40 -- base=0xfffffe0000003000 limit=0x206f
> PGD 800000000456e067 P4D 800000000456e067 PUD 4623067 PMD 0
> SMP PTI
> CPU: 0 PID: 153 Comm: ldt_gdt_64 Not tainted 4.19.0+ #1317
> Hardware name: ...
> RIP: 0033:0x401454

I've applied your series, with one small edit, the following message:

  > HW error: normal kernel read fault

will IMHO confuse the heck out of users, thinking that their hardware is 
broken...

Yes, the message is accurate, in MM pagefault language it's indeed the HW 
error code, but it's a language very few people speak.

So I edited it over to say '#PF error code'. I also applied a few other 
minor cleanups - see the changelog below.

Let me know if you have any objections.

Thanks,

	Ingo

===============>
From a2aa52ab16efbee40ad118ebac4a5e438f5b43ee Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@kernel.org>
Date: Thu, 22 Nov 2018 09:34:03 +0100
Subject: [PATCH] x86/fault: Clean up the page fault oops decoder a bit

 - Make the oops messages a bit less scary (don't mention 'HW errors')

 - Turn 'PROT USER' (which is visually easily confused with PROT_USER)
   into individual bit descriptors: "[PROT] [USER]".
   This also makes "[normal kernel read fault]" more apparent.

 - De-abbreviate variables to make the code easier to read

 - Use vertical alignment where appropriate.

 - Add comment about string size limits and the helper function.

 - Remove unnecessary line breaks.

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f5efbdba2b6d..2ff25ad33233 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -603,10 +603,13 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
 		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
 }
 
-static void errstr(unsigned long ec, char *buf, unsigned long mask,
-		   const char *txt)
+/*
+ * This helper function transforms the #PF error_code bits into
+ * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
+ */
+static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
 {
-	if (ec & mask) {
+	if (error_code & mask) {
 		if (buf[0])
 			strcat(buf, " ");
 		strcat(buf, txt);
@@ -614,10 +617,9 @@ static void errstr(unsigned long ec, char *buf, unsigned long mask,
 }
 
 static void
-show_fault_oops(struct pt_regs *regs, unsigned long error_code,
-		unsigned long address)
+show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
-	char errtxt[64];
+	char err_txt[64];
 
 	if (!oops_may_print())
 		return;
@@ -646,15 +648,21 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
 		 (void *)address);
 
-	errtxt[0] = 0;
-	errstr(error_code, errtxt, X86_PF_PROT, "PROT");
-	errstr(error_code, errtxt, X86_PF_WRITE, "WRITE");
-	errstr(error_code, errtxt, X86_PF_USER, "USER");
-	errstr(error_code, errtxt, X86_PF_RSVD, "RSVD");
-	errstr(error_code, errtxt, X86_PF_INSTR, "INSTR");
-	errstr(error_code, errtxt, X86_PF_PK, "PK");
-	pr_alert("HW error: %s\n", error_code ? errtxt :
-		 "normal kernel read fault");
+	err_txt[0] = 0;
+
+	/*
+	 * Note: length of these appended strings including the separation space and the
+	 * zero delimiter must fit into err_txt[].
+	 */
+	err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
+	err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
+	err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
+	err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
+	err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
+	err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
+
+	pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+
 	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
 		struct desc_ptr idt, gdt;
 		u16 ldtr, tr;
