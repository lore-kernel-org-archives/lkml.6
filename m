Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeDDEea (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 00:34:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:28462 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750747AbeDDEe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 00:34:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,404,1517904000";
   d="scan'208";a="44721769"
Date: Wed, 4 Apr 2018 12:34:08 +0800
From: kbuild test robot <lkp@intel.com>
To: Paolo Pisati <p.pisati@gmail.com>
Cc: kbuild-all@01.org, Alan Tull <atull@kernel.org>,
        Moritz Fischer <mdf@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/2] fpga: lattice machxo2: Add Lattice MachXO2
 support
Message-ID: <201804041222.0xEsTote%fengguang.wu@intel.com>
References: <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522782152-27300-3-git-send-email-p.pisati@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16 next-20180403]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paolo-Pisati/dt-bindings-fpga-add-lattice-machxo2-slave-spi-binding-description/20180404-055540
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
>> drivers/fpga/machxo2-spi.c:86:19: sparse: cast to restricted __be32
   drivers/fpga/machxo2-spi.c:369:12: sparse: no member 'parent' in struct fpga_manager
>> drivers/fpga/machxo2-spi.c:375:33: sparse: not enough arguments for function fpga_mgr_register
>> drivers/fpga/machxo2-spi.c:382:29: sparse: incorrect type in argument 1 (different base types) @@    expected struct device *dev @@    got structstruct device *dev @@
>> drivers/fpga/machxo2-spi.c:369:12: sparse: generating address of non-lvalue (8)
   drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_probe':
   drivers/fpga/machxo2-spi.c:369:5: error: 'struct fpga_manager' has no member named 'parent'
     mgr->parent = dev;
        ^~
   drivers/fpga/machxo2-spi.c:375:27: error: passing argument 1 of 'fpga_mgr_register' from incompatible pointer type [-Werror=incompatible-pointer-types]
     return fpga_mgr_register(mgr);
                              ^~~
   In file included from drivers/fpga/machxo2-spi.c:12:0:
   include/linux/fpga/fpga-mgr.h:173:5: note: expected 'struct device *' but argument is of type 'struct fpga_manager *'
    int fpga_mgr_register(struct device *dev, const char *name,
        ^~~~~~~~~~~~~~~~~
   drivers/fpga/machxo2-spi.c:375:9: error: too few arguments to function 'fpga_mgr_register'
     return fpga_mgr_register(mgr);
            ^~~~~~~~~~~~~~~~~
   In file included from drivers/fpga/machxo2-spi.c:12:0:
   include/linux/fpga/fpga-mgr.h:173:5: note: declared here
    int fpga_mgr_register(struct device *dev, const char *name,
        ^~~~~~~~~~~~~~~~~
   drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_remove':
   drivers/fpga/machxo2-spi.c:382:22: error: passing argument 1 of 'fpga_mgr_unregister' from incompatible pointer type [-Werror=incompatible-pointer-types]
     fpga_mgr_unregister(mgr);
                         ^~~
   In file included from drivers/fpga/machxo2-spi.c:12:0:
   include/linux/fpga/fpga-mgr.h:176:6: note: expected 'struct device *' but argument is of type 'struct fpga_manager *'
    void fpga_mgr_unregister(struct device *dev);
         ^~~~~~~~~~~~~~~~~~~
   drivers/fpga/machxo2-spi.c: In function 'machxo2_spi_probe':
   drivers/fpga/machxo2-spi.c:376:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors

vim +86 drivers/fpga/machxo2-spi.c

    65	
    66	static int get_status(struct spi_device *spi, unsigned long *status)
    67	{
    68		struct spi_message msg;
    69		struct spi_transfer rx, tx;
    70		static const u8 cmd[] = LSC_READ_STATUS;
    71		int ret;
    72	
    73		memset(&rx, 0, sizeof(rx));
    74		memset(&tx, 0, sizeof(tx));
    75		tx.tx_buf = cmd;
    76		tx.len = sizeof(cmd);
    77		rx.rx_buf = status;
    78		rx.len = 4;
    79		spi_message_init(&msg);
    80		spi_message_add_tail(&tx, &msg);
    81		spi_message_add_tail(&rx, &msg);
    82		ret = spi_sync(spi, &msg);
    83		if (ret)
    84			return ret;
    85	
  > 86		*status = be32_to_cpu(*status);
    87	
    88		return 0;
    89	}
    90	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
