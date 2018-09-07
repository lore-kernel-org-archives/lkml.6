Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90A3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409662083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 15:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UD2PEPGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409662083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeIGTyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 15:54:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36784 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbeIGTyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 15:54:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so12565748ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NZnfr1AEnZIjJ4bFIXCeG1stAXwQHcU0KRcjALs7tbU=;
        b=UD2PEPGqsjR2FOHDY+JHg5mVbNiFavqSbL8QRCB4G62sOrQ37z3I07/P2S6C3a/696
         82HqbWhcZFTPhUOrc6bPk8Fv6JylI2kRL04BwEDE0vnRn8wfPsUPkvytFil3AnRUPbDa
         suXT7QzcNQJkaiIcDAf6QVRECo+Vgq8fgcxJVMNrFQ97xKORqHTCPmjPcC0qjc+E3Bkz
         KrnVZ4tolOYRtori/8WpEOPlfBiidXI9vgoSB2I9pBY+XbJU2A9uzCjm2zg08UbGHeEW
         vHQBWQLj8x/dCXoYj3sohAxcyxvNE9BYcMJ/01SJpF+KDCz5ITVhfYilL7+1L68YEBYg
         bo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NZnfr1AEnZIjJ4bFIXCeG1stAXwQHcU0KRcjALs7tbU=;
        b=NkyAkF2fHltwQCCV+fm3PHIFmIt+9d0C0ijC4LhmpktqEfSveYORWE+VTGhGTsFznO
         6BwBLyyya/FSH63FDRWRYv7PUTqSbRdpxeCeOXRumyH+vE6NAPrLhHdlSLo2Hoddq5c0
         5VcGURtW5t2gLBTd5rfEy7tOk8vABymmldEQ22sUJzhmbsvW5ol3p9k1HaMIiaWobpjZ
         TS3BJimWt8ETLK2o7Qn0R5H9BdxMxWjEG1vPutH1kGHsOvjpOFrrBdFLVwAbJMNF0wS9
         pYLCFWVLKuYS6LxjV7sq9r8drBGfl7g6tQMQoe4ONjK9tRBS+1u1YWVfnBvgUkbOP9w4
         SCjA==
X-Gm-Message-State: APzg51CUI3Qv/61pfO8EdejBty9AZpSaIahquBIzi10j9Py5kVImfxuJ
        DUGkg9nLJnRCm17BBv2lm1Ebyw==
X-Google-Smtp-Source: ANB0VdYyNhZ1gIFiKFnqxpdJlkR1ph408RUd3KAnSTEo/nBdxKv04blTp2RayFo54t36sGuufZOucw==
X-Received: by 2002:a2e:498:: with SMTP id a24-v6mr5539198ljf.27.1536333162544;
        Fri, 07 Sep 2018 08:12:42 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id o11-v6sm1316547lfl.1.2018.09.07.08.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 08:12:41 -0700 (PDT)
Subject: Re: [PATCH 1/3] lightnvm: use internal allocation for chunk log page
To:     hans.ml.holmberg@owltronix.com, javier@javigon.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
 <1535537370-10729-2-git-send-email-javier@cnexlabs.com>
 <CANr-nt0DBCSux=acwkOohFy4BsG7KgzHKH_KA+OG3Y_h7ee1Qw@mail.gmail.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9ba97821-9bb8-293b-2d97-a3095c207184@lightnvm.io>
Date:   Fri, 7 Sep 2018 17:12:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANr-nt0DBCSux=acwkOohFy4BsG7KgzHKH_KA+OG3Y_h7ee1Qw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:53 PM, Hans Holmberg wrote:
> On Wed, Aug 29, 2018 at 12:10 PM Javier González <javier@javigon.com> wrote:
>>
>> The lightnvm subsystem provides helpers to retrieve chunk metadata,
>> where the target needs to provide a buffer to store the metadata. An
>> implicit assumption is that this buffer is contiguous and can be used to
>> retrieve the data from the device. If the device exposes too many
>> chunks, then kmalloc might fail, thus failing instance creation.
>>
>> This patch removes this assumption by implementing an internal buffer in
>> the lightnvm subsystem to retrieve chunk metadata. Targets can then
>> use virtual memory allocations. Since this is a target API change, adapt
>> pblk accordingly.
>>
>> Signed-off-by: Javier González <javier@cnexlabs.com>
>> ---
>>   drivers/lightnvm/pblk-core.c |  4 ++--
>>   drivers/lightnvm/pblk-init.c |  2 +-
>>   drivers/nvme/host/lightnvm.c | 23 +++++++++++++++--------
>>   3 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
>> index fdcbeb920c9e..a311cc29afd8 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -120,7 +120,7 @@ static void pblk_end_io_erase(struct nvm_rq *rqd)
>>   /*
>>    * Get information for all chunks from the device.
>>    *
>> - * The caller is responsible for freeing the returned structure
>> + * The caller is responsible for freeing (vmalloc) the returned structure
>>    */
>>   struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>>   {
>> @@ -134,7 +134,7 @@ struct nvm_chk_meta *pblk_get_chunk_meta(struct pblk *pblk)
>>          ppa.ppa = 0;
>>
>>          len = geo->all_chunks * sizeof(*meta);
>> -       meta = kzalloc(len, GFP_KERNEL);
>> +       meta = vzalloc(len);
>>          if (!meta)
>>                  return ERR_PTR(-ENOMEM);
>>
>> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
>> index e0db6de137d6..a99854439224 100644
>> --- a/drivers/lightnvm/pblk-init.c
>> +++ b/drivers/lightnvm/pblk-init.c
>> @@ -983,7 +983,7 @@ static int pblk_lines_init(struct pblk *pblk)
>>
>>          pblk_set_provision(pblk, nr_free_chks);
>>
>> -       kfree(chunk_meta);
>> +       vfree(chunk_meta);
>>          return 0;
>>
>>   fail_free_lines:
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index 2c96e7fcdcac..5bfa354c5dd5 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -579,7 +579,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>>          struct nvm_geo *geo = &ndev->geo;
>>          struct nvme_ns *ns = ndev->q->queuedata;
>>          struct nvme_ctrl *ctrl = ns->ctrl;
>> -       struct nvme_nvm_chk_meta *dev_meta = (struct nvme_nvm_chk_meta *)meta;
>> +       struct nvme_nvm_chk_meta *dev_meta, *dev_meta_off;
>>          struct ppa_addr ppa;
>>          size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>>          size_t log_pos, offset, len;
>> @@ -591,6 +591,10 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>>           */
>>          max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
>>
>> +       dev_meta = kmalloc(max_len, GFP_KERNEL);
>> +       if (!dev_meta)
>> +               return -ENOMEM;
> 
> We should free the memory after using it. Pardon the late review, I
> just now discovered the memory leak during testing.

Thanks Hans. No worries, I saw it just when I had ack'ed the patch. 
Would you like me to add your Reviewed-by?

> 
>> +
>>          /* Normalize lba address space to obtain log offset */
>>          ppa.ppa = slba;
>>          ppa = dev_to_generic_addr(ndev, ppa);
>> @@ -604,6 +608,9 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>>          while (left) {
>>                  len = min_t(unsigned int, left, max_len);
>>
>> +               memset(dev_meta, 0, max_len);
>> +               dev_meta_off = dev_meta;
>> +
>>                  ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
>>                                  dev_meta, len, offset);
>>                  if (ret) {
>> @@ -612,15 +619,15 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>>                  }
>>
>>                  for (i = 0; i < len; i += sizeof(struct nvme_nvm_chk_meta)) {
>> -                       meta->state = dev_meta->state;
>> -                       meta->type = dev_meta->type;
>> -                       meta->wi = dev_meta->wi;
>> -                       meta->slba = le64_to_cpu(dev_meta->slba);
>> -                       meta->cnlb = le64_to_cpu(dev_meta->cnlb);
>> -                       meta->wp = le64_to_cpu(dev_meta->wp);
>> +                       meta->state = dev_meta_off->state;
>> +                       meta->type = dev_meta_off->type;
>> +                       meta->wi = dev_meta_off->wi;
>> +                       meta->slba = le64_to_cpu(dev_meta_off->slba);
>> +                       meta->cnlb = le64_to_cpu(dev_meta_off->cnlb);
>> +                       meta->wp = le64_to_cpu(dev_meta_off->wp);
>>
>>                          meta++;
>> -                       dev_meta++;
>> +                       dev_meta_off++;
>>                  }
>>
>>                  offset += len;
>> --
>> 2.7.4
>>

