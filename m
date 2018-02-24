Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeBXWZG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 17:25:06 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37513 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbeBXWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 17:25:04 -0500
X-Google-Smtp-Source: AG47ELvFmOTkeNhgUA/+9mfZOWxN+Yyr8/pLHFCMXUHK5qYN2HKgtwAoHyp5F2DJRIHm9+QO+M17hg==
Subject: Re: [PATCH] scsi: lpfc: use memcpy_toio instead of writeq
To: Arnd Bergmann <arnd@arndb.de>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180223153700.2186058-1-arnd@arndb.de>
 <CAK8P3a1--4o7piRf1VEr_cTUaE09ATnWoJfezrg=eqFzM64RoA@mail.gmail.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <36e88521-f064-895e-de46-45236e43a8d4@broadcom.com>
Date: Sat, 24 Feb 2018 14:24:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1--4o7piRf1VEr_cTUaE09ATnWoJfezrg=eqFzM64RoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

About to post a patch to fix. Rather than fidgeting with the copy 
routine, I want to go back to what we originally proposed - writeq() on 
64bit, writel() on 32-bit.

-- james


On 2/23/2018 1:02 PM, Arnd Bergmann wrote:
> On Fri, Feb 23, 2018 at 4:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> @@ -138,12 +137,10 @@ lpfc_sli4_wq_put(struct lpfc_queue *q, union lpfc_wqe *wqe)
>>          if (q->phba->sli3_options & LPFC_SLI4_PHWQ_ENABLED)
>>                  bf_set(wqe_wqid, &wqe->generic.wqe_com, q->queue_id);
>>          lpfc_sli_pcimem_bcopy(wqe, temp_wqe, q->entry_size);
>> -       if (q->dpp_enable && q->phba->cfg_enable_dpp) {
>> +       if (q->dpp_enable && q->phba->cfg_enable_dpp)
>>                  /* write to DPP aperture taking advatage of Combined Writes */
>> -               tmp = (uint8_t *)wqe;
>> -               for (i = 0; i < q->entry_size; i += sizeof(uint64_t))
>> -                       writeq(*((uint64_t *)(tmp + i)), q->dpp_regaddr + i);
>> -       }
>> +               memcpy_toio(tmp, q->dpp_regaddr, q->entry_size);
>> +
>>          /* ensure WQE bcopy and DPP flushed before doorbell write */
>>          wmb();
>>
> Not sure where we are with the question of whether memcpy_toio
> is a good replacement or not, but further build testing showed that
> my patch was completely broken in more than one way:
>
> I mixed up the source and destination arguments, and I used
> the uninitialized 'tmp' instead of 'wqe'. Don't try this patch.
>
>         Arnd
