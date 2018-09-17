Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38B2ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78878214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78878214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbeIQORD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:17:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbeIQORD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:17:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44BB180F7A;
        Mon, 17 Sep 2018 08:50:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8251A4C494;
        Mon, 17 Sep 2018 08:50:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 56CB54F973; Mon, 17 Sep 2018 10:50:33 +0200 (CEST)
Date:   Mon, 17 Sep 2018 10:50:33 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        intel-gvt-dev@lists.freedesktop.org,
        open list <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] vfio: add edid api for display (vgpu) devices.
Message-ID: <20180917085033.ttcs3cpznnf3wngd@sirius.home.kraxel.org>
References: <20180913054745.6353-1-kraxel@redhat.com>
 <20180913054745.6353-2-kraxel@redhat.com>
 <20180913115139.02775316@t450s.home>
 <20180914122552.3xmepqo7azzmx7ky@sirius.home.kraxel.org>
 <20180917065154.GI20737@zhen-hp.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917065154.GI20737@zhen-hp.sh.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Sep 2018 08:50:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#define VFIO_DEVICE_INFO_CAP_EDID	1
> > +
> > +struct vfio_device_info_edid_cap {
> > +	struct vfio_info_cap_header header;
> > +	__u32   max_x;     /* Max display height (zero == no limit) */
> > +	__u32   max_y;     /* Max display height (zero == no limit) */
> > +};
> 
> As current virtual display for Intel vGPU is still emulating against real HW
> pipeline with same limitations, asked display developers that whether or not
> specific mode can work might still depend on current or future HW behavior.
> So could we add some hints on what kind of edid mode vfio device can operate?
> Some may support arbitrary modes, but some may only support standard modes.

What kind of restrictions do we have here?  Really to a fixed list of
standard modes?

Some testing (kaby lake) indicates y axis has no restrictions and x axis
gets rounded up to the next multiple of 8 pixels (32 bytes), maybe to
align scanlines with cachelines?

Oh, and btw:  Seems the resolution restriction (to 1024x768 for the
smallest vgpu type) seems to not be enforced.  Intentional?

cheers,
  Gerd

