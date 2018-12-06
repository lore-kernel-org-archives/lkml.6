Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE055C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A82020838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A82020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbeLFQqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:46:24 -0500
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:60831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725896AbeLFQqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:46:24 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BB31C837F24A;
        Thu,  6 Dec 2018 16:46:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pear67_71a7fdeeebf3c
X-Filterd-Recvd-Size: 2683
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Thu,  6 Dec 2018 16:46:20 +0000 (UTC)
Message-ID: <168bc68c9383cd379b3cd7a25b32edc731c8f5e6.camel@perches.com>
Subject: Re: [PATCH 2/2] drm/ttm: Use pr_debug for all output from
 ttm_bo_evict
From:   Joe Perches <joe@perches.com>
To:     "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Date:   Thu, 06 Dec 2018 08:46:19 -0800
In-Reply-To: <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
References: <20181205165621.5805-1-michel@daenzer.net>
         <20181205165621.5805-2-michel@daenzer.net>
         <b0b57acb-7152-ab1a-855a-3de8c77fa425@amd.com>
         <3198051c-c09d-5bf9-e177-3a90b10b4149@daenzer.net>
         <d0990059-24bb-3f21-8b9d-85761f0be409@amd.com>
         <357b0045-d2a2-2246-b69d-19e657f6e843@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-06 at 17:39 +0800, Zhang, Jerry(Junwei) wrote:
> On 12/6/18 5:33 PM, Koenig, Christian wrote:
> > Am 06.12.18 um 10:09 schrieb Michel Dänzer:
> > > On 2018-12-06 3:43 a.m., Zhang, Jerry(Junwei) wrote:
> > > > On 12/6/18 12:56 AM, Michel Dänzer wrote:
> > > > > From: Michel Dänzer <michel.daenzer@amd.com>
> > > > > 
> > > > > All the output is related, so it should all be printed the same way.
> > > > > Some of it was using pr_debug, but some of it appeared in dmesg by
> > > > > default. The caller should handle failure, so there's no need to spam
> > > > > dmesg with potentially quite a lot of output by default.
> > > > > 
> > > > > Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
> > > > Sounds reasonable, but personally prefer to show error when some
> > > > vital incident happens, e.g. no memory on eviction.
> > > The amdgpu driver still prints these in that case:
> > > 
> > >    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* amdgpu_cs_list_validate(validated) failed.
> > >    [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Not enough memory for command submission!

Aren't dump_stack()s already done on all these allocation failures?
I don't notice any use of __GFP_NOWARN on generic allocations in drm.


