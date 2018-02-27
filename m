Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeB0Emg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 23:42:36 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33094 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeB0Eme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 23:42:34 -0500
X-Google-Smtp-Source: AG47ELsaASWa/a21ogvrCTnQaRGwR+A0/JpDO1NQ2v5DRQDlygP94f4mW/F8+SGlq3x3s2YRUNkKSH5M0ZQ/aKPwtdY=
MIME-Version: 1.0
In-Reply-To: <20180226162440.GB10832@localhost.localdomain>
References: <20180226085123.26120-1-baegjae@gmail.com> <20180226162440.GB10832@localhost.localdomain>
From: Baegjae Sung <baegjae@gmail.com>
Date: Tue, 27 Feb 2018 13:42:33 +0900
Message-ID: <CAB2tqttsT7QQCehYz50TWrs5zG7n9wE4=Qc_brw5JqDKwjFvyQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-multipath: fix sysfs dangerously created links
To: Keith Busch <keith.busch@intel.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-27 1:24 GMT+09:00 Keith Busch <keith.busch@intel.com>:
> On Mon, Feb 26, 2018 at 05:51:23PM +0900, baegjae@gmail.com wrote:
>> From: Baegjae Sung <baegjae@gmail.com>
>>
>> If multipathing is enabled, each NVMe subsystem creates a head
>> namespace (e.g., nvme0n1) and multiple private namespaces
>> (e.g., nvme0c0n1 and nvme0c1n1) in sysfs. When creating links for
>> private namespaces, links of head namespace are used, so the
>> namespace creation order must be followed (e.g., nvme0n1 ->
>> nvme0c1n1). If the order is not followed, links of sysfs will be
>> incomplete or kernel panic will occur.
>>
>> The kernel panic was:
>>   kernel BUG at fs/sysfs/symlink.c:27!
>>   Call Trace:
>>     nvme_mpath_add_disk_links+0x5d/0x80 [nvme_core]
>>     nvme_validate_ns+0x5c2/0x850 [nvme_core]
>>     nvme_scan_work+0x1af/0x2d0 [nvme_core]
>>
>> Correct order
>> Context A     Context B
>> nvme0n1
>> nvme0c0n1     nvme0c1n1
>>
>> Incorrect order
>> Context A     Context B
>>               nvme0c1n1
>> nvme0n1
>> nvme0c0n1
>>
>> The function of a head namespace creation is moved to maintain the
>> correct order. We verified the code with or without multipathing
>> using three vendors of dual-port NVMe SSDs.
>>
>> Signed-off-by: Baegjae Sung <baegjae@gmail.com>
>
> Thanks, I see what you mean on the potential ordering problem here.
> Calling nvme_mpath_add_disk, though, before the 'head' has any namespace
> paths available looks like you'll get a lot of 'no path available'
> warnings during the bring-up. It should resolve itself shortly after,
> but the warnings will be a bit alarming, right?

Thanks for reply.
I agree what you concern about temporary 'no path available' warnings.
That was why nvme_mpath_add_disk and nvme_mpath_add_disk_links were
coded together.
I will send you a new patch that reflects your concerns.

>
>> ---
>>  drivers/nvme/host/core.c | 12 +++---------
>>  1 file changed, 3 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 0fe7ea35c221..28777b7352a5 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2844,7 +2844,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>>  }
>>
>>  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>> -             struct nvme_id_ns *id, bool *new)
>> +             struct nvme_id_ns *id)
>>  {
>>       struct nvme_ctrl *ctrl = ns->ctrl;
>>       bool is_shared = id->nmic & (1 << 0);
>> @@ -2860,8 +2860,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>>                       ret = PTR_ERR(head);
>>                       goto out_unlock;
>>               }
>> -
>> -             *new = true;
>> +             nvme_mpath_add_disk(head);
>>       } else {
>>               struct nvme_ns_ids ids;
>>
>> @@ -2873,8 +2872,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>>                       ret = -EINVAL;
>>                       goto out_unlock;
>>               }
>> -
>> -             *new = false;
>>       }
>>
>>       list_add_tail(&ns->siblings, &head->list);
>> @@ -2945,7 +2942,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>       struct nvme_id_ns *id;
>>       char disk_name[DISK_NAME_LEN];
>>       int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
>> -     bool new = true;
>>
>>       ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>>       if (!ns)
>> @@ -2971,7 +2967,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>       if (id->ncap == 0)
>>               goto out_free_id;
>>
>> -     if (nvme_init_ns_head(ns, nsid, id, &new))
>> +     if (nvme_init_ns_head(ns, nsid, id))
>>               goto out_free_id;
>>       nvme_setup_streams_ns(ctrl, ns);
>>
>> @@ -3037,8 +3033,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>               pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
>>                       ns->disk->disk_name);
>>
>> -     if (new)
>> -             nvme_mpath_add_disk(ns->head);
>>       nvme_mpath_add_disk_links(ns);
>>       return;
>>   out_unlink_ns:
>> --
>> 2.16.2
>>
