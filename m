Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752258AbeDLUz5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:55:57 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39583 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751670AbeDLUzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:55:55 -0400
X-Google-Smtp-Source: AIpwx49y3NA1wHnwKX0nwtteoVy25odLCzi8rixZt8bdDk0yHQQkDhHuhyrKOVxam9dZkrb5PrzIYg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Lina Iyer <ilina@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180410174629.GD19682@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
References: <20180406151356.7818-1-ilina@codeaurora.org>
 <20180406151356.7818-2-ilina@codeaurora.org>
 <152305699547.94378.15462587304123828477@swboyd.mtv.corp.google.com>
 <20180410174629.GD19682@codeaurora.org>
Message-ID: <152356655313.37499.5720064569896132604@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v7 [RESEND] 1/2] drivers: qcom: add command DB driver
Date: Thu, 12 Apr 2018 13:55:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3CKu1LV015929

Quoting Lina Iyer (2018-04-10 10:46:29)
> On Fri, Apr 06 2018 at 17:23 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-04-06 08:13:55)
> >> From: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> >>
> >> Command DB is a simple database in the shared memory of QCOM SoCs, that
> >> provides information regarding shared resources. Some shared resources
> >> in the SoC have properties that are probed dynamically at boot by the
> >> remote processor. The information pertaining to the SoC and the platform
> >> are made available in the shared memory. Drivers can query this
> >> information using predefined strings.
> >>
> >> Signed-off-by: Mahesh Sivasubramanian <msivasub@codeaurora.org>
> >> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> >> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >> ---
> >
> >I have this patch on top to fix the endian stuff. Care to test it out
> >and see if it still works?
> >
> >From: Stephen Boyd <swboyd@chromium.org>
> >Subject: soc: qcom: cmd-db: Make endian-agnostic
> >
> >This driver deals with memory that is stored in little-endian format.
> >Update the structures with the proper little-endian types and then
> >do the proper conversions when reading the fields. Note that we compare
> >the ids with a memcmp() because we already pad out the string 'id' field
> >to exactly 8 bytes with the strncpy() onto the stack.
> >
> >Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> >
> >diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> >index b5172049f608..a56dc9edab82 100644
> >--- a/drivers/soc/qcom/cmd-db.c
> >+++ b/drivers/soc/qcom/cmd-db.c
> >@@ -13,18 +13,10 @@
> >
> > #define NUM_PRIORITY          2
> > #define MAX_SLV_ID            8
> >-#define CMD_DB_MAGIC          0x0C0330DBUL
> >+static const char CMD_DB_MAGIC[] = { 0xdb, 0x33, 0x03, 0x0c };
> This has to be { 0xdb, 0x30, 0x03, 0x0c }
> 
> Otherwise it works.
> 

Perfect! Thanks for catching that. I will resend with the typo fix.
