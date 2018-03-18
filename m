Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeCRIMV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 04:12:21 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41775 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeCRIMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 04:12:17 -0400
X-Google-Smtp-Source: AG47ELuAdL5mBYGyNKnkgZXit/8Md9Ljo/ytTfIf25RBXv+wKNAiUujc7mCytNTia5CsWWEKV3mnQGlbpG0sWV8fyAM=
MIME-Version: 1.0
In-Reply-To: <20180315164952.2168794-1-arnd@arndb.de>
References: <20180315164952.2168794-1-arnd@arndb.de>
From: Oded Gabbay <oded.gabbay@gmail.com>
Date: Sun, 18 Mar 2018 10:11:45 +0200
Message-ID: <CAFCwf11Co7djF5u2DvHbGz1LjQYpQ0PZOqHcuk1EAJpb2Zw=mA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix uninitialized variable use
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
        Kent Russell <kent.russell@amd.com>, Amber Lin <Amber.Lin@amd.com>,
        Maling list - DRI developers
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 6:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> When CONFIG_ACPI is disabled, we never initialize the acpi_table
> structure in kfd_create_crat_image_virtual:
>
> drivers/gpu/drm/amd/amdkfd/kfd_crat.c: In function 'kfd_create_crat_image_virtual':
> drivers/gpu/drm/amd/amdkfd/kfd_crat.c:888:40: error: 'acpi_table' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The undefined behavior also happens for any other acpi_get_table()
> failure, but then the compiler can't warn about it.
>
> This adds an error check that prevents the structure from
> being used in error, avoiding both the undefined behavior and
> the warning about it.
>
> Fixes: 520b8fb755cc ("drm/amdkfd: Add topology support for CPUs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 7493f47e7fe1..d85112224f1d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -882,7 +882,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>         crat_table->length = sizeof(struct crat_header);
>
>         status = acpi_get_table("DSDT", 0, &acpi_table);
> -       if (status == AE_NOT_FOUND)
> +       if (status != AE_OK)
>                 pr_warn("DSDT table not found for OEM information\n");
>         else {
>                 crat_table->oem_revision = acpi_table->revision;
> --
> 2.9.0
>

Thanks!
Applied to -next
Oded
