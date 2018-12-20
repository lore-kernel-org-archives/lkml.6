Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE04C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A124218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545320434;
	bh=4d2f79oa4N3Yzf3Sx64VY7TSmVS4zqicShxnZ1sUR0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Reo8qHEeO0Ia1Z0hfls2BQYV97gEkidUM6e45CqWimEaFIEnytfCjoqHqlIuhrzdN
	 uuoTlffRisJnrxhWitLyqG8zOozyj9aFC5QS4Lk6cLT9ZkNfSuXpTINOOl3C21nLRC
	 sINXSB5vyocuTkoZVAEMjLYR5if2wj2BmexnW8QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbeLTPkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:40:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbeLTPkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:40:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC3E2186A;
        Thu, 20 Dec 2018 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545320432;
        bh=4d2f79oa4N3Yzf3Sx64VY7TSmVS4zqicShxnZ1sUR0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hx2GY2x+stExRxoItRF3Dq045C67G+JoQnd5HCfROkEd1HvGVAy0tGGOEDYIY+0s6
         O+l3SP3C+F1bqTFF+ivcGGvHm1v+9h5byqyqX4/YDkFzcGTDoZwIjP4wwjfJLP4WrL
         vhD4+5OChUtt15/ONuQJVPSgMEi93Pwnml9cYvBo=
Date:   Thu, 20 Dec 2018 16:40:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.14 29/72] locking/qspinlock, x86: Provide liveness
 guarantee
Message-ID: <20181220154030.GA9962@kroah.com>
References: <20181220085922.332225035@linuxfoundation.org>
 <20181220085923.488666294@linuxfoundation.org>
 <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 12:14:00PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, Dec 20, 2018 at 9:28 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.
> 
> Another upstream commit fixes this.
> b987ffc18fb3 ("x86/qspinlock: Fix compile error")

Maybe, but that commit doesn't apply to any of these stable trees :(

Care to provide a backport?

thanks,

greg k-h
