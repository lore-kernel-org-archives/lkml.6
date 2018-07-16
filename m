Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD5ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC57208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j5tGeAwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC57208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbeGPSeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:34:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55988 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbeGPSeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=54kUDa6rz2aJz1jyjAmCw5/TQB4tldaKfv+NLu0vipU=; b=j5tGeAwWxSyrSYaKBfZmU+5e0m
        zoGmctSnEVEnK6Y5HQSj/Ck/teC6JWsJblyCJuSxB6nU3nTMEF55X//acdUUR+5/OG0S9XN5pC+ya
        2vi2OkcvDM3UBRKVoVnpgbSHuxXJRmDubGO4f+oYW9VEQwqLqQrOhAtpPr1D+qS/EysNwvi3jSpWo
        UtXI1WejKDT0DH+icFEQVJ7seiLAu9+2X+jkM4sIu9cpNgFpLWAol/lx3V+C3VNyCBzB5Q87GqT4t
        ttToCtF6/Jzz5894krqnw7TXC08EKwBqimez6c2bfYzVPKIxfDdVcUMWZUfKcloIzB1SO+d5nwIS1
        gBtnI/Aw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1ff7sI-0003po-FH; Mon, 16 Jul 2018 18:05:30 +0000
Subject: Re: [PATCH 4/4] lib/test_crc: Add test cases for crc calculation
To:     Coly Li <colyli@suse.de>, linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180716165507.23100-1-colyli@suse.de>
 <20180716165507.23100-5-colyli@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02a39b74-918b-a9ab-5023-99c11a8ac832@infradead.org>
Date:   Mon, 16 Jul 2018 11:05:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180716165507.23100-5-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/16/2018 09:55 AM, Coly Li wrote:
> This patch adds a kernel module to test the consistency of multiple crc
> calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.
> 
> The test results are printed into kernel message, which look like,
> 
> test_crc: crc64_le: PASSED (0x4e6b1ff972fa8c55, expval 0x4e6b1ff972fa8c55)
> test_crc: crc64_le_bch: PASSED (0x0e4f1391d7a4a62e, expval 0x0e4f1391d7a4a62e)
> test_crc: crc64_le_update: FAILED (0x03d4d0d85685d9a1, expval 0x3d4d0d85685d9a1f)
> 
> kernel 0day system has framework to check kernel message, then the above
> result can be handled by 0day system. If crc calculation inconsistency
> happens, it can be detected quite soon.
> 
> lib/test_crc.c can is a testing frame work for all crc consistency

            drop ^^^ "can"

Well, we already have (from lib/Makefile):
obj-$(CONFIG_CRC32_SELFTEST)	+= crc32test.o

so lib/test_crc.c isn't exactly "for all crc".


> testings. For now, there are only test caes for 3 crc routines,
> - crc64_le()
> - crc64_le_bch()
> - crc64_le_update()
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> ---
>  lib/Kconfig.debug |  11 ++++
>  lib/Makefile      |   1 +
>  lib/test_crc.c    | 136 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+)
>  create mode 100644 lib/test_crc.c


> diff --git a/lib/test_crc.c b/lib/test_crc.c
> new file mode 100644
> index 000000000000..3a9442252de5
> --- /dev/null
> +++ b/lib/test_crc.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CRC test driver
> + *
> + * Copyright (C) 2018 Coly Li <colyli@suse.de>
> + *
> + * This module provides an simple framework to check the consistency of
> + * Linux kernel crc calculation routines in lib/crc*.c. This driver

                   CRC

> + * requires CONFIG_CRC* items to be enabled if the associated routines are
> + * tested here. The test results will be printed to kernel message
> + * when this test driver is loaded.
> + *
> + * Current test routines are,
> + * - crc64_le()
> + * - crc64_le_bch()
> + * - crc64_le_update()
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/printk.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/async.h>
> +#include <linux/delay.h>
> +#include <linux/vmalloc.h>
> +#include <linux/crc64.h>
> +
> +struct crc_test_record {
> +
> +	char	*name;
> +	__le64	data[4];
> +	__le64	initval;
> +	__le64	expval;
> +	int	(*handler)(struct crc_test_record *rec);
> +};
> +
> +static int chk_and_msg(const char *name, __le64 crc, __le64 expval)
> +{
> +	int ret = 0;
> +
> +	if (crc == expval) {
> +		pr_info("test_crc: %s: PASSED:(0x%016llx, expval 0x%016llx)",
> +			name, crc, expval);
> +	} else {
> +		pr_err("test_crc: %s: FAILED:(0x%016llx, expval 0x%016llx)",
> +			name, crc, expval);

For both pr_err() lines, please print "expected" instead of "expval".

> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Add your crc test caese here */

               CRC test cases

> +static int test_crc64_le(struct crc_test_record *rec)
> +{
> +	__le64 crc;
> +
> +	crc = crc64_le(rec->data, sizeof(rec->data));
> +	return chk_and_msg(rec->name, crc, rec->expval);
> +
> +}
> +
> +static int test_crc64_le_bch(struct crc_test_record *rec)
> +{
> +	__le64 crc;
> +
> +	crc = crc64_le_bch(rec->data, sizeof(rec->data));
> +	return chk_and_msg(rec->name, crc, rec->expval);
> +}
> +
> +static int test_crc64_le_update(struct crc_test_record *rec)
> +{
> +	__le64 crc = rec->initval;
> +
> +	crc = crc64_le_update(crc, rec->data, sizeof(rec->data));
> +	return chk_and_msg(rec->name, crc, rec->expval);
> +}
> +
> +/*
> + * Set up your crc test initial data here.
> + * Do not change the existing items, they are hard coded with
> + * pre-calculated values.
> + */
> +static struct crc_test_record test_data[] = {
> +	{ .name		= "crc64_le",
> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
> +	  .initval	= 0,
> +	  .expval	= 0xe2b9911e7b997201,
> +	  .handler	= test_crc64_le,
> +	},
> +	{ .name		= "crc64_le_bch",
> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
> +	  .initval	= 0,
> +	  .expval	= 0xd2753a20fd862892,
> +	  .handler	= test_crc64_le_bch,
> +	},
> +	{ .name		= "crc64_le_update",
> +	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
> +			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
> +	  .initval	= 0x61C8864680B583EB,
> +	  .expval	= 0xb2c863673f4292bf,
> +	  .handler	= test_crc64_le_update,
> +	},
> +	{ .name = NULL, }
> +};
> +
> +
> +static int __init test_crc_init(void)
> +{
> +	int i;
> +	int v, ret = 0;
> +
> +	pr_info("Kernel crc consitency testing:");

	                CRC consistency

> +	for (i = 0; test_data[i].name; i++) {
> +		v = test_data[i].handler(&test_data[i]);
> +		if (v < 0 && ret == 0)
> +			ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +late_initcall(test_crc_init);
> +
> +static void __exit test_crc_exit(void) { }
> +module_exit(test_crc_exit);
> +
> +MODULE_DESCRIPTION("CRC consistency testing driver");
> +MODULE_AUTHOR("Coly Li <colyli@suse.de>");
> +MODULE_LICENSE("GPL");
> 


thanks,
-- 
~Randy
