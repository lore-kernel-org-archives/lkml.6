Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40898C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F2C2082F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 07:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F2C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725767AbeLBHOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 02:14:46 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57738 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBHOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 02:14:45 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AEB1D20786; Sun,  2 Dec 2018 08:14:41 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 478912071D;
        Sun,  2 Dec 2018 08:14:41 +0100 (CET)
Date:   Sun, 2 Dec 2018 08:14:40 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] drm/vc4: Add a debugfs entry to disable/enable the
 load tracker
Message-ID: <20181202081440.0ec235c4@bbrezillon>
In-Reply-To: <87r2f2patf.fsf@anholt.net>
References: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
        <87r2f2patf.fsf@anholt.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 12:30:52 -0800
Eric Anholt <eric@anholt.net> wrote:

> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
> 
> > In order to test whether the load tracker is working as expected, we
> > need the ability to compare the commit result with the underrun
> > indication. With the load tracker always enabled, commits that are
> > expected to trigger an underrun are always rejected, so userspace
> > cannot get the actual underrun indication from the hardware.
> >
> > Add a debugfs entry to disable/enable the load tracker, so that a DRM
> > commit expected to trigger an underrun can go through with the load
> > tracker disabled. The underrun indication is then available to
> > userspace and can be checked against the commit result with the load
> > tracker enabled.
> >
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>  
> 
> Given that the load tracker is going to be conservative and say things
> will underrun even when they might not in practice, will this actually
> be useful for automated testing? Or is the intent to make it easier to
> tune the load tracker by disabling it so that you can experiment freely?

Yes, that's one goal, though I'm not sure IGT is supposed to contain
such debugging tools. But the main benefit is being able to track
regressions in the load tracking algo that makes it more (too?)
conservative. I think people won't like this sort of regressions. The
idea would be to settle on an acceptable load tracking algo (maybe
after refining the proposed one), record the results (both good and too
conservative predictions) and use that as a reference for the IGT
test.  
