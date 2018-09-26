Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E991AC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96CA9214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LdXtEiQA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CA9214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeIZWSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:18:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40056 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZWSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GY3lQqH+NfL7uzpfwZtKtdjg2OLbNdUfVzhSwDhPJjw=; b=LdXtEiQAgrRfXRcK8ml9igp8z
        XIIxtzU35Ue3tl0acrYvIniuinAFH64ysviuUTRt1LdxlYN6tgCC8Nk5h3C7S3onmsp5lbMi8pm14
        qMB4Mue7rgT+3jK0RIn47i3s0piWBWSz0Oii/5k5VIc5DpqcXDND2F+EmVIDCA/gP0wc8LTVvj63U
        7kE5eo81wjn5zY94H0MDQcX8nRydaKdbu55SE6U7cyguMfpwT/8fikdIzWrzljjoSx0TFXdNMNNfR
        fS9Zkowonv0D2IPVvqy46TXxlMsoZ1QC+WspZzyPpJMDLcR5Wr0iODT58loW6neW7HsMzpw9yDNIA
        lIOm2T/qg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g5CJ5-0005bM-FS; Wed, 26 Sep 2018 16:04:55 +0000
Date:   Wed, 26 Sep 2018 09:04:55 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/virtio: Use IDAs more efficiently
Message-ID: <20180926160455.GA20337@bombadil.infradead.org>
References: <20180926160031.15721-1-willy@infradead.org>
 <20180926160031.15721-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926160031.15721-5-willy@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:00:31AM -0700, Matthew Wilcox wrote:
> @@ -59,6 +59,7 @@ static int virtio_gpu_context_create(struct virtio_gpu_device *vgdev,
>  
>  	if (handle < 0)
>  		return handle;
> +	handle++;
>  	virtio_gpu_cmd_context_create(vgdev, handle, nlen, name);
>  	return handle;
>  }

Uh.  This line is missing.

-       int handle = ida_alloc_min(&vgdev->ctx_id_ida, 1, GFP_KERNEL);
+       int handle = ida_alloc(&vgdev->ctx_id_ida, GFP_KERNEL);

It'll be there in v2 ;-)
