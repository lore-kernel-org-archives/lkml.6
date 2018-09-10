Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC97C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93442086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93442086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeIJNa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:30:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727652AbeIJNa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:30:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 216B8807A0C3;
        Mon, 10 Sep 2018 08:37:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-66.ams2.redhat.com [10.36.116.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B7561012335;
        Mon, 10 Sep 2018 08:37:32 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6E73A4FD7D; Mon, 10 Sep 2018 10:37:31 +0200 (CEST)
Date:   Mon, 10 Sep 2018 10:37:31 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gert Wollny <gert.wollny@collabora.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v7] Add udmabuf misc device
Message-ID: <20180910083731.o4rryvermyighbtp@sirius.home.kraxel.org>
References: <1536491489.4810.22.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536491489.4810.22.camel@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:37:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 10 Sep 2018 08:37:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +		fput(memfd);
> > +	}
> > +	memfd = NULL;
> Now memfd is NULL 

> > +	buf = dma_buf_export(&exp_info);
> > +	if (IS_ERR(buf)) {
> > +		ret = PTR_ERR(buf);
> > +		goto err_put_pages;
> Assume an error occured 

> > +err_put_pages:
> > +	while (pgbuf > 0)
> > +		put_page(ubuf->pages[--pgbuf]);
> > +err_free_ubuf:
> > +	fput(memfd);
> Now fput it called with NULL, and in fput this is used in 

> where the bug is signalled, so I guess fput doesn't accept a null
> pointer. 

Indeed.  Already fixed in drm-misc-next.

> I'm not sure why you set memfd to NULL at all, because on the following
> non-error path it is not used.

And in the error path it should not be user either, at least when the
error happens *after* exiting the loop, otherwise we would fput twice in
the error case.

> The other question is of course, why did dma_buf_export fail for me ...

What exactly did you try?

cheers,
  Gerd

