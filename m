Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeCESmb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751311AbeCESm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:42:28 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA44E20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Lina Iyer <ilina@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180226175802.20052-2-ilina@codeaurora.org>
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180226175802.20052-1-ilina@codeaurora.org>
 <20180226175802.20052-2-ilina@codeaurora.org>
Message-ID: <152027534725.108663.13213325833387672227@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v4 1/2] drivers: qcom: add command DB driver
Date: Mon, 05 Mar 2018 10:42:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-02-26 09:58:01)
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> new file mode 100644
> index 000000000000..0792a2a98fc9
> --- /dev/null
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -0,0 +1,319 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/types.h>
> +
> +#include <soc/qcom/cmd-db.h>
> +
> +#define NUM_PRIORITY           2
> +#define MAX_SLV_ID             8
> +#define CMD_DB_MAGIC           0x0C0330DBUL

Make this an array so it's endian safe.

> +#define SLAVE_ID_MASK          0x7
> +#define SLAVE_ID_SHIFT         16
> +
> +#define ENTRY_HEADER(hdr)      ((void *)cmd_db_header +        \
> +                               sizeof(*cmd_db_header) +        \
> +                               hdr->header_offset)
> +
> +#define RSC_OFFSET(hdr, ent)   ((void *)cmd_db_header +        \
> +                               sizeof(*cmd_db_header) +        \
> +                               hdr.data_offset + ent.offset)
> +
> +/**
> + * entry_header: header for each entry in cmddb

struct entry_header - header for each...

> + *
> + * @id: resource's identifier
> + * @priority: unused
> + * @addr: the address of the resource
> + * @len: length of the data
> + * @offset: offset at which data starts

offset from this entry header at which data starts? Or offset from
where?

> + */
> +struct entry_header {
> +       u64 id;
> +       u32 priority[NUM_PRIORITY];
> +       u32 addr;
> +       u16 len;
> +       u16 offset;
> +};
> +
> +/**
> + * rsc_hdr: resource header information

ditto.

> + *
> + * @slv_id: id for the resource
> + * @header_offset: Entry header offset from data
> + * @data_offset: Entry offset for data location

Same question: offset from where?

> + * @cnt: number of entries for HW type
> + * @version: MSB is major, LSB is minor

@reserved: reserved for future use

> + */
> +struct rsc_hdr {
> +       u16 slv_id;
> +       u16 header_offset;
> +       u16 data_offset;
> +       u16 cnt;
> +       u16 version;
> +       u16 reserved[3];
> +};
> +
> +/**
> + * cmd_db_header: The DB header information
> + *
> + * @version: The cmd db version
> + * @magic_number: constant expected in the database
> + * @header: array of resources
> + * @check_sum: check sum for the header. Unused.
> + * @reserved: reserved memory
> + * @data: driver specific data
> + */
> +struct cmd_db_header {
> +       u32 version;
> +       u32 magic_num;
> +       struct rsc_hdr header[MAX_SLV_ID];
> +       u32 check_sum;

Drop underscore? 'checksum' is usually one word.

> +       u32 reserved;
> +       u8 data[];
> +};
> +
> +/**
> + * DOC: Description of the Command DB database.
> + *
> + * At the start of the command DB memory is the cmd_db_header structure.
> + * The cmd_db_header holds the version, checksum, magic key as well as an
> + * array for header for each slave (depicted by the rsc_header). Each h/w
> + * based accelerator is a 'slave' (shared resource) and has slave id indicating
> + * the type of accelerator. The rsc_header is the header for such individual
> + * slaves of a given type. The entries for each of these slaves begin at the
> + * rsc_hdr.header_offset. In addition each slave could have auxiliary data
> + * that may be needed by the driver. The data for the slave starts at the
> + * entry_header.offset to the location pointed to by the rsc_hdr.data_offset.
> + *
> + * Drivers have a stringified key to a slave/resource. They can query the slave
> + * information and get the slave id and the auxiliary data and the length of the
> + * data. Using this information, they can format the request to be sent to the
> + * h/w accelerator and request a resource state.
> + */
> +
> +static struct cmd_db_header *cmd_db_header;
> +
> +/**
> + * cmd_db_ready - Indicates if command DB is available
> + *
> + * Return: 0 on success, errno otherwise
> + */
> +int cmd_db_ready(void)
> +{
> +       if (cmd_db_header == NULL)
> +               return -EPROBE_DEFER;
> +       else if (cmd_db_header->magic_num != CMD_DB_MAGIC)
> +               return -EINVAL;
> +       else
> +               return 0;

Drop else and just return 0.

> +}
> +EXPORT_SYMBOL(cmd_db_ready);
> +
> +static u64 cmd_db_get_u64_id(const char *id)
> +{
> +       u64 rsc_id = 0;
> +       u8 *ch = (u8 *)&rsc_id;
> +       int i;
> +
> +       for (i = 0; i < sizeof(rsc_id) && id[i]; i++)
> +               ch[i] = id[i];

This could be a strncpy now? Didn't I already ask this? I'll have to
look back at the other emails it seems. Actually, it looks like a cast
of a string to an integer, which is then reversed to look up the same
string. Not sure what the use is for this.

> +
> +       return rsc_id;
> +}
> +
> +static int cmd_db_get_header(u64 query, struct entry_header *eh,
> +                           struct rsc_hdr *rh)
> +{
> +       struct rsc_hdr *rsc_hdr;
> +       struct entry_header *ent;
> +       int ret, i, j;
> +
> +       ret = cmd_db_ready();
> +       if (ret)
> +               return ret;
> +
> +       if (!eh || !rh)
> +               return -EINVAL;
> +
> +       for (i = 0; i < MAX_SLV_ID; i++) {
> +               rsc_hdr = &cmd_db_header->header[i];
> +               if (!rsc_hdr->slv_id)
> +                       break;
> +
> +               ent = ENTRY_HEADER(rsc_hdr);
> +               for (j = 0; j < rsc_hdr->cnt; j++, ent++) {
> +                       if (ent->id == query)
> +                               break;
> +               }
> +
> +               if (j < rsc_hdr->cnt) {
> +                       memcpy(eh, ent, sizeof(*ent));
> +                       memcpy(rh, rsc_hdr, sizeof(*rh));

I suppose it's OK to punt on the endian issues for now if it's too hard.
Eventually we'll want to handle it though and it shouldn't make the code
any worse when endianness is the same. Can it be done now?

> +                       return 0;
> +               }
> +       }
> +
> +       return -ENODEV;
> +}
> +
> +static int cmd_db_get_header_by_rsc_id(const char *id,
> +                                     struct entry_header *ent_hdr,
> +                                     struct rsc_hdr *rsc_hdr)
> +{
> +       u64 rsc_id = cmd_db_get_u64_id(id);
> +
> +       return cmd_db_get_header(rsc_id, ent_hdr, rsc_hdr);
> +}
> +
> +/**
> + * cmd_db_read_addr() - Query command db for resource id address.
> + *
> + *  @id: resource id to query for address
> + *
> + * This is used to retrieve resource address based on resource
> + * id.
> + *  Return: resource address on success, 0 on error

Weird spaces here. Mix of tabs and spaces perhaps?

> + */
> +u32 cmd_db_read_addr(const char *id)
> +{
> +       int ret;
> +       struct entry_header ent;
> +       struct rsc_hdr rsc_hdr;
> +
> +       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
> +
> +       return ret < 0 ? 0 : ent.addr;
> +}
> +EXPORT_SYMBOL(cmd_db_read_addr);
> +
> +/**
> + * cmd_db_read_aux_data() - Query command db for aux data.
> + *
> + *  @id : Resource to retrieve AUX Data on.
> + *  @data : Data buffer to copy returned aux data to. Returns size on NULL
> + *  @len : Caller provides size of data buffer passed in.

Attach the ':' to the variable please.

> + *
> + *  Return: size of data on success, errno on error

success, -EINVAL on error

> + */
> +int cmd_db_read_aux_data(const char *id, u8 *data, int len)
> +{
> +       int ret;
> +       struct entry_header ent;
> +       struct rsc_hdr rsc_hdr;
> +
> +       if (!data)
> +               return -EINVAL;
> +
> +       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
> +       if (ret)
> +               return ret;
> +
> +       if (len < ent.len)
> +               return -EINVAL;
> +
> +       len = min_t(u16, ent.len, len);
> +       memcpy(data, RSC_OFFSET(rsc_hdr, ent), len);
> +
> +       return len;
> +}
> +EXPORT_SYMBOL(cmd_db_read_aux_data);
> +
> +/**
> + * cmd_db_read_aux_data_len - Get the length of the auxllary data stored in DB.
> + *
> + * @id: Resource to retrieve AUX Data.
> + *
> + * Return: size on success, 0 on error
> + */
> +size_t cmd_db_read_aux_data_len(const char *id)
> +{
> +       int ret;
> +       struct entry_header ent;
> +       struct rsc_hdr rsc_hdr;
> +
> +       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);

A bunch of code is calling this function. Why not change the user
interface to use an opaque 'resource' cookie that we can 'get' or 'find'
and then use that cookie in the rest of the API to pull out the data
that's desired?

> +
> +       return ret < 0 ? 0 : ent.len;
> +}
> +EXPORT_SYMBOL(cmd_db_read_aux_data_len);
> +
> +/**
> + * cmd_db_read_slave_id - Get the slave ID for a given resource address
> + *
> + * @id: Resource id to query the DB for version
> + *
> + * Return: cmd_db_hw_type enum on success, CMD_DB_HW_INVALID on error
> + */
> +enum cmd_db_hw_type cmd_db_read_slave_id(const char *id)
> +{
> +       int ret;
> +       struct entry_header ent;
> +       struct rsc_hdr rsc_hdr;
> +
> +       ret = cmd_db_get_header_by_rsc_id(id, &ent, &rsc_hdr);
> +
> +       return ret < 0 ? CMD_DB_HW_INVALID :
> +                      (ent.addr >> SLAVE_ID_SHIFT) & SLAVE_ID_MASK;
> +}
> +EXPORT_SYMBOL(cmd_db_read_slave_id);
> +
> +static int cmd_db_dev_probe(struct platform_device *pdev)
> +{
> +       struct reserved_mem *rmem;
> +       void *dict, *start_addr;
> +       int ret = 0;
> +
> +       rmem = of_reserved_mem_lookup(pdev->dev.of_node);
> +       if (!rmem) {
> +               dev_err(&pdev->dev, "failed to acquire memory region\n");
> +               return -EINVAL;
> +       }
> +
> +       dict = devm_memremap(&pdev->dev, rmem->base, rmem->size, MEMREMAP_WB);
> +       if (IS_ERR(dict))
> +               return -ENOMEM;
> +
> +       start_addr = memremap(readl_relaxed(dict), readl_relaxed(dict + 0x4),
> +                            MEMREMAP_WB);
> +       if (IS_ERR_OR_NULL(start_addr)) {

Should just be !start_addr? I don't see where memremap() returns an
error pointer.

> +               ret = PTR_ERR(start_addr);
> +               goto done;
> +       }
> +
> +       cmd_db_header = start_addr;
> +       if (cmd_db_header->magic_num != CMD_DB_MAGIC) {

memcmp?

> +               ret = -EINVAL;
> +               dev_err(&pdev->dev, "Invalid Command DB Magic\n");
> +               goto done;
> +       }
> +
> +done:
> +       devm_memunmap(&pdev->dev, dict);

I'm lost why we use devm_*() for this mapping.

> +       return ret;
> +}
> +
> +static const struct of_device_id cmd_db_match_table[] = {
> +       { .compatible = "qcom,cmd-db" },
> +       { },
> +};
> +
> +static struct platform_driver cmd_db_dev_driver = {
> +       .probe  = cmd_db_dev_probe,
> +       .driver = {
> +                 .name = "cmd-db",
> +                 .of_match_table = cmd_db_match_table,

Add suppress_bind_attrs here to make sure we can't remove this device
later? That also allows us to ignore unmapping the start_addr pointer
in any sort of 'remove' function.

> +       },
> +};
> +
