Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C59222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550030745;
	bh=1ISBSWGHHJm0iWeiYsdOya1tCWNb3ADGGlEBFKUYjoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U3bSirRi5Gm3GjXyMBawIdFBrcWFqlfVWJmBpKh+QWXC3TBtqRp9ZE1TxFSYq9QNM
	 erXqDuLg3TqLcVArOjeW2hP08bXeMTpexk+sOPO6P5qNQcYG4KfrmoQ7v06VJy1OR/
	 YedC8s0jr4a3lifjQS9exF2dkh3bngp0bfRDLy4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfBMEFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:05:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfBMEFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:05:44 -0500
Received: from localhost (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34969222BB;
        Wed, 13 Feb 2019 04:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550030743;
        bh=1ISBSWGHHJm0iWeiYsdOya1tCWNb3ADGGlEBFKUYjoo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xr/4WP3GE7oxlO31RJEYZ4Tlyv2P1Gcr9PPdLTdSUhaEMdDTslDZJEYUjr5T/dwQV
         oVAJoaAsMBMJuSshWOb8eBnkGTHcXVEjRfpmlvSsxUMv+jPUXFvJ4ncsechngjNEJ2
         qqEeLGIlKE2SXES6LyHgZKtIbAuX/PvytMluOvww=
Date:   Wed, 13 Feb 2019 05:05:40 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Denys Vlasenko <vda.linux@googlemail.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: preempt.h: some SOFTIRQ_OFFSET should be SOFTIRQ_MASK?
Message-ID: <20190213040539.GA8524@lenoir>
References: <CAK1hOcN8_0MNEFfoHg0sAuu09SPhXHvXfXkeHONtoFXOArjumg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1hOcN8_0MNEFfoHg0sAuu09SPhXHvXfXkeHONtoFXOArjumg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 07:34:31PM +0100, Denys Vlasenko wrote:
> SOFTIRQ is a counter.
> Why here:
> 
> #define in_serving_softirq()    (softirq_count() & SOFTIRQ_OFFSET)
> #define in_task()               (!(preempt_count() & \
>                                    (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> 
> we check only lowest bit?

So we have SOFTIRQ_OFFSET that is used when serving softirqs.
And we have SOFTIRQ_DISABLE_OFFSET that is used when we disable
softirqs.

I think the choice is right on both tests above, or am I missing something?
