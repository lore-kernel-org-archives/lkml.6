Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738B2ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2005520C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MBHSYcHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2005520C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbeGQMA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:00:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbeGQMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cvcn4gVpyLiDlJfZfHSdxhQOBK2zvNc0GP6oJvtUq0Y=; b=MBHSYcHMg8/XqYmb0LBeBlz7X
        SV9sUR89Pm3kmk1X2k/vvvMzhSLAkTAYSFy/bFP4kbw5zz64Ts6gifHSZnKtDqibTSnTp1+88YAxI
        blga8k9dbn/Egp3aVDNSAgyuWj46rC38UOvKPmYnnxIIBeg1kYjvRCJ2uh1V4iUhXAV9tPU76OsWL
        Zla+HnAU9txBcUcBZuZcK5rUqsi/QjsextrMPIrDF4ppzv3+bG4qV3/C7TJEm8Iq1d033O5bs4EaI
        eH5Zp+rhFIBChqVseFIG4BvVU8dfrel5ny6Zd43SRIFicMYCIRyDrE2yPIJdQoE4GTGBYcIJFu6w2
        TcxhkBOOQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ffO9s-0005U6-Ga; Tue, 17 Jul 2018 11:28:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3698420275F3B; Tue, 17 Jul 2018 13:28:42 +0200 (CEST)
Date:   Tue, 17 Jul 2018 13:28:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        ricardo.neri-calderon@linux.intel.com, marc.zyngier@arm.com,
        mingo@kernel.org
Subject: Re: [RFC PATCH 1/4] genirq: Provide basic NMI management for
 interrupt lines
Message-ID: <20180717112842.GT2476@hirez.programming.kicks-ass.net>
References: <1531152846-19374-1-git-send-email-julien.thierry@arm.com>
 <1531152846-19374-2-git-send-email-julien.thierry@arm.com>
 <alpine.DEB.2.21.1807171114280.3238@nanos.tec.linutronix.de>
 <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c00482-7125-32e5-faa1-4251c118de5e@arm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 12:13:44PM +0100, Julien Thierry wrote:

> I'm a bit unsure about this one. In practice NMI handlers shouldn't take
> forever nor block the system for too long.

On x86 at least, kgdb can be in NMI context for extended periods. Not
saying that's a good thing, but on occasion we get reports on stuff
coming apart because of that.

(most times we tell people to not do that then)
