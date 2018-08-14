Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF26C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012D62173C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 04:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012D62173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbeHNHmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 03:42:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725999AbeHNHml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 03:42:41 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 28973F9F81189;
        Tue, 14 Aug 2018 12:57:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Tue, 14 Aug 2018
 12:57:10 +0800
Message-ID: <5B726124.5030308@huawei.com>
Date:   Tue, 14 Aug 2018 12:57:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Joe Perches <golf@perches.com>
CC:     <tony.luck@intel.com>, <fenghua.yu@intel.com>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <oleg@redhat.com>, <rppt@linux.vnet.ibm.com>,
        <dhowells@redhat.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>, <linux-ia64@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 1/2] ia64: Use ARRAY_SIZE to replace its implementation
References: <1534214814-9043-1-git-send-email-zhongjiang@huawei.com>  <1534214814-9043-2-git-send-email-zhongjiang@huawei.com> <81ae2b1b7ea395217dbf3494457a232bdfdc79c5.camel@perches.com>
In-Reply-To: <81ae2b1b7ea395217dbf3494457a232bdfdc79c5.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/14 12:45, Joe Perches wrote:
> On Tue, 2018-08-14 at 10:46 +0800, zhong jiang wrote:
>> We prefer to ARRAY_SIZE rather than duplicating its implementation.
>> So just replace it.
> []
>> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
> []
>> @@ -4645,7 +4645,7 @@ static char *pfmfs_dname(struct dentry *dentry, char *buffer, int buflen)
>>  /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
>>  /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
>>  };
>> -#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
>> +#define PFM_CMD_COUNT	ARRAY_SIZE(pfm_cmd_tab)
> Better would be to remove the #define altogether and change
> the one place where it's used to ARRAY_SIZE(...)
> ---
>  arch/ia64/kernel/perfmon.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
> index a9d4dc6c0427..08ece2c7b6e1 100644
> --- a/arch/ia64/kernel/perfmon.c
> +++ b/arch/ia64/kernel/perfmon.c
> @@ -4645,7 +4645,6 @@ static pfm_cmd_desc_t pfm_cmd_tab[]={
>  /* 32 */PFM_CMD(pfm_write_ibrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL),
>  /* 33 */PFM_CMD(pfm_write_dbrs, PFM_CMD_PCLRWS, PFM_CMD_ARG_MANY, pfarg_dbreg_t, NULL)
>  };
> -#define PFM_CMD_COUNT	(sizeof(pfm_cmd_tab)/sizeof(pfm_cmd_desc_t))
>  
>  static int
>  pfm_check_task_state(pfm_context_t *ctx, int cmd, unsigned long flags)
> @@ -4770,7 +4769,7 @@ sys_perfmonctl (int fd, int cmd, void __user *arg, int count)
>  	 */
>  	if (unlikely(pmu_conf == NULL)) return -ENOSYS;
>  
> -	if (unlikely(cmd < 0 || cmd >= PFM_CMD_COUNT)) {
> +	if (unlikely(cmd < 0 || cmd >= ARRAY_SIZE(pfm_cmd_tab)) {
>  		DPRINT(("invalid cmd=%d\n", cmd));
>  		return -EINVAL;
>  	}
>
>
> .
>
 Thank you for suggestion.  That's indeed better if just one palce use it.  I will repost in v2.

 Sincerely,
zhong jiang

