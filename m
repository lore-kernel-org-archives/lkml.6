Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeBKLQG (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 06:16:06 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45782 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbeBKLQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 06:16:05 -0500
X-Google-Smtp-Source: AH8x225yy2jVmgNP7zV5YgDf2ILDD87jxovlFNTJetmgZnMYcixxWzNeBB6T0DhPe2ZjHJGDNpxV/w==
Subject: Re: [PATCH 2/9] nvme: fix the deadlock in nvme_update_formats
To: Jianchao Wang <jianchao.w.wang@oracle.com>, keith.busch@intel.com,
        axboe@fb.com, hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
 <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6cc12ce7-07ca-35ac-0bae-c6d875854504@grimberg.me>
Date: Sun, 11 Feb 2018 13:16:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>   	mutex_lock(&ctrl->namespaces_mutex);
>   	list_for_each_entry(ns, &ctrl->namespaces, list) {
> -		if (ns->disk && nvme_revalidate_disk(ns->disk))
> -			nvme_ns_remove(ns);
> +		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
> +			list_del_init(&ns->list);
> +			list_add_tail(&ns->list, &rm_list);

list_move_tail?
