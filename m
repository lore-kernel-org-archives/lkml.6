Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A2DECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37A872150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A872150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJQVAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:00:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:36722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727000AbeJQVAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 14FD1ACC8;
        Wed, 17 Oct 2018 13:04:55 +0000 (UTC)
Subject: Re: [PATCH -next] advansys: remove set but not used variable
 'srb_tag' in adv_isr_callback
To:     Matthew Wilcox <willy@infradead.org>
Cc:     YueHaibing <yuehaibing@huawei.com>, hare@suse.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20181017123432.18304-1-yuehaibing@huawei.com>
 <4950b4fe-61b5-e1c3-9d16-7643107857a5@suse.de>
 <20181017130022.GA3575@bombadil.infradead.org>
From:   Johannes Thumshirn <jthumshirn@suse.de>
Message-ID: <73b10652-5ccf-4760-4aba-9f58600b6da6@suse.de>
Date:   Wed, 17 Oct 2018 15:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181017130022.GA3575@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/18 15:00, Matthew Wilcox wrote:
> On Wed, Oct 17, 2018 at 02:49:50PM +0200, Johannes Thumshirn wrote:
>> On 17/10/18 14:34, YueHaibing wrote:
>>> -	srb_tag = le32_to_cpu(scsiqp->srb_tag);
>>>  	scp = scsi_host_find_tag(boardp->shost, scsiqp->srb_tag);
>>
>> Shouldn't this be:
>> 	scp = scsi_host_find_tag(boardp->shost,
>> 					le32_to_cpu(scsiqp->srb_tag));
> 
> I don't think so.  Look at how scsiqp->srb_tag is set:
> 
>  adv_build_req(struct asc_board *boardp, struct scsi_cmnd *scp,
>               ADV_SCSI_REQ_Q **adv_scsiqpp)
>  {
> +       u32 srb_tag = scp->request->tag;
> ...
> +       scsiqp->srb_tag = srb_tag;
> 
> If we're not converting it to le32 on the way in, we probably don't want
> to convert it back on the way out.

Yeah right, didn't check the submission path. It was just the removed
srb_tag = le32_to_cpu(scsiqp->srb_tag);
that triggered here.

> Please don't make me power up my PA-RISC machine with an Advansys card
> in it, just to find out ...

Now that your saying it...

-- 
Johannes Thumshirn                                        SUSE Labs
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
