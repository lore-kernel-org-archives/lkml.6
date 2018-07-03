Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B7C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7544623C6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7544623C6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeGCH27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:28:59 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:33856 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753213AbeGCH26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:28:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4549060B5C38;
        Tue,  3 Jul 2018 09:28:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C77BoF04kTPk; Tue,  3 Jul 2018 09:28:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EBDDC60B5C39;
        Tue,  3 Jul 2018 09:28:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yV6RGVr_PYUt; Tue,  3 Jul 2018 09:28:56 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C53E960B5C38;
        Tue,  3 Jul 2018 09:28:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        y2038@lists.linaro.org, Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubifs: tnc: use monotonic znode timestamp
Date:   Tue, 03 Jul 2018 09:28:56 +0200
Message-ID: <58899545.Szx3E6bSux@blindfold>
In-Reply-To: <31916482.81kKL2104G@blindfold>
References: <20180620082937.719067-1-arnd@arndb.de> <31916482.81kKL2104G@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Juli 2018, 16:24:15 CEST schrieb Richard Weinberger:
> Arnd,
> 
> Am Mittwoch, 20. Juni 2018, 10:29:11 CEST schrieb Arnd Bergmann:
> > The tnc uses get_seconds() based timestamps to check the age of a znode,
> > which has two problems: on 32-bit architectures this may overflow in
> > 2038 or 2106, and it gives incorrect information when the system time
> > is updated using settimeofday().
> > 
> > Using montonic timestamps with ktime_get_seconds() solves both thes
> > problems.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  fs/ubifs/shrinker.c | 2 +-
> >  fs/ubifs/tnc.c      | 4 ++--
> >  fs/ubifs/tnc_misc.c | 2 +-
> >  fs/ubifs/ubifs.h    | 2 +-
> >  4 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ubifs/shrinker.c b/fs/ubifs/shrinker.c
> > index 9a9fb94a41c6..9d10cbdec2cc 100644
> > --- a/fs/ubifs/shrinker.c
> > +++ b/fs/ubifs/shrinker.c
> > @@ -71,7 +71,7 @@ static int shrink_tnc(struct ubifs_info *c, int nr, int age, int *contention)
> >  {
> >  	int total_freed = 0;
> >  	struct ubifs_znode *znode, *zprev;
> > -	int time = get_seconds();
> > +	time64_t time = ktime_get_seconds();
> 
> ubifs does
> 	abs(time - znode->time) >= age) {
> 
> Is this still legit with time64_t?

Answering my own question, yes.
abs() seems to be able to deal with 64bit numbers and time64_t is just a number.

Thanks,
//richard
