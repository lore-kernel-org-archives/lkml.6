Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D237C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6142320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080672;
	bh=ACOJcjG4rVF2opM4WTsVMSDlvUpqXcectVyDWrCX4m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sURs5zHza17gyytMih0UWDIdOo38B1P71aw4Hdkm8ispYKAIOHg2rzfkLW7mJ0Nkd
	 T3aL8mHQpfvIoJBS+CWz+3qP24DE7+mpaMZRtVfq/QeQF28waKivBCYoIYH21Jm/E+
	 UkxyxYnxMqMbpCq42JJM6kGqCWLlEO0VJBSpxKH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbfAUOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfAUOYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:24:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A3812063F;
        Mon, 21 Jan 2019 14:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548080669;
        bh=ACOJcjG4rVF2opM4WTsVMSDlvUpqXcectVyDWrCX4m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7hl3cfTyKUDKtdQaW5joqJ5KWb9+YnJ7ctJYgHkXB+qPAq4ueAeYGbAZdNdzxLE0
         OJv4S+4qUgvP8c0ytacvlJ0J9+8c021cqnFaAZh5kPwjppKN8gEerX68NoAoaXDyb+
         vyZBNM5y5vp3CqJ6XbkS0BXBqG+tVJVPh2hyw1jY=
Date:   Mon, 21 Jan 2019 15:24:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        H Peter Anvin <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: x86: Fix single-step debugging
Message-ID: <20190121142427.GA26671@kroah.com>
References: <1548074920-10651-1-git-send-email-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548074920-10651-1-git-send-email-alex.popov@linux.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 03:48:40PM +0300, Alexander Popov wrote:
> The single-step debugging of KVM guests on x86 is broken: if we run
> gdb 'stepi' command at the breakpoint when the guest interrupts are
> enabled, RIP always jumps to native_apic_mem_write(). Then other
> nasty effects follow.
> 
> Long investigation showed that on Jun 7, 2017 the
> commit c8401dda2f0a00cd25c0 ("KVM: x86: fix singlestepping over syscall")
> introduced the kvm_run.debug corruption: kvm_vcpu_do_singlestep() can
> be called without X86_EFLAGS_TF set.
> 
> Let's fix it. Please consider that for -stable.
> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  arch/x86/kvm/x86.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
