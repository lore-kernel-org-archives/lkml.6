Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98B5ECE568
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1512087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 20:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="okLMIFFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F1512087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeIYC7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 22:59:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51421 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeIYC7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 22:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1537822511; x=1569358511;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7HoNZHAIVceRRl8V9absbQdxVJL1GpmgDBfkNWWq6Fc=;
  b=okLMIFFaPP3IG8m6FC5j913N/TM/MYFZqWYwXk/u+i8NEZKakW42k7tM
   6gzdX4ZvQEOKxgzLs+arSVChuHuD+lqgTnrL9AZp7qo6sajRFk8ohfluA
   LosZJKv8E02lrU+KoEIvx3R0y+g8F2Zkec/qSBnwnohZlPVni0GTwTr/B
   2LOWYkYDQhCcR7m7duQ3KnwnXw2lXQCeq1dYayBJby6EV48YPGYUzApiA
   tD90pPUCZ2/lVX4myPBTDx9MYiSOcQ8JtZ3ruD7rRjInMtPbNEHGNjs07
   8ViUVG60T6cFGSE61gZziZacOewMFFtqJ4j4T5/fKUHlB7IQBHYffaj9H
   g==;
X-IronPort-AV: E=Sophos;i="5.54,299,1534780800"; 
   d="scan'208";a="188061111"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2018 04:55:11 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 24 Sep 2018 13:41:01 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Sep 2018 13:55:05 -0700
Subject: Re: [PATCH] RISCV: Fix end PFN for low memory
To:     "palmer@sifive.com" <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "terpstra@sifive.com" <terpstra@sifive.com>
References: <1536690618-9157-1-git-send-email-atish.patra@wdc.com>
 <20180917140816.GA28689@infradead.org>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <50f35396-9e2b-c177-6a96-9c450c7abdde@wdc.com>
Date:   Mon, 24 Sep 2018 13:55:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917140816.GA28689@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/18 7:08 AM, Christoph Hellwig wrote:
> On Tue, Sep 11, 2018 at 11:30:18AM -0700, Atish Patra wrote:
>> Use memblock_end_of_DRAM which provides correct last low memory
>> PFN. Without that, DMA32 region becomes empty resulting in zero
>> pages being allocated for DMA32.
>>
>> This patch is based on earlier patch from palmer which never
>> merged into 4.19. I just edited the commit text to make more
>> sense.
> 
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Palmer, can you queue this up for 4.19?
> 
Hi Palmer,
I did not see this one pulled into your rc6 PR.
Not sure if it was intentional or just lost in heap of emails.


Regards,
Atish
