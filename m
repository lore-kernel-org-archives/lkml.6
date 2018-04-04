Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751807AbeDDIyR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:54:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43991 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751735AbeDDIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:54:15 -0400
Subject: Re: [PATCH] lib: logic_pio: Fix potential NULL pointer dereference
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180403211505.GA29612@embeddedor.com>
CC: <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddeodr.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <c5cc072b-88cb-979c-3645-9b59319dd511@huawei.com>
Date: Wed, 4 Apr 2018 09:54:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180403211505.GA29612@embeddedor.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 22:15, Gustavo A. R. Silva wrote:
> new_range is being dereferenced before it is null checked, hence
> there is a potential null pointer dereference.
>
> Fix this by moving the pointer dereference after new_range has
> been properly null checked.
>

Hi Gustavo,

In fact we expect new_range to never be NULL. But, if we're going to 
check, then better make sure the check is correct...

Thanks,
John

> Addresses-Coverity-ID: 1466163 ("Dereference before null check")
> Fixes: 0a7198426259 ("lib: Add generic PIO mapping method")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>  lib/logic_pio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index 29cedea..30dfdce 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -33,8 +33,8 @@ static DEFINE_MUTEX(io_range_mutex);
>  int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  {
>  	struct logic_pio_hwaddr *range;
> -	resource_size_t start = new_range->hw_start;
> -	resource_size_t end = new_range->hw_start + new_range->size;
> +	resource_size_t start;
> +	resource_size_t end;
>  	resource_size_t mmio_sz = 0;
>  	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
>  	int ret = 0;
> @@ -42,6 +42,9 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	if (!new_range || !new_range->fwnode || !new_range->size)
>  		return -EINVAL;
>
> +	start = new_range->hw_start;
> +	end = new_range->hw_start + new_range->size;
> +
>  	mutex_lock(&io_range_mutex);
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>  		if (range->fwnode == new_range->fwnode) {
>
