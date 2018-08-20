Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A877C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2DD2173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A2DD2173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeHTVQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 17:16:01 -0400
Received: from smtprelay0234.hostedemail.com ([216.40.44.234]:57141 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbeHTVQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 17:16:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9BD46837F242;
        Mon, 20 Aug 2018 17:59:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: angle26_8bdaa20397243
X-Filterd-Recvd-Size: 2303
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Mon, 20 Aug 2018 17:59:20 +0000 (UTC)
Message-ID: <ecb6c8e8d1b7258b7ddc17213284afced8486f2a.camel@perches.com>
Subject: Re: [PATCH v3] staging: mt7621-mmc: Fix debug macros and their
 usages
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?ISO-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>
Date:   Mon, 20 Aug 2018 10:59:19 -0700
In-Reply-To: <20180819113401.GB18715@kroah.com>
References: <20180819100458.GA13296@nishad>
         <20180819113401.GB18715@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-08-19 at 13:34 +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 19, 2018 at 03:35:02PM +0530, Nishad Kamdar wrote:
> > Fixed four debug macros and their usages. Replaced printk with
> > dev_<level> without __func__ or __LINE__ or current->comm and
> > current->pid. Further removed the do {} while(0) loop for single
> > statement macros.
> > Out of the four, replaced all usages of ERR_MSG and IRQ_MSG with
> > dev_err() in the code itself and dropped them from dbg.h.
> > Removed all INIT_MSG usages and dropped it from dgb.h.
> > Issues found by checkpatch.
> 
> This needs to be multiple patches.  One for each type of macro you are
> deleting/changing, not all lumped together into one big patch.
> 
> Plaese fix that up and resend.

I'd also be tempted to add some logging macros like:

#define host_err(host, fmt, ...) \
	dev_err(mmc_dev((host)->mmc, fmt, ##__VA_ARGS__)

so that the code flows a little better.

e.g.:

@@ -521,7 +517,7 @@ static void msdc_abort_data(struct msdc_host *host)>  {
>  	struct mmc_command *stop = host->mrq->stop;
> -	ERR_MSG("Need to Abort.");
> +	dev_err(mmc_dev(host->mmc), "%d -> Need to Abort.\n", host->id);
>  	msdc_reset_hw(host);
>  	msdc_clr_fifo(host);

becomes

	host_err(host, "%d -> Need to Abort\n", host->id);

etc...

