Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D1FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F8E2077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1QKqT9FA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F8E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeIGQCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:02:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeIGQCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rv0iF90kgOtQh1SwnwC53DMoLwfCcdq5nf68M9YfNvo=; b=1QKqT9FAxe2Bk3rgzwill4DcC
        9qJNN4VjVbk1v1l8XpiopdENQQMaWv4dJEsKRKB+zJtNd45CjpuhYt/kwEZQix5yBwArg5yH9jb1B
        yKsBRXqBq0YtRRjtnMji/KDPDFSX1wrV94uvM7iSUyyrLbS0A/isvKUz3TQR8x66/UdYDx6Ad+uGn
        1OTIakQ3YFHAhdT9QqB2vkDUYaGiop+6nD/RUhMDoLCAtdaSpkaOUMfTE2vmKyEfgpW78Niirjivz
        ZLkS4gH1YgrD+CM9L1Wd+FRUMoyhkecXis3QWqSLYuUlxl63DNZAM3sLCsvp7UNOE3Mh0Yz7ZnY6D
        tsMq4gA9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyEph-0001Qp-Gv; Fri, 07 Sep 2018 11:21:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1983320191BFB; Fri,  7 Sep 2018 13:21:48 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:21:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, ricardo.neri@intel.com, matt@codeblueprint.co.uk,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH V4 2/3] x86/efi: Add efi page fault handler to recover
 from page faults caused by the firmware
Message-ID: <20180907112147.GR24106@hirez.programming.kicks-ass.net>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-3-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536276468-28499-3-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:27:47PM -0700, Sai Praneeth Prakhya wrote:
> @@ -790,6 +792,13 @@ no_context(struct pt_regs *regs, unsigned long error_code,
>  		return;
>  
>  	/*
> +	 * Buggy firmware could access regions which might page fault, try to
> +	 * recover from such faults.
> +	 */
> +	if (efi_recover_from_page_fault(address))
> +		return;
> +
> +	/*
>  	 * Oops. The kernel tried to access some bad page. We'll have to
>  	 * terminate things with extreme prejudice:
>  	 */

> +int efi_recover_from_page_fault(unsigned long phys_addr)
> +{
> +	/* Recover from page faults caused *only* by the firmware */
> +	if (current->active_mm != &efi_mm)
> +		return 0;
> +
> +	/*
> +	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
> +	 * page faulting on these addresses isn't expected.
> +	 */
> +	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
> +		return 0;
> +
> +	/*
> +	 * Print stack trace as it might be useful to know which EFI Runtime
> +	 * Service is buggy.
> +	 */
> +	WARN(1, FW_BUG "Page fault caused by firmware at PA: 0x%lx\n",
> +	     phys_addr);
> +
> +	/*
> +	 * Buggy efi_reset_system() is handled differently from other EFI
> +	 * Runtime Services as it doesn't use efi_rts_wq. Although,
> +	 * native_machine_emergency_restart() says that machine_real_restart()
> +	 * could fail, it's better not to compilcate this fault handler
> +	 * because this case occurs *very* rarely and hence could be improved
> +	 * on a need by basis.
> +	 */
> +	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
> +		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
> +		machine_real_restart(MRR_BIOS);
> +		return 0;
> +	}
> +
> +	/* Firmware has caused page fault, hence, freeze efi_rts_wq. */
> +	set_current_state(TASK_UNINTERRUPTIBLE);

This doesn't freeze it, as such, it just sets the state.

> +
> +	/*
> +	 * Before calling EFI Runtime Service, the kernel has switched the
> +	 * calling process to efi_mm. Hence, switch back to task_mm.
> +	 */
> +	arch_efi_call_virt_teardown();
> +
> +	/* Signal error status to the efi caller process */
> +	efi_rts_work.status = EFI_ABORTED;
> +	complete(&efi_rts_work.efi_rts_comp);
> +
> +	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> +	pr_info("Froze efi_rts_wq and disabled EFI Runtime Services\n");

> +	schedule();

So what happens when we get a spurious wakeup and return from this?

Quite possibly you want something like:

	for (;;) {
		set_current_state(TASK_IDLE);
		schedule();
	}

here. The TASK_UNINTERRUPTIBLE thing will cause the load-avg to spike;
is that what you want?

> +
> +	return 0;
> +}
