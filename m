Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F605C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CF4720869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732538AbfA3R0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:26:53 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48110 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728878AbfA3R0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:26:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TJHNjWk_1548869202;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TJHNjWk_1548869202)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Jan 2019 01:26:46 +0800
To:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     mhocko@suse.com, hannes@cmpxchg.org, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, fengguang.wu@intel.com,
        YangShi <yang.shi@linux.alibaba.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: [LSF/MM TOPIC] Use NVDIMM as NUMA node and NUMA API
Message-ID: <f0d66b0c-c9b6-a040-c485-1606041a70a2@linux.alibaba.com>
Date:   Wed, 30 Jan 2019 09:26:41 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I would like to attend the LSF/MM Summit 2019. I'm interested in most MM 
topics, particularly the NUMA API topic proposed by Jerome since it is 
related to my below proposal.

I would like to share some our usecases, needs and approaches about 
using NVDIMM as a NUMA node.

We would like to provide NVDIMM to our cloud customers as some low cost 
memory.  Virtual machines could run with NVDIMM as backed memory.  Then 
we would like the below needs are met:

     * The ratio of DRAM vs NVDIMM is configurable per process, or even 
per VMA
     * The user VMs alway get DRAM first as long as the ratio is not 
reached
     * Migrate cold data to NVDIMM and keep hot data in DRAM dynamically 
and throughout the life time of VMs

To meet the needs we did some in-house implementation:
     * Provide madvise interface to configure the ratio
     * Put NVDIMM into a separate zonelist so that default allocation 
can't touch it as long as it is requested explicitly
     * A kernel thread scans cold pages

We tried to just use current NUMA APIs, but we realized they can't meet 
our needs.  For example, if we configure a VMA use 50% DRAM and 50% 
NVDIMM, mbind() could set preferred node policy (DRAM node or NVDIMM 
node) for this VMA, but it can't control how much DRAM or NVDIMM is used 
by this specific VMA to satisfy the ratio.

So, IMHO we definitely need more fine-grained APIs to control the NUMA 
behavior.

I'd like also to discuss about this topic with:
     Dave Hansen
     Dan Williams
     Fengguang Wu

Other than the above topic, I'd also like to meet other MM developers to 
discuss about some our usecases about memory cgroup (hallway 
conversation may be good enough).  I had submitted some RFC patches to 
the mailing list and they did incur some discussion, but we have not 
reached solid conclusion yet.

https://lore.kernel.org/lkml/1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com/


Thanks,

Yang

