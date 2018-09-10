Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23412C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D940A2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D940A2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeIJSZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:25:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbeIJSZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:25:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E76F94021709;
        Mon, 10 Sep 2018 13:30:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8288E20290B1;
        Mon, 10 Sep 2018 13:30:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BAF7316E28; Mon, 10 Sep 2018 15:30:50 +0200 (CEST)
Date:   Mon, 10 Sep 2018 15:30:50 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gert Wollny <gert.wollny@collabora.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v7] Add udmabuf misc device
Message-ID: <20180910133050.tr2lozfmhimqs4c4@sirius.home.kraxel.org>
References: <1536491489.4810.22.camel@collabora.com>
 <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
 <1536571118.4810.38.camel@collabora.com>
 <20180910105309.zmyoo5yhrmqg47md@sirius.home.kraxel.org>
 <1536579068.4810.68.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536579068.4810.68.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 13:30:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 10 Sep 2018 13:30:56 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 01:31:08PM +0200, Gert Wollny wrote:
> Am Montag, den 10.09.2018, 12:53 +0200 schrieb Gerd Hoffmann:
> > 
> > By default qemu doesn't use memfd for backing storage, you have to
> > explicitly configure qemu that way (see qemu commit log of the test
> > branch):
> > 
> >     qemu-system-x86_64 -m 2G
> >             -object memory-backend-memfd,id=ram,size=2G
> >             -numa node,memdev=ram"
> 
> Thanks, but that doesn't seem to help.

Note the memory is specified twice, once with -m, once for the
memory-backend-memfd object.  The two must match of course (or, to be
exact, the sum of all memory backends must match the total memory, but
unless you want create a virtual numa machine there is no reason to have
multiple memory-backends).

> Are there any host kernel
> configuration parameters or features that I should set (apart from
> enabling udmabuf)? 

I'm not aware of any unusual parameters required.  My config is based on
rhel-7, then stripped down with localmodconfig, then enabled the bits I
want in my test kernel.

Oh, wait, CONFIG_MEMFD_CREATE could be the one.  I guess I should add a
Kconfig dependency.  Even though udmabuf will build just fine without
that (because memfd is basically shmem with some features on top) it
doesn't buy you much if the memfd_create syscall is not available ...

cheers,
  Gerd

