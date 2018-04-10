Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753916AbeDJNQN convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:16:13 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53567 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753884AbeDJNQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:16:11 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Colin King <colin.king@canonical.com>,
        "Zhenyu Wang" <zhenyuw@linux.intel.com>,
        "Zhi Wang" <zhi.a.wang@intel.com>,
        "Jani Nikula" <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "David Airlie" <airlied@linux.ie>, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
From: Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20180410123312.24631-1-colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180410123312.24631-1-colin.king@canonical.com>
Message-ID: <152336616409.3167.2652004727166779432@mail.alporthouse.com>
User-Agent: alot/0.3.6
Subject: Re: [PATCH] drm/i915/gvt: fix memory leak of a cmd_entry struct on error
 exit path
Date: Tue, 10 Apr 2018 14:16:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2018-04-10 13:33:12)
> From: Colin Ian King <colin.king@canonical.com>
> 
> The error exit path when a duplicate is found does not kfree and cmd_entry
> struct and hence there is a small memory leak.  Fix this by kfree'ing it.
> 
> Detected by CoverityScan, CID#1370198 ("Resource Leak")
> 
> Fixes: be1da7070aea ("drm/i915/gvt: vGPU command scanner")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/gvt/cmd_parser.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
> index d85939bd7b47..3b6d26c44e37 100644
> --- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
> +++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
> @@ -2864,6 +2864,7 @@ static int init_cmd_table(struct intel_gvt *gvt)
>                 if (info) {
>                         gvt_err("%s %s duplicated\n", e->info->name,
>                                         info->name);
> +                       kfree(e);

e kzalloc'ed moments above, not yet added to any lists, so fine to use
kfree.

Alternatively, the find_cmd_entry_any_ring() could be moved ahead of the
kzalloc as this function must be externally serialised.

Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris
