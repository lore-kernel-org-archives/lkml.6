Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80508C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36DD8214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DD8214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbeLFCvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:51:47 -0500
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:56688 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727804AbeLFCvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:51:47 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B77A7182CED34;
        Thu,  6 Dec 2018 02:51:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ray11_666d8984bb302
X-Filterd-Recvd-Size: 3538
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Dec 2018 02:51:43 +0000 (UTC)
Message-ID: <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
From:   Joe Perches <joe@perches.com>
To:     "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Dec 2018 18:51:42 -0800
In-Reply-To: <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
References: <20181205165621.5805-1-michel@daenzer.net>
         <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 10:40 +0800, Zhang, Jerry(Junwei) wrote:
> On 12/6/18 12:56 AM, Michel Dänzer wrote:
> > From: Michel Dänzer <michel.daenzer@amd.com>
> > 
> > The following cases are possible for pr_debug():
> > 
> > 1. CONFIG_DYNAMIC_DEBUG disabled
> >     a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
> >        it never generates any output.
> >     b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
> >        i.e. it generates output which doesn't appear in dmesg by default,
> >        can be enabled dynamically.
> > 
> > 2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
> >     dynamic_pr_debug()
> >     a) DEBUG not defined: dynamic_pr_debug() generates no output by
> >        default, can be enabled dynamically.
> >     b) DEBUG defined: dynamic_pr_debug() generates output by default,
> >        can be disabled dynamically.
> > 
> > The intention for drm_debug_printer() is to generate output which
> > doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
> > cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
> > instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.
> > 
> > Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")

I very much doubt this is a fix.

Did you read the commit log for this commit?

It says "make sure it will always produce output"

And why didn't you cc Chris Wilson, the author of that patch?

> > Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>
> 
> > ---
> >   drivers/gpu/drm/drm_print.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > index 0e7fc3e7dfb4..ee56e4a1b343 100644
> > --- a/drivers/gpu/drm/drm_print.c
> > +++ b/drivers/gpu/drm/drm_print.c
> > @@ -23,11 +23,13 @@
> >    * Rob Clark <robdclark@gmail.com>
> >    */
> >   
> > -#define DEBUG /* for pr_debug() */
> > -
> >   #include <stdarg.h>
> >   #include <linux/seq_file.h>
> >   #include <drm/drmP.h>
> > +
> > +#ifndef CONFIG_DYNAMIC_DEBUG
> > +#define DEBUG /* for pr_debug() */
> > +#endif
> >   #include <drm/drm_print.h>
> >   
> >   void __drm_puts_coredump(struct drm_printer *p, const char *str)

