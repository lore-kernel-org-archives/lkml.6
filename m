Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669EE2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669EE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeJSC2C convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:28:02 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35637 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbeJSC2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:28:02 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gDCzL-00009Q-5i; Thu, 18 Oct 2018 20:25:39 +0200
Date:   Thu, 18 Oct 2018 20:25:39 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
Message-ID: <20181018182538.vgotfpsdy7qxl2tg@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-6-bigeasy@linutronix.de>
 <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com>
 <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com>
 <20181018162644.qqjkzoqn2fleyi2b@linutronix.de>
 <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-18 09:48:24 [-0700], Andy Lutomirski wrote:
> > On Oct 18, 2018, at 9:26 AM, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >> On 2018-10-12 11:02:18 [-0700], Andy Lutomirski wrote:
> >> On Fri, Oct 12, 2018 at 10:54 AM Dave Hansen
> >>> So I'm kinda missing the point of the patch.
> >> 
> >> use_mm().
> > 
> > So. I would drop that patch from queue. Anyone feels different about it?
> > 
> 
> I think we *do* want the patch. It’s a bugfix for use_mm users, right?

This is the loophole that has been pointed out. I am not convinced what
the correct behaviour should be here (and we have five users of that
interface). For instance f_fs[0].  It reads data from the USB EP and
then writes it to userland task. Due to $circumstances it happens in a
workqueue instead of the task's context.  So it borrows the mm with
use_mm().  The current behaviour random because the PKRU value can not
be predicted. It may or may not work.

Setting it to allow-all/none would let the operation always fail or
succeed which might be an improvement in terms of debugging. However it
is hard to judge what the correct behaviour should be. Should fail or
succeed.
But this is not the only loophole: There is ptrace interface which is
used by gdb (just checked) and also bypasses PKRU. So…

[0] drivers/usb/gadget/function/f_fs.c::ffs_user_copy_worker()

Sebastian
