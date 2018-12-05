Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BA2C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616862084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616862084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeLEPXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:23:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:57635 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbeLEPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:23:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 07:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,317,1539673200"; 
   d="scan'208";a="115877161"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by orsmga002.jf.intel.com with ESMTP; 05 Dec 2018 07:23:36 -0800
Date:   Wed, 5 Dec 2018 07:23:36 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6/5] x86/fault: Clean up the page fault oops decoder a bit
Message-ID: <20181205152336.GA31197@linux.intel.com>
References: <cover.1542841400.git.luto@kernel.org>
 <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
 <20181122084119.GA44720@gmail.com>
 <20181127153202.GA27075@linux.intel.com>
 <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW00oTpXOONwbONHHuiyqp9QbNMe0gvVgf8X3_X0fidqw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 11:22:25AM -0800, Andy Lutomirski wrote:
> On Tue, Nov 27, 2018 at 7:32 AM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
> >  arch/x86/mm/fault.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 2ff25ad33233..510e263c256b 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -660,8 +660,10 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
> >         err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
> >         err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
> >         err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
> > -
> > -       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
> > +       err_str_append(~error_code, err_txt, X86_PF_USER, "[KERNEL]");
> > +       err_str_append(~error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR,
> > +                                                         "[READ]");
> > +       pr_alert("#PF error code: %s\n", err_txt);
> >
> 
> Seems generally nice, but I would suggest making the bit-not-set name
> be another parameter to err_str_append().

I didn't recall why I chose to negate error_code until I revisited the
actual code.  The "READ" case is a combination of !WRITE && !USER, i.e.
doesn't fit into an existing err_str_append() call.  So we'd end up with
an extra err_str_append() call that would also have a null message for
the positive test, which seemed unnecessarily complex and more convoluted
than simply negating error_code.

E.g.:

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..48b420621825 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -607,12 +607,17 @@ static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
  * This helper function transforms the #PF error_code bits into
  * "[PROT] [USER]" type of descriptive, almost human-readable error strings:
  */
-static void err_str_append(unsigned long error_code, char *buf, unsigned long mask, const char *txt)
+static void err_str_append(unsigned long error_code, char *buf, unsigned long mask,
+                          const char *pos, const char *neg)
 {
-       if (error_code & mask) {
+       if ((error_code & mask) == mask && pos) {
                if (buf[0])
                        strcat(buf, " ");
-               strcat(buf, txt);
+               strcat(buf, pos);
+       } else if (!(error_code & mask) && neg) {
+               if (buf[0])
+                       strcat(buf, " ");
+               strcat(buf, neg);
        }
 }

@@ -654,14 +659,15 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
         * Note: length of these appended strings including the separation space and the
         * zero delimiter must fit into err_txt[].
         */
-       err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" );
-       err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]");
-       err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" );
-       err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" );
-       err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]");
-       err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   );
-
-       pr_alert("#PF error: %s\n", error_code ? err_txt : "[normal kernel read fault]");
+       err_str_append(error_code, err_txt, X86_PF_PROT,  "[PROT]" , NULL);
+       err_str_append(error_code, err_txt, X86_PF_WRITE, "[WRITE]", NULL);
+       err_str_append(error_code, err_txt, X86_PF_USER,  "[USER]" , "[SUPERVISOR]");
+       err_str_append(error_code, err_txt, X86_PF_RSVD,  "[RSVD]" , NULL);
+       err_str_append(error_code, err_txt, X86_PF_INSTR, "[INSTR]", NULL);
+       err_str_append(error_code, err_txt, X86_PF_PK,    "[PK]"   , NULL);
+       err_str_append(error_code, err_txt, X86_PF_WRITE | X86_PF_INSTR, NULL,
+                                                         "[READ]");
+       pr_alert("#PF error code: %s\n", err_txt);

        if (!(error_code & X86_PF_USER) && user_mode(regs)) {
                struct desc_ptr idt, gdt;
