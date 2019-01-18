Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303B2C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EBA20657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OIj8XrKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfARTe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:34:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39086 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728738AbfARTe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:34:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0IJYHEm003496;
        Fri, 18 Jan 2019 13:34:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547840057;
        bh=6nglwg59ccw6RG8umST1ZgDFbaRU7W9E+lf+vsjMHh4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OIj8XrKgcIR9fb71zukjpn0Bm2oaH0gLeqa7YrbE+f1c6Y5hSGdgfO5l9q4AMtGIi
         UXEyofuPj2epe6U5N9QJTiV4LVt3HFdCGSoeJ0u88wr/Vko+I0Mn1tj4GLeA7/vlgt
         LcGxPnznLTu8GEJBOyduS+F1ryz9uaCU2/b2jfu8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0IJYHLP067694
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jan 2019 13:34:17 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 18
 Jan 2019 13:34:17 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 18 Jan 2019 13:34:17 -0600
Received: from [172.22.101.212] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0IJYGY0015015;
        Fri, 18 Jan 2019 13:34:16 -0600
Subject: Re: [PATCH 1/4] staging: android: ion: Support cpu access during
 dma_buf_detach
To:     Liam Mark <lmark@codeaurora.org>, <labbott@redhat.com>,
        <sumit.semwal@linaro.org>
CC:     <arve@android.com>, <tkjos@android.com>, <maco@android.com>,
        <joel@joelfernandes.org>, <christian@brauner.io>,
        <devel@driverdev.osuosl.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <john.stultz@linaro.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-2-git-send-email-lmark@codeaurora.org>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <b006960e-131b-dc63-fadb-7d9e696b33fb@ti.com>
Date:   Fri, 18 Jan 2019 13:34:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547836667-13695-2-git-send-email-lmark@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/19 12:37 PM, Liam Mark wrote:
> Often userspace doesn't know when the kernel will be calling dma_buf_detach
> on the buffer.
> If userpace starts its CPU access at the same time as the sg list is being
> freed it could end up accessing the sg list after it has been freed.
> 
> Thread A				Thread B
> - DMA_BUF_IOCTL_SYNC IOCT
>  - ion_dma_buf_begin_cpu_access
>   - list_for_each_entry
> 					- ion_dma_buf_detatch
> 					 - free_duped_table
>    - dma_sync_sg_for_cpu
> 

The window for this seems really small, but it does seem technically
possible, good find. for what it's worth:

Acked-by: Andrew F. Davis <afd@ti.com>

> Fix this by getting the ion_buffer lock before freeing the sg table memory.
> 
> Fixes: 2a55e7b5e544 ("staging: android: ion: Call dma_map_sg for syncing and mapping")
> Signed-off-by: Liam Mark <lmark@codeaurora.org>
> ---
>  drivers/staging/android/ion/ion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index a0802de8c3a1..6f5afab7c1a1 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -248,10 +248,10 @@ static void ion_dma_buf_detatch(struct dma_buf *dmabuf,
>  	struct ion_dma_buf_attachment *a = attachment->priv;
>  	struct ion_buffer *buffer = dmabuf->priv;
>  
> -	free_duped_table(a->table);
>  	mutex_lock(&buffer->lock);
>  	list_del(&a->list);
>  	mutex_unlock(&buffer->lock);
> +	free_duped_table(a->table);
>  
>  	kfree(a);
>  }
> 
