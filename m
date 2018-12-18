Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF36C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3695D218A5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeLRRbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:31:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLRRbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:31:38 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D222133F;
        Tue, 18 Dec 2018 17:31:36 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:31:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V2 7/9] x86/alternative: Batch of patch operations
Message-ID: <20181218123134.2bdcc042@gandalf.local.home>
In-Reply-To: <327a30e43e27ed3a0300952126bf36fae6652b74.1545149539.git.bristot@redhat.com>
References: <cover.1545149539.git.bristot@redhat.com>
        <327a30e43e27ed3a0300952126bf36fae6652b74.1545149539.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 17:46:36 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> +void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries)
> +{
> +	unsigned int i;
> +	unsigned char int3 = 0xcc;
> +	int patched_all_but_first = 0;
> +
> +	bp_int3_tpv = tp;
> +	bp_int3_tpv_nr = nr_entries;
> +	bp_patching_in_progress = true;
> +	/*
> +	 * Corresponding read barrier in int3 notifier for making sure the
> +	 * in_progress and handler are correctly ordered wrt. patching.
> +	 */
> +	smp_wmb();
> +
> +	for (i = 0; i < nr_entries; i++)
> +		text_poke_bp_set_handler(tp[i].addr, tp[i].handler, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +
> +	for (i = 0; i < nr_entries; i++) {
> +		if (tp->len - sizeof(int3) > 0) {

Should this be:

		if (tp[i].len - sizeof(int3) > 0) {

?

-- Steve

> +			patch_all_but_first_byte(tp[i].addr, tp[i].opcode,
> +						 tp[i].len, int3);
> +			patched_all_but_first++;
> +		}
> +	}
> +
> +	if (patched_all_but_first) {
> +		/*
> +		 * According to Intel, this core syncing is very likely
> +		 * not necessary and we'd be safe even without it. But
> +		 * better safe than sorry (plus there's not only Intel).
> +		 */
> +		on_each_cpu(do_sync_core, NULL, 1);
> +	}
> +
> +	for (i = 0; i < nr_entries; i++)
> +		patch_first_byte(tp[i].addr, tp[i].opcode, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +	/*
> +	 * sync_core() implies an smp_mb() and orders this store against
> +	 * the writing of the new instruction.
> +	 */
> +	bp_int3_tpv_nr = 0;
> +	bp_int3_tpv = NULL;
> +	bp_patching_in_progress = false;
> +}

