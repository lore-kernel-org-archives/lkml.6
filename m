Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519A72084A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 03:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519A72084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJ3MH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 08:07:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:61209 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbeJ3MH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 08:07:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 20:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,442,1534834800"; 
   d="gz'50?scan'50,208,50";a="99855833"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Oct 2018 20:15:42 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gHKVJ-0009kW-VH; Tue, 30 Oct 2018 11:15:41 +0800
Date:   Tue, 30 Oct 2018 11:14:44 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Ross Zwisler <zwisler@google.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Ross Zwisler <zwisler@google.com>
Subject: Re: [PATCH 2/2] gsmi: Log event for critical thermal thresholds
Message-ID: <201810301132.DIuNAVYy%fengguang.wu@intel.com>
References: <20181022203218.7007-2-zwisler@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20181022203218.7007-2-zwisler@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Duncan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc-thermal/next]
[also build test ERROR on v4.19]
[cannot apply to next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ross-Zwisler/thermal-Add-notifier-call-chain-for-hot-critical-events/20181023-043806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git next
config: i386-randconfig-k0-10291547 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/firmware/google/gsmi.o: In function `gsmi_exit':
>> drivers/firmware/google/gsmi.c:936: undefined reference to `unregister_thermal_notifier'
   drivers/firmware/google/gsmi.o: In function `gsmi_init':
>> drivers/firmware/google/gsmi.c:909: undefined reference to `register_thermal_notifier'

vim +936 drivers/firmware/google/gsmi.c

   787	
   788	static __init int gsmi_init(void)
   789	{
   790		unsigned long flags;
   791		int ret;
   792	
   793		ret = gsmi_system_valid();
   794		if (ret)
   795			return ret;
   796	
   797		gsmi_dev.smi_cmd = acpi_gbl_FADT.smi_command;
   798	
   799		/* register device */
   800		gsmi_dev.pdev = platform_device_register_full(&gsmi_dev_info);
   801		if (IS_ERR(gsmi_dev.pdev)) {
   802			printk(KERN_ERR "gsmi: unable to register platform device\n");
   803			return PTR_ERR(gsmi_dev.pdev);
   804		}
   805	
   806		/* SMI access needs to be serialized */
   807		spin_lock_init(&gsmi_dev.lock);
   808	
   809		ret = -ENOMEM;
   810		gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
   811						     GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
   812		if (!gsmi_dev.dma_pool)
   813			goto out_err;
   814	
   815		/*
   816		 * pre-allocate buffers because sometimes we are called when
   817		 * this is not feasible: oops, panic, die, mce, etc
   818		 */
   819		gsmi_dev.name_buf = gsmi_buf_alloc();
   820		if (!gsmi_dev.name_buf) {
   821			printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
   822			goto out_err;
   823		}
   824	
   825		gsmi_dev.data_buf = gsmi_buf_alloc();
   826		if (!gsmi_dev.data_buf) {
   827			printk(KERN_ERR "gsmi: failed to allocate data buffer\n");
   828			goto out_err;
   829		}
   830	
   831		gsmi_dev.param_buf = gsmi_buf_alloc();
   832		if (!gsmi_dev.param_buf) {
   833			printk(KERN_ERR "gsmi: failed to allocate param buffer\n");
   834			goto out_err;
   835		}
   836	
   837		/*
   838		 * Determine type of handshake used to serialize the SMI
   839		 * entry. See also gsmi_exec().
   840		 *
   841		 * There's a "behavior" present on some chipsets where writing the
   842		 * SMI trigger register in the southbridge doesn't result in an
   843		 * immediate SMI. Rather, the processor can execute "a few" more
   844		 * instructions before the SMI takes effect. To ensure synchronous
   845		 * behavior, implement a handshake between the kernel driver and the
   846		 * firmware handler to spin until released. This ioctl determines
   847		 * the type of handshake.
   848		 *
   849		 * NONE: The firmware handler does not implement any
   850		 * handshake. Either it doesn't need to, or it's legacy firmware
   851		 * that doesn't know it needs to and never will.
   852		 *
   853		 * CF: The firmware handler will clear the CF in the saved
   854		 * state before returning. The driver may set the CF and test for
   855		 * it to clear before proceeding.
   856		 *
   857		 * SPIN: The firmware handler does not implement any handshake
   858		 * but the driver should spin for a hundred or so microseconds
   859		 * to ensure the SMI has triggered.
   860		 *
   861		 * Finally, the handler will return -ENOSYS if
   862		 * GSMI_CMD_HANDSHAKE_TYPE is unimplemented, which implies
   863		 * HANDSHAKE_NONE.
   864		 */
   865		spin_lock_irqsave(&gsmi_dev.lock, flags);
   866		gsmi_dev.handshake_type = GSMI_HANDSHAKE_SPIN;
   867		gsmi_dev.handshake_type =
   868		    gsmi_exec(GSMI_CALLBACK, GSMI_CMD_HANDSHAKE_TYPE);
   869		if (gsmi_dev.handshake_type == -ENOSYS)
   870			gsmi_dev.handshake_type = GSMI_HANDSHAKE_NONE;
   871		spin_unlock_irqrestore(&gsmi_dev.lock, flags);
   872	
   873		/* Remove and clean up gsmi if the handshake could not complete. */
   874		if (gsmi_dev.handshake_type == -ENXIO) {
   875			printk(KERN_INFO "gsmi version " DRIVER_VERSION
   876			       " failed to load\n");
   877			ret = -ENODEV;
   878			goto out_err;
   879		}
   880	
   881		/* Register in the firmware directory */
   882		ret = -ENOMEM;
   883		gsmi_kobj = kobject_create_and_add("gsmi", firmware_kobj);
   884		if (!gsmi_kobj) {
   885			printk(KERN_INFO "gsmi: Failed to create firmware kobj\n");
   886			goto out_err;
   887		}
   888	
   889		/* Setup eventlog access */
   890		ret = sysfs_create_bin_file(gsmi_kobj, &eventlog_bin_attr);
   891		if (ret) {
   892			printk(KERN_INFO "gsmi: Failed to setup eventlog");
   893			goto out_err;
   894		}
   895	
   896		/* Other attributes */
   897		ret = sysfs_create_files(gsmi_kobj, gsmi_attrs);
   898		if (ret) {
   899			printk(KERN_INFO "gsmi: Failed to add attrs");
   900			goto out_remove_bin_file;
   901		}
   902	
   903		ret = efivars_register(&efivars, &efivar_ops, gsmi_kobj);
   904		if (ret) {
   905			printk(KERN_INFO "gsmi: Failed to register efivars\n");
   906			goto out_remove_sysfs_files;
   907		}
   908	
 > 909		register_thermal_notifier(&gsmi_thermal_notifier);
   910		register_reboot_notifier(&gsmi_reboot_notifier);
   911		register_die_notifier(&gsmi_die_notifier);
   912		atomic_notifier_chain_register(&panic_notifier_list,
   913					       &gsmi_panic_notifier);
   914	
   915		printk(KERN_INFO "gsmi version " DRIVER_VERSION " loaded\n");
   916	
   917		return 0;
   918	
   919	out_remove_sysfs_files:
   920		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
   921	out_remove_bin_file:
   922		sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
   923	out_err:
   924		kobject_put(gsmi_kobj);
   925		gsmi_buf_free(gsmi_dev.param_buf);
   926		gsmi_buf_free(gsmi_dev.data_buf);
   927		gsmi_buf_free(gsmi_dev.name_buf);
   928		dma_pool_destroy(gsmi_dev.dma_pool);
   929		platform_device_unregister(gsmi_dev.pdev);
   930		pr_info("gsmi: failed to load: %d\n", ret);
   931		return ret;
   932	}
   933	
   934	static void __exit gsmi_exit(void)
   935	{
 > 936		unregister_thermal_notifier(&gsmi_thermal_notifier);
   937		unregister_reboot_notifier(&gsmi_reboot_notifier);
   938		unregister_die_notifier(&gsmi_die_notifier);
   939		atomic_notifier_chain_unregister(&panic_notifier_list,
   940						 &gsmi_panic_notifier);
   941		efivars_unregister(&efivars);
   942	
   943		sysfs_remove_files(gsmi_kobj, gsmi_attrs);
   944		sysfs_remove_bin_file(gsmi_kobj, &eventlog_bin_attr);
   945		kobject_put(gsmi_kobj);
   946		gsmi_buf_free(gsmi_dev.param_buf);
   947		gsmi_buf_free(gsmi_dev.data_buf);
   948		gsmi_buf_free(gsmi_dev.name_buf);
   949		dma_pool_destroy(gsmi_dev.dma_pool);
   950		platform_device_unregister(gsmi_dev.pdev);
   951	}
   952	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
WhWcFf4feCIFxW3EAQA=

--YiEDa0DAkWCtVeE4--
