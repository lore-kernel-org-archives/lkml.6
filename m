Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A82C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC66F2083D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC66F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbeHaLK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:10:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbeHaLK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A98940200A8;
        Fri, 31 Aug 2018 07:04:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-224.ams2.redhat.com [10.36.116.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA5201C5AB;
        Fri, 31 Aug 2018 07:04:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0345511AA4; Fri, 31 Aug 2018 09:04:25 +0200 (CEST)
Date:   Fri, 31 Aug 2018 09:04:24 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Zach Reizner <zachr@google.com>,
        Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v6] Add udmabuf misc device
Message-ID: <20180831070424.3xoxfy54vyxbdfzd@sirius.home.kraxel.org>
References: <20180703075359.30349-1-kraxel@redhat.com>
 <20180703083757.GG7880@phenom.ffwll.local>
 <20180704055338.n3b7oexltaejqmcd@sirius.home.kraxel.org>
 <9818b301-9c9d-c703-d4fe-7c2d4d43ed66@collabora.com>
 <20180704080005.juutrwri4kxm7yim@sirius.home.kraxel.org>
 <06d8aa8d-5eac-64e2-f21e-43fe7ca96cc2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d8aa8d-5eac-64e2-f21e-43fe7ca96cc2@collabora.com>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 07:04:26 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 31 Aug 2018 07:04:26 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > qemu can use memfd to allocate guest ram.  Now, with the help of
> > udmabuf, qemu can create a *host* dma-buf for the *guest* graphics
> > buffer.
> 
> Guess each physical address in the iovec in
> VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING can be passed as the offset in the
> udmabuf_create_item struct?

Exactly.

https://git.kraxel.org/cgit/qemu/commit/?h=sirius/udmabuf&id=515a5b9f1215ea668a992e39d66993a17a940801

> Are you thinking of anything else besides passing the winsrv protocol across
> the guest/host boundary? Just wondering if I'm missing something.

The patch above uses the dmabuf internally in qemu.  It simply mmaps it,
so qemu has a linear representation of the resource and can use it as
pixman image backing storage without copying the pixel data.

So it is useful even without actually exporting the dmabuf to other
processes.

cheers,
  Gerd

PS: Any chance you can review the v7 patch?
