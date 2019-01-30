Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756BAC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52217218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731812AbfA3Q1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:27:30 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:39435 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfA3Q13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:27:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 1CB60185C4;
        Wed, 30 Jan 2019 17:27:28 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id OSqAUao7DtbY; Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 6047418490;
        Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 418EB1E072;
        Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 350DC1E070;
        Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 27C48230D;
        Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 235E680C3B; Wed, 30 Jan 2019 17:27:23 +0100 (CET)
Date:   Wed, 30 Jan 2019 17:27:23 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Sudeep Dutt <sudeep.dutt@intel.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        ashutosh.dixit@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tiwei.bie@intel.com,
        luto@kernel.org
Subject: Re: [PATCH] mic: vop: Fix broken virtqueues
Message-ID: <20190130162722.bnr5wlsbg767lslz@axis.com>
References: <20190129102207.9577-1-vincent.whitchurch@axis.com>
 <1548865797.29684.47.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548865797.29684.47.camel@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 08:29:57AM -0800, Sudeep Dutt wrote:
> On Tue, 2019-01-29 at 11:22 +0100, Vincent Whitchurch wrote:
> > VOP is broken in mainline since commit 1ce9e6055fa0a9043 ("virtio_ring:
> > introduce packed ring support"); attempting to use the virtqueues leads
> > to various kernel crashes.  I'm testing it with my not-yet-merged
> > loopback patches, but even the in-tree MIC hardware cannot work.
> > 
> > The problem is not in the referenced commit per se, but is due to the
> > following hack in vop_find_vq() which depends on the layout of private
> > structures in other source files, which that commit happened to change:
> > 
> >   /*
> >    * To reassign the used ring here we are directly accessing
> >    * struct vring_virtqueue which is a private data structure
> >    * in virtio_ring.c. At the minimum, a BUILD_BUG_ON() in
> >    * vring_new_virtqueue() would ensure that
> >    *  (&vq->vring == (struct vring *) (&vq->vq + 1));
> >    */
> >   vr = (struct vring *)(vq + 1);
> >   vr->used = used;
> > 
> > Fix vop by using __vring_new_virtqueue() to create the needed vring
> > layout from the start, instead of attempting to patch in the used ring
> > later.  __vring_new_virtqueue() was added way back in commit
> > 2a2d1382fe9dcc ("virtio: Add improved queue allocation API") in order to
> > address mic's usecase, according to the commit message.
> > 
> 
> Thank you for fixing this up Vincent.
> 
> Reviewed-by: Sudeep Dutt <sudeep.dutt@intel.com>

Thanks, but I just noticed that the removal patch has the hack too
(without a comment), so that needs to be fixed.  I'll post a v2.

(The removal path also has an unrelated use-after-free, but that's a
 subject for a different patch.)
