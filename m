Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753961AbeBGKcJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 05:32:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753794AbeBGKcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 05:32:06 -0500
Date: Wed, 7 Feb 2018 11:31:46 +0100
From: Borislav Petkov <bp@suse.de>
To: Xie XiuQi <xiexiuqi@huawei.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com,
        mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com,
        Dave.Martin@arm.com, takahiro.akashi@linaro.org,
        tbaicar@codeaurora.org, stephen.boyd@linaro.org,
        julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com,
        zhengqiang10@huawei.com, gengdongjiu@huawei.com,
        huawei.libin@huawei.com, wangkefeng.wang@huawei.com,
        lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org,
        cj.chengjian@huawei.com
Subject: Re: [PATCH v5 2/3] GHES: add a notify chain for process memory
 section
Message-ID: <20180207103145.GC8944@pd.tnic>
References: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com>
 <1516969885-150532-3-git-send-email-xiexiuqi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1516969885-150532-3-git-send-email-xiexiuqi@huawei.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 08:31:24PM +0800, Xie XiuQi wrote:
> Add a notify chain for process memory section, with
> which other modules might do error recovery.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
> ---
>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>  include/acpi/ghes.h      |  8 ++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index cff671d..1f0ebfb 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -109,6 +109,9 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>  static LIST_HEAD(ghes_hed);
>  static DEFINE_MUTEX(ghes_list_mutex);
>  
> +ATOMIC_NOTIFIER_HEAD(ghes_mem_err_chain);
> +EXPORT_SYMBOL(ghes_mem_err_chain);

Definitely not EXPORT_SYMBOL.

And certainly not export the notifier head. Have register and unregister
functions instead.

That is, *if* you can't solve it differently with James. Notifiers
should be avoided if possible.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
