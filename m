Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E2C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B9C25780
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B9C25780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeGAVjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:39:22 -0400
Received: from smtprelay0216.hostedemail.com ([216.40.44.216]:56307 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752495AbeGAVjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:39:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id B9CC918045E87;
        Sun,  1 Jul 2018 21:39:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cave43_172a3ed53ef0d
X-Filterd-Recvd-Size: 3519
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Jul 2018 21:39:19 +0000 (UTC)
Message-ID: <6d3fb517adb8880d9f7642d185405590dc9f7e83.camel@perches.com>
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
From:   Joe Perches <joe@perches.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Date:   Sun, 01 Jul 2018 14:39:17 -0700
In-Reply-To: <2098416.O8QMNZQyoz@blindfold>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
         <20180701223347.2cef133b@bbrezillon>
         <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
         <2098416.O8QMNZQyoz@blindfold>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 23:01 +0200, Richard Weinberger wrote:
> Am Sonntag, 1. Juli 2018, 22:54:32 CEST schrieb Joe Perches:
> > On Sun, 2018-07-01 at 22:33 +0200, Boris Brezillon wrote:
> > > On Sun, 01 Jul 2018 21:35:57 +0200 Richard Weinberger <richard@nod.at> wrote:
> > > > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:
> > > > > Now that we have the logic for skipping CRC check for static UBI volumes
> > > > > in the core, let's expose it to users.
> > []
> > > > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> > []
> > > > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
> > > > >  	    req->vol_type != UBI_STATIC_VOLUME)
> > > > >  		goto bad;
> > > > >  
> > > > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
> > > 
> > > Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> > > missing parens (checkpatch --strict should complain about that).
> > 
> > Why should checkpatch complain?
> > & has higher precedence than &&.
> 
> The code is more readable.

IYO.  checkpatch doesn't care and I think it's unnecessary.

Just fyi:

checkpatch does suggest parenthesis removal with --strict
when using
	== or !=
with
	&& or ||

e.g.:

$ cat -n foo.c
     1	bool function(void)
     2	{
     3		if (foo & 1 && bar & 2)
     4			return true;
     5		if ((foo & 1) && (bar && 2))
     6			return true;
     7		if (foo == 1 && bar != 2)
     8			return true;
     9		if ((foo == 1) && (bar != 2))
    10			return true;
    11		return false;
    12	}

$ ./scripts/checkpatch.pl -f --strict foo.c
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#1: FILE: foo.c:1:
+bool function(void)

CHECK: Unnecessary parentheses around 'foo == 1'
#9: FILE: foo.c:9:
+	if ((foo == 1) && (bar != 2))

CHECK: Unnecessary parentheses around 'bar != 2'
#9: FILE: foo.c:9:
+	if ((foo == 1) && (bar != 2))

total: 0 errors, 1 warnings, 2 checks, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

foo.c has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


