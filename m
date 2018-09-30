Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A273EC43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B9D7206B8
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9D7206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbeI3JPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeI3JPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEE69307D844;
        Sun, 30 Sep 2018 02:44:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 160646B8EE;
        Sun, 30 Sep 2018 02:44:03 +0000 (UTC)
Subject: Re: [PATCH 4/4 v8] kdump/vmcore: support encrypted old memory with
 SME enabled
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        bp@suse.de, brijesh.singh@amd.com, dyoung@redhat.com,
        bhe@redhat.com, jroedel@suse.de
References: <20180929154333.3116-5-lijiang@redhat.com>
 <201809300241.UwCU2sCA%fengguang.wu@intel.com>
From:   lijiang <lijiang@redhat.com>
Message-ID: <25f7cc00-034f-0b6e-3af0-5a63ad16c05a@redhat.com>
Date:   Sun, 30 Sep 2018 10:43:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <201809300241.UwCU2sCA%fengguang.wu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 30 Sep 2018 02:44:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018年09月30日 02:25, kbuild test robot 写道:
> Hi Lianbo,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on sof-driver-fuweitax/master]
> [also build test ERROR on v4.19-rc5 next-20180928]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Lianbo-Jiang/Support-kdump-for-AMD-secure-memory-encryption-SME/20180930-001539
> base:   https://github.com/fuweitax/linux master
> config: i386-randconfig-x0-09300051 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    fs/proc/vmcore.o: In function `read_from_oldmem':
>>> fs/proc/vmcore.c:115: undefined reference to `copy_oldmem_page_encrypted'
> 
Ok, i will fix this compile error, and post again later.

Thanks.
> vim +115 fs/proc/vmcore.c
> 
>     88	
>     89	/* Reads a page from the oldmem device from given offset. */
>     90	static ssize_t read_from_oldmem(char *buf, size_t count,
>     91					u64 *ppos, int userbuf,
>     92					bool encrypted)
>     93	{
>     94		unsigned long pfn, offset;
>     95		size_t nr_bytes;
>     96		ssize_t read = 0, tmp;
>     97	
>     98		if (!count)
>     99			return 0;
>    100	
>    101		offset = (unsigned long)(*ppos % PAGE_SIZE);
>    102		pfn = (unsigned long)(*ppos / PAGE_SIZE);
>    103	
>    104		do {
>    105			if (count > (PAGE_SIZE - offset))
>    106				nr_bytes = PAGE_SIZE - offset;
>    107			else
>    108				nr_bytes = count;
>    109	
>    110			/* If pfn is not ram, return zeros for sparse dump files */
>    111			if (pfn_is_ram(pfn) == 0)
>    112				memset(buf, 0, nr_bytes);
>    113			else {
>    114				if (encrypted)
>  > 115					tmp = copy_oldmem_page_encrypted(pfn, buf,
>    116									 nr_bytes,
>    117									 offset,
>    118									 userbuf);
>    119				else
>    120					tmp = copy_oldmem_page(pfn, buf, nr_bytes,
>    121							       offset, userbuf);
>    122	
>    123				if (tmp < 0)
>    124					return tmp;
>    125			}
>    126			*ppos += nr_bytes;
>    127			count -= nr_bytes;
>    128			buf += nr_bytes;
>    129			read += nr_bytes;
>    130			++pfn;
>    131			offset = 0;
>    132		} while (count);
>    133	
>    134		return read;
>    135	}
>    136	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
