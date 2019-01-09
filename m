Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA8E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 00:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbfAIAjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 19:39:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfAIAjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 19:39:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D3F05AF9E;
        Wed,  9 Jan 2019 00:39:18 +0000 (UTC)
Received: from ovpn-120-48.rdu2.redhat.com (ovpn-120-48.rdu2.redhat.com [10.10.120.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4364A5D76A;
        Wed,  9 Jan 2019 00:39:15 +0000 (UTC)
Message-ID: <1546994355.3632.15.camel@redhat.com>
Subject: Re: [PATCH RT] x86/mm/pat: disable preemption __split_large_page()
 after spin_lock()
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, stable-rt@vger.kernel.org
Date:   Tue, 08 Jan 2019 18:39:15 -0600
In-Reply-To: <20181213164430.mggilzfjgr5retz6@linutronix.de>
References: <20181213164430.mggilzfjgr5retz6@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 09 Jan 2019 00:39:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 17:44 +0100, Sebastian Andrzej Siewior wrote:
> Commit "x86/mm/pat: Disable preemption around __flush_tlb_all()" added a
> warning if __flush_tlb_all() is invoked in preemptible context. On !RT
> the warning does not trigger because a spin lock is acquired which
> disables preemption. On RT the spin lock does not disable preemption and
> so the warning is seen.
> 
> Disable preemption to avoid the warning in __flush_tlb_all().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

FWIW, that __flush_tlb_all() can probably just be removed.  It was added as
a partial workaround for an erratum, but since it didn't completely solve
the problem, hugepages were disabled on the affected chips in commit
7a0fc404ae66377 ("x86: Disable large pages on CPUs with Atom erratum
AAE44").  I was going to send a (non-RT) patch removing the flush but in
4.20 commit c0a759abf5a68 ("x86/mm/cpa: Move flush_tlb_all()") reworked the
code to make it moot.

-Scott

