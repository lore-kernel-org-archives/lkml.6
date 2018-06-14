Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0302C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEDB208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEDB208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964826AbeFNN7R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:59:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755127AbeFNN7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:59:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE3B3401EF14;
        Thu, 14 Jun 2018 13:59:15 +0000 (UTC)
Received: from 192.168.1.112 (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A8AB41C702;
        Thu, 14 Jun 2018 13:59:10 +0000 (UTC)
Subject: Re: [PATCH 2/2 V2] Support kdump when AMD secure memory encryption is
 active
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, thomas.lendacky@amd.com,
        dyoung@redhat.com
References: <20180614084748.9617-3-lijiang@redhat.com>
 <201806142024.WDGkcZ5I%fengguang.wu@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <21035093-9194-e02d-2596-e158aa6dc3fd@redhat.com>
Date:   Thu, 14 Jun 2018 21:59:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <201806142024.WDGkcZ5I%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 13:59:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 14 Jun 2018 13:59:15 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lijiang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年06月14日 20:55, kbuild test robot 写道:
> Hi Lianbo,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.17 next-20180614]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Lianbo-Jiang/Support-kdump-for-AMD-secure-memory-encryption-sme/20180614-164938
> config: i386-randconfig-c0-06141337 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/proc/vmcore.o: In function `read_from_oldmem':
>>> fs/proc/vmcore.c:127: undefined reference to `copy_oldmem_page_encrypted'
> 
It is strange, it doesn't have this error in my test. I will look for another environment to test
and see whether it can be reproduced.
Maybe the compile error will be fixed in the patch V3.

Thanks.
Lianbo 
> vim +127 fs/proc/vmcore.c
> 
>    100	
>    101	/* Reads a page from the oldmem device from given offset. */
>    102	static ssize_t read_from_oldmem(char *buf, size_t count,
>    103					u64 *ppos, int userbuf,
>    104					bool encrypted)
>    105	{
>    106		unsigned long pfn, offset;
>    107		size_t nr_bytes;
>    108		ssize_t read = 0, tmp;
>    109	
>    110		if (!count)
>    111			return 0;
>    112	
>    113		offset = (unsigned long)(*ppos % PAGE_SIZE);
>    114		pfn = (unsigned long)(*ppos / PAGE_SIZE);
>    115	
>    116		do {
>    117			if (count > (PAGE_SIZE - offset))
>    118				nr_bytes = PAGE_SIZE - offset;
>    119			else
>    120				nr_bytes = count;
>    121	
>    122			/* If pfn is not ram, return zeros for sparse dump files */
>    123			if (pfn_is_ram(pfn) == 0)
>    124				memset(buf, 0, nr_bytes);
>    125			else {
>    126				if (encrypted)
>  > 127					tmp = copy_oldmem_page_encrypted(pfn, buf,
>    128						       nr_bytes, offset, userbuf);
>    129				else
>    130					tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>    131							offset, userbuf);
>    132	
>    133				if (tmp < 0)
>    134					return tmp;
>    135			}
>    136			*ppos += nr_bytes;
>    137			count -= nr_bytes;
>    138			buf += nr_bytes;
>    139			read += nr_bytes;
>    140			++pfn;
>    141			offset = 0;
>    142		} while (count);
>    143	
>    144		return read;
>    145	}
>    146	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
