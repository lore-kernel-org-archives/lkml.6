Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC26C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6B222395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6B222395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeHJAlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:41:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:52794 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbeHJAlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:41:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 15:14:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,217,1531810800"; 
   d="scan'208";a="247597370"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 09 Aug 2018 15:14:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fntC3-0001fV-A4; Fri, 10 Aug 2018 06:14:07 +0800
Date:   Fri, 10 Aug 2018 06:13:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Samuel Holland <samuel@sholland.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Subject: Re: [PATCH v2 2/2] firmware: coreboot: Collapse platform drivers
 into bus core
Message-ID: <201808100649.mgka0SgL%fengguang.wu@intel.com>
References: <20180808172414.29983-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808172414.29983-3-swboyd@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc8 next-20180809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stephen-Boyd/firmware-coreboot-Fix-probe-and-simplify-code/20180810-015624
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/firmware/google/coreboot_table.c:113:22: sparse: cast removes address space of expression
   drivers/firmware/google/coreboot_table.c:115:39: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got noderef] <asn:2>*addr @@
   drivers/firmware/google/coreboot_table.c:115:39:    expected void const volatile [noderef] <asn:2>*addr
   drivers/firmware/google/coreboot_table.c:115:39:    got void *[assigned] ptr_entry
   drivers/firmware/google/coreboot_table.c:127:47: sparse: incorrect type in argument 2 (different address spaces) @@    expected void const volatile [noderef] <asn:2>*addr @@    got noderef] <asn:2>*addr @@
   drivers/firmware/google/coreboot_table.c:127:47:    expected void const volatile [noderef] <asn:2>*addr
   drivers/firmware/google/coreboot_table.c:127:47:    got void *[assigned] ptr_entry
>> drivers/firmware/google/coreboot_table.c:163:29: sparse: dereference of noderef expression
   drivers/firmware/google/coreboot_table.c:163:52: sparse: dereference of noderef expression

vim +163 drivers/firmware/google/coreboot_table.c

    96	
    97	static int coreboot_table_init(struct device *dev, void __iomem *ptr)
    98	{
    99		int i, ret;
   100		void *ptr_entry;
   101		struct coreboot_device *device;
   102		struct coreboot_table_entry entry;
   103		struct coreboot_table_header header;
   104	
   105		ptr_header = ptr;
   106		memcpy_fromio(&header, ptr_header, sizeof(header));
   107	
   108		if (strncmp(header.signature, "LBIO", sizeof(header.signature))) {
   109			pr_warn("coreboot_table: coreboot table missing or corrupt!\n");
   110			return -ENODEV;
   111		}
   112	
 > 113		ptr_entry = (void *)ptr_header + header.header_bytes;
   114		for (i = 0; i < header.table_entries; i++) {
   115			memcpy_fromio(&entry, ptr_entry, sizeof(entry));
   116	
   117			device = kzalloc(sizeof(struct device) + entry.size, GFP_KERNEL);
   118			if (!device) {
   119				ret = -ENOMEM;
   120				break;
   121			}
   122	
   123			dev_set_name(&device->dev, "coreboot%d", i);
   124			device->dev.parent = dev;
   125			device->dev.bus = &coreboot_bus_type;
   126			device->dev.release = coreboot_device_release;
   127			memcpy_fromio(&device->entry, ptr_entry, entry.size);
   128	
   129			ret = device_register(&device->dev);
   130			if (ret) {
   131				put_device(&device->dev);
   132				break;
   133			}
   134	
   135			ptr_entry += entry.size;
   136		}
   137	
   138		return ret;
   139	}
   140	
   141	static int coreboot_table_probe(struct platform_device *pdev)
   142	{
   143		phys_addr_t phyaddr;
   144		resource_size_t len;
   145		struct coreboot_table_header __iomem *header = NULL;
   146		struct resource *res;
   147		void __iomem *ptr = NULL;
   148	
   149		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   150		if (!res)
   151			return -EINVAL;
   152	
   153		len = resource_size(res);
   154		if (!res->start || !len)
   155			return -EINVAL;
   156	
   157		phyaddr = res->start;
   158		header = ioremap_cache(phyaddr, sizeof(*header));
   159		if (header == NULL)
   160			return -ENOMEM;
   161	
   162		ptr = ioremap_cache(phyaddr,
 > 163				    header->header_bytes + header->table_bytes);
   164		iounmap(header);
   165		if (!ptr)
   166			return -ENOMEM;
   167	
   168		return coreboot_table_init(&pdev->dev, ptr);
   169	}
   170	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
