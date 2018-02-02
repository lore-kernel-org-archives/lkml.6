Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbeBBU0i (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:26:38 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:42648 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752139AbeBBU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:26:26 -0500
X-Google-Smtp-Source: AH8x224+FVkjLJaC55jQ8y2U1ogaMKS2pZg41v5+JUYkQzeNrdJLHY60yoMgJlWM3nU62HRf+q8481wZgxD3jJ+S+rA=
MIME-Version: 1.0
In-Reply-To: <20180202190600.GD9080@ziepe.ca>
References: <20180202154636.1624079-1-arnd@arndb.de> <20180202190600.GD9080@ziepe.ca>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 2 Feb 2018 21:26:24 +0100
X-Google-Sender-Auth: OZ7NuUviUA8DDpOBgAw8n1i5GV4
Message-ID: <CAK8P3a2gi4EC+0tEzoRQ9ojscmXgddrmgwtB=TfQKriszPVaLA@mail.gmail.com>
Subject: Re: [PATCH] net: mlx5: remove pointless memcpy
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>,
        Matan Barak <matanb@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Networking <netdev@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 8:06 PM, Jason Gunthorpe <jgg@mellanox.com> wrote:
> On Fri, Feb 02, 2018 at 04:46:30PM +0100, Arnd Bergmann wrote:
>> gcc-8 notices that the memcpy in mlx5_core_query_xsrq() makes no
>> sense because the source and destination variables are identical:
>>
>> drivers/net/ethernet/mellanox/mlx5/core/transobj.c: In function 'mlx5_core_query_xsrq':
>> drivers/net/ethernet/mellanox/mlx5/core/transobj.c:347:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
>>
>> Either one of the pointers should be something else, or the code is
>> completely bogus. Removing the memcpy() won't change the behavior
>> but gets rid of the warning.
>>
>> Fixes: 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when using ISSI > 0")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Please review carefully, I have no idea what the author actually
>> intended here.
>
> I think they intended to adjust the command return between
> mlx5_ifc_query_srq_out_bits and mlx5_ifc_query_xrc_srq_out_bits?
>
>> index 9e38343a951f..75450f7d53bf 100644
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/transobj.c
>> @@ -332,20 +332,12 @@ int mlx5_core_destroy_xsrq(struct mlx5_core_dev *dev, u32 xsrqn)
>>  int mlx5_core_query_xsrq(struct mlx5_core_dev *dev, u32 xsrqn, u32 *out)
>>  {
>>       u32 in[MLX5_ST_SZ_DW(query_xrc_srq_in)] = {0};
>> -     void *srqc;
>> -     void *xrc_srqc;
>>       int err;
>>
>>       MLX5_SET(query_xrc_srq_in, in, opcode,   MLX5_CMD_OP_QUERY_XRC_SRQ);
>>       MLX5_SET(query_xrc_srq_in, in, xrc_srqn, xsrqn);
>>       err = mlx5_cmd_exec(dev, in, sizeof(in), out,
>>                           MLX5_ST_SZ_BYTES(query_xrc_srq_out));
>> -     if (!err) {
>> -             xrc_srqc = MLX5_ADDR_OF(query_xrc_srq_out, out,
>> -                                     xrc_srq_context_entry);
>> -             srqc = MLX5_ADDR_OF(query_srq_out, out, srq_context_entry);
>> -             memcpy(srqc, xrc_srqc, MLX5_ST_SZ_BYTES(srqc));
>> -     }
>
> Probably should add a
>
> BUILD_BUG_ON(MLX5_BYTE_OFF(query_xrc_srq_out, xrc_srq_context_entry) == MLX5_BYTE_OFF(query_srq_out, srq_context_entry));
>
> Just for clarity that the SRQ and XRC_SRQ are being used interchangeably.
>
> and the 'err' variable can be eliminated.
>
> Curious though that I can't find a call site for it, and removing the
> prototype doesn't break the build.. Seems like dead code.

I checked the git history and don't see any user ever added after the function
first showed up in the kernel, same for a couple of other functions from
commit 01949d0109ee ("net/mlx5_core: Enable XRCs and SRQs when
using ISSI > 0").

Can you come up with a proper patch for this isse, either removing the
dead code, or fixing it appropriately? You clearly understand what this
file is about, and I don't ;-)

      Arnd
