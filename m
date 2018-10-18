Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935D1C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644682083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644682083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJRNKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:10:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJRNKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:10:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98C543001DAF;
        Thu, 18 Oct 2018 05:11:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3856C6D0B0;
        Thu, 18 Oct 2018 05:11:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 190AFA0DCC; Thu, 18 Oct 2018 07:11:02 +0200 (CEST)
Date:   Thu, 18 Oct 2018 07:11:02 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] drm/bochs: add edid support.
Message-ID: <20181018051102.7hkrtj5siw6fss2y@sirius.home.kraxel.org>
References: <20181005120934.21959-1-kraxel@redhat.com>
 <CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twEjDr5dj+9B==QSYtAB7uqy0Szn2d7cw9swSk+THMA2g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 18 Oct 2018 05:11:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Recent qemu (latest master branch, upcoming 3.1 release) got support
> > for EDID data.  This patch adds guest driver support.
> >
> > EDID support in qemu is not (yet) enabled by default, so please use
> > 'qemu -device VGA,edid=on' for testing.
> 
> The EDID never changes after boot?

Right now it doesn't.

> Is there plans to let it?

Needs more virtual hardware changes, the stdvga has no support for
interrupts, so qemu can't signal an edid update to the guest.

So not not sure yet what to do about it.  Maybe add it later (but it's
not high priority).  Maybe simply recommend to use virtio-gpu instead.

> > +       kfree(bochs->edid);
> > +       bochs->edid = kmalloc(len, GFP_KERNEL);
> 
> Don't you need to free it somewhere?

Oh, yes, we leak that on driver unload.
I'll fix it.

cheers,
  Gerd

