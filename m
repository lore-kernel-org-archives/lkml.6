Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12099C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D072087C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D072087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388052AbeGKTgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:36:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27535 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387634AbeGKTgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A89C430832ED;
        Wed, 11 Jul 2018 19:30:30 +0000 (UTC)
Received: from t450s.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD3E16BFC;
        Wed, 11 Jul 2018 19:30:27 +0000 (UTC)
Date:   Wed, 11 Jul 2018 13:30:26 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] sample: vfio-mdev: avoid deadlock in mdev_access()
Message-ID: <20180711133026.5339589d@t450s.home>
In-Reply-To: <1530910206-24948-1-git-send-email-khoroshilov@ispras.ru>
References: <1530910206-24948-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 11 Jul 2018 19:30:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 23:50:06 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> mdev_access() calls mbochs_get_page() with mdev_state->ops_lock held,
> while mbochs_get_page() locks the mutex by itself.
> It leads to unavoidable deadlock.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  samples/vfio-mdev/mbochs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index 2960e26c6ea4..6295a21381eb 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -178,6 +178,8 @@ static const char *vbe_name(u32 index)
>  	return "(invalid)";
>  }
>  
> +static struct page *__mbochs_get_page(struct mdev_state *mdev_state,
> +				      pgoff_t pgoff);
>  static struct page *mbochs_get_page(struct mdev_state *mdev_state,
>  				    pgoff_t pgoff);
>  
> @@ -394,7 +396,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, char *buf, size_t count,
>  		   MBOCHS_MEMORY_BAR_OFFSET + mdev_state->memsize) {
>  		pos -= MBOCHS_MMIO_BAR_OFFSET;
>  		poff = pos & ~PAGE_MASK;
> -		pg = mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
> +		pg = __mbochs_get_page(mdev_state, pos >> PAGE_SHIFT);
>  		map = kmap(pg);
>  		if (is_write)
>  			memcpy(map + poff, buf, count);

Looks good, applied to vfio for-linus branch for v4.18.  Thanks,

Alex
