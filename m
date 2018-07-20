Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34967ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7620661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeGTUnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:43:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37830 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbeGTUnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:43:32 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fgbTB-0002H9-Tw; Fri, 20 Jul 2018 21:53:42 +0200
Date:   Fri, 20 Jul 2018 21:53:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in
 all page-tables
In-Reply-To: <alpine.DEB.2.21.1807202142130.1694@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1807202152400.1694@nanos.tec.linutronix.de>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org> <1532103744-31902-2-git-send-email-joro@8bytes.org> <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com> <alpine.DEB.2.21.1807202126400.1694@nanos.tec.linutronix.de>
 <CALCETrW7o=s7esmE4+SxLPsLv2SvJZU6f7jfsedazZVrot2EqA@mail.gmail.com> <alpine.DEB.2.21.1807202142130.1694@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Thomas Gleixner wrote:
> On Fri, 20 Jul 2018, Andy Lutomirski wrote:
> > On Fri, Jul 20, 2018 at 12:27 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > On Fri, 20 Jul 2018, Andy Lutomirski wrote:
> > >> > On Jul 20, 2018, at 6:22 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > >> >
> > >> > From: Joerg Roedel <jroedel@suse.de>
> > >> >
> > >> > The ring-buffer is accessed in the NMI handler, so we better
> > >> > avoid faulting on it. Sync the vmalloc range with all
> > >> > page-tables in system to make sure everyone has it mapped.
> > >> >
> > >> > This fixes a WARN_ON_ONCE() that can be triggered with PTI
> > >> > enabled on x86-32:
> > >> >
> > >> >    WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230
> > >> >
> > >> > This triggers because with PTI enabled on an PAE kernel the
> > >> > PMDs are no longer shared between the page-tables, so the
> > >> > vmalloc changes do not propagate automatically.
> > >>
> > >> It seems like it would be much more robust to fix the vmalloc_fault()
> > >> code instead.
> > >
> > > Right, but now the obvious fix for the issue at hand is this. We surely
> > > should revisit this.
> > 
> > If you commit this under this reasoning, then please at least make it say:
> > 
> > /* XXX: The vmalloc_fault() code is buggy on PTI+PAE systems, and this
> > is a workaround. */
> > 
> > Let's not have code in the kernel that pretends to make sense but is
> > actually voodoo magic that works around bugs elsewhere.  It's no fun
> > to maintain down the road.
> 
> Fair enough. Lemme amend it. Joerg is looking into it, but I surely want to
> get that stuff some exposure in next ASAP.

Delta patch below.

Thanks.

	tglx

8<-------------
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -815,8 +815,12 @@ static void rb_free_work(struct work_str
 	vfree(base);
 	kfree(rb);
 
-	/* Make sure buffer is unmapped in all page-tables */
-	vmalloc_sync_all();
+	/*
+	 * FIXME: PAE workaround for vmalloc_fault(): Make sure buffer is
+	 * unmapped in all page-tables.
+	 */
+	if (IS_ENABLED(CONFIG_X86_PAE))
+		vmalloc_sync_all();
 }
 
 void rb_free(struct ring_buffer *rb)
@@ -844,11 +848,13 @@ struct ring_buffer *rb_alloc(int nr_page
 		goto fail_all_buf;
 
 	/*
-	 * The buffer is accessed in NMI handlers, make sure it is
-	 * mapped in all page-tables in the system so that we don't
-	 * fault on the range in an NMI handler.
+	 * FIXME: PAE workaround for vmalloc_fault(): The buffer is
+	 * accessed in NMI handlers, make sure it is mapped in all
+	 * page-tables in the system so that we don't fault on the range in
+	 * an NMI handler.
 	 */
-	vmalloc_sync_all();
+	if (IS_ENABLED(CONFIG_X86_PAE))
+		vmalloc_sync_all();
 
 	rb->user_page = all_buf;
 	rb->data_pages[0] = all_buf + PAGE_SIZE;
