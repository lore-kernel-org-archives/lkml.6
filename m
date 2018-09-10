Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400FFC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D0B20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D0B20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeIJPqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:46:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727649AbeIJPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:46:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C8FB7A7E8;
        Mon, 10 Sep 2018 10:53:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 191E963A70;
        Mon, 10 Sep 2018 10:53:10 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4DEDF11AA4; Mon, 10 Sep 2018 12:53:09 +0200 (CEST)
Date:   Mon, 10 Sep 2018 12:53:09 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gert Wollny <gert.wollny@collabora.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v7] Add udmabuf misc device
Message-ID: <20180910105309.zmyoo5yhrmqg47md@sirius.home.kraxel.org>
References: <1536491489.4810.22.camel@collabora.com>
 <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
 <1536571118.4810.38.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536571118.4810.38.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 10:53:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 10 Sep 2018 10:53:10 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:18:38AM +0200, Gert Wollny wrote:
> Am Montag, den 10.09.2018, 10:37 +0200 schrieb Gerd Hoffmann:
> ... 
> 
> > > The other question is of course, why did dma_buf_export fail for me
> > > ...
> > 
> > What exactly did you try?
> 
> I ran 
> 
> qemu-system-x86_64 -enable-kvm -smp 5 -M q35 -m 8G \
>     -drive format=raw,file=ubuntu.raw,if=virtio   \
>     -net nic,model=virtio  -net user,hostfwd=tcp::2224-:22  \
>     -vga virtio

By default qemu doesn't use memfd for backing storage, you have to
explicitly configure qemu that way (see qemu commit log of the test
branch):

    qemu-system-x86_64 -m 2G
            -object memory-backend-memfd,id=ram,size=2G
            -numa node,memdev=ram"

HTH,
  Gerd

