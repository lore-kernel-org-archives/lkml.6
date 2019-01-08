Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2340C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB812173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546931452;
	bh=V2RAIktucXxrjj2gVr//OEPy9ScEKe+O6AWpSIqc0tw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W1yBOu8XKv+AskYeQF6ME9aAvIUNuwHRLNRsXs6ILuGYUnCYd8DhTgVOLQgGQvRnK
	 nbSthyXrAYeVt4Tt9nDvNcMg0WuGJYNGMhxq1I/Bh2wta+CGelCv68hCtItduLNoEl
	 JKm0/rW3S5O5CNHlbihrXC9bntem2TbH6U4C/PgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfAHHKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:10:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfAHHKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:10:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDDD32087F;
        Tue,  8 Jan 2019 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546931445;
        bh=V2RAIktucXxrjj2gVr//OEPy9ScEKe+O6AWpSIqc0tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHSs555pZrvSlbs1RQiR9XsnYEK9AuL0vcymC2/ZGSYhl8lnW510y9tnbzfyegnLj
         aU9WIbNB2R53iuWLSTKkXJT+LEgoA3l+lzPnUzx/oPJKcNaFzBnOI8J0hnEf9Hq+Gz
         f4kfJILIPR+6TikxatWrXEp9vBiNhBXpdjm6wV3I=
Date:   Tue, 8 Jan 2019 08:10:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
        kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com,
        borntraeger@de.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com,
        pasic@linux.ibm.com
Subject: Re: [PATCH v4 2/3] virtio-balloon: improve update_balloon_size_func
Message-ID: <20190108071043.GB32048@kroah.com>
References: <1546923005-40517-1-git-send-email-wei.w.wang@intel.com>
 <1546923005-40517-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546923005-40517-3-git-send-email-wei.w.wang@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 12:50:04PM +0800, Wei Wang wrote:
> There is no need to update the balloon actual register when there is no
> ballooning request. This patch avoids update_balloon_size when diff is 0.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/virtio/virtio_balloon.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 45d32f5..d48c12c 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -457,9 +457,12 @@ static void update_balloon_size_func(struct work_struct *work)
>  			  update_balloon_size_work);
>  	diff = towards_target(vb);
>  
> +	if (!diff)
> +		return;
> +
>  	if (diff > 0)
>  		diff -= fill_balloon(vb, diff);
> -	else if (diff < 0)
> +	else
>  		diff += leak_balloon(vb, -diff);
>  	update_balloon_size(vb);
>  
> -- 
> 2.7.4
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
