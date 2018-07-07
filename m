Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AC6C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920D7208A3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 19:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920D7208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.it
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeGGTCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 15:02:07 -0400
Received: from picard.linux.it ([213.254.12.146]:54480 "EHLO picard.linux.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754312AbeGGTCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 15:02:06 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2018 15:02:05 EDT
Received: from taihen.jp (unknown [IPv6:2405:6580:2420:3e00:517b:ea2d:893:99d2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by picard.linux.it (Postfix) with ESMTPSA id CCE5D3E6C37;
        Sat,  7 Jul 2018 20:56:22 +0200 (CEST)
Date:   Sun, 8 Jul 2018 03:56:17 +0900
From:   Mattia Dongili <malattia@linux.it>
To:     Darren Hart <dvhart@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: sony-laptop: Mark expected switch
 fall-through
Message-ID: <20180707185616.GA7168@taihen.jp>
References: <20180705204703.GA12352@embeddedor.com>
 <20180706232427.GC3041@fury>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706232427.GC3041@fury>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 4.17.0+ x86_64
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:24:27PM -0700, Darren Hart wrote:
> On Thu, Jul 05, 2018 at 03:47:03PM -0500, Gustavo A. R. Silva wrote:
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >  drivers/platform/x86/sony-laptop.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
> > index b205b03..e614cb7 100644
> > --- a/drivers/platform/x86/sony-laptop.c
> > +++ b/drivers/platform/x86/sony-laptop.c
> > @@ -4427,6 +4427,7 @@ sony_pic_read_possible_resource(struct acpi_resource *resource, void *context)
> >  	default:
> >  		dprintk("Resource %d isn't an IRQ nor an IO port\n",
> >  			resource->type);
> > +		/* fall through */
> 
> Here too, I wonder if this is intentional. Either way, from what I can see, the
> final line in the function:
> 
> 	return AE_CTRL_TERMINATE;
> 
> Is unreachable as there are no "break" statements in the switch, and the default
> falls through to return AE_OK. Something doesn't seem right here.

I think so too. Looks to me that the default case was meant to return
AE_CTRL_TERMINATE (i.e. swapping it to be last would do).

Having written that code aeons ago, I'm not sure if there is a good
reason to be like that, though it still looks like a bug (that
existed ever since...).

Want to fix it as part of this patch series? Or I can send a patch
myself, let me know.

-- 
mattia
:wq!
