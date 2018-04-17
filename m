Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeDQRWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:22:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44206 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeDQRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:22:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2419E60310
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 17 Apr 2018 11:22:34 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: Make endian-agnostic
Message-ID: <20180417172234.GA29077@codeaurora.org>
References: <20180412224111.35216-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180412224111.35216-1-swboyd@chromium.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12 2018 at 16:41 -0600, Stephen Boyd wrote:
>This driver deals with memory that is stored in little-endian format.
>Update the structures with the proper little-endian types and then
>do the proper conversions when reading the fields. Note that we compare
>the ids with a memcmp() because we already pad out the string 'id' field
>to exactly 8 bytes with the strncpy() onto the stack.
>
>Cc: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>Cc: Lina Iyer <ilina@codeaurora.org>
>Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>Cc: Evan Green <evgreen@chromium.org>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>---
>
>Changes from inline patch:
> * Fixed magic
> * Made function for memcmp()
> *
>
> drivers/soc/qcom/cmd-db.c | 116 +++++++++++++++++++++-----------------
> 1 file changed, 65 insertions(+), 51 deletions(-)
>
>@@ -99,8 +90,34 @@ struct cmd_db_header {
>  * h/w accelerator and request a resource state.
>  */
>
>+static const char CMD_DB_MAGIC[] = { 0xdb, 0x30, 0x03, 0x0c };
>+
This works now.

>+static bool cmd_db_magic_matches(struct cmd_db_header *header)
>+{
>+	__le32 *magic = &header->magic_num;
>+
>+	return memcmp(magic, CMD_DB_MAGIC, sizeof(CMD_DB_MAGIC)) == 0;
>+}
>+
> static struct cmd_db_header *cmd_db_header;
Could  you move this up, along with other declarations?
>
>+
>+static inline void *rsc_to_entry_header(struct rsc_hdr *hdr)
>+{
>+	u16 offset = le16_to_cpu(hdr->header_offset);
>+
>+	return cmd_db_header->data + offset;

I noticed that the data was incorrect, with the above and I did it to
read the correct data.

return ((void*)cmd_db_header + sizeof(*cmd_db_header) + offset);
>+}
>+
>+static inline void *
>+rsc_offset(struct rsc_hdr *hdr, struct entry_header *ent)
>+{
>+	u16 offset = le16_to_cpu(hdr->header_offset);
>+	u16 loffset = le16_to_cpu(ent->offset);
>+
>+	return cmd_db_header->data + offset + loffset;
As well here -
 return ((void*)cmd_db_header + sizeof(*cmd_db_header) + offset +
 loffset);
>+}
>+

Thanks,
Lina
