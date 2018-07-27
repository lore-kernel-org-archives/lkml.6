Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE3C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92CC208A6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBiJRrZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92CC208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeG0NRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730632AbeG0NRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:17:08 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D6B208A3;
        Fri, 27 Jul 2018 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532692533;
        bh=7ocUMiZzH1zJvbhgwWqKeCxrGjPmT++HvoktZNrpmfA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mBiJRrZjIeUI1L3ko4N/dMgXIpEcGH4KwB1KTdJWuGo7ySG/56d5XdeBCOS+YeGmv
         L4bqkC5AbbocAR3mxM1VEZGmmS7WOFYFhx9oqum/65VV7M8fCxmy1d+9xEbZ/NKuGp
         G47spuRjBKQJ8Hn+spvOCwZmry19fMjBn8pdYufY=
Subject: Re: [PATCH v4 1/2] f2fs: fix to avoid broken of dnode block list
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180725111621.37564-1-yuchao0@huawei.com>
 <20180727100344.GD16155@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <06ed02ea-aba0-a771-155a-fc000564f6c7@kernel.org>
Date:   Fri, 27 Jul 2018 19:55:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180727100344.GD16155@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/27 18:03, Jaegeuk Kim wrote:
> On 07/25, Chao Yu wrote:
>> f2fs recovery flow is relying on dnode block link list, it means fsynced
>> file recovery depends on previous dnode's persistence in the list, so
>> during fsync() we should wait on all regular inode's dnode writebacked
>> before issuing flush.
>>
>> By this way, we can avoid dnode block list being broken by out-of-order
>> IO submission due to IO scheduler or driver.
>>
>> Sheng Yong helps to do the test with this patch:
>>
>> Target:/data (f2fs, -)
>> 64MB / 32768KB / 4KB / 8
>>
>> 1 / PERSIST / Index
>>
>> Base:
>> 	SEQ-RD(MB/s)	SEQ-WR(MB/s)	RND-RD(IOPS)	RND-WR(IOPS)	Insert(TPS)	Update(TPS)	Delete(TPS)
>> 1	867.82		204.15		41440.03	41370.54	680.8		1025.94		1031.08
>> 2	871.87		205.87		41370.3		40275.2		791.14		1065.84		1101.7
>> 3	866.52		205.69		41795.67	40596.16	694.69		1037.16		1031.48
>> Avg	868.7366667	205.2366667	41535.33333	40747.3		722.21		1042.98		1054.753333
> 
> I merged it tho, do you know why SEQ-RD is much better?

I have no idea about what happened, this patch should only affect write path.
Let me and Sheng do one more round test to check the result.

> 
>> +void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&sbi->fsync_node_lock, flags);
>> +	sbi->fsync_node_num = 0;

I reviewed the patch again, and found that here it needs to update the code to
sbi->fsync_seg_id = 0; Let me send v5.

Thanks,
