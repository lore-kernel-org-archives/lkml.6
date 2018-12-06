Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F29C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6E3214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6E3214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hofr.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbeLFGdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:33:38 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:38943 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbeLFGdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:33:38 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 768FD5C0F63; Thu,  6 Dec 2018 06:32:57 +0000 (UTC)
Date:   Thu, 6 Dec 2018 07:32:57 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     hofrat@osadl.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Message-ID: <20181206063257.GA30835@osadl.at>
References: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
 <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADRPPNSZ18XhgojYgw-KJHHCS=7XnGa_6rYvXw8E0_UUwb+p7Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 02:42:55PM -0600, Li Yang wrote:
> On Sun, Dec 2, 2018 at 3:07 AM Nicholas Mc Guire <hofrat@osadl.org> wrote:
> >
> > devm_kstrdup() may return NULL if internal allocation failed.
> > soc_dev_attr.machine  should be checked (although its only use
> > in pr_info() would be safe even with a NULL). Therefor
> > in the unlikely case of allocation failure, fsl_guts_probe() returns
> > -ENOMEM as this allocating failing is an indication of something
> > more serious going wrong at system level.
> >
> > As  machine  is from the device tree which I assume to be RO - if
> > that assumption is always correct - a better alternative would be
> > to use devm_kstrdup_const() here. That would then simply copy the
> > reference to the RO data and not perform any allocation at all.
> 
> I think your assumption is correct.  Do you want to send a new and
> better version?  :)

The issue was actually more general that I did not find a reliable
method to assure that some object is *always* RO. Even for device
tree data it was not clear to me if there could be systems where
it is not RO.
Anyway - will send the version using devm_kstrdup_const() then.

thx!
hofrat

> 
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
> > ---
> >
> > Problem located by experimental coccinelle script
> >
> > Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)
> >
> > Patch is against 4.20-rc4 (localversion-next is next-20181130)
> >
> >  drivers/soc/fsl/guts.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
> > index 302e0c8..a0c751b 100644
> > --- a/drivers/soc/fsl/guts.c
> > +++ b/drivers/soc/fsl/guts.c
> > @@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
> >         if (of_property_read_string(root, "model", &machine))
> >                 of_property_read_string_index(root, "compatible", 0, &machine);
> >         of_node_put(root);
> > -       if (machine)
> > +       if (machine) {
> >                 soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
> > +               if (!soc_dev_attr.machine)
> > +                       return -ENOMEM;
> > +       }
> >
> >         svr = fsl_guts_get_svr();
> >         soc_die = fsl_soc_die_match(svr, fsl_soc_die);
> > --
> > 2.1.4
> >
