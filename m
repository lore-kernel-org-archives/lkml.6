Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E733C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B842077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B842077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbeIDUSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:18:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeIDUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:18:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2005A8830B;
        Tue,  4 Sep 2018 15:52:53 +0000 (UTC)
Received: from t450s.home (ovpn-116-77.phx2.redhat.com [10.3.116.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D54EF19489;
        Tue,  4 Sep 2018 15:52:50 +0000 (UTC)
Date:   Tue, 4 Sep 2018 09:52:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Li Qiang <liq3ea@gmail.com>
Cc:     eric.auger@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liqiang02@corp.netease.com
Subject: Re: [PATCH] vfio: fix potential memory leak in vfio_msi_cap_len
Message-ID: <20180904095250.32e170c5@t450s.home>
In-Reply-To: <1535374041-3551-1-git-send-email-liq3ea@gmail.com>
References: <1535374041-3551-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 04 Sep 2018 15:52:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2018 05:47:21 -0700
Li Qiang <liq3ea@gmail.com> wrote:

> Free the vdev->msi_perm in error path.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 115a36f6f403..62023b4a373b 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1180,8 +1180,10 @@ static int vfio_msi_cap_len(struct vfio_pci_device *vdev, u8 pos)
>  		return -ENOMEM;
>  
>  	ret = init_pci_cap_msi_perm(vdev->msi_perm, len, flags);
> -	if (ret)
> +	if (ret) {
> +		kfree(vdev->msi_perm);
>  		return ret;
> +	}
>  
>  	return len;
>  }

Fix looks correct to me, I'll queue this for v4.20 with Eric's R-b.
Thanks,

Alex
