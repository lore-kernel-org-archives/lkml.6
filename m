Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1198C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C1320661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 11:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C1320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeLFLl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 06:41:56 -0500
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:41939 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727832AbeLFLl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 06:41:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 7723318047610;
        Thu,  6 Dec 2018 11:41:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: town23_4a9b2de08394f
X-Filterd-Recvd-Size: 3790
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Dec 2018 11:41:52 +0000 (UTC)
Message-ID: <e7859ce4b8417b094604d9ab4740d338730e38bf.camel@perches.com>
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
From:   Joe Perches <joe@perches.com>
To:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Date:   Thu, 06 Dec 2018 03:41:51 -0800
In-Reply-To: <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
References: <20181205165621.5805-1-michel@daenzer.net>
         <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
         <1586a49594d30b4bf4d88eba0d258e21efd26da2.camel@perches.com>
         <276fbf7f-d33f-83a5-cb88-bd4051dc03ba@daenzer.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 10:23 +0100, Michel Dänzer wrote:
> On 2018-12-06 3:51 a.m., Joe Perches wrote:
> > On Thu, 2018-12-06 at 10:40 +0800, Zhang, Jerry(Junwei) wrote:
> > > On 12/6/18 12:56 AM, Michel Dänzer wrote:
> > > > From: Michel Dänzer <michel.daenzer@amd.com>
> > > > 
> > > > The following cases are possible for pr_debug():
> > > > 
> > > > 1. CONFIG_DYNAMIC_DEBUG disabled
> > > >     a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
> > > >        it never generates any output.
> > > >     b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
> > > >        i.e. it generates output which doesn't appear in dmesg by default,
> > > >        can be enabled dynamically.
> > > > 
> > > > 2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
> > > >     dynamic_pr_debug()
> > > >     a) DEBUG not defined: dynamic_pr_debug() generates no output by
> > > >        default, can be enabled dynamically.
> > > >     b) DEBUG defined: dynamic_pr_debug() generates output by default,
> > > >        can be disabled dynamically.
> > > > 
> > > > The intention for drm_debug_printer() is to generate output which
> > > > doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
> > > > cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
> > > > instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.
> > > > 
> > > > Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")
> > 
> > I very much doubt this is a fix.
> > 
> > Did you read the commit log for this commit?
> > 
> > It says "make sure it will always produce output"
> 
> I thought the commit log covered this, suggestions for improvement welcome.
> 
> Chris' change addressed case 1a), but also took us from 2a) to 2b). But
> we want 2a)

> I suspect Chris missed that pr_debug()'s output is visible by default if
> CONFIG_DYNAMIC_DEBUG and DEBUG are both defined.

I believe you and Chris have different goals and that your
point of 2b is
misguided.

I think the language used in the Chris' commit log is
plain ans obvious.  'always produce output'.

> > And why didn't you cc Chris Wilson, the author of that patch?k
> 
> I used the get_maintainer.pl script. Thanks for adding Chris.
> P.S. FYI, your e-mail had a very aggressive tone to me, not sure what for.

No worries.

I think the language I used is also plain and obvious
and you are overreading.

cheers, Joe

