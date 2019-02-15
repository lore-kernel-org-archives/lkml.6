Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FC21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550190696;
	bh=lcNHBpYqkO+CSOSkHgROusb/Pk4OlXS52v8mfiwkrCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=brid4gV5kDpDl5Qm/5t7rolLq2rJExHYI1iAqzzZjY7WqollbLXjCy5m+dGYHp/08
	 hR36m5O2NO5dy8e2pShgPt8qaN7RuNRVkD2n2nGoGhxkx2kVDahD7rnpdV13AtlVsc
	 5UrR/9vDN8vVhwpl4de4KQdjj8UvVKzXkewp1h5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfBOAbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:31:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729730AbfBOAbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:31:34 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 637DC21B18;
        Fri, 15 Feb 2019 00:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550190694;
        bh=lcNHBpYqkO+CSOSkHgROusb/Pk4OlXS52v8mfiwkrCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3Y14OloejyozXgutZxkuNIkS4rfjf3ayj4FJXGb9zSFpbx+iV7szo13nhFpyd1C9
         GGEXPU7Qob6h+zmPGxeGP9IQ1aKlkLIDoOHTiy902SaShe5WrECdenGaF7OYGv5rTk
         0OGB0zXGlcnjvx4FrtEl4+khFhUZYw1qkbGQf+jc=
Date:   Fri, 15 Feb 2019 01:31:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
Message-ID: <20190215003129.GA15707@lerouge>
References: <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20190116062408.GA26169@lenoir>
 <f60567f7-fa7e-f424-12e6-b3df7a24c0be@gmail.com>
 <48a2817e-4133-967e-7e57-eea2f547cb01@gmail.com>
 <alpine.DEB.2.21.1902142245170.1646@nanos.tec.linutronix.de>
 <fe610ada-c93c-2fec-3f45-3642272bc682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe610ada-c93c-2fec-3f45-3642272bc682@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:33:44PM +0100, Heiner Kallweit wrote:
> On 14.02.2019 22:47, Thomas Gleixner wrote:
> > On Thu, 14 Feb 2019, Heiner Kallweit wrote:
> >> On 24.01.2019 20:37, Heiner Kallweit wrote:
> >>>>
> >>> Hi Frederic,
> >>> is the update debug patch still to come?
> > 
> > Heiner, there is a related fix queued in
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> > 
> > See also:
> >     https://lkml.kernel.org/r/20190128234625.78241-3-mka@chromium.org
> >     https://lkml.kernel.org/r/20190128234625.78241-2-mka@chromium.org
> > 
> > Can you please have a look?
> > 
> Great. And sure, I can test it over the weekend.

Thanks you, and sorry for the shutdown, I was buried into softirq code lately.
