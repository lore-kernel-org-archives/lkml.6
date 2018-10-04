Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AE1C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C21621473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C21621473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeJDSlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:41:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbeJDSlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:41:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 067AECE8299FA;
        Thu,  4 Oct 2018 19:48:23 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 4 Oct 2018
 19:48:21 +0800
Subject: Re: [SCSI] pmcraid: PMC-Sierra MaxRAID driver to support 6Gb/s SAS
 RAID controller
To:     Colin Ian King <colin.king@canonical.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <f512d8fa-e782-0679-8140-0a27dd3b9062@canonical.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4910c207-5dc2-0095-7a7f-75bb025b337c@huawei.com>
Date:   Thu, 4 Oct 2018 12:48:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <f512d8fa-e782-0679-8140-0a27dd3b9062@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 09:28, Colin Ian King wrote:
> Hi,
>
> Static analysis from CoverityScan (CID#114178 "Operands don't affect
> result") detected an issue in drivers/scsi/pmcraid.c, function
> pmcraid_init_res_table with the following check:
>
>         if (pinstance->cfg_table->flags & MICROCODE_UPDATE_REQUIRED)
>                 pmcraid_err("IOA requires microcode download\n");
>
>
> pinstance->cfg_table->flags is a u8, MICROCODE_UPDATE_REQUIRED is  1 <<
> 31, so the & operation always results in false and the error message is
> never displayed.  From my understanding, flags should be a u8, so there
> is something wrong here with the check.  Any ideas?
>
> Colin
>
>

Maybe MICROCODE_UPDATE_REQUIRED definition is wrong and should be:
  /* config_table.flags value */
-#define MICROCODE_UPDATE_REQUIRED        PMC_BIT32(0)
+#define MICROCODE_UPDATE_REQUIRED        PMC_BIT8(0)

John

