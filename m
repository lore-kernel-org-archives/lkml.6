Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCECC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3F3252B0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3F3252B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753716AbeGBHuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:50:07 -0400
Received: from mga14.intel.com ([192.55.52.115]:34566 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753225AbeGBHuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:50:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2018 00:50:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,298,1526367600"; 
   d="scan'208";a="69360694"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 02 Jul 2018 00:49:48 -0700
Received: from abityuts-desk.fi.intel.com (abityuts-desk.fi.intel.com [10.237.68.39])
        by linux.intel.com (Postfix) with ESMTP id 2BD6F5802B1;
        Mon,  2 Jul 2018 00:49:45 -0700 (PDT)
Message-ID: <1530517784.469.94.camel@gmail.com>
Subject: Re: [PATCH v3 1/2] ubi: provide a way to skip CRC checks
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     Richard Weinberger <richard@nod.at>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Date:   Mon, 02 Jul 2018 10:49:44 +0300
In-Reply-To: <1814021.2UnKZ8bNR8@blindfold>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
         <3f9cef553d4f5da3fe2d76113d79ada1f0fe5224.1530169759.git-series.quentin.schulz@bootlin.com>
         <1530516625.469.82.camel@gmail.com> <1814021.2UnKZ8bNR8@blindfold>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-02 at 09:43 +0200, Richard Weinberger wrote:
> Artem,
> 
> Am Montag, 2. Juli 2018, 09:30:25 CEST schrieb Artem Bityutskiy:
> > Hi,
> > 
> > On Thu, 2018-06-28 at 09:40 +0200, Quentin Schulz wrote:
> > > diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
> > > index d4b2e87..e9e9ecb 100644
> > > --- a/drivers/mtd/ubi/kapi.c
> > > +++ b/drivers/mtd/ubi/kapi.c
> > > @@ -202,7 +202,7 @@ struct ubi_volume_desc *ubi_open_volume(int
> > > ubi_num, int vol_id, int mode)
> > >  	desc->mode = mode;
> > >  
> > >  	mutex_lock(&ubi->ckvol_mutex);
> > > -	if (!vol->checked) {
> > > +	if (!vol->checked && !vol->skip_check) {
> > >  		/* This is the first open - check the volume */
> > >  		err = ubi_check_volume(ubi, vol_id);
> > >  		if (err < 0) {
> > 
> > Did you deliberately did not add a similar check to
> > 'vol_cdev_write()' ?
> > You want to skip checking on load but do have the checking after
> > volume update ?
> > Looks a bit inconsistent to me. At the very least deserves a
> > comment in
> > 'vol_cdev_write()' about why 'skip_check' flag is ignored there.
> 
> Well, the idea is skipping the check, not the crc32 on the medium.
> That way we can later, if needed, offer a way to drop the flag but
> and don't have to rewrite with crc32-enabled.

I understand that. I am talking about cdev.c line 370. We will check
the CRC after the update regardless of 'skip_check'. So I point out
that this is not very consistent with what we do in
'ubi_open_volume()'.

Is this deliberate or not? If this is deliberate, we should at least
add an explanation comment in 'vol_cdev_write()'.
