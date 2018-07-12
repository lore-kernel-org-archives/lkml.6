Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2646ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B444120BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B444120BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbeGLX5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 19:57:35 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54686 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387612AbeGLX5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 19:57:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T4VkHsu_1531439119;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T4VkHsu_1531439119)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 13 Jul 2018 07:45:22 +0800
Subject: Re: [RFC v4 0/3] mm: zap pages with read mmap_sem in munmap for large
 mapping
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>, willy@infradead.org,
        ldufour@linux.vnet.ibm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1531265649-93433-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180711111052.hbyukcwetmjjpij2@kshutemo-mobl1>
 <3d4c69c9-dd2b-30d2-5bf2-d5b108a76758@linux.alibaba.com>
 <20180712080418.GC32648@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f47b5a41-3fb1-ac81-1ead-78e4ac5fae51@linux.alibaba.com>
Date:   Thu, 12 Jul 2018 16:45:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180712080418.GC32648@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/18 1:04 AM, Michal Hocko wrote:
> On Wed 11-07-18 10:04:48, Yang Shi wrote:
> [...]
>> One approach is to save all the vmas on a separate list, then zap_page_range
>> does unmap with this list.
> Just detached unmapped vma chain from mm. You can keep the existing
> vm_next chain and reuse it.

Yes. Other than this, we still need do:

   * Tell zap_page_range not update vm_flags as what I did in v4. Of 
course without VM_DEAD this time

   * Extract pagetable free code then do it after zap_page_range. I 
think I can just cal free_pgd_range() directly.

>

