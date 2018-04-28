Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeD1TtF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 15:49:05 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:42192 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeD1TtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 15:49:04 -0400
X-Google-Smtp-Source: AB8JxZqqRb8Gv/XZ0LNeKS1ATwux9+z4vtIQxz5x9ySACjBdjgzMoO5Ek8Z8kWaExINTiNXDNlRf114oBEGGf3E2Ydc=
MIME-Version: 1.0
References: <20180427155851.16402-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180427155851.16402-1-mika.westerberg@linux.intel.com>
From: Yehezkel Bernat <yehezkelshb@gmail.com>
Date: Sat, 28 Apr 2018 19:48:48 +0000
Message-ID: <CA+CmpXufiyeAOqoRhYaMd7u65LY-RyjsewOuohpKAXi42zOuTw@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Handle NULL boot ACL entries properly
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, andreas.noever@gmail.com,
        michael.jamet@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 6:58 PM Mika Westerberg <
mika.westerberg@linux.intel.com> wrote:

> If the boot ACL entry is already NULL we should not fill in the upper
> two DWs with 0xfffffffff. Otherwise they are not shown as empty entries
> when the sysfs attribute is read.
> Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>    drivers/thunderbolt/icm.c | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 2d2ceda9aa26..aec6a82989d8 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -1255,7 +1255,7 @@ static int icm_ar_get_boot_acl(struct tb *tb,
uuid_t *uuids, size_t nuuids)
>                           /* Map empty entries to null UUID */
>                           uuid[0] = 0;
>                           uuid[1] = 0;
> -               } else {
> +               } else if (uuid[0] != 0 && uuid[1] != 0) {

Maybe || instead of &&?
I'd think it's enough for one of them to be non-zero to be a valid UUID.

>                           /* Upper two DWs are always one's */
>                           uuid[2] = 0xffffffff;
>                           uuid[3] = 0xffffffff;
> --
> 2.17.0
