Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49343C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BE72150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 06:29:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BE72150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389308AbeIUMQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 08:16:47 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47534 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389220AbeIUMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 08:16:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8209E609B268;
        Fri, 21 Sep 2018 08:29:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vG4x8QIRNjcc; Fri, 21 Sep 2018 08:29:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 23394609B26F;
        Fri, 21 Sep 2018 08:29:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id M12jjFiP8DSM; Fri, 21 Sep 2018 08:29:21 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C6F6E609B268;
        Fri, 21 Sep 2018 08:29:20 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        koen.vandeputte@ncentric.com, Eddie James <eajames.ibm@gmail.com>
Subject: Re: [PATCH] Revert "ubifs: xattr: Don't operate on deleted inodes"
Date:   Fri, 21 Sep 2018 08:29:20 +0200
Message-ID: <2219464.2Z2OOz3cfv@blindfold>
In-Reply-To: <CACPK8XfnV=MOLqLL3UK7FP+oRCt1NLLgB-OdNEGWXwyFWVu_+g@mail.gmail.com>
References: <20180916215735.31393-1-richard@nod.at> <2090091.R1QOzN4fXt@blindfold> <CACPK8XfnV=MOLqLL3UK7FP+oRCt1NLLgB-OdNEGWXwyFWVu_+g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 21. September 2018, 03:42:25 CEST schrieb Joel Stanley:
> On Thu, 20 Sep 2018 at 16:40, Richard Weinberger <richard@nod.at> wrote:
> >
> > Am Donnerstag, 20. September 2018, 04:30:41 CEST schrieb Joel Stanley:
> > > On Mon, 17 Sep 2018 at 07:30, Richard Weinberger <richard@nod.at> wrote:
> > > >
> > > > This reverts commit 11a6fc3dc743e22fb50f2196ec55bee5140d3c52.
> > > > UBIFS wants to assert that xattr operations are only issued on files
> > > > with positive link count. The said patch made this operations return
> > > > -ENOENT for unlinked files such that the asserts will no longer trigger.
> > > > This was wrong since xattr operations are perfectly fine on unlinked
> > > > files.
> > > > Instead the assertions need to be fixed/removed.
> > > >
> > > > Cc: <stable@vger.kernel.org>
> > > > Fixes: 11a6fc3dc743 ("ubifs: xattr: Don't operate on deleted inodes")
> > > > Reported-by: Koen Vandeputte <koen.vandeputte@ncentric.com>
> > > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > >
> > > The bad commit 11a6fc3dc743 was included in 4.18.7, and broke our
> > > systems which use overlayfs on top of ubifs.
> > >
> > > This patch didn't apply cleanly for me to 4.18.8 (an encoding issue?),
> > > but I did a revert of the offending commit which did the trick.
> > >
> > > Tested-by: Joel Stanley <joel@jms.id.au>
> >
> > Thanks a lot for testing and sorry for the breakage. :-(
> 
> No worries. How do you plan to get this fix in? It would be good to
> get it in master asap, so we can get it backported in the next wave of
> stable releases.

Since yesterday it is in -next, I'll send a pull request to Linus^WGreg later
this day.

Thanks,
//richard


