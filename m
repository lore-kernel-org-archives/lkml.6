Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71E820846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 03:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71E820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754388AbeFTDdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 23:33:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:42884 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbeFTDdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 23:33:23 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fVTs1-0001PZ-Rb; Wed, 20 Jun 2018 03:33:21 +0000
Date:   Wed, 20 Jun 2018 04:33:21 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __poll_t regressions this cycle
Message-ID: <20180620033321.GR30522@ZenIV.linux.org.uk>
References: <20180618134730.GO30522@ZenIV.linux.org.uk>
 <CA+55aFzt37S-iKfHAuCL=5XhCvEtRARfs_exyn2o-0LzCWFvXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFzt37S-iKfHAuCL=5XhCvEtRARfs_exyn2o-0LzCWFvXQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:57:41AM +0900, Linus Torvalds wrote:
> On Mon, Jun 18, 2018 at 10:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Do you prefer it in one commit, or split into per-driver pieces?
> 
> If it's all the exact same issue with the same commit message, then
> just one commit.

Some EPOLL... misspelled as POLL..., some ->poll() instances declared
as returning unsigned int instead of __poll_t and some __poll_t local
variables declared unsigned int.  The only case beyond misannotations
is POLLWRNORM instead of EPOLLWRNORM - basically, on sparc, mips et.al. 
EPOLLWRNORM (via epoll(7)) doesn't trigger for mei and xsk.  Which
used to be the case for all drivers (only EPOLLOUT used to trigger on
these architectures) before the fixes this February...
