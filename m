Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A279C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D00620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D00620852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shmanahar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbeGXVwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:52:16 -0400
Received: from avasout06.plus.net ([212.159.14.18]:36358 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXVwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:52:15 -0400
Received: from hairyalien ([80.229.148.18])
        by smtp with SMTP
        id i4A1fPkvyWLW2i4A2f8HFt; Tue, 24 Jul 2018 21:44:00 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=o7Djd4SkmPXITDn8qH+ssQ==:117 a=o7Djd4SkmPXITDn8qH+ssQ==:17
 a=kj9zAlcOel0A:10 a=R9QF1RCXAYgA:10 a=V0UhwjhiAAAA:8 a=j__2KkWjlvgj1fPFIAYA:9
 a=cbrz1JhfchTSv7bw:21 a=TdPYgfttPOwo3Jso:21 a=CjuIK1q_8ugA:10
 a=_UVLBGXn8Au_dgoMdIS7:22
Received: by hairyalien (sSMTP sendmail emulation); Tue, 24 Jul 2018 21:43:57 +0100
Date:   Tue, 24 Jul 2018 21:43:57 +0100
From:   Nick Dyer <nick@shmanahar.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Chris Healy <cphealy@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH v1 07/10] Input: atmel_mxt_ts - zero terminate config
 firmware file
Message-ID: <20180724204357.GA5025@hairyalien>
References: <20180720215122.23558-1-nick@shmanahar.org>
 <20180720215122.23558-7-nick@shmanahar.org>
 <20180723223534.GK100814@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180723223534.GK100814@dtor-ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-CMAE-Envelope: MS4wfIZeJ7+eRttwGVf4hDp1fW9FPa7iawSD6JY2QyC/NTzVPwF/4eTtmVeXmpGR0+HoELe14j3BF+KWAqpxCGhCP9+i5CsRGPdhlSqn1fTOVPPUoMYBiQxn
 IVFxZgazzwr47PJdu8FKJSzUVb29VnhFkMPWj32oUGapE0avw20lR4hY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 03:35:34PM -0700, Dmitry Torokhov wrote:
> On Fri, Jul 20, 2018 at 10:51:19PM +0100, Nick Dyer wrote:
> > From: Nick Dyer <nick.dyer@itdev.co.uk>
> > 
> > We use sscanf to parse the configuration file, so it's necessary to zero
> > terminate the configuration otherwise a truncated file can cause the
> > parser to run off into uninitialised memory.
> > 
> > Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
> > ---
> >  drivers/input/touchscreen/atmel_mxt_ts.c | 36 +++++++++++++++++-------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> > index 0ce126e918f1..2d1fddafb7f9 100644
> > --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> > +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> > @@ -279,7 +279,7 @@ enum mxt_suspend_mode {
> >  
> >  /* Config update context */
> >  struct mxt_cfg {
> > -	const u8 *raw;
> > +	u8 *raw;
> >  	size_t raw_size;
> >  	off_t raw_pos;
> >  
> > @@ -1451,14 +1451,21 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
> >  	u32 info_crc, config_crc, calculated_crc;
> >  	u16 crc_start = 0;
> >  
> > -	cfg.raw = fw->data;
> > +	/* Make zero terminated copy of the OBP_RAW file */
> > +	cfg.raw = kzalloc(fw->size + 1, GFP_KERNEL);
> 
> kmemdup_nul()? I guess config it not that big to be concerned with
> kmalloc() vs vmalloc() and allocation failures...

Yes, that looks like it should work. There's a limit on the size of the
data due to the I2C address space, so we should be fine.

Nick
