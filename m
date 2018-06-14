Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C6F6BC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87AD6208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AD6208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755171AbeFNLiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:38:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47954 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754893AbeFNLiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:38:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 60FA2207A8; Thu, 14 Jun 2018 13:38:19 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-37-30.w90-88.abo.wanadoo.fr [90.88.156.30])
        by mail.bootlin.com (Postfix) with ESMTPSA id 006892072C;
        Thu, 14 Jun 2018 13:38:08 +0200 (CEST)
Date:   Thu, 14 Jun 2018 13:38:08 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philipp Rosenberger <p.rosenberger@linutronix.de>,
        Richard Weinberger <richard@sigma-star.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 0/3] mtd: rawnand: denali: add new clocks and improve
 setup_data_interface
Message-ID: <20180614133808.31c99e11@bbrezillon>
In-Reply-To: <CAK7LNARfnTtESsVdUtvreLh50+awtL42nCLY9tHzbp2UN2kpBw@mail.gmail.com>
References: <1528953067-24324-1-git-send-email-yamada.masahiro@socionext.com>
        <6557713.S7AzxIg9TS@blindfold>
        <CAK7LNASoV9nHTFax1nD_8pvkEjTzXkFpDFRf_xuoOnPPf9K23A@mail.gmail.com>
        <20180614093835.5c3bf426@bbrezillon>
        <CAK7LNARfnTtESsVdUtvreLh50+awtL42nCLY9tHzbp2UN2kpBw@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jun 2018 20:31:59 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> Hi Boris,
> 
> 2018-06-14 16:38 GMT+09:00 Boris Brezillon <boris.brezillon@bootlin.com>:
> > On Thu, 14 Jun 2018 16:29:59 +0900
> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> >  
> >> Hi Richard,
> >>
> >> 2018-06-14 16:25 GMT+09:00 Richard Weinberger <richard@sigma-star.at>:  
> >> > Masahiro,
> >> >
> >> > Am Donnerstag, 14. Juni 2018, 07:11:04 CEST schrieb Masahiro Yamada:  
> >> >>
> >> >> The ->setup_data_interface() hook needs to know the clock frequency.
> >> >> In fact, this IP needs three clocks, bus "which clock?" is really
> >> >> confusing.  (It is not described in the DT-binding at all.)
> >> >>
> >> >> This series adds more clocks.  In the new binding, three clocks
> >> >> are required: core clock, bus interface clock, ECC engine clock.
> >> >>
> >> >> This series also takes care of the backward compatibility by
> >> >> providing hardcoded values in case the new clocks are missing.
> >> >> So, existing DT should work.
> >> >>
> >> >>
> >> >> Changes in v2:
> >> >>   - Split patches into sensible chunks
> >> >>
> >> >> Masahiro Yamada (3):
> >> >>   mtd: rawnand: denali_dt: use dev as a shorthand of &pdev->dev
> >> >>   mtd: rawnand: denali_dt: add more clocks based on IP datasheet
> >> >>   mtd: rawnand: denali: optimize timing parameters for data interface  
> >> >
> >> > This still means that we need to feed at least 2/3 and 3/3 into -stable to
> >> > unbreak the driver.  
> >>
> >>
> >> 3/3 is not mandatory.
> >>
> >> You can only back-port 1/3 and 2/3.  
> >
> > Well, patch 1 is not a fix, can we move it after patch 2 so that only
> > patch 2 is flagged with the Fixes+Cc-stable tags?  
> 
> 
> OK, will do that.
> 
> If you try to port this back to v4.14.*
> you need to fix-up the file path
> since the driver did not reside in the raw/ sub-directory at that time.

Yes I know :-/. We'll do that when we receive GKH's notification
saying that the patch does not apply.
