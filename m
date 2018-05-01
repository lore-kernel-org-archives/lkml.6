Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756602AbeEAS4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 14:56:31 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41225 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756382AbeEAS4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 14:56:30 -0400
X-Google-Smtp-Source: AB8JxZrgdjPGNjO2IhdYATkeEMhg7YEhc1j7AzruW/J2ApDGjF5sDIG5mrNhuBWXM4Q7WcgDw+5bgMU1SXh+FUHqMKw=
MIME-Version: 1.0
References: <20180430111245.31072-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20180430111245.31072-1-mika.westerberg@linux.intel.com>
From: Yehezkel Bernat <yehezkelshb@gmail.com>
Date: Tue, 01 May 2018 18:56:13 +0000
Message-ID: <CA+CmpXtiJx=Ufk6tdZOa+4m3uLiR3KoY1hknWmBZ5c0AUg6yEQ@mail.gmail.com>
Subject: Re: [PATCH v2] thunderbolt: Handle NULL boot ACL entries properly
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>, michael.jamet@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 2:12 PM Mika Westerberg <
mika.westerberg@linux.intel.com> wrote:

> If the boot ACL entry is already NULL we should not fill in the upper
> two DWs with 0xfffffffff. Otherwise they are not shown as empty entries
> when the sysfs attribute is read.

> Fixes: 9aaa3b8b4c56 ("thunderbolt: Add support for preboot ACL")
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> Changes from v1 (https://lkml.org/lkml/2018/4/27/845):

>   * Use || instead of && to make sure UUIDs with only one zero DW
>     are still treated as valid.

>   drivers/thunderbolt/icm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 2d2ceda9aa26..500911f16498 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -1255,7 +1255,7 @@ static int icm_ar_get_boot_acl(struct tb *tb,
uuid_t *uuids, size_t nuuids)
>                          /* Map empty entries to null UUID */
>                          uuid[0] = 0;
>                          uuid[1] = 0;
> -               } else {
> +               } else if (uuid[0] != 0 || uuid[1] != 0) {
>                          /* Upper two DWs are always one's */
>                          uuid[2] = 0xffffffff;
>                          uuid[3] = 0xffffffff;
> --
> 2.17.0


Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
