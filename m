Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF0ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E9920838
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 03:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E9920838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJRLZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 07:25:02 -0400
Received: from mail.windriver.com ([147.11.1.11]:63334 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbeJRLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 07:25:02 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w9I3Q9Fn023280
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 17 Oct 2018 20:26:09 -0700 (PDT)
Received: from [128.224.162.153] (128.224.162.153) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 17 Oct
 2018 20:26:08 -0700
To:     <linux-kernel@vger.kernel.org>, <mm-commits@vger.kernel.org>
From:   "Hongzhi, Song" <hongzhi.song@windriver.com>
Subject: Question about mmap syscall and POSIX standard on mips arch
Message-ID: <e897b11f-1577-9298-7c82-7bbdea56e7e5@windriver.com>
Date:   Thu, 18 Oct 2018 11:26:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [128.224.162.153]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Ltp has a POSIX teatcase about mmap, 24-2.c.

https://github.com/linux-test-project/ltp/blob/e816127e5d8efbff5ae53e9c2292fae22f36838b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-2.c#L94

-----part of code-----

     pa = mmap(addr, len, PROT_READ | PROT_WRITE, MAP_FIXED | 
MAP_SHARED, fd,
0);
     if (pa == MAP_FAILED && errno == ENOMEM) {
         printf("Got ENOMEM: %s\nTest PASSED\n", strerror(errno));
exit(PTS_PASS);
     }

-----end----------------


Under POSIX standard, the expected errno should be ENOMEM

when the specific [addr+len] exceeds the bound of memory.


But mips returns EINVAL.

https://github.com/torvalds/linux/blob/bab5c80b211035739997ebd361a679fa85b39465/arch/mips/mm/mmap.c#L69

-------part of code-------

     if (flags & MAP_FIXED) {
         /* Even MAP_FIXED mappings must reside within TASK_SIZE */
         if (TASK_SIZE - len < addr)
             return -EINVAL;

-------end------------------


So, can we change EINVAL to ENOMEM to follow POSIX standard?


--Hongzhi

