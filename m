Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F843C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C1E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C1E20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbeLAVJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:09:43 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49175 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbeLAVJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:09:42 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 035F320742; Sat,  1 Dec 2018 10:57:33 +0100 (CET)
Received: from collins (unknown [77.128.107.220])
        by mail.bootlin.com (Postfix) with ESMTPSA id BCB7120717;
        Sat,  1 Dec 2018 10:57:22 +0100 (CET)
Message-ID: <fb5e3339e23d0191a67d161958b83b3da99b3b30.camel@bootlin.com>
Subject: Re: [PATCH v2] drm/vc4: Add a debugfs entry to disable/enable the
 load tracker
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Date:   Sat, 01 Dec 2018 10:58:57 +0100
In-Reply-To: <87r2f2patf.fsf@anholt.net>
References: <20181130161104.16352-1-paul.kocialkowski@bootlin.com>
         <87r2f2patf.fsf@anholt.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Le vendredi 30 novembre 2018 à 12:30 -0800, Eric Anholt a écrit :
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
> be useful for automated testing?  Or is the intent to make it easier to
> tune the load tracker by disabling it so that you can experiment freely?

The intent here is to be able to compare the load tracker's result with
the underrun indication from the HVS.

The idea is to have the following testing scheme:
1. enable the load tracker
2. try a commit and get the errno if it fails
3. disable the load tracker
4. do the commit
5. wait for vblank and get the underrun indication
6. check that the underrun occurs when errno == -ENOSPC

This way, we can find out when the load tracker gave us a false
positive and refine the load calculation.

Cheers,

Paul

