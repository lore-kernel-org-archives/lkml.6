Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574DBECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4420838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D4420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJYOw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:52:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:33668 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbeJYOw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:52:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 23:20:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="gz'50?scan'50,208,50";a="268621807"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2018 23:20:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gFZ0Y-00040c-Cr; Thu, 25 Oct 2018 14:20:38 +0800
Date:   Thu, 25 Oct 2018 14:19:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: drivers/cdrom/gdrom.c:797:3: error: 'rc' undeclared
Message-ID: <201810251440.SeZ4xMtb%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   01aa9d518eae8a4d75cd3049defc6ed0b6d0a658
commit: ad5fc6bb72214615f300af1f4ed57f71bc3be510 gdrom: convert to blk-mq
date:   9 days ago
config: sh-dreamcast_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ad5fc6bb72214615f300af1f4ed57f71bc3be510
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   drivers/cdrom/gdrom.c: In function 'probe_gdrom':
>> drivers/cdrom/gdrom.c:797:3: error: 'rc' undeclared (first use in this function)
      rc = PTR_ERR(gd.gdrom_rq);
      ^~
   drivers/cdrom/gdrom.c:797:3: note: each undeclared identifier is reported only once for each function it appears in

vim +/rc +797 drivers/cdrom/gdrom.c

   749	
   750	/*
   751	 * register this as a block device and as compliant with the
   752	 * universal CD Rom driver interface
   753	 */
   754	static int probe_gdrom(struct platform_device *devptr)
   755	{
   756		int err;
   757		/* Start the device */
   758		if (gdrom_execute_diagnostic() != 1) {
   759			pr_warning("ATA Probe for GDROM failed\n");
   760			return -ENODEV;
   761		}
   762		/* Print out firmware ID */
   763		if (gdrom_outputversion())
   764			return -ENOMEM;
   765		/* Register GDROM */
   766		gdrom_major = register_blkdev(0, GDROM_DEV_NAME);
   767		if (gdrom_major <= 0)
   768			return gdrom_major;
   769		pr_info("Registered with major number %d\n",
   770			gdrom_major);
   771		/* Specify basic properties of drive */
   772		gd.cd_info = kzalloc(sizeof(struct cdrom_device_info), GFP_KERNEL);
   773		if (!gd.cd_info) {
   774			err = -ENOMEM;
   775			goto probe_fail_no_mem;
   776		}
   777		probe_gdrom_setupcd();
   778		gd.disk = alloc_disk(1);
   779		if (!gd.disk) {
   780			err = -ENODEV;
   781			goto probe_fail_no_disk;
   782		}
   783		probe_gdrom_setupdisk();
   784		if (register_cdrom(gd.cd_info)) {
   785			err = -ENODEV;
   786			goto probe_fail_cdrom_register;
   787		}
   788		gd.disk->fops = &gdrom_bdops;
   789		/* latch on to the interrupt */
   790		err = gdrom_set_interrupt_handlers();
   791		if (err)
   792			goto probe_fail_cmdirq_register;
   793	
   794		gd.gdrom_rq = blk_mq_init_sq_queue(&gd.tag_set, &gdrom_mq_ops, 1,
   795					BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_BLOCKING);
   796		if (IS_ERR(gd.gdrom_rq)) {
 > 797			rc = PTR_ERR(gd.gdrom_rq);
   798			gd.gdrom_rq = NULL;
   799			goto probe_fail_requestq;
   800		}
   801	
   802		blk_queue_bounce_limit(gd.gdrom_rq, BLK_BOUNCE_HIGH);
   803	
   804		err = probe_gdrom_setupqueue();
   805		if (err)
   806			goto probe_fail_toc;
   807	
   808		gd.toc = kzalloc(sizeof(struct gdromtoc), GFP_KERNEL);
   809		if (!gd.toc) {
   810			err = -ENOMEM;
   811			goto probe_fail_toc;
   812		}
   813		add_disk(gd.disk);
   814		return 0;
   815	
   816	probe_fail_toc:
   817		blk_cleanup_queue(gd.gdrom_rq);
   818		blk_mq_free_tag_set(&gd.tag_set);
   819	probe_fail_requestq:
   820		free_irq(HW_EVENT_GDROM_DMA, &gd);
   821		free_irq(HW_EVENT_GDROM_CMD, &gd);
   822	probe_fail_cmdirq_register:
   823	probe_fail_cdrom_register:
   824		del_gendisk(gd.disk);
   825	probe_fail_no_disk:
   826		kfree(gd.cd_info);
   827	probe_fail_no_mem:
   828		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
   829		gdrom_major = 0;
   830		pr_warning("Probe failed - error is 0x%X\n", err);
   831		return err;
   832	}
   833	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
8vuaEaoAAA==

--IS0zKkzwUGydFO0o--
