Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB2BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA08721B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439894AbfBNT6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:58:08 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:11695 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728119AbfBNT6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:58:08 -0500
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 14 Feb 2019 11:58:04 -0800
Received: from promb-2n-dhcp77.eng.vmware.com (promb-2n-dhcp77.eng.vmware.com [10.20.88.77])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id AE58541027;
        Thu, 14 Feb 2019 11:58:06 -0800 (PST)
Message-ID: <2b3f7531e6bf4a2d9b6fdd1af07c6400712b3127.camel@vmware.com>
Subject: Re: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'restart'
From:   Deepak Singh Rawat <drawat@vmware.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Date:   Thu, 14 Feb 2019 11:58:37 -0800
In-Reply-To: <20190214020804.22935-1-yuehaibing@huawei.com>
References: <20190214020804.22935-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: drawat@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for doing this. Will include this one with next vmwgfx pull
request.

Reviewed-by: Deepak Rawat <drawat@vmware.com>

On Thu, 2019-02-14 at 02:08 +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c: In function
> 'vmw_cmdbuf_work_func':
> drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c:514:7: warning:
>  variable 'restart' set but not used [-Wunused-but-set-variable]
> 
> It not used any more after commit dc366364c4ef ("drm/vmwgfx: Fix
> multiple
> command buffer context use")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> index 70dab55e7888..ed15655eacd2 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
> @@ -511,17 +511,14 @@ static void vmw_cmdbuf_work_func(struct
> work_struct *work)
>  		container_of(work, struct vmw_cmdbuf_man, work);
>  	struct vmw_cmdbuf_header *entry, *next;
>  	uint32_t dummy;
> -	bool restart[SVGA_CB_CONTEXT_MAX];
>  	bool send_fence = false;
>  	struct list_head restart_head[SVGA_CB_CONTEXT_MAX];
>  	int i;
>  	struct vmw_cmdbuf_context *ctx;
>  	bool global_block = false;
>  
> -	for_each_cmdbuf_ctx(man, i, ctx) {
> +	for_each_cmdbuf_ctx(man, i, ctx)
>  		INIT_LIST_HEAD(&restart_head[i]);
> -		restart[i] = false;
> -	}
>  
>  	mutex_lock(&man->error_mutex);
>  	spin_lock(&man->lock);
> @@ -533,7 +530,6 @@ static void vmw_cmdbuf_work_func(struct
> work_struct *work)
>  		const char *cmd_name;
>  
>  		list_del_init(&entry->list);
> -		restart[entry->cb_context] = true;
>  		global_block = true;
>  
>  		if (!vmw_cmd_describe(header, &error_cmd_size,
> &cmd_name)) {
> 
> 
> 

