Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A7C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E758E208D6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 11:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E758E208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeHZOxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 10:53:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:34783 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbeHZOxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 10:53:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2018 04:10:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,290,1531810800"; 
   d="scan'208";a="75703229"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Aug 2018 04:10:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ftsw9-0001O5-FB; Sun, 26 Aug 2018 19:10:29 +0800
Date:   Sun, 26 Aug 2018 17:00:46 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     kbuild-all@01.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] Bluetooth: bt3c_cs: Fix obsolete function
Message-ID: <201808261649.k4zGe5cR%fengguang.wu@intel.com>
References: <1535107465-5470-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535107465-5470-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ding,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v4.18 next-20180824]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ding-Xiang/Bluetooth-bt3c_cs-Fix-obsolete-function/20180824-184743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/bluetooth/bt3c_cs.c:510:54: sparse: incorrect type in argument 3 (different type sizes) @@    expected unsigned long *res @@    got nsigned long *res @@
   drivers/bluetooth/bt3c_cs.c:510:54:    expected unsigned long *res
   drivers/bluetooth/bt3c_cs.c:510:54:    got unsigned int *<noident>
   drivers/bluetooth/bt3c_cs.c: In function 'bt3c_load_firmware':
   drivers/bluetooth/bt3c_cs.c:510:25: error: passing argument 3 of 'kstrtoul' from incompatible pointer type [-Werror=incompatible-pointer-types]
        if (kstrtoul(b, 16, &tmp))
                            ^
   In file included from include/linux/list.h:9:0,
                    from include/linux/module.h:9,
                    from drivers/bluetooth/bt3c_cs.c:24:
   include/linux/kernel.h:333:32: note: expected 'long unsigned int *' but argument is of type 'unsigned int *'
    static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
                                   ^~~~~~~~
   cc1: some warnings being treated as errors

vim +510 drivers/bluetooth/bt3c_cs.c

   443	
   444	
   445	static int bt3c_load_firmware(struct bt3c_info *info,
   446				      const unsigned char *firmware,
   447				      int count)
   448	{
   449		char *ptr = (char *) firmware;
   450		char b[9];
   451		unsigned int iobase, tmp;
   452		unsigned long size, addr, fcs, tn;
   453		int i, err = 0;
   454	
   455		iobase = info->p_dev->resource[0]->start;
   456	
   457		/* Reset */
   458		bt3c_io_write(iobase, 0x8040, 0x0404);
   459		bt3c_io_write(iobase, 0x8040, 0x0400);
   460	
   461		udelay(1);
   462	
   463		bt3c_io_write(iobase, 0x8040, 0x0404);
   464	
   465		udelay(17);
   466	
   467		/* Load */
   468		while (count) {
   469			if (ptr[0] != 'S') {
   470				BT_ERR("Bad address in firmware");
   471				err = -EFAULT;
   472				goto error;
   473			}
   474	
   475			memset(b, 0, sizeof(b));
   476			memcpy(b, ptr + 2, 2);
   477			if (kstrtoul(b, 16, &size) < 0)
   478				return -EINVAL;
   479	
   480			memset(b, 0, sizeof(b));
   481			memcpy(b, ptr + 4, 8);
   482			if (kstrtoul(b, 16, &addr) < 0)
   483				return -EINVAL;
   484	
   485			memset(b, 0, sizeof(b));
   486			memcpy(b, ptr + (size * 2) + 2, 2);
   487			if (kstrtoul(b, 16, &fcs) < 0)
   488				return -EINVAL;
   489	
   490			memset(b, 0, sizeof(b));
   491			for (tmp = 0, i = 0; i < size; i++) {
   492				memcpy(b, ptr + (i * 2) + 2, 2);
   493				if (kstrtoul(b, 16, &tn))
   494					return -EINVAL;
   495				tmp += tn;
   496			}
   497	
   498			if (((tmp + fcs) & 0xff) != 0xff) {
   499				BT_ERR("Checksum error in firmware");
   500				err = -EILSEQ;
   501				goto error;
   502			}
   503	
   504			if (ptr[1] == '3') {
   505				bt3c_address(iobase, addr);
   506	
   507				memset(b, 0, sizeof(b));
   508				for (i = 0; i < (size - 4) / 2; i++) {
   509					memcpy(b, ptr + (i * 4) + 12, 4);
 > 510					if (kstrtoul(b, 16, &tmp))
   511						return -EINVAL;
   512					bt3c_put(iobase, tmp);
   513				}
   514			}
   515	
   516			ptr   += (size * 2) + 6;
   517			count -= (size * 2) + 6;
   518		}
   519	
   520		udelay(17);
   521	
   522		/* Boot */
   523		bt3c_address(iobase, 0x3000);
   524		outb(inb(iobase + CONTROL) | 0x40, iobase + CONTROL);
   525	
   526	error:
   527		udelay(17);
   528	
   529		/* Clear */
   530		bt3c_io_write(iobase, 0x7006, 0x0000);
   531		bt3c_io_write(iobase, 0x7005, 0x0000);
   532		bt3c_io_write(iobase, 0x7001, 0x0000);
   533	
   534		return err;
   535	}
   536	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
