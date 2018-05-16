Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeEPIZH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:25:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:29934 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752992AbeEPIZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:25:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="gz'50?scan'50,208,50";a="41661410"
Date: Wed, 16 May 2018 16:24:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Florian Schmaus <flo@geekplace.eu>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] driver-core: print bus registration error value
Message-ID: <201805161459.eBiS9YuC%fengguang.wu@intel.com>
References: <20180515135114.31939-4-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20180515135114.31939-4-flo@geekplace.eu>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on v4.17-rc5 next-20180515]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Florian-Schmaus/return-EINVAL-error-instead-of-BUG_ON/20180516-141149
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/base/driver.c: In function 'driver_register':
>> drivers/base/driver.c:154:28: error: 'struct bus_type' has no member named 'bus_register_retval'; did you mean 'bus_register_error'?
          drv->name, drv->bus->bus_register_retval);
                               ^~~~~~~~~~~~~~~~~~~
                               bus_register_error

vim +154 drivers/base/driver.c

   137	
   138	/**
   139	 * driver_register - register driver with bus
   140	 * @drv: driver to register
   141	 *
   142	 * We pass off most of the work to the bus_add_driver() call,
   143	 * since most of the things we have to do deal with the bus
   144	 * structures.
   145	 */
   146	int driver_register(struct device_driver *drv)
   147	{
   148		int ret;
   149		struct device_driver *other;
   150	
   151		if (!drv->bus->p) {
   152			printk(KERN_ERR "Driver '%s' was unable to register bus_type "
   153				   "(error: %d)\n",
 > 154				   drv->name, drv->bus->bus_register_retval);
   155			return -EINVAL;
   156		}
   157	
   158		if ((drv->bus->probe && drv->probe) ||
   159		    (drv->bus->remove && drv->remove) ||
   160		    (drv->bus->shutdown && drv->shutdown))
   161			printk(KERN_WARNING "Driver '%s' needs updating - please use "
   162				"bus_type methods\n", drv->name);
   163	
   164		other = driver_find(drv->name, drv->bus);
   165		if (other) {
   166			printk(KERN_ERR "Error: Driver '%s' is already registered, "
   167				"aborting...\n", drv->name);
   168			return -EBUSY;
   169		}
   170	
   171		ret = bus_add_driver(drv);
   172		if (ret)
   173			return ret;
   174		ret = driver_add_groups(drv, drv->groups);
   175		if (ret) {
   176			bus_remove_driver(drv);
   177			return ret;
   178		}
   179		kobject_uevent(&drv->p->kobj, KOBJ_ADD);
   180	
   181		return ret;
   182	}
   183	EXPORT_SYMBOL_GPL(driver_register);
   184	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Q68bSM7Ycu6FN28Q--
