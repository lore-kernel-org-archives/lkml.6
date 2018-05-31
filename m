Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754067AbeEaISA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:18:00 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33438 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:17:56 -0400
X-Google-Smtp-Source: ADUXVKIhXiE4f3W6PH5BHfokGvGk+Ai0quDZPHQtov1meHDGQA1BxwO47YxuWNi8KfJ6+sizKhkcYw==
Subject: Re: [PATCH 1/3] nvme: provide a way to disable nvme mpath per
 subsystem
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>
Cc: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525125322.15398-2-jthumshirn@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <795f42a6-a6c3-e42d-3215-71b36fb7a0d4@grimberg.me>
Date: Thu, 31 May 2018 11:17:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180525125322.15398-2-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -246,3 +246,27 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	blk_cleanup_queue(head->disk->queue);
>   	put_disk(head->disk);
>   }
> +
> +int nvme_mpath_change_personality(struct nvme_subsystem *subsys)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int ret = 0;
> +
> +restart:
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (!list_empty(&ctrl->namespaces)) {
> +			mutex_unlock(&subsys->lock);
> +			nvme_remove_namespaces(ctrl);

This looks completely broken. Any of these namespaces can have an
active handle on it.
