Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE9C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A31821D64
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 19:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TzfayQ17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A31821D64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFUT6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 15:58:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753906AbeFUT6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 15:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NCfZJbCeE/T6TScOracemGkfHW/3YQjTxG86YlEGMCg=; b=TzfayQ177UCZ5LGCfGbel8jP5
        k+m7bEY7ahxAa0wFZr20Trlj1DlyC6QZYh3umNX6jOg2YAEjVEm6CMwaSaT/IwVyfJ1HempoRJWJ4
        vhjD45oggFXztCQU/4yVdNx1/6cqWrAYdJcWHS1JdvUca64AjxeBaogQQzpStbN+CV9FOBle1JizX
        knHXl2zwqm7LtjBFagpfwIEYkML/dG0GOr/tcJAGdF9Nzcml/hJPUyc9pv3TlYJ8uWuHUK19wiIq0
        o+8yGt807Y6Qste/b2bpN7BhEMGO3OGTgzpfYGpJ3CP6e/HfPUhfawzJoKSE1s11D+jWntxG5lVWA
        Aw4ZF4+Rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW5is-000111-64; Thu, 21 Jun 2018 19:58:26 +0000
Received: by worktop (Postfix, from userid 1000)
        id E6A876E093E; Thu, 21 Jun 2018 21:58:23 +0200 (CEST)
Date:   Thu, 21 Jun 2018 21:58:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 06/16] x86/split_lock: Save #AC setting for split
 lock in firmware in boot time and restore the setting in reboot
Message-ID: <20180621195823.GD13636@worktop.programming.kicks-ass.net>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
 <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527435965-202085-7-git-send-email-fenghua.yu@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 27, 2018 at 08:45:55AM -0700, Fenghua Yu wrote:
> Firmware may contain split locked instructions.

I think that's the wrong attitude. You should mandate in your BIOS
development guide that Firmware _MUST_NOT_ contain unaligned LOCK
prefixed instructions.

