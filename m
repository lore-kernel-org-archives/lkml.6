Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DE4C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A3A206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A3A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeLDOZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:25:45 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:37927 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbeLDOZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:25:44 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id BD8F85C0FF8; Tue,  4 Dec 2018 14:25:04 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:25:04 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Peter Rosin <peda@axentia.se>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: handle failure case of
 devm_kstrdup()
Message-ID: <20181204142504.GA16001@osadl.at>
References: <1543658470-20887-1-git-send-email-hofrat@osadl.org>
 <549eba3a-28b9-e4b0-f680-8fb51b160879@axentia.se>
 <20181204121318.GB28201@osadl.at>
 <2c43e965-9a12-0367-fb23-bedfaaed4f68@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c43e965-9a12-0367-fb23-bedfaaed4f68@axentia.se>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:49:11PM +0000, Peter Rosin wrote:
> On 2018-12-04 13:13, Nicholas Mc Guire wrote:
> > On Tue, Dec 04, 2018 at 11:16:59AM +0000, Peter Rosin wrote:
> >> Hi!
> >>
> >> This patch looks like a good idea. However, a nitpick below.
> >>
> >> On 2018-12-01 11:01, Nicholas Mc Guire wrote:
> >>> devm_kstrdup() may return NULL if internal allocation failed.
> >>> Thus using  name, value  is unsafe without being checked. As
> >>> i2c_demux_pinctrl_probe() can return -ENOMEM in other cases
> >>> a dev_err() message is included to make the failure location
> >>> clear.
> >>>
> >>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >>> Fixes: e35478eac030 ("i2c: mux: demux-pinctrl: run properly with multiple instances")
> >>> ---
> >>>
> >>> Problem located with experimental coccinelle script
> >>>
> >>> Q: The use of devm_kstrdup() seems a bit odd while technically not wrong,
> >>>    personally I think devm_kasprintf() would be more suitable here.
> >>>
> >>> Patch was compile tested with: multi_v7_defconfig 
> >>> (implies I2C_DEMUX_PINCTRL=y)
> >>>
> >>> Patch is against 4.20-rc4 (localversion-next is next-20181130)
> >>>
> >>>  drivers/i2c/muxes/i2c-demux-pinctrl.c | 6 ++++++
> >>>  1 file changed, 6 insertions(+)
> >>>
> >>> diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> >>> index 035032e..c466999 100644
> >>> --- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
> >>> +++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
> >>> @@ -244,6 +244,12 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
> >>>  
> >>>  		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
> >>>  		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
> >>> +		if (!props[i].name || !props[i].value) {
> >>> +			dev_err(&pdev->dev,
> >>> +				"chan %d name, value allocation failed\n", i);
> >>
> >> Please drop this memory allocation failure message. You should get such a
> >> message from devm_kstrdup.
> >>
> > 
> > hm...tried to figure out where that message would be comming
> > from - but I could not find any point in the call tree that
> > would issue such a message ?
> > 
> >  devm_kstrdup() 
> >    -> devm_kmalloc()
> >         -> alloc_dr()
> >              --> kmalloc_track_caller() (non-NUMA)
> >              |     -> __kmalloc_node()
> >              |        -> __do_kmalloc_node()
> >              `-> __kmalloc_node_track_caller() (NUMA)
> >                    -> __do_kmalloc_node()
> > 
> >  __do_kmalloc_node() seems like it simply returns NULL but
> >  issues no failure message.
> >  Am I overlooking something ? 
> 
> Well, I don't know the details, but checkpatch will warn about simple
> error messages on devm_kstrdup failure (if I read the checkpatch source
> correctly). But in this case there are two parallel conditions in the
> if and hence checkpatch stumbles, but gist is the same, you should not
> sprinkle messages on memory allocation failure.
>
not in this case - atleast checkpatch --strict on the original patch
did not issue any complaint to that ends. But yes - you
are right that the intent in checkpatch is clear and this should not
be carrying a failure message.

thx!
hofrat 
