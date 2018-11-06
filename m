Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA38C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05612085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCrFfTT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05612085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbeKFWgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:36:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730421AbeKFWgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:36:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f4hpFykd27WZgb0tMujriu5Rm8XBUlMJV+J4NIrpLl8=; b=kCrFfTT4ZXzXUCEZk5Nv/PaeK
        txBrp5ZQiRyq7C5Jfi+jFZH8uNJ/pZvLIqiShhtGyABjdFTWJoNKy2Lk8YytKrb6ZjuvbPjpHBG0T
        EdouzxfDlbTKw9cvV3LALdWxxR2uaO1BB1csz3L8/LA3cCo+kL2svNkwXeUQICxZLhFkHDNxp7lRB
        tW86yC8G6nRPQKl92Ir6DsVHQOjFBH4ijakMTjCZm67IIzH06Jk9tcSfOs1W08S/j6j4yQRO7MD9/
        gCanqQrw1tLi/PTublDLj0s0CSr9BlIIrgSUOXn0KrHwsmKsbRgGG9RU0b68DBr2018GIHoQUy8or
        qDIboiy/g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gK18a-0005G2-Tm; Tue, 06 Nov 2018 13:11:21 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A15A20284F96; Tue,  6 Nov 2018 14:11:19 +0100 (CET)
Date:   Tue, 6 Nov 2018 14:11:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 6/7] x86/alternatives: use temporary mm for text poking
Message-ID: <20181106131119.GA9828@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-7-namit@vmware.com>
 <20181105133041.GC22467@hirez.programming.kicks-ass.net>
 <EFF64D16-26DE-437E-99B5-A870921B7D5F@vmware.com>
 <20181106082019.GF22431@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106082019.GF22431@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 09:20:19AM +0100, Peter Zijlstra wrote:

> By our current way of thinking, kmap_atomic simply is not correct.

Something like the below; which weirdly builds an x86_32 kernel.
Although I imagine a very sad one.

---

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ba7e3464ee92..e273f3879d04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1449,6 +1449,16 @@ config PAGE_OFFSET
 config HIGHMEM
 	def_bool y
 	depends on X86_32 && (HIGHMEM64G || HIGHMEM4G)
+	depends on !SMP || BROKEN
+	help
+	  By current thinking kmap_atomic() is broken, since it relies on per
+	  CPU PTEs in the global (kernel) address space and relies on CPU local
+	  TLB invalidates to completely invalidate these PTEs. However there is
+	  nothing that guarantees other CPUs will not speculatively touch upon
+	  'our' fixmap PTEs and load then into their TLBs, after which our
+	  local TLB invalidate will not invalidate them.
+
+	  There are AMD chips that will #MC on inconsistent TLB states.
 
 config X86_PAE
 	bool "PAE (Physical Address Extension) Support"
