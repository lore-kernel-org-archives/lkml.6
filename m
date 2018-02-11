Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753254AbeBKLPw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:15:52 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40468 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBKLPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:15:51 -0500
X-Google-Smtp-Source: AH8x226VCuOIriV0V8M4ve+LPCVRMdGXkWtMZT52OGQKmJ39gLYXH5DdgQjY6zavDVES4CyOlbKlvg==
Subject: Re: [PATCH 1/9] nvme: fix the dangerous reference of namespaces list
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c57de825-102e-527d-ab7e-4b2c1120c514@grimberg.me>
Date: Sun, 11 Feb 2018 13:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e810487..bc05bc4 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3092,11 +3092,20 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   					unsigned nsid)
>   {
>   	struct nvme_ns *ns, *next;
> +	LIST_HEAD(rm_list);
>   
> +	mutex_lock(&ctrl->namespaces_mutex);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			nvme_ns_remove(ns);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_init(&ns->list);
> +			list_add_tail(&ns->list, &rm_list);

list_move_tail?
