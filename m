Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752200AbeDJRqe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:46:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52894 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbeDJRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:46:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09D1960250
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date: Tue, 10 Apr 2018 11:46:29 -0600
From: Lina Iyer <ilina@codeaurora.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Subject: Re: [PATCH v7 [RESEND] 1/2] drivers: qcom: add command DB driver
Message-ID: <20180410174629.GD19682@codeaurora.org>
References: <20180406151356.7818-1-ilina@codeaurora.org>
 <20180406151356.7818-2-ilina@codeaurora.org>
 <152305699547.94378.15462587304123828477@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <152305699547.94378.15462587304123828477@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06 2018 at 17:23 -0600, Stephen Boyd wrote:
>Quoting Lina Iyer (2018-04-06 08:13:55)
>> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>>
>> Command DB is a simple database in the shared memory of QCOM SoCs, that
>> provides information regarding shared resources. Some shared resources
>> in the SoC have properties that are probed dynamically at boot by the
>> remote processor. The information pertaining to the SoC and the platform
>> are made available in the shared memory. Drivers can query this
>> information using predefined strings.
>>
>> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>
>I have this patch on top to fix the endian stuff. Care to test it out
>and see if it still works?
>
>From: Stephen Boyd <swboyd@chromium.org>
>Subject: soc: qcom: cmd-db: Make endian-agnostic
>
>This driver deals with memory that is stored in little-endian format.
>Update the structures with the proper little-endian types and then
>do the proper conversions when reading the fields. Note that we compare
>the ids with a memcmp() because we already pad out the string 'id' field
>to exactly 8 bytes with the strncpy() onto the stack.
>
>Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>
>diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
>index b5172049f608..a56dc9edab82 100644
>--- a/drivers/soc/qcom/cmd-db.c
>+++ b/drivers/soc/qcom/cmd-db.c
>@@ -13,18 +13,10 @@
>
> #define NUM_PRIORITY		2
> #define MAX_SLV_ID		8
>-#define CMD_DB_MAGIC		0x0C0330DBUL
>+static const char CMD_DB_MAGIC[] = { 0xdb, 0x33, 0x03, 0x0c };
This has to be { 0xdb, 0x30, 0x03, 0x0c }

Otherwise it works.

Thanks,
Lina
