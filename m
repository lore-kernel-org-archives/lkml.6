Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeE3RVw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:21:52 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:46029 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbeE3RVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:21:50 -0400
X-Google-Smtp-Source: ADUXVKKfBml5G5Blgz2RzTF/Cbpi2qyg6krSH0/rRhAeQs1MoB0YaBzl4IxGzFJdz8Q37oVyJ23N1Q==
MIME-Version: 1.0
References: <20180529181740.195362-1-evgreen@chromium.org> <20180529181740.195362-6-evgreen@chromium.org>
In-Reply-To: <20180529181740.195362-6-evgreen@chromium.org>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 30 May 2018 10:21:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft7ho=2mb7DHbVOHL_0A94BQOZwsdoXcMw_0JOGBUdqSew@mail.gmail.com>
Message-ID: <CAE=gft7ho=2mb7DHbVOHL_0A94BQOZwsdoXcMw_0JOGBUdqSew@mail.gmail.com>
Subject: Re: [PATCH 5/7] scsi: ufs: Refactor descriptor read for write
To: vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, stanislav.nijnikov@wdc.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: gwendal@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewing my own patch...

On Tue, May 29, 2018 at 11:18 AM Evan Green <evgreen@chromium.org> wrote:

> This change refactors the ufshcd_read_desc_param function into
> one that can both read and write descriptors. Most of the low-level
> plumbing for writing to descriptors was already there, this change
> simply enables that code path, and manages the incoming data buffer
> appropriately.

> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>   drivers/scsi/ufs/ufs-sysfs.c |  4 +-
>   drivers/scsi/ufs/ufshcd.c    | 89
++++++++++++++++++++++++++++++++------------
>   drivers/scsi/ufs/ufshcd.h    | 13 ++++---
>   3 files changed, 74 insertions(+), 32 deletions(-)

...
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 00e79057f870..6a5939fb5da3 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -3004,22 +3004,24 @@ int ufshcd_map_desc_id_to_length(struct ufs_hba
*hba,
>   EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);

>   /**
> - * ufshcd_read_desc_param - read the specified descriptor parameter
> + * ufshcd_rw_desc_param - read or write the specified descriptor
parameter
>    * @hba: Pointer to adapter instance
> + * @opcode: indicates whether to read or write
>    * @desc_id: descriptor idn value
>    * @desc_index: descriptor index
> - * @param_offset: offset of the parameter to read
> - * @param_read_buf: pointer to buffer where parameter would be read
> - * @param_size: sizeof(param_read_buf)
> + * @param_offset: offset of the parameter to read or write
> + * @param_buf: pointer to buffer to be read or written
> + * @param_size: sizeof(param_buf)
>    *
>    * Return 0 in case of success, non-zero otherwise
>    */
> -int ufshcd_read_desc_param(struct ufs_hba *hba,
> -                          enum desc_idn desc_id,
> -                          int desc_index,
> -                          u8 param_offset,
> -                          u8 *param_read_buf,
> -                          u8 param_size)
> +int ufshcd_rw_desc_param(struct ufs_hba *hba,
> +                        enum query_opcode opcode,
> +                        enum desc_idn desc_id,
> +                        int desc_index,
> +                        u8 param_offset,
> +                        u8 *param_buf,
> +                        u8 param_size)
>   {
>          int ret;
>          u8 *desc_buf;
> @@ -3042,24 +3044,57 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
>                  return ret;
>          }

> +       if (param_offset > buff_len)
> +               return 0;
> +
>          /* Check whether we need temp memory */
>          if (param_offset != 0 || param_size < buff_len) {
> -               desc_buf = kmalloc(buff_len, GFP_KERNEL);
> +               desc_buf = kzalloc(buff_len, GFP_KERNEL);
>                  if (!desc_buf)
>                          return -ENOMEM;
> +
> +               /* If it's a write, first read the complete descriptor,
then
> +                * copy in the parts being changed.
> +                */
> +               if (opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
> +                       if ((int)param_offset + (int)param_size >
buff_len) {
> +                               ret = -EINVAL;
> +                               goto out;
> +                       }
> +
> +                       ret = ufshcd_query_descriptor_retry(hba,
> +
UPIU_QUERY_OPCODE_READ_DESC,
> +                                               desc_id, desc_index, 0,
> +                                               desc_buf, &buff_len);
> +
> +                       if (ret) {
> +                               dev_err(hba->dev,
> +                                       "%s: Failed reading descriptor.
desc_id %d, desc_index %d, param_offset %d, ret %d",
> +                                       __func__, desc_id, desc_index,
> +                                       param_offset, ret);
> +
> +                               goto out;
> +                       }
> +
> +                       memcpy(desc_buf + param_offset, param_buf,
param_size);
> +               }
> +
>          } else {
> -               desc_buf = param_read_buf;
> +               desc_buf = param_buf;
>                  is_kmalloc = false;
>          }

> -       /* Request for full descriptor */
> -       ret = ufshcd_query_descriptor_retry(hba,
UPIU_QUERY_OPCODE_READ_DESC,
> +       /* Read or write the entire descriptor. */
> +       ret = ufshcd_query_descriptor_retry(hba, opcode,
>                                          desc_id, desc_index, 0,
>                                          desc_buf, &buff_len);

>          if (ret) {
> -               dev_err(hba->dev, "%s: Failed reading descriptor. desc_id
%d, desc_index %d, param_offset %d, ret %d",
> -                       __func__, desc_id, desc_index, param_offset, ret);
> +               dev_err(hba->dev, "%s: Failed %s descriptor. desc_id %d,
desc_index %d, param_offset %d, ret %d",
> +                       __func__,
> +                       opcode == UPIU_QUERY_OPCODE_READ_DESC ?
> +                       "reading" : "writing",
> +                       desc_id, desc_index, param_offset, ret);
>                  goto out;
>          }

> @@ -3071,12 +3106,16 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
>                  goto out;
>          }

> -       /* Check wherher we will not copy more data, than available */
> -       if (is_kmalloc && param_size > buff_len)
> -               param_size = buff_len;
> +       /* Copy data to the output. The offset is already validated to be
> +        * within the buffer.
> +        */
> +       if (is_kmalloc && (opcode == UPIU_QUERY_OPCODE_READ_DESC)) {
> +               if ((int)param_offset + (int)param_size > buff_len)
> +                       param_size = buff_len - param_offset;
> +
> +               memcpy(param_buf, &desc_buf[param_offset], param_size);
> +       }

Previously this function didn't handle param_offset being non-zero well at
all, as it would allow you to read off the end of the descriptor. My hunk
here, as well as the "if (param_offset > buff_len) return 0;" above prevent
reading off the end of the kmalloced buffer. But it will return success
while leaving the caller's buffer uninitialized, which I think is asking
for trouble. I think I should fail if the starting offset is greater than
the size. If the requested read starts at a valid index but ends beyond the
end, I think I should clear the remaining buffer. ufshcd_read_string_desc,
for example, always asks for the max, and would need this bit of leniency.
-Evan
