Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E2BC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACF020874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="P7yQ4Zj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACF020874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbeGVQVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 12:21:00 -0400
Received: from imap.thunk.org ([74.207.234.97]:42990 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbeGVQU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 12:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TpsuwyKqDYo6S/F9awbGePl8pchmvOeBGXRGKTykDUw=; b=P7yQ4Zj8B9m7seSjHTTSA38wKK
        vjYBBMZVjfOfrF1GCBkXEIeC39jEMFo415SiaecZWKeKJVpJs3i66hl6HvK/VEc57heO0wnCXSxyk
        aT/O57hx1BSK91Yfy/V3HMVeehB4aa7W2iH3xuhgiEVGOK0If1kpeZHa/V3cpi2mToTM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhGD8-0002dH-IJ; Sun, 22 Jul 2018 15:23:50 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E52267A04D1; Sun, 22 Jul 2018 10:52:06 -0400 (EDT)
Date:   Sun, 22 Jul 2018 10:52:06 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tglx@linutronix.de, Ingo Molnar <mingo@kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] random: Remove preempt disabled region
Message-ID: <20180722145206.GA6685@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@elte.hu>
References: <20180711143721.18378-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711143721.18378-1-bigeasy@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 04:37:21PM +0200, Sebastian Andrzej Siewior wrote:
> From: Ingo Molnar <mingo@elte.hu>
> 
> No need to keep preemption disabled across the whole function.
> 
> mix_pool_bytes() uses a spin_lock() to protect the pool and there are
> other places like write_pool() whhich invoke mix_pool_bytes() without
> disabling preemption.
> credit_entropy_bits() is invoked from other places like
> add_hwgenerator_randomness() without disabling preemption.
> 
> Before commit 95b709b6be49 ("random: drop trickle mode") the function
> used __this_cpu_inc_return() which would require disabled preemption.
> The preempt_disable() section was added in commit 43d5d3018c37 ("[PATCH]
> random driver preempt robustness", history tree).  It was claimed that
> the code relied on "vt_ioctl() being called under BKL".
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: enhance the commit message]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied, thanks.

					- Ted
