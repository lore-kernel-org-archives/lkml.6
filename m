Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFA7C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5D320844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 11:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQ6qmHJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5D320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeIGQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 12:02:45 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeIGQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 12:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z3Nd7ZIp4WmOWGI94vPTqYGjqDJTj78oMv5r92i9wXc=; b=hQ6qmHJiNE1pRwqPOK1o51ZQh
        zrUfSl3U9qCdz/WtV5jMbPoneitrQyT2m3WrmP0OnufkHrZneG7FfcKPSCfghWt1VGW+WqPZkp6ty
        0DEjtIqzQ17VB+AdpHOUSzpIXn61ioNQbOEgwBYWpdJFd6YPGOyqmZxz0Fn3dUYDPYYpTE/2y8lDd
        T+m8VMN+GBwMYmeQhooQpXOwITvBl6DG3gzNGLWCJiOWN9XTBH/cY9pGV3phVZqkdfrmM6MEJZ8pI
        yMxMGsfOYotRjaAZixXwBMkTR1TTfSkKQRuakvHF6KHQNOq38NyhbODUPOs4hH+KwCvTp6LA3ff4e
        D25v6Yzmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fyEq0-0001R7-Ne; Fri, 07 Sep 2018 11:22:08 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80C3820191BFB; Fri,  7 Sep 2018 13:22:07 +0200 (CEST)
Date:   Fri, 7 Sep 2018 13:22:07 +0200
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
Subject: Re: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
Message-ID: <20180907112207.GS24106@hirez.programming.kicks-ass.net>
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 04:27:48PM -0700, Sai Praneeth Prakhya wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
> 
> There may exist some buggy UEFI firmware implementations that might
> access efi regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even
> after the kernel has assumed control of the platform. This violates UEFI
> specification.
> 
> If selected, this debug option will print a warning message if the UEFI
> firmware tries to access any memory region which it shouldn't. Along
> with the warning, the efi page fault handler will also try to recover
> from the page fault triggered by the firmware so that the machine
> doesn't hang.

Why make this optional?
