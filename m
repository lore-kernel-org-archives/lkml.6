Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96214C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EDF2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EDF2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeILWVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:21:15 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46305 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbeILWVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:21:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01429;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T8XO04V_1536772523;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T8XO04V_1536772523)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Sep 2018 01:15:26 +0800
Subject: Re: [RFC v9 PATCH 2/4] mm: mmap: zap pages with read mmap_sem in
 munmap
To:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     ldufour@linux.vnet.ibm.com, vbabka@suse.cz,
        akpm@linux-foundation.org, dave.hansen@intel.com, oleg@redhat.com,
        srikar@linux.vnet.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1536699493-69195-1-git-send-email-yang.shi@linux.alibaba.com>
 <1536699493-69195-3-git-send-email-yang.shi@linux.alibaba.com>
 <20180911211645.GA12159@bombadil.infradead.org>
 <b69d3f7d-e9ba-b95c-45cd-44489950751b@linux.alibaba.com>
 <20180912022921.GA20056@bombadil.infradead.org>
 <20180912091105.GB10951@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <26cf9c0e-51dd-5fcf-e2c9-0b12df1e2061@linux.alibaba.com>
Date:   Wed, 12 Sep 2018 10:15:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180912091105.GB10951@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/18 2:11 AM, Michal Hocko wrote:
> On Tue 11-09-18 19:29:21, Matthew Wilcox wrote:
>> On Tue, Sep 11, 2018 at 04:35:03PM -0700, Yang Shi wrote:
> [...]
>
> I didn't get to read the patch yet.

If you guys think this is the better way I could convert my patches to 
go this way. It is simple to do the conversion.

Thanks,
Yang

>
>>> And, Michal prefers have VM_HUGETLB and VM_PFNMAP handled separately for
>>> safe and bisectable sake, which needs call the regular do_munmap().
>> That can be introduced and then taken out ... indeed, you can split this into
>> many patches, starting with this:
>>
>> +		if (tmp->vm_file)
>> +			downgrade = false;
>>
>> to only allow this optimisation for anonymous mappings at first.
> or add a helper function to check for special cases and make the
> downgrade behavior conditional on it.

