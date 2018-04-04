Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDDMjG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:39:06 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:52600 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDDMjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:39:05 -0400
X-Google-Smtp-Source: AIpwx4+ForMQ5hQpKjkNQxWKpn1YuNbEAwqRxthB6/qfb6w12NT2Y0inaeOpfFTui5y8O57wS3vsDA==
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
To: Baegjae Sung <baegjae@gmail.com>, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180327043851.6640-1-baegjae@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6a9c0385-7055-13da-fc5b-f7b7c41cd3eb@grimberg.me>
Date: Wed, 4 Apr 2018 15:39:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327043851.6640-1-baegjae@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -85,7 +121,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
>   	int srcu_idx;
>   
>   	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	switch (head->mpath_policy) {
> +	case NVME_MPATH_ROUND_ROBIN:
> +		ns = nvme_find_path_rr(head);
> +		break;
> +	case NVME_MPATH_ACTIVE_STANDBY:
> +	default:
> +		ns = nvme_find_path(head);
> +	}

If we grow multiple path selectors, would be more elegant to
use a callout mechanism.
