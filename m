Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeEEI7j (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 04:59:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:27479 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbeEEI7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 04:59:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="gz'50?scan'50,208,50";a="221831635"
Date: Sat, 5 May 2018 16:58:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Jane Wan <Jane.Wan@nokia.com>
Cc: kbuild-all@01.org, Boris.Brezillon@bootlin.com,
        miquel.raynal@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, richard@nod.at, marek.vasut@gmail.com,
        yamada.masahiro@socionext.com, prabhakar.kushwaha@nxp.com,
        shawnguo@kernel.org, jagdish.gediya@nxp.com,
        shreeya.patel23498@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ties.bos@nokia.com,
        Jane Wan <Jane.Wan@nokia.com>
Subject: Re: [PATCH v2 2/2] mtd: rawnand: fsl_ifc: use bit-wise majority to
 recover the contents of ONFI parameter
Message-ID: <201805051646.R4HISEmo%fengguang.wu@intel.com>
References: <1525464493-5006-2-git-send-email-Jane.Wan@nokia.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <1525464493-5006-2-git-send-email-Jane.Wan@nokia.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jane,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mtd/nand/next]
[also build test WARNING on v4.17-rc3 next-20180504]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jane-Wan/mtd-rawnand-fsl_ifc-fix-FSL-NAND-driver-to-read-all-ONFI-parameter-pages/20180505-163132
base:   git://git.infradead.org/linux-mtd.git nand/next
config: x86_64-randconfig-x015-201817 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/mtd/nand/raw/nand_base.c: In function 'nand_scan_ident':
>> drivers/mtd/nand/raw/nand_base.c:5247:2: warning: 'p' may be used uninitialized in this function [-Wmaybe-uninitialized]
     kfree(p);
     ^~~~~~~~
   drivers/mtd/nand/raw/nand_base.c:5097:27: note: 'p' was declared here
     struct nand_onfi_params *p;
                              ^

vim +/p +5247 drivers/mtd/nand/raw/nand_base.c

2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5090  
d1e1f4e42 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-08-30  5091  /*
8b6e50c9e drivers/mtd/nand/nand_base.c     Brian Norris     2011-05-25  5092   * Check if the NAND chip is ONFI compliant, returns 1 if it is, 0 otherwise.
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5093   */
29a198a15 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5094  static int nand_flash_detect_onfi(struct nand_chip *chip)
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5095  {
cbe435a18 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5096  	struct mtd_info *mtd = nand_to_mtd(chip);
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5097  	struct nand_onfi_params *p;
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5098  	char id[4];
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5099  	int i, ret, val, pagesize;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5100  	u8 *buf;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5101  
7854d3f74 drivers/mtd/nand/nand_base.c     Brian Norris     2011-06-23  5102  	/* Try ONFI for unknown chip or LP */
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5103  	ret = nand_readid_op(chip, 0x20, id, sizeof(id));
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5104  	if (ret || strncmp(id, "ONFI", 4))
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5105  		return 0;
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5106  
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5107  	/* ONFI chip: allocate a buffer to hold its parameter page */
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5108  	pagesize = sizeof(*p);
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5109  	buf = kzalloc((pagesize * 3), GFP_KERNEL);
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5110  	if (!buf)
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5111  		return -ENOMEM;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5112  
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5113  	ret = nand_read_param_page_op(chip, 0, NULL, 0);
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5114  	if (ret) {
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5115  		ret = 0;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5116  		goto free_onfi_param_page;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5117  	}
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5118  
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5119  	for (i = 0; i < 3; i++) {
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5120  		p = (struct nand_onfi_params *)&buf[i*pagesize];
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5121  		ret = nand_read_data_op(chip, p, pagesize, true);
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5122  		if (ret) {
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5123  			ret = 0;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5124  			goto free_onfi_param_page;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5125  		}
97d90da8a drivers/mtd/nand/nand_base.c     Boris Brezillon  2017-11-30  5126  
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5127  		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) ==
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5128  				le16_to_cpu(p->crc)) {
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5129  			break;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5130  		}
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5131  	}
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5132  
c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5133  	if (i == 3) {
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5134  		int j, k, l;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5135  		u8 v, m;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5136  
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5137  		pr_err("Could not find valid ONFI parameter page\n");
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5138  		pr_info("Recover ONFI params with bit-wise majority\n");
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5139  		for (j = 0; j < pagesize; j++) {
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5140  			v = 0;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5141  			for (k = 0; k < 8; k++) {
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5142  				m = 0;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5143  				for (l = 0; l < 3; l++)
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5144  					m += GET_BIT(k, buf[l*pagesize + j]);
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5145  				if (m > 1)
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5146  					v |= BIT(k);
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5147  			}
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5148  			((u8 *)p)[j] = v;
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5149  		}
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5150  		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 254) !=
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5151  				le16_to_cpu(p->crc)) {
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5152  			pr_err("ONFI parameter recovery failed, aborting\n");
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5153  			goto free_onfi_param_page;
c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5154  		}
2c5f4f892 drivers/mtd/nand/raw/nand_base.c Jane Wan         2018-05-04  5155  	}
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5156  
8b6e50c9e drivers/mtd/nand/nand_base.c     Brian Norris     2011-05-25  5157  	/* Check version */
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5158  	val = le16_to_cpu(p->revision);
b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5159  	if (val & (1 << 5))
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5160  		chip->parameters.onfi.version = 23;
b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5161  	else if (val & (1 << 4))
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5162  		chip->parameters.onfi.version = 22;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5163  	else if (val & (1 << 3))
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5164  		chip->parameters.onfi.version = 21;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5165  	else if (val & (1 << 2))
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5166  		chip->parameters.onfi.version = 20;
b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5167  	else if (val & (1 << 1))
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5168  		chip->parameters.onfi.version = 10;
b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5169  
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5170  	if (!chip->parameters.onfi.version) {
20171642e drivers/mtd/nand/nand_base.c     Ezequiel Garcia  2013-11-25  5171  		pr_info("unsupported ONFI version: %d\n", val);
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5172  		goto free_onfi_param_page;
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5173  	} else {
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5174  		ret = 1;
b7b1a29d9 drivers/mtd/nand/nand_base.c     Brian Norris     2010-12-12  5175  	}
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5176  
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5177  	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5178  	sanitize_string(p->model, sizeof(p->model));
f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5179  	strncpy(chip->parameters.model, p->model,
f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5180  		sizeof(chip->parameters.model) - 1);
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5181  
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5182  	mtd->writesize = le32_to_cpu(p->byte_per_page);
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5183  
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5184  	/*
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5185  	 * pages_per_block and blocks_per_lun may not be a power-of-2 size
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5186  	 * (don't ask me who thought of this...). MTD assumes that these
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5187  	 * dimensions will be power-of-2, so just truncate the remaining area.
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5188  	 */
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5189  	mtd->erasesize = 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5190  	mtd->erasesize *= mtd->writesize;
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5191  
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5192  	mtd->oobsize = le16_to_cpu(p->spare_bytes_per_page);
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5193  
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5194  	/* See erasesize comment */
4355b70cf drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-27  5195  	chip->chipsize = 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
637957551 drivers/mtd/nand/nand_base.c     Matthieu CASTET  2012-03-19  5196  	chip->chipsize *= (uint64_t)mtd->erasesize * p->lun_count;
13fbd1794 drivers/mtd/nand/nand_base.c     Huang Shijie     2013-09-25  5197  	chip->bits_per_cell = p->bits_per_cell;
e2985fc1d drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5198  
34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5199  	chip->max_bb_per_die = le16_to_cpu(p->bb_per_lun);
34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5200  	chip->blocks_per_die = le32_to_cpu(p->blocks_per_lun);
34da5f5f3 drivers/mtd/nand/nand_base.c     Zach Brown       2017-01-10  5201  
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5202  	if (le16_to_cpu(p->features) & ONFI_FEATURE_16_BIT_BUS)
29a198a15 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5203  		chip->options |= NAND_BUSWIDTH_16;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5204  
10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5205  	if (p->ecc_bits != 0xff) {
10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5206  		chip->ecc_strength_ds = p->ecc_bits;
10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5207  		chip->ecc_step_ds = 512;
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5208  	} else if (chip->parameters.onfi.version >= 21 &&
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5209  		(le16_to_cpu(p->features) & ONFI_FEATURE_EXT_PARAM_PAGE)) {
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5210  
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5211  		/*
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5212  		 * The nand_flash_detect_ext_param_page() uses the
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5213  		 * Change Read Column command which maybe not supported
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5214  		 * by the chip->cmdfunc. So try to update the chip->cmdfunc
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5215  		 * now. We do not replace user supplied command function.
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5216  		 */
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5217  		if (mtd->writesize > 512 && chip->cmdfunc == nand_command)
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5218  			chip->cmdfunc = nand_command_lp;
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5219  
6dcbe0cdd drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-22  5220  		/* The Extended Parameter Page is supported since ONFI 2.1. */
cbe435a18 drivers/mtd/nand/nand_base.c     Boris Brezillon  2016-05-24  5221  		if (nand_flash_detect_ext_param_page(chip, p))
c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5222  			pr_warn("Failed to detect ONFI extended param page\n");
c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5223  	} else {
c7f23a706 drivers/mtd/nand/nand_base.c     Brian Norris     2013-08-13  5224  		pr_warn("Could not retrieve ONFI ECC requirements\n");
10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5225  	}
10c86babf drivers/mtd/nand/nand_base.c     Huang Shijie     2013-05-17  5226  
f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5227  	/* Save some parameters from the parameter page for future use */
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5228  	if (le16_to_cpu(p->opt_cmd) & ONFI_OPT_CMD_SET_GET_FEATURES) {
f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5229  		chip->parameters.supports_set_get_features = true;
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5230  		bitmap_set(chip->parameters.get_feature_list,
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5231  			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5232  		bitmap_set(chip->parameters.set_feature_list,
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5233  			   ONFI_FEATURE_ADDR_TIMING_MODE, 1);
789157e41 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5234  	}
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5235  	chip->parameters.onfi.tPROG = le16_to_cpu(p->t_prog);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5236  	chip->parameters.onfi.tBERS = le16_to_cpu(p->t_bers);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5237  	chip->parameters.onfi.tR = le16_to_cpu(p->t_r);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5238  	chip->parameters.onfi.tCCS = le16_to_cpu(p->t_ccs);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5239  	chip->parameters.onfi.async_timing_mode =
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5240  		le16_to_cpu(p->async_timing_mode);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5241  	chip->parameters.onfi.vendor_revision =
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5242  		le16_to_cpu(p->vendor_revision);
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5243  	memcpy(chip->parameters.onfi.vendor, p->vendor,
a97421c75 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5244  	       sizeof(p->vendor));
f4531b2b1 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5245  
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5246  free_onfi_param_page:
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19 @5247  	kfree(p);
bd0b64340 drivers/mtd/nand/raw/nand_base.c Miquel Raynal    2018-03-19  5248  	return ret;
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5249  }
6fb277ba8 drivers/mtd/nand/nand_base.c     Florian Fainelli 2010-09-01  5250  

:::::: The code at line 5247 was first introduced by commit
:::::: bd0b64340c2d66c0fe1aa99b0b23159d7e0c21f2 mtd: rawnand: get rid of the ONFI parameter page in nand_chip

:::::: TO: Miquel Raynal <miquel.raynal@bootlin.com>
:::::: CC: Boris Brezillon <boris.brezillon@bootlin.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJVv7VoAAy5jb25maWcAlFzdd+O2jn/vX+Ezfbn3oW2SSXNnz548UBRls9YHS1J2nBed
NPG0OTeTzCbObfvfL0BKFklBnt0+dMYECPEDAH8AyPn+u+8X7P3w8uXu8Hh/9/T09+L3/fP+
9e6wf1h8fnza//cibxZ1Yxcil/ZHYC4fn9//+umvT1fd1eXi8sfzf/149sPr/flivX993j8t
+Mvz58ff30HA48vzd99/x5u6kEvgzaS9/nv4eeO6R7/HH7I2VrfcyqbucsGbXOiR2LRWtbYr
Gl0xe/1h//T56vIHGM0PV5cfBh6m+Qp6Fv7n9Ye71/s/cMQ/3bvBvfWj7x72n33LsWfZ8HUu
VGdapRodDNhYxtdWMy6mtKpqxx/u21XFVKfrvINJm66S9fXFp1MM7Ob64wXNwJtKMTsKmpET
sYG486uBrxYi7/KKdcgK07BiHKyjmaUjl6Je2tVIW4paaMm7rF2SjZ0WJbNyIzrVyNoKbaZs
q62Qy1WwVHprRNXd8NWS5XnHymWjpV1V056clTLTMFjYx5LtkvVdMdNx1boh3FA0xleiK2UN
uyVvgwmvGIzXCNuqTgntZDAtWLIiA0lUGfwqpDa246u2Xs/wKbYUNJsfkcyErpnTZ9UYI7NS
JCymNUrANs6Qt6y23aqFr6gKNmwFY6Y43OKx0nHaMhtZbhtYCdjkjxdBtxYM2nWejMXpt+ka
ZWUFy5eDRcJayno5x5kLVAhcBlaCCY1sa2ZYjQPOm23XFAUs/fXZXw+f4b/7s+N/0e6gLpWd
vZl4i85Uam4ArdJNJgINLORNJ5gud/C7q0SgYWppGaww6PtGlOb6cmiHP7zbaUJNlvrXbtvo
YEuzVpY5LIzoxI2XZCJvYFegULhkRQP/6ywz2Bk84feLpfOsT4u3/eH96+gbYWltJ+oNzAk8
ECy5DbwB16ASzrwlqMWHDyDmOGDX1llh7OLxbfH8ckDJgStj5QbMEtQO+xHNoAO2SYxjDaoK
67+8lYqmZEC5oEnlbcVoys3tXI+Z75e3eDoc5xqMKpxqSndjO8WAIyTWKhzltEtzWuIlIRAO
H9aWYLONsTWrYOP+8fzyvP9nsH1mZzZScVI2uAHQ3+rXVrSCkO51ArS60buOWTiaVuHAWyPA
eZKCndETEt3SO5NyHDA20JJy0FswgsXb+29vf78d9l9GvR18NdqIs7+pG0eSWTVbmiKKQnB3
hLCigPPJrKd86BbB8yA/LaSSS+18K03mq1CRsSVvKibruM3IimIC1w0OFZZlNxVeGUkPqidM
vhMNmlkNO+y8JQOPQ3NpYYTe+IOjAhgUDxEgEAff7P1N5JyNYtqIfnTHvQ8lO4ddGEq3EAKZ
pgXZcKhYvsqb1O2HLDmzgcmHlA2c4Dke4CXDc3HHS0I/nB/djOqWogCUB366tgS4CIhdphuW
c/jQaTYAUB3Lf2lJvqrBcyT3AMnpvX38sn99o1TfSr7u4FAF3Q5E1U23ukW/XDltPK48NAJU
kE0uaXP3/WReUsbuiUUbro9ri74AMAvVxS2ojvbVzQRQyk/27u3fiwNMaXH3/LB4O9wd3hZ3
9/cv78+Hx+ffx7ltpLYeGXHetLWNVIsg4gqGY0H9cvs6shDTykyOToML8GTAGKxiSuk2H0Px
eKAijCWVFwYmTVMO/sDNXfN2YYgt1EJ0QAvAKQfIdwM7FeL+iMP1MZNOMJyyHPc9oHiALZY8
K2WodPCHBfjQYUSxjhY4pXgzj6UWrIYw6PrqctoIsIYVAfr3FDDAQWXCwTU8wyVLsA0EEfVF
gOHkuo+jJi1um8bmskEJBTh8Wdjri7OwHXcG4pKAfn6EOEoD5lt3hhUikXH+MTqgWkBoHnEB
vM+9Zc8hwrqFmCZjJav5FLg6tJyhdwMxbY2REeDlrihbM4uGYYznF5+CjVrqplUmVE04kTml
657VjzqAqEzqjqTwAjwaq/OtzMOIDCwvZh+hoG9XMietwlN17tBZ2qkAnb4VmnRMsGuA2E/I
zMVGOu1MpUJPtF1aaj9aoYtTdHdG0f4SEBWcceAhiJF53UBk68SEY4NzpsBgRWkBp67ISeEY
U+4oh1WucboOretgs9xvVoFgf/AFWFvnA44epedTkDqSYgANDSFudvQmEUbDT86PwRv6D7fU
mDCpk71K2DBWplYUjmcbnD7gaGqYNgCS4FT2Birz8yCR4zuCT+VCORDjEihJH8WNWsMQwWnj
GANnpIrxx9EvjygXv0WMtgLcLUFtA0xlIBxGdNlNgIbXiLE5VBUcek8hPlOswEDLaDk9ap+e
wJGbCwJR7/bqSoYOeBlKFGUBB4IWdJAQLxzJkzHAgYgdqBm0cNAE7gh/ggsJ1lw10VrJZc3K
IlB9N9WwwcGssMGsfOw9BiCyIYbC8o2EgfarHWgV9M6Y1tLt5qi3K8HXLuuEmMcmC9QzrVHS
rgqEDS1dpAJjawbIARYBrSU6FY8cbjWHtFc4IFDVE6qCyujCwXBljrmqcYogouZuv4MVxRRU
Hh4O3mhAYpcCY9cIH+s2VZKGUfz87HLAQ32iVu1fP7+8frl7vt8vxH/2z4AGGeBCjngQUO8I
lMhv9Rmf6RePa7KpfKfOgcDEJEY7K9vshKcf0pp6PdObZZTDAqGRMZcNzcYyWH69FEO8HncC
Kh6OiNw6Ddbe0DYWM66YziGioM8WN1ufMdRWspK2a90UsqRRs9v8xnMEWjK0oDPxVhlo7zE1
dvzCL22lICzLBKWtcCKkyTT3VQjWJZe4oS24AfAFeMpyROmJUqM+IJAE4A9YfsuC8HutBS1c
gtIjCgOiTUhrssOspLnh92IgaOsK6hgq2tpXHITWcBTK+hfB46yCY4u89Zg1cRJXTbNOiJhY
R0Qvl23TEjGsgY3AuK+P4gn3AK7dymI3gIspAwC0PhVEDsxnI31ms9uupBVxJHLEwwCMdgCs
MCh3R6XrkYjUYgl+ss59OaTf/o6pdE14SS0E8HlTT2irLRi4YN6jJ7RK3oCejWTjxpDCDnCw
0G5bXUNQA8slQwNIHSaxh2i0GEw41GkF5oBdD0oI8f3BDep+XfK2SpOnbplHu0vXFaIxH9mg
H5lsstc7HyDxSmH5JBXfG2S/z5iJT7fE9/P53xla3rQztYfeD0vFO59bGhLLBG9T5gE/tQ5G
cGTowGXZyU4tAZWqsl3KOvJZQfOcXwQOt/7oRNweJlg3JoKm1GRydcIIO96W7BvSYOWbeuYQ
mzBjdHIyC7uVdgXu06tToTHeSfdsNoPgyPN5msjtTlM1M96txpyi6KtQhHrN8nWqTcGL12qs
ZgFsIA3FNIXtcphC6tOqJu85lOBg54F6AaktwcHj8YO4GXEaMV1xIy0eAi7ri8tLuFTX3R34
0+LhtHybnpP4AdKdx73GijAhNyjnzgkJWQhRPdmxI26d6o/aDaeDLVOqV7w+hRvZuTQMTvfE
6aPJQ3jQVzE/htksN4qezqgT1Y120xenye0A05Lg1PqCi94GQcsJUtrd6wfZnSIdu2u8R9CG
B9PQMiRlfW2PN5sffrt72z8s/u0B9tfXl8+PTz61GrixZtMPl4qDho86tgHUReEKmHWFkVq4
oS4uMQjBr88Tc0jtw6cT4RQItbMntXXfPCa0wj6eTHo44OsPBBrl93KM5sfKY0mD34FTUui3
J6JSaY87034DaVIpnGEL8yuDA3FJ3hKwXJw8yhAgUGE9i2sgzNTn46+2drVzmJECf45LOJ+y
ZLZB+KWroFzm9tp3hlVrtnV4XvrbFDNE/NIc7YjTXYUxd2yudDOyzFPSznpLd520jxY5xLld
Jgr8A7FTXOAKeF1Y3W01UyqcQ5+3HOxPvb7c79/eXl4Xh7+/+hLH5/3d4f11/xba33ATggoH
Q9CGVw4KwQBSCp9uDFUBiTcX4AHpcg6SK+VwEvGZJTjDQoZ5ZgxlGlSS8Bv+GoTOqWotfgDO
fnC1eAllkjhD8sbPJhrT8OXZQftvlspQEAsZWDV+b8z9DiNuTNFVmbz+krakqB9FHbW+L2MX
TJatjpbAZ3LBJqyHQMNFIwo57UA3NtIAtlq2IoxvYBsYgqFQ8NB2IvFwZDkaALUkceELfnZq
Q/MBYbUJ92hoStQOmo2PtFxeK6b4pEthph9dEV9dg/BkMbApEJLOdRYKHjmGksuYSoBtWzXo
Ddyn6Ppl1jQ2yQNW60+0/1eGNqoK/QV9t6NCx0lZ2lDZDZN5g55rzF/3F8XSghTylOcR8Sqk
WcNjgX0AldxoxJLyJm6pZC2rtnLIvIBgu9wFVTxkcLvDbVmZKN7o66EYZ4hScGqdUSQYlTfi
AIH1zWC600YOSJ21YQSmhD0mkI5fzytJLvySgUrIpqpaajysBPrO04NPh82dqDHqBUS8C1Jw
g/lvZRPdYvNdVqJU8fAqdgNGRKmeu55nEMsv8axZ4kVMmgi+9Prn8wlxGNS4ST0laPFuylTh
0F1TxaferOKY96dvFAEkEZWyc4HpQN40Jdgnc/metO+JbgmIdTqOuQBE8ok6y4Zo1EI3mB3H
QlGmmzX4HbRrDKRMouThqdA3YF23FBAB7CakVGOH5khjh0aMWMwKDrL0cPOCfqFtwxntCjAG
THczpAY8bAiy4F9enh8PL68JYg8zR/6AbOu0JjPLCqClHM/DKZ37C7kkhztsm22IeXAe51eT
m9TCqELepN5nuFbTiao93ogY8cUnOqUOCBR8DfjGeWhjqBPY+TvVysnG/OwuWs4FO2q1g5nm
ue5sekfc3+LGvOE8uS+ggPlyvVPRIY/LF5DoQnJLIsE+w4AAzktgxI3dI3niuPocF/rpAd0g
uA1UXJZoC+UAaDDQbgVejN3fPZydTS/GnhQ2jqRidcsoSppF8XIwBBKhTwimfANRUCUo0gb+
h9F6uiojhysFdX5AqrPNUqDtRb4wlTaXDMPiWBwyRc2dO8SnSaTh5F+26Y3hXIJN6JwQ3C9K
eH0ovNiBtFVjMQVJxQ6qBJSqrBuUOx8uo8/6xRrY0LBt/HWXKEnSI8TNxhPm4hFcg8mZQETV
EhnxtQk0Yriq6jbVX5DL9fXl2X9dxfr8bbweU0iDozKEcwboixJ2pbq4iMRLwWqHzYK28N4E
/DhGHGMSdmikbz2im9GCmet/DU23qmmiKwG3WZsTXW8/FngcHV34relroaNT72+cwwKrCFYP
rO5Zxtg8aK+7vz6UxqINE1rHyX53CyVy71hUcpQhQXwq3eSj4iSe8zHXZpJJ9+XxbnIHb4SF
gCwzcLurimkqY+KOCizhdxlEiJgI0K1KTQ6ZEF9g6FENqjWyegEzwv29WUzibAOcVlkd2AD+
glALlk3eitn2wXAHH382w+Z0GgsFiA8H5vN4NopR0MTtgU82p9M3iWMkYvW2mrkQP7JAaPIt
juE4cOUJXNy12NFbKwo6EugrOiRtddudn53NkS5+PqOc/2338ewsXBAvhea9Bt7wYv6NoGNI
R8GqE32pnplVUrpDdysRI4Oya3y5ct6fy+FtMbzBjUpCAcKhv6vPQf+L+L2LP0/6AHXMNB7V
PmCgF9AH899k69Pwm9xQZSePy1O8GLn2lCUNUQI3m7t0J8yBwnwAXbCYXeZ2ehfLndyl3MCh
YCePktBL4ZMxdGlpSrG30fiQPgL8lz/3rwsA+He/77/snw8uM8i4kouXr/hEMcoO9gUMSsn6
N1yYMijLjEWJTVV1phRCTVvi7A60YuVvyrtla5EkS8PW/lHQeah4EX3JKeWrImmTExFHk2/w
TmA+TYSl80gyeLn7fPo6IGx1WQS8pXx+EY/aP6LUlh5yfHVg+6uPgILLJ1O0zcNKFP4atNVZ
pRlT+aHOVPgusS9AYReV80QI6KcFgOq/78I0M3366Tjd2ixjhBsRXH6b8v3uO4prP9R0Fio+
0v04ITgrjB8V/cIHubTYdM0GUILMxfFN4dwAwCX2wAggSyyHUZvkKBmzELjsRpDjW1tr4RhP
xWxgGOS1PyQWrE6kWJYnLXlcNcEml0HTAhQkuoA0rJFPlvHkvWtClvlk0Y/EpH3GVScC2XIJ
GAAf9MzNts9CUN7NTx09WasA+Ofp0E7REvP0w+ISb76l2gp/t0zG5aBwhrKJcz9eSbN0kaML
615wa2yDUM2umnyiAwBYW/Q0eNVmi2CpqUvqmvVokkyJyV2roT2+w0Owj5zLVVy8GSlC1r/M
7ZNnwBe9fmmP+pgrW6RpGW9GNxDSLcN5K6zmNRBlLwFTzX3I/71IUmjoJ+NrfKaQw5EGOrgo
Xvf/875/vv978XZ/9xS93xksI073OltZNht8L4hZZDtDTl+xHIlxjHJsHsJH7Dt3zZzkxSXE
Usfcw4NpF/Si7tr//71LU+cQPNV01ZrsAbT+0d3/Z2guudtaSWGeaHnjJSI5hoUJVSniINeB
YhxmP7vV41RHBY9YjvMKde9zqnuLh9fH/0R3hoHNr5GNBPdtroYI4WaSdXbBiEpctrMGzofe
MWE4CRzlyxwF/swSgbjGdbPt1p/CVR5KnF7fRW0guttIuyP1wEVoSogcYIKvpGhZU6ec++Cl
L51VzjO6lXz74+51/xCgUFJuKbOhAy69fHjax5Yen2FDi9u8EgBz6EIiYiXqoCrj176X5b6W
vb8NY1v8A46Sxf5w/+M/g1vhPPC2eNTkUgsel1mhtar8DwrsAfkmvJLmpLhHsyYVw+vs4qzE
KweSTCkAj0Bk5pNfYVfBZoCSoxlFFQ6RBC5YpKI6ZWfY/ZUoMi/nVsHISQP5Rhhpbo6TFZhF
6BzPVp9G6gOh+FW/gwG2DS0AS8Zc4mOmQuM1wtBDIDuLXhVAA6puKdy/Q4BtMVG6Imc0WKXl
zFAVMzL52nAhNpLgC/p00qAHKqiUAd3byN3DHks5QNsv7l+eD68vT0/+De/Xry+vh6iwgzvK
AUuBL3YP9SfS8v3b4+/PW7BTFLjgL/AXcxQUism30ZywwYmctqLrO8amIPSPl7dDMNLAlQYv
KfLJ0LCreH74+vL4nE4Ka5musEB2evvz8XD/B/3FUGO2WH+FUM4KHrrI/vofuTFI6+95U2gH
HGudhQuCifh43ysuqXoMMnrL7qfxw/3d68Pit9fHh9/j6z07LGiTg9Mwqpx8fOQc7s4U2SBf
/LW/fz/c/fa0d/8C0sIVCA9vi58W4sv7013irzNZF5XFO6NJNt+SJPgRv/DpmQzXUtlJcyVN
kEnGnnGGSrKPFzMFPqQwiMBnT6+bj9QzxH7s4T8V45sm08NKcHt16ZNblUiry+hfUB0aFXiT
Why1v94f/nx5/TfiByIVA/hmLaiEaVvLm3Ce+BsOH0bf47EleXGn0HG2FX5PgvSYatqsw1ta
fAYNII8v2MxUTp0QwDbSWMlpA4LFwdQrMWDp123cXOXfOeI/eUDbohqTO65uT0WkwKTqUJnc
7y5fcZV8DJtdWnLuY8igmabpOC+pZjLVnghxMyhM1d4Qw/QcnW3rWiSPNGvQxWYtxfx6SrWx
dM4aqUXTnqKNn53xeMjH6At1jibMzIr5oaU585B6nG7Y6NUMi56+khYlo1KO0wIyIdK+aEVJ
k+VqaI4H3+Zq3uoch2bbb3AgFXYdn07QVoVfh78uj7pMLNaRh7dZmLcYwrOBfv3h/v23x/sP
sfQq/5m+awx6cxUbweaqtyQsnNMv1x2Tf1KNVt7lM/elcfZXpxTn6qTmXBGqE4+hkop6G+07
f1OJrr6hRVdTNUrGN9LdkvWvzN0ZNT/oxFBDkkmqm31bd6UplXDkGkv97oKABSw56e3ndWIF
0b0qfJnnssgnGN0M5+lGLK+6cvut7zm2VcVm/oUYYSfvNUMi/hNlWIRLK64THrXaucwSnESV
kjMPloDZP82a8/Y557MngeEzp4TO6VW0c/8KFrP0g9vyYuYLmZY5eZ/AP6FDj2OifwKjbyKF
bUpWd5/OLv6XsSfZbtxW9le0eidZ9ItITdQiC4qkJLQ4maAkqjc8Tlv3ts+12z62c5P8/asC
QBIAC9Zb9KCqwkAMhUJN8O4clrcoT+izN00j2lE1rMOUnp7GX9BVhSWdyKvcF67ml2lxLkPH
PkuSBL9pMXdNvFT50J8cUVHUcY4xMrzApHL6TWED0xeiNwl9iyvKJD/JKwY9/BzTNjk8DHA7
sPzgPl6y0nFi4xfmDhf4PacXvBgV0VMQaZ0U6QwzmOHx8BlVHnGKyVW6jFxtReIjwyfSTDSj
MqRghU5vUo0mSkMO126HaFVhVh5+ac1sD5s7Q9TCDAdfydRxQlSCJaeMlKZwP/m4vn9YDpWi
14d6l9BLdB9mVRi7Psqxrjf0Vgi38HWVi71s20NE6XPOrEpSK74o2u5w33hjjUOH+Hm9PrxP
Pl4mf1wn1594e3zAm+MEWLogGG6MHQSvA2j62YvMSCJRqWYqPTOA0ox0e2CO8Ckc2zXNHKOQ
OdLtJOW+dSUMzLeODIUczo+UPvaEbLulcdRB2DESTBNnunXBEobuyYwgJtNOTsgAiFqy8CKC
kxSFZUBK1Drulml8/e/j9+sk7lUgQ57Ox+8KPCnGt9OjTG0hfdGpb0lOdVbqVp0OAlKR4YcN
ayCPw7Qwo39AwhQNbFmVCWuZyMxFNLQ9i1g+Xc2LvpthX1JLR9TTylj13pH+M3S7Ve4Ohgkt
xf2O9/tOIeE4ItE5Ja7YyTFGAp2cKtNAJ+GY1VSVheMlK07UuS6IQhFOpkhlHspeYaKFgAi1
qCNNJaJPxxSz525Yymqm+5hUyc7wv5O/W+ZrihkF42XGRsAsY8W4tJ45sisNKyNG5qOtmiyU
6X5jzIq21acLUVuhu+zSWQwjiFknTM/mXqf/IFa86fXCcCujzdGl2YN/cuEHSG24Wo8krWMx
KYYrAQLhC0S0ACY+oTQySNP5Dgka/XsQWWw/LRtWK1VOWUvK+7ePR9y3k9f7t3dtcx/hxyR7
efjz6Soz3tRv9z/fpVpvkt7/Y6hCRctFOeqNyN+CtxkM6RCn/miwqzD7rSqy37ZP9+8/Jt9/
PL6ONa3iq7fMHqyvCUiXYqk6vnaHGny10o2SUBlKXOIOWpCZEpBKxoSD/CQSzLWeOX8W1v8U
Ozex2D7zCJhvj6CAotUJ2JVrPeDHZHAsaO4gHRzYZjiGCkulAYVZMHsDU2JShBvhBK+WTXb/
+qpZNMUJLubu/juGl1pTV+DGaTrHXm62hM5/yDisKVJgpUSlpVeNrNg6Rkca4IwyuxIjd+KY
FmORQtr5Tpj8wrGXhYECR83qdop+XaPKxZjx69O/vqBB4f7xJwg9QK24DL3gyyxaLDxzEiQM
059tWWMNo0RZHi6I4anspzFqIxD8sRcBulbWRY1+nSh06b7uCgsHAVe54z0/ULLC4/t/vhQ/
v0S4HEaCg9ZiXES72dCJjcjGkMNJlf3uzcfQ+ve5xeryJA9JL0TEIqpNosgciw7a8ozAELQb
3cXSqGGE4dnIK6QvECeYDMqJMM3ENlL3DuhxuIiJInBMF1SPY8YPRW5meSaQkl32esT/H20s
sgxMb5Ni+l17M9qUm019rphDUzQUgLVD3817kijcus4Fgce/ZD7rcVkqWaBY3GmJO/t/5L/+
pISL0fP1+eXtH3oPCzJz8u5ExnvyVOIlsxmOgT9uqDtxXGsrudjq/0ejT10boc0A3Kbo26Tn
TwKgDKIgUYdi89UAqARYBqxbBTrMEN7gd56YHVHqEH0GAIoOmXRqUdsjVWZZMvWyHUD3L5Og
tiRdaRUybIJgtV5S5YCzUclDO3SO4pqeRFA3FQk7kRDUMxgd5ZTdJWL4ePn+8qQblPNSeelK
3cApSzQ7ujx3H9+/a7JpJ5kmOS8q9H/ms/Q09XW/0HjhL5o2LouaBJryOdxRsouYtyE5wSaD
q4N2WJT7MK8L7aTgO3RuiDQRp2bbTCZofDZAq6bRDjQW8fXM5/Opp486iOppwTGfBDpdMTp5
7R5uBqnG/sIy5utg6ocp1+rnqb+eTmc2xJ/q7XVjVwNusaDjAjqazd5brajYio5A9GM9bYYm
91m0nC18bYi5twx8vQcndXXF6yLpAHnkG6VYa7c8XM+D6VAdl4f2sGg1xwbXkxdoLG/hDmDY
hyMfV/OI4SUJsKpM8wvppknA27D250NnFFAFMNvgLGyWwWphTLbErGdRsyRHXhGADN0G632Z
cFrVE21W3nSUAlYmp7/+ff8+YT/fP97+fBbpO5VH2QfeZ/CjJk8gj00eYGc9vuJ/9TtfjSL0
JxOOO05tIVEsfPq4vt1PtuUunPzr8e35L3SKeXj56+fTy/3D5Flcpya/oGPg4xvcq6Ck5isW
oi0hRJldj4bugo80AaEHtXrs6QCtG23nqeV1yqKes7CfH9enCbBwOMnerk/iEat3k9EMJHgb
lvKbPjCqMfHG0TiPPo/Y1izYjRsgWs1H5VSUjgYAQ1Y9dGyPLkF9QQsZoeeLiRSdojrUTZ5W
+uW1z5PDP2B84MLTR8b8EhU8+5WQaVFDUghW2X/b+LvgTnq+owSTJNrrAl23Ry3RsAcDU7CU
dizuvRI5qs/V5WK0dRGJRkdNpXU0kxTK31LdupOivYlJi91OhmjKgUuSZOLN1vPJL1tY12f4
8+u43S2rEqW26Uejg7XFPqLdD3oKlx1nICg4JTVkYQSLtcCgNaH7MpUUYYRuQRmmZtnUFPOF
ZmXEp+md0+UfHlTrhXiAhdbw4bFK87e7I0j4rrzywrMgCWnzHnQdbW+0VahxYaAUd4T9QWt4
0ypc6up6owaDNk8e6QYB3p7EgInXeByVn5LaYd9iVQ23ddfk52nmMJWDsGgVkrsQ1fsD638w
Ndpwd/14e/zjT2SIXHoAhm/ffzx+XL9jiqyxkC9C9g25NovhXvasr5QTnMdF1c4iM3T1BMdt
Qh9n9aXc06KAVl8YhyV6HeoKZwkSYZi4LW5UsEvMJZzU3sxzeRZ1hdIwwuuZ+ZQST+HaSabD
MorWiel7F0ZJzhxWJ3kW1mRuML3SLPxmVgp35n5abpU1/CrhZ+B5XutaiiUuqJnDZJ3FbbMj
FZF6g7Db85oZtvXwzvb2IMpVkcl8Ojh+ZmGG7dSpy6ieek4EvSkR45odeuHqfTtWRUV5qQpe
IN2JLU5Mmc21GuXjReYm2sxpLcAmytBoQTONTd7QYxS5VmPNdkU+c1ZGD4aMjLSlar3gjfUJ
HxzJGDatkGtIVZkoPLGjMUT1/pijtSrHV8Jo06ZOcrpNstk52JZGU+0oRiJ715a14TiZsruj
7XQ8QlodI758n6ScGQ9/KFBb0yu/R9Mz26PpJTagb/YMhLbCZFGM0kXoRTCdeW4wil2CWdFI
1jb0qWnxyRZaCLnJD2PzNJHelSmZIFQvpezHQ0Op73iGAJYHqhU/rw+9tBPjarpJ/Jt9T74p
3eYwyALS5iW+9JrDYYeu163NFIiaGjOHNfcdK/PUkE5UWlV7o0P70iMTM+gFjuE5MewVe3Zz
rXR5wYYvp9tB8FSzf+NP7Z4of7f7sx7VwnYb7Sa62wDaerQNgA6WweBAJLqBYK1Z8ZOoFsGu
iudThyMhIFxlHOGQ28ybUv4R+vgG/qIxFuTX7MbEZ2F1SsyXcrJT5mJx/LCjO8cPFyr0QG8I
Wgnzwuhdljbz1uE1BLiF+6kcwPLzp+jt+UZ/WFSZi/HAg2DhQVnaE+fAvwXBvLGjlIiaL5Vp
yIPf3tQxcNskTPMbkmwegnCZGXUqEC3a8GAW+Df2L/y3KvLCDInLtzc4aM5I6S6YracmP/YP
t8cpP8FpaRwc8gFMS6odFywOxlhgeLqL8cigE1hjOysb7x7EceC65ABeEnSH2bIbsu5dWuyY
cQ7dpeGsaWiR4y51ymx3qWNxQGMY2ucsR7rP6z2EKzsa+ow+RuEK2Gd7DB3S3h2UgKPN4bdc
ZTePJQxerBPTv8jh3xt4s7XD8RhRdUGzoSrwlutbncgTHnJyuVaxMWvVcjq/sVsqdF2tyMp4
mIG0YIRTcHFQ3FzGPNGjn3UEA05pVBit/enMu1EdM65X8HPtSNIEKG9944sxaV61hT9mAmeH
8yDA0a8sunU95Bk3hj4pWeRKJYW0a89z3FgQOb/F5HgRoUeP/vK4jq1Fakzj++pM6NluTt3R
fA42LMtLljief8LlkdCasQjdeHMHG2dUEl6tE3WyP9YGJ5SQG6XMEhhTDydp6NB21ZZ2blzf
yWTh8LOtQBR0KM8Ae8IUR1YM/rjaM/tmRchJSHteuBZMTzC7JbzyS16UcOk17gLnqG3SnYvv
beOYniaQ3Et3OBrf2DnOBrEAr4pSYUsrcfYXlw9vmTpC78qShnP6boTmOuF8O1Y3IwruZ/Rg
IPIA8r9D/YToMtmF3OF8iPiqTgPPYcQc8LTyA/GwLleB46hFPPxxXT0Rzco9vcnPFuvtXMfb
M/kSK5IPas5MHnsUrt6b5+H+k1T1gF245Cez0kwPKdBRmgaKwHbXfAJlpW62URVnhsyMIfGO
nIZlxXi2oPwR9EqH+weFTEBAdI5pFZr+4Aaul0EopJ68QUfo7ic6vHbQf7vEuoiho4T+NMmF
YkSap0UEweT8iEEAv4xDpX/FSIP363Xy8aOjIjIHnEl2LIREYfDQ8z8MXDdrUB9M87XjV1bz
Y+sIiFOKsk2R1k7Lhszs4DZ8iI5xRp+AjMfGFynz5uufH06rIMvLoxHfWIpXsmPdoULAtltM
ISgCPywMRsZguhoLLLMYH6SPp4HJwrpijcL0XsdPmHrwEV/X/Ne94eaiCqGtTjYzfK+BwagL
MkLaIuNwV4U5bn73pv78c5rL76tlYLf3tbi4rGGSIDlZeAsrM2Zpk+Nyl5QFDsllU1jJIDoY
8ElXMs+eoFwsAvo5CYuIugUMJPVhQ3fhrvamK/rw0Wh8b3mDJlZBa9UyoMP9esr0AH35nAT9
JG9TiLXriOfrCesoXM492lFFJwrm3o1hlgv/xrdlwcyn2YtBM7tBAzxvNVusbxA5Ui0MBGXl
+bQavafJk3PtsMb2NBjPiAqmG82p+9+NiVMP9aiXAG7UWBfn8BzSZviB6pjfXFEF8CvaJDAs
gsxv6+IY7a00FWPKpr7ZHhrOW2eq3o4oLOFWd2NJbSLHcTHwvE/wwO4wWp/W7UsSEQTuyLQh
CXBQJE/9rCeMU6qnKmNzy61QgKT/laZMARjPKN2zQG2n2st7HQS9DXXDvYD7sXL0suk9bwTx
bchsOoLMDQWJgJGinEItOilnf//2IDzJ2G/FBI9tw/ez0h3BCR9Zi0L8bFkwnfs2EP62nWcl
IqoDP1p5Lu9IJIFD3lrJJjpiJdfcICUUrmII/ceurAopPbPEKc8AWZvdCe5jQgJ32SpqiW6E
5caAKtmrP28tcnlg6AWO1urZhVmiRtKCtDmHA5aAp3MCmGRHb3rwCMw2C4TfrBRjf9y/3X//
wCRVtmtwXRvv35xcqYLWQVvWF03sVsmBXUD1To6/WOpjE4qU1zJW05RThK6vdhrDo0uUhrHj
VMiKJpRXqJTMTCXwPMNYM1PvdMkjFCXI5DEdst1ps5QX3wo9NJFx7Ufe7uPUtJC2O05zVJW9
2ZVRSKK5cdHqT7Naf85Vhyon/Ug6aRlqlgQfCCF7AqiDhVPRSG+P909jjyY1jaKpSHcKVIjA
X0ztDavA0FZZof0Zn6NzRtbpBQxfeR2xxek+0Dji+406yRu+TpFXQk+vPT6iYyt81S1LehKy
ke5ZwRsthSJDZXvCumxu1Q/a2clV+y7VfhA4VLYameNFQp0kYxY36xGwh4geYjipKxYmf/n5
BcsCRCwl4VBHJBBUVeEYpFZgj0lhJnzTgNqUm8ivemCCgvEoypuS+BYeeUvGVw11M1Qk6mz5
Woc7MWXjJWZRdD37bG5UEds0ZBI1DJhRA6dKq9aKVUcVUTBcyuK5meFBW4WsSn9UAGDD2p/5
FnbL8U1Lx0qNUOGPr5bHbMeiIiXDIhUtXputBKMaJqqrFJmZfRQM5xXquPL6oEWcVEJJpncr
LamR7+hLSz2wP0WozXEoz4WD6WfzyMqMgTSVxyn9qOa5e5hEb7IDygTVrLB48IhMqgjJGsKM
fGqhx6Ox4JkCiwNRqzI/VSHVi2q21l9FC8sS/Tn1ANGzlWgZH0Ck+hTmO/lkjUzLPYT/RPBH
f2lBABi39ryCGrYURQhCvlTN0uetRsUAkiek0Uwny4+nQmbh15C5/mQlAqQ22KDp6jcJjRS9
CIiqjQk4wQBg4F9z0Uey6xKvZ7NvpS9uM1TPk1Q+KvpsHO1OgQr4SXoh4yeg+rHyTw8Cw8ER
ci9GKho+OX5EhGPrSMxabygAAZgdmz5q/M+nj8fXp+vfIKliP0SIMNUZ4G0bKWZDlWma5Ltk
VKmMgH02uyfhVn7EEUVaR/PZlMz8pijKKFwv5h5VvUT9/VlhliOXG/e4SnYmUKRydNNnaROV
aWz3QqUcwUQdjl7A7ffYp3jAkQ6f/v3y9vjx4/ndGud0V2AaZqsFBJeRw5Oqx48zZ2BT/WUV
43qsqKIymkDXAO5O52u0wrzFbGGOiwAuZ+MeA7iZOcYDOOhqsRyVEdCWz4OANokpIvQKd1TM
gulokTDuyNUlkZlr95SMNXO7slx471BeYGKeGdwm1wu7EICXM8paq5DrZWMOqnGCKABwqj6q
Dd8BIqeIR+K6NHCWf94/rs+TPzCDikoN8cszzPXTP5Pr8x/Xh4frw+Q3RfUF5EfMGfGrWWWE
OcLV3ja2Cme7XISymSogC9m/8+0i4GloxhzbFTgCkSyyTXiBWxxzpCr0MawoObnmjWJdgt3J
XJzygVZSxkLKQihQ7fKwH0lZ3SCqDjM3a+Qsqx16RkRLEXW055O/P65vP0H+B5rf5O6+f7h/
/XDt6pgVaNE72kcOEbmtgdsUdVqOAamKTVFvj9++tQUX4XxGDXWI+tMTJfgINMsvIprOKnZi
JZrowmqcVbz4+CFPMPW92nI3v9XBwJVG99Pkmjgf9ZF0oEWUWsQ2SAXM2g3KEHSnY+dAgoz9
Bokr+REn05mbqZ723PxhyBlS1cmZnpC+OzgE+OkR43eHEcYKUOTQbgpmCiL4OXYIkAdRybv6
xgIIFotS8YzWwXpeRkOlsZFzXMMMK3mMU2k7+k78G3Oo3X+8vI3PyrqELr58/4+NUDZv5cmC
xlJn1lLN+H3/8CDyPMFGFbW+/6/2wUoAGSX8UohW5EjUHztgOYp1FD3KLdtjLh5INEvg/+gm
JEKTa3GdqbZpLwjVL+tmNMJnUenP+DQgFmZHwmGcTGVSh6kOwXTxScnuBDA/EjFwBaqqy4kl
Z20NKJzlCtJXBveC2njCtqsrzPMiT8NDMq4rSuIQ38k5jIvFSX5KKrJGGUhC15gmZ8Y3x2o3
LsaPecV4IjILaNMI6xkfX9HzepipaWS2JeP1OVUIE03YURty7m2jrV4VvkHArerVYuo2ViZT
sjzfv76CvCEqG7FnUW41b5ou8VzfBdlhobRx9QHWXWkNQhufQ/F+jlnPtsZ/pg7Tid75zw9v
SVl9NjD79Kwp9wSIRXsLkl7ypptCs/JsEyz5ilKOSTRcPo/lqBQ+T0letQX21ATCiqXDpBjR
80BgbF/URKF165PJ8qZzFB7aeZBYH4UYESPmLa3GFAbKWEW2Ky8IGgsoPzSzB7EOVhaIm+Gv
HWzmkeGzAn1mOYaIWxWdubeMoHP/DCK0GIHr36/A2MdjoJw4rFrCODcUnvI70O5P+mwOaN8e
AXG5nTWjyuAyGCxWtOgoCOqSRX5gLnO5F7fxjU+q2LciD62OfA3zb21dp6OepOVsPaddHhQ+
WDlk3B6/WFJ8XX0HXy6mwXLUrkD4HnWUyJnMgvV63t2F8BIx+mqLwzgvlgK9qYPGnp0Mjg89
u5eaGtYv/vG0sUQifcrOLGiqOJr5XjNez0UcnliajlOqgLD8+ZQOovPwAWevW+Tel78elXog
u4eLoF787HXZodFFxoxrGnAx9+ekq71JEvh68wPGO2cUQhfNVB/50/1/zSSgQC4FbfFCJd0F
ScCzJLO6LxHYtSnt2GTSUGvNoPA0Rwaz6NKB8B0lQNLRF49RZka7/Zg09I40aW59z2o5pXu3
CpwIz/E9yXRuzLGG8TRuLp+tDU/mtUEA8XV06sKpXro9lmWq2Wl1KPGGcByO36K1BOEwjrTn
Ygf9MObudZVV9CBe1cF6vtCYaIdRw2omnO8xAbWJDAJtfA24P24qTXYF3LNnYww+i6q/0gh3
NnzuF8CUNV8E61aqkFXT5s5fNU0z7pRCmJpsG7mP7/RZsdFx3R5hpvAF45xUF3Qdj8O1t/g/
yq6su20cWf8VPXafM3Oai7jd+0SRlMQ2tyGhxXnRUWwl8Rnbyjj23Mm/v6gCFwAsKD0P3bHq
K2yFrQAWqixC2AN9VgTfbe2AfhClsTjG5A6pXAx1yrsGklNy5qnDyDI9chc8sC06wY381Ru5
KWvsrKk/xvxY4vqy+1KpMvbSC4I5kmYMb70Ei4/3tfPEQeBHLtVK3otL27slIuSIrHm2ADge
USUAAvkGWgK8kMqqK1fuMqDq1ysQAdkNQ0dv4t0mA+E50ZJSDUa+3ixkXoGW8YVAqrF4Wa3+
hEjTOqm/IhLHMfF9//zO1XDKQqR3dpcGS1sZcApCrfYTQ2lbjjQ6VMAzAb4JiAyAa9P1KyOH
nIwTBwuOtkXlynjbSA+CAqJ6TeHwHWPi274FkYMSTZcEPiXMuxD8jxB026KBdVza3rYP20xV
ku9uWVdS3yenysDbLKqSYAlD0NmxIaqedr5D5ALOEx2yS9OsKPjko1btgSX37rjSvaJSw2nQ
8ig3HjJH6Kw3dGrPDTza9Kbn4IfDkmj9mnHNcweRfDsq403h2WF3q02cw7FUI5ge4Lt+TJId
gio+PVRzZJtvfdsleiKHC4d+aZnVO/c88uA54HARTY9A9aw9UP9MluSk4QO1tR3yverkoLHK
Yvnr8QjgGktMJwQiosnw1dj2iMEKgGN7VA0RcqjPQArH0pzYv9k65CAnBGyivkUedBUWm1g6
EfBDGoiIDgLXnuQShIAbGSro+8tbokEOj+gJBKLAkKtrB+ThcGRJGpfcfFjie0uitKxaO/aq
TPS9dOyF0ncpakBT6b4uA1ozkBhu7ahFGVJDtgxdurTw1sDgMCncooxMJuAjA/0lXWKg9VCJ
wXNc6rJC4ViSY15At1rWJGHg+oSkAFg6xNCuWCLO+nnHdVMCTxifKqSUAQqCW9XhHPwMRqzI
AEQWMRjxIi6SBm/Tm3rofDQZlCKHUiLAzXOyXjdEmrx1PYfedYvS8SyfMqRRVtMgNCxvAIFV
DMTlNTg+l7jd0P7lcmb51AyOj44VUEu3WC5CQiCALJdLevUJ/ZBYHbmGv+QHOHKr4pjn+gH1
sm5g2SVpZFG6EwAOBXwqfFLZ6rbMJprEyXQ3csClDJokPCGEN1mf6MpYmdmBS0ymrEzspUVO
Fg45tkUZ8Egc/sGxqIqUXbIMyhtIRMwxga1cakPj+prnH49DQAcap5YLBFyflDJjHR+EN0c5
12D9m3t2nCa2E6ahTYy/mKvHFtXxHAhCh0rBRRrSYyKvYse6NVyBQb6hluiuQ2+vATE32bZM
qD2elY1NrYxIJzZWpFOTsmyW1JgBOt1ycKeRNDtQUG80n3P5oR+TGTDbuXkO3LPQcYk6HUI3
CFzyjAFQaNPvDSaOyCYOGQg4JoCcjIjcGoacoeDLJiO2CwH5lakZfNpsactClSlTuW4Yoo2j
maM3Dq/szrJtSjHE7T1WPDD0JEMkco0pK7N2k1XwMAoKr9drOI7G96eykyMVDuy1ycOmgCH6
CTyjPLE2b24VO0Ru3tR7Xs+sOR3yLqMaITOu47wVodJuVkJOgmHuuiY2eFShkvTX6kVRJ8aN
fUhnrhXBKLeTgFdxtcH/UWL4L9ryV9uAJtlDqps5glfLWVznnkf40sfykiIulY/sXNU4NXfw
GaBsbhYkMunq5JSyjuKcJhBndZfWEcyC3l6UN2BybsDyF0pski3F1fOg2zOwARMNiIu4VYzT
5I8f5lwOEFQrrSWjlIEyc8M+AlV9iO/rHfUFZ+QRbzpOGHEvq2DSpUQRg8EJyudwfn/49nj9
OnfVMC049ZqNqYni0ziyfHdqlP7R9kbS6ShKpT6kMS84NT4IgAdGVOYjz6c8b+Ez2Y0aIN41
cvnDXBA+nQkkPRA92FYe8+2QbAic793jLyrbZmx3q6Zx8o8dhAU4pIpNKYa2Av/luqQGvMhL
sDrv00nUgCtXem7ZKjnxc8nSKHa8WQwzQ2FdA363uGakvlvlma5z1iTObQlku7amWjLN0FXA
czejZWwI5XyI13zto+uc+65lZd0KRTFZoGagLgvSVAJvmLl4Fga2szaVwlFd2NvmVn93XDEW
rZXT4Lnedg2lVHtd9r4lmkEv983OM4JwnBiMgEzdzVncYBX0TdMcvNFpBo1JT8HpYRDMxCfj
EYGPMyzZftKzhHGXNfzQ496S8xRmRhkAVR5Z7lGdNVWeBBbMcSWCXVadYsdWU4OvJUEYzGf+
/vn84/I4rbcQ0EWOlZXkTSKtKtIiyDQL/sFmxZTjmJTzTHnOchjTNW+X96eXy/XjfbG58sX/
9ap7k+o3joYvUXmZ8U0IFApqPIBLt7rr8pXytrWTfC4jS5KDRzCZdeqzCTcU0OVFppr7AbWP
A2ywJ1wlZUwWt6Li5eKzri8frw8YG9YY03Kdaq/9gDK3XEAqvLo7rYvsqHhbm6BtkaSJmoZX
zYuso2K7hvQ08gK7PNCOmjDLY+NYR8PDO6y2sNdXKzIY8WveR2Sofw9nLBg1AeoGfARdtY1z
AwOkFhV96wpgmdhubxhhKGib+/wkfGogpN/0UZjB04suT1y9NDH//7GL27vx3QqRc9EkaH76
UyZodpOTztpg8KQtAzWQekYwFQyP3OkqAYJnwF+mx5hKimDR3DAp61R9lwPQHVdcyZjiAIZh
U4bWrEcEmTpAY5dMJhBqV6F1Q0hdp05wNOsQYd5B2W4gynzlhgtpgxqpkimzPaCDpqUX2iRr
jw9P6r4Ok8yNCpHMPMuc5i6UL3CQJJREldjly8A/Dq/AlPy70rOoixfE7u5DLnbldjZeHT1r
HjhOToX2zerMZxBv2XU9fjzquNarrQvCQFWtMk9RlLuJBrYgtuUpa5WwPKUvKBAKjlqmk6mq
TnXsYF4BNIwlyZ7vkZmEunyRHtmOvpooTIfCdgL3llCL0vVcTUSaqTiuy71lMEUkl91uGRSq
oatasZJr2+aVEmCDnb6AwygyzTIEQ7Wmo0WwdnTSPFgNXz8UbzkDcf58acaxzo/gYqQumPKd
e2IAPwA74cOh2ymvmSYeuBfBa5GbXHxZ24Ty21EF6hfCGQRbfOgrXz1VEPZ/wxFvZEs9N6K+
f0osFf+noSogaQZz+Wq7rII4NtkgRGwKWccVPzp6hrYadsqJQezEVMYC2XuuRWedd0XkkhuO
wsNPEnZM5c9npO+SAoLlLLDpUhGjJ5TMFAYOZZansphK56uTZ0R8GmKJ64WRCfIDn27OsC//
okHA5pG7tMIT+svIWE7ok3YdKk+kblYKiJrA7Rz4xk+PUkAc15A1qgs3M27Wu0+ZTc/1Zh+G
lm8YpAiSJscaT0TmPd4lUqCmPEjAqEIQNRp0gptVgk+3NpcYlTu1kauo4xrcnapsnuXc7k5J
BzBm8YtBiUy2uSGq2jDDSPHue88VRJ3E/ke3PTGqB+CcGu3oxQva6YD5cnl8Oi8erm+E82KR
KolLjJ/bJ/6ponx/KPihnO0lhmmDRxZwbsT4TjnxGGvYxvCqxlBUl7bmQhII0DjPXeeqK9aC
T1rK7H+fpxl6uZ96RJD2y8LRaXG6nz9IEJBQHcq8Qr/f1YaMtS1Y4ZVRd5cVmeIyR2BsV8m+
fqASp/WhqtNM41zt1nDjT1DTkkttdIZcYlcTnyWEbDAe9i/6B+s7doGU68P5O4bynI2hvi0H
vrQrRs0D3ad9+gr4U93Gc4/bSol/nF/Pz9evC7annKSJbLbZEeLjiRe6N4rr+eqW/qAkmMrj
Su+plLk2bqfG6v3x7efnt6fHm7VMjo4XOtQ5S+BdHAe2u1RGxPi6VQqLoGYar7nymch3EHAx
IOY0RZM9fUwVXMLVZOnw/4aCaDFyPnxZc4sJprFe7Vkfd0JKl8dFWSZ/dBDjq3d/oYxcsV6I
AK2teZqx/dyBQ3LftBArYZ23GMrblJjPI0c7XEx0YmVAOhdULRt9TQhMSViF8g2ZX4lfRk0J
Oz2RGBRL30A+7ffqqDy/Pjw9P5/ffk5+ZN4/Xvm/f+Ptfv1xhT+enAf+6/vT3xZf3q6v75fX
xx+/63tCt1ul7R59JXV89Urm2wJjMd5Kie+jH49P18Xj5eH6iGWNYcB/oKOFl6f/KHeafafx
A0EoW4r15AzchXu6jAQdrduxyDbtxgL1nLl0fPHcV0QUf3q8XG8xB7Z9VJmh1melUYMbCYFf
XlVqcn6BAPZCxnN3sqKkeh/4way9JYtK2x6d0q6fzz++STlIhT69cLn+W0RTBw9AI4zi/0Mw
PVw5F5c93CkPTDPhBJ6zHR1d8fm6wEGiZlo+/Xi48LH0ermC56nL83edoxMjavEB3wd4cT+u
D6cHIYhHJYS8BAwSmhmjTAsUCMRSbI9UzLaNGLNt1YxQQfeWYzCzndjqvWewrpZ5gkB+Aq5A
ka8YPypQYIDaP71lRTeKHaJIPk6L2aepDhIRvBE1RUZjfMaFTkTnJkDlskwFbY7aRjQK5RcI
CpjFXuCbUiJoSFkyR7l+kLFj4liyaZ6KeYpBqIotjViZLJddiFZyOGzZ9fr8A5zB8Nl4eb5+
X7xe/m9aM4fBvXk7f//29EA4xIk30r0K/wFv11UlCYh4v059UecYhFFTchAex6b9eBODzz96
r+ZYd8gZeFUxhK5LCfe0cdIsfhPreXJthnX8d/7j9cvT14+3M3ytGheeMl0UT5/fYMN5u368
P71Oa9b6jc/4xeePL1/4upGO69n0iZ9y0rSKkzt0WXUqknR+TgBiUsRd18eqknVzwChfILOc
tQxm+OAV5YWolHYDOyH4xkvumglq+IFuaZ8OBen3eOLr4m3cxmTmaROG+nNkBTTED1Fq7rt0
NAupBuZz/cQkHXmJLExfRqeK7D3HCoqGaucq9W0rICXQJsekki2K612lOAjrqrnDsW2ezmfl
NlfS8Z/Tg2vWZtWGDMXF2dr4II+3HeROMkojSOyT3y8P4OkZEsw2PuCPl2CPotcqTlqDQ05E
YcCZUS3cmQztIB7VJEkUQFbc5ZVKE96YdFrOf93rNeXacxfntE0M4rjKGurT6+l6nlzcmxpd
JxmzzUqu3dNWoQhzvbUmvQcD+Oku0xrHj4+rXP6Ih8S17BMRKDwdhuPQqPeZSjjEhXKvjpnd
t2jMqFJzjFavkphG+DNeyUsDkNghr7ZxpVeuAs9cTC+jSAYDX5mYpTqhqve13hMQWRbGp1HQ
ZbzJk1kYFIXhfs0X3dkIx5CXYPdnzroGF9YZFZ8R4V3B8qE3lIQV+T0cEL6hZHdqu5u4AivK
om6VpUEia+NMTpuxGLxDaTmCt+8kJYnTsjbtPjIM6X6qrRmhLKXP3MhUxHD5VeWGoETI0+YQ
zI1uCp/DM9EMEWVVIjxKxnh3KpllWQE+y7NOA3ZVU+w0Yqt4OITZAeFt4k7VcEaiuQf6sCM4
ALVyIbjFn/W9WrhM5bmqncDyfa3NM37Qz/SZwrZ8lpU6rd11THjFmRCZOittB5vKqelcbe3I
87LWl4BjXpVa1T5xzU5t20CZlQTRAflkq/R5Isz8T1vSZSZuF0UznhTBg5G6p8pGYCdtQ9RG
8Hx7HrJbXTmVq5rv14craVaNIT4N8Z4Am609k1dlSgNAZ9CoBQg+rs8/L/Jua+BG+xeIJbKV
3T9AufU2yU9FzliRnbKKb3GSxYN026oS+7dRCg3DD23j7rRNUgVRFA5hs2aUAng83IEpcZUd
evV2fu+mnuqhB/qQj7q8h3cJDYTZJK3kkOu+isEGCS/DO7VRNdvMCKfDlq8xRd4xvWUArgpc
GTumj8cZ55p83i/GgibbAwp9FSsObhXA4OwUhyc43E4mh9uzEIOYhx8cLWvWd6cjDI9tog0a
pKarTRI3BPvcDzNA2ZCTJjSkt2CHzwV2YuYQs8jIIGzmoeOKHaW4yuUYqlEfd45tbZu+UUoJ
4EjH9o8AGWux5l3HM9B59Bk1E2R9u1pdEdo2VacR4LWjTiUY2zeMfd+LgnmpkE4xKh2IeANe
wnean9NI6R82JM/nH4RXY5yfSakWMATo0Dr1kNK+LAFjqhcR4XCGbxX/s8D2spprzdni8fId
bijgTq5Lupwfwt8Xq+IOA4l06eLl/HM4pJ+ff1wXny+L18vl8fL4vwtweyvntL08f198ub4t
XuAD4tPrl+uQEtqcv5y/QtTYx/npHqdimoSGeNMczhvTx0xMi8JO20TvUwHQdrsjvonTTTZb
YhBKwaanrQn/fM3z+Z039WWxef64LIrzz+kCs8QeLmMuhseLdFeOvZjXp7qSnZphMQfVBHSg
nXaFIUL3yKE3bs4hmmdakoFjbOVoGq40Tixjw0eY2dIPOdTr/irRXIyjTg2gYOWHMjfnx6+X
9z/Sj/Pz3/n6eUHpLd4u//p4eruIzUewDJsu3LXxwXhBT82PRLUc2I4gXHZreFw18pHdPGPS
v++OyB4sOsnzzMgCwcjuIOZil6XweKmbDQBncMkMgWzSPNFLAq9ReZrRRlzDmhr4c+egIDmU
F7nO7LoucKzZWoixhMisVJ2AzDMrc9UBU0906LCuuNylO0aGExa12XeZph5wIXny1SxGVs82
NdOfpiJwY5sZvvwl90HiU+Yhggkfzul9kqfmeJ64hbE0P2UFGfkaWw3XMinvuCK+1/PmehT/
Z7+hbkKwTZqmwEcYV+f2OT/6Kz40sJ71IW65xDQybE2qVLNtlzGxZa3zI9vJLwnEGIOT6Pqg
Uu8533HW359QAkf6IwquyzsMdu949pE6TyBLx9VF/ofrWbMFcsCWvkW5MkEZQexBLlv8dtAx
tfXJNq47ca8zDu7m288fTw/nZ7Gg06O72Uqrd1U3Qh1Lsnyv11D4aV2Rl2ss3u5rPSTCSMSV
8bS6HxRrQ/tgyrvyxy9pO9PrgtS58mpk4gOgMMSKnLNSLZS4QAYnvBJ1CLRXH07Vrjytdus1
GC5MfKcpOlonbVHYW5e3p+/fLm+8vyatW+2sQYncpTPdYNMC9ReKnp6oOcYO6b8bVYY9VQ5Q
XZMK21W6rfJA5TmhBqsi4Lkimq2tK85rbkuVMccJtP23J4Ihgb7y9N0yD0Wi7ny7sry/oZwX
+QriWNWdcj2JfcIV5VOhqcpDP+us9So76rTdPtGmMv657nS5DHRiP6P54sR0UhxZsEL63jyA
lSH4s8KU/UUmsKvoDJGeFd624nvIX8iSjI6nsKx5v/DeMbZvrU11Exf9tUNjgm40F9Sfd8jS
2H2TmUY7qMwn4ZdpyvpAXxCUpJvFMisxBrf83VdQRh1QioDQvT89/JN4iTck2VUdWF1xHWNX
ZlTSX94ajFmxfF2Cv4t5vf7Ey/Hq5IZHAm092TXPRM4gAMOd9lBLR3fyoRYui+BaWfrIyn+J
j6QT10Q7DTf5MrJqQYmoQOnaHmAbrjboEwAlA989Z8LEZHHMbGGPMH3FRXrn+qbHDaK8pPRd
h7YsnBg86uUDwvgdd16u+LxrzhU+opLGISMaOcdZrsJu3JRKhA5wNIH2VC0mCEJ6ECxRNrye
onSmEfX0IorG8whXTSMmv6iYiC5B9OdZh541T95/w56105vLrKcbX0kOPMrrC6ROD4P0PFep
E1rm3mOuF+mtY0kM1uOzrFiReJFNhsQVXT69OdTHl/cfjUi8KkT6HUsdP9JFm3euvS5cO9Lb
3QPCt5Q27/AG5/Pz0+s/f7N/Rz2r3awWvT3CB4QioL5RL36bvnT8Lh/GhTQxRLhRAMVRidqI
RHgtpZHgqXu4UqrM3p6+ftU+AAih80VmYzI6jZMkg3fXXMNh9yQHxh/NV3FF7WNZGkOc1Bru
sruk3UmReRCa3eQDdWoL8vRR3ge/J2PBCJoepPVgUqfZqUwyLcvBYGhGO2VtC2+TMOJdLl95
I08WeLKBGtLy0IkCdaoJumuRXmd7UPGgJ2iZa8+pRzfU+bzlPG2gqsY9ozVn9GwisTujNVUq
P8xgyUkJqwQEcJ7nh3Y4R8QmJz8g5MRtwmreh+QYApxjrN5SWgagsyslIFZ6mHlhwcp4Jq/v
l7cvZ+3yFNJwVWktxpKhJGRo2jrRS0PA9H4e69ju8fBMfjGDWs126yGVeK6oPqbpoXi18j5l
HfkaZ2Q5GhKnHT/0Gh6QSSyB4VnMxOKb3tX1LNv7MvT+n7EnaW7cZvb+foVqTknVN4l2S4c5
QCQlMeJmLpI8F5ZjKx5VLMslyy/x9+tfN8ClATY87zA1VncTOxoN9Dblj/iaBsPozC3v1jWN
9Jv6pKtpNnFGN0Our34WwPbhZRedxmKtahDxL3A10R5I+KQpNYUMjcp7UVGKvp48VsON2Fc2
jeSTr2c/mY7xIOe93yqCxe1ouNF5AIIzkOXmNJh3jViGo4HhEFrPGqxPiyszIZnM+GCUtJQh
61NaEXjhqD+8YRuAbnyjzr7EHJHWfSmz7UZolNGklEV6tGDv7mdmz4BsyjrytVM0HNhaC/2Y
O8NOextlw08qd8LYzmerHT3kvfNagonmrUngE3bJIZOYTTBmvx9wZkWE7mY85EoejmmE4QZe
e0R3aszyzeAmF5+xi3A8y/XkWRQz+nwDI8mECznaEGThdMj1ZXE71sIoNxObTBw9QXONwRn/
bC9+v4tu9Uh8zVyr4C6dtXJ++eokxc9WyjKHv362N7Noazss5TAYIT2a3t7gg+tHazKq/Bps
TXJDYTOuANSiWHIWFdld5MjnV6Z9oti3CoMKhiFwdPsxdzy+obHK/XCFKSx8vwwc02rNkhy3
8Hkz8O2SvWRhAATidtaSL+L9qvBYDSx+QxPeqN94xyl0P0oJtlmzVOgF+kpZPPUkgR8lhfYs
XlcX6h2qLF8eLue381/X3vrj9XD5uu09vR/eroyBsLQnI0Ov7MvyzEkwVAQ1zVMYpp2yxv3h
pb6AMRZTGLuL+VLDo8Le2+bO2kpiebzDj0F4rFroZ2xSbCSCf/iSv0zjKPcizcAE0asot0mS
Ep2KKJetlG5tTB3Zzo/zYIHUetiyHPO8nfTikq0D5bStsbQ5gTXp0LwgCERXtXIPN39Pr6dK
odruxFysMMcv2yWMGtp4LnY3eb3DQnVXpMXWmYWseZ4bgsRPOC7grNM4bPOwaztO4YB/JqhY
Yb+uQmcFCbmVEiDsQBJvp0bA7SHXwvhJxGYhDU1bM1X2QTUIRBTvW4uc1j9QXv3LdZwnQUED
XQYbXCiw3lVC1HoPYXgXwGHYt0RQ7aR6mUJczZyd8+l0fuk5Mr2z9C/553z5m24qLGiduRtu
iJrizKgHBJP5k9FEO/l05IB7Y9NJxmNbydT3j2Ac1/Fu+lNLpYids+IkJcrgQt4vnYStYOto
kVXWO5APIwzB2+FYamSz8/uFC0UHZQEzwoeECcmHCNBF4JrQUPjBIiYZ55p9Fa61oyBxOLah
8giXIRZxMso0FL8+dLQoBU2UrECGH/sKU4YfH3oS2Uvunw5XmRA86xh8yq/9eEtCKMVLBaYt
F6GrgEz7QRJISxmPmrRKGZJWxXSBZbbVWApF1daYnwRCVoTLIE6Su3JH2u6nt2XqhaLJUJYe
TufrAX10WZHLQ9tjfFjovli8nt6emFtIEmZaIFoJkDIML69JtIxLspL6fABwcpskMyUK6fiz
89NG8QKr9eVxh2lHXdPttqGV2qOPLrgKvsuh6oTjqg4YjF+yj7fr4dSLgQH9OL7+2nvDJ9O/
YEW16h3lFHd6Pj8BODtT+VGiFpfz/ePD+cThjr+Few5++37/DJ+Y37QHWmwG/1PCx/H5+PKv
8VF9zqmgxltHi0+XyDNvmXq33GvgPnfkM6Ms3Pv3+gCM2B7MWZHL+NR/CIdjxxVFpeAwP6yW
NIbTnnP3v4qMCwnYokajCcc3WwLjjb5CpPlsfjMSHXgWTib9IVNVbRhir6vAGLF1OEyqmItT
IvT7dJ1jpjBlOqERVLDS0axMCAL1b1UsMo5VAOFm6S8luV5Z9byOB7+qVsOqP5cZ+43ewrr6
DA3fGpIhJclqA3WzE4CoPugsaPHwcHg+XM6ng577WLj7YEQzklUAI6dpKAb0+rQIncGkL9UG
AQ/Vv3fFcKa9GblixCarQM7v6qe5AnE3dImh7t1y/CrpTLVCaRU645RX6JHY+5yMutlnrhZH
SwIs4Uw3e+ePzaA/oLEFndGQJrALQ3GjJcisAPooIXA61T+bjanqEQDzyWRgWMhUUBOgx+yU
rtv8UwjgpkN2s2f5ZjYyggIAaCEmXbNKoSLNoMP38el4vX/uAZMDzmaut5shzSQFv+dUG+c4
A5DFBsj76PLBCLTAJTSoF209OK+9JocruXTubwaaHKryxmCpnM4td4ZjPdycBM344ZI4Pigj
MNSRFj5X7OdT+sKGaeBUsqYKEIlCT8bVJi/whW471WK2Rj/ayXHloRHGbje5VTN/+wF9gcO4
oq7Tnw0cA2ak9Wnjj2qTsF1OB/3SaGkb09Uc8eqIf32Go58GAPlxOEkzwyooBj0MRR4IYIbr
ytmKE+WdbGZMt7i1WMdvv8/ocqMcgyaKNDmGQdPp0vr4WD98AXl11SJCMT6rZG22omHr3Zwl
9YfcR8Cp9I94XNXk6pr3/qLvOZhvDJ3slk1MF7faoVeM1SK3rbZX27F3J/0pd2nD0Jg6RwfI
eMxrUwA1mY/YmYNuaKpgN4nzCtIeANl4bAuwOh2ORpbgqmI/GVg26WQ21Pfk+Iam/1VrWrVC
afZgSh/fT6ePNjILmQdl+OdttSBjcoKkB4DC2zHwpRfl2otFh0TJFJ1Vt0RvgMPLw0cv+3i5
/ji8Hf+Llgeum/2eBEGzueS1VF7g7q/ny+/u8e16Of75TkNRJD/u3w5fAyA8PPaC8/m19wuU
8Gvvr6aGN1JD/VW9jJ4+Lue3h/ProffW7N9GJlgNpprkgL87gXSTYtSf9K0RfqvlvrpLY+uZ
7eerSt2uduTh/vn6gzCUGnq59tL766EXnl+OV62tYumNNe0ESsF9TZNeQYZNLe+n4+Px+tHt
uAiHIz09q7vOB7zua+3iqcc6FueZltZM/dZ5wTovjJxi/k2fDcuKiDYGlA8L4opWK6fD/dv7
RUVGeodB0abPN6bPZ6ZvE+6nnDTnR1uc2qmcWk08pwiGrwVZOHWzvQ1OGWhwfPpxZYYf03KJ
gAaAcf9wy0yLTioC4B5UySkSN5trZhISMteGYD24mRi/dVbohKPhwKLmRJyFYwGKt3QDBIyU
UcN0asnqR4+rKoRKGnNra5UMRQLrQfT75DLTHDdZMJz39RimOm7I6eQkajDUWvtHJgbDAasm
TdL+xJbl025NmKdGxPUWtYXdOWYTp8HWHevRi+IkH/V1TV0iMLUzQtntMxgYSZPzzWhk0avB
ci22fjbkhcjcyUbjAX+qSdwNG0arziMIozyhgqYE6AlhATSejLh+FNlkMKO5+bZOFOhDs/XC
YNrXwq0FU+0K+B1Gb6gSYyoF0f3Ty+Gq7pfMdtzM5jQRo/xNb52b/nyuy3DVbTIUq8iWR0Ks
YDvreRDg5jUZjvkZqZiILLFzinQWIKaInI1HZt3/08SGfX0+6IH5pJRXNOZ4/svD8/GlMyIS
V5vp9b723q73L48gg70cqOTlSwVd7qVpkeTcrZ72Ce2cmqcCQ8R7PV+Brx/biz8Vy4bsKgPR
f6a7F6GIBLyAmwPATGhayTwJ6AFpNgN6S8+XIEzmg357aicYfE9GSmUuAoukP+2HnB3gIkyG
+vsE/u4eLTVfXIiUBoNIjN4mwWAwsS26JIBFR6/y2US/4snfHQkHoCNOHK0WZR3Fh4Hq3cgn
Y5qJdJ0M+1Otpu+JgBNm2lmz8qB8QYdjYy0ml/O/xxMKMWj18njEBfnAzkDguyLFkA1eubVY
Vy3dm5uxJd9Bli5Zz7RsP9dcF5Guuarkh9MrCq6WRREG+3l/yiqWFIoah+dh0u9Pjd83lIve
ZdTyWv6mjDLKF9oP1GLoAF/PBCZBlhB1iFMh5nL6rongxI9WSUwDxyA0j+PALBwu2lxkF0me
iiirIlq3V/PQsypZk13XzNJPb2XYSiayR3qLLrjt66VIw3KF0SzEvozSbwPCzBJ09uX9/mCF
ezmJPE1TQEjfS7+TDmUZOtqPcik2ngpM3VSJYOCIW5/N7YhYTHnqlVXkW624KoNS4/y9vutl
73++SQVG2/86i6Ryf2yPLScsN5grBD05EcmpwNd36DhXDmdRKN02NRGEIrEQfq6AykkcIb0t
rRShSJJ1HHll6IbTqcUqEwnl25JyIrW0l1DQ6H6IqqIcycbqmBxAAy2hhUo4KpKuqi4VCW94
EzqLzrJMDhc0kZOM6qQuct0VmgqitsrXReTiq1TQRHgXL4+X8/GRSCmRm8Y+CWRRAcqFj9/C
OnasuMrg4duXP4/oEvCfH/9Uf/zvy6P664u9VBA6gqXufewKov6VJtCNkdWud73cP0hObnY5
y8lahh/V44NmwRGini6tsq7wPv6EaO2JNF941O9SzVeuRQ2rYaZVkomWBiWdksqVpbQs5wOn
NQSw8j6rLsm52moz83rPJyt6B1TK8wQnxnho76Bqh9SW7UBRZbhKa1Jnm7Dtl3SL1HdX3PAv
M6KOhx9lFQDLdF4iKFvIHyTJ+EB+MvxbEnj7Vmgkci0bCb/A19/VzXzIOeEjtmohgaA1Gdn+
Idy6aOSeyEdDK2ljpbTM5BWDvbVmgR/q+mgAKO5UZYVQT2PHy+mf+wuvXnU526g60jkqFkOd
QbleAPxpUbAj7DruQrAPUhg9pvQXS4wdEBGustyVzrJN8ctA4YKPEeI0c7lVHK8C77OA7IW3
9OFQkGdoJTs9Xe57f9VDoYeVXh6fQaKShxoRyF1HOGuv3GHUPuUVRFcipmf0YQ04AXGZ2aOM
QXtSQ8qFzFSNod7bMnzoA4L9iOzAEFgi6ivuTDxZx6UXOeldYklnvcyiOPeXRB/smgBfAZQj
FS1aKAQ7u7dFnPOulGgyt8zGNgfgJVTDxwGIt16Kidp1P6cWCoKP66eek5euJSooRyuCnYCd
tAQhKt59WmuJxw45XAgmwmHemylECMEeBlH2vGv8dP/wg1qPLDO5knR2pRYX5re3DFpFsfaz
PF6lgvcLr6nssRtqiniBHl5l4DPuOsnb4f3xDLvj+dDZBWi/Y8yPBG0sWiWJ3IZ6plEJRNk1
DwwgWsJiqDXfyMAmkSBUB27qcYt846UR3WgGB4HrjN5mCWj3LP/YJGn2Is8tEWiLlZcHC3Yl
N4H3Vv5KRLmvekZtEPE/9F4nrQyBL6pYGndwcoUEE8t0MIq81fLKTW9MRgMEZp1ldpPUP5bL
bMjvQgdWF22W+l2GuWbFC3cD2R5uzqU1KZlZ+RttzdCMFi0I1Z2ezq8iCb7HDdpaMFCN20JO
XeTasaNn4yFtgI78pGVm4z8Jt8K0sqZmu0zbyxVrfkG78PNmdJrw5fm/4y8dojpiilkZ2srZ
C4eVQURxL4fDccOv4MhY6/h7OzR+j2gDFMTcnRSphbxHSLYTvFCpyEuLfxXGObQZvOOXeF5V
TrhuxK3Lmgi5EMjRQGR0hJOqgInDJULF8CKu+HDAmz+xp9pAmaE+4Y6Z0guY+l2u9OjXFdR+
NjhesrawBF+PmIK/PzmsJHrniU2Z7JAL8jcVSVUkaJpvx3fYL0V2nGJbqEWR1ODx+pdgzO1P
euD+P9qXhYuRRXcp8dV5yxPErrAJScLGXKOA7qKA7Ovj23k2m8y/Dr5QNHqAy1N1PCLveRrm
BjAfPOZmYsHM9LzXBo57OzdIJpbGzCa2ZhqZCgwcPwcG0c/bRVVHBmZsxUw+aRdnZWqQzC0F
z0dTG4aqWY1vhhrv0XBjPlGD3pwb7sUYSeAmiuurnFl7OxhOOCc+k2ZgFiD9zaxNq+vlFHYU
3+l4jeA0xxQ/NttTIzhLAYqf2mrk1BkUP7d9OPhZWwfWxg54dSqSbGJ/VvJCbIPmHosQGQoH
ZT2aEKAGO16Q+47OIBQ8yr2C6pEaTBqL3BeR2QeJu0v9IPA5zVJNshJeQJ9YG3jqeZtuO3wH
Ayq6DCIq/Jxrg+yozwZhrEnyIt342dqcwCJf8q73btBVHWwOl5fDc+/H/cPfx5en9nKVS5HA
T29B1lxlpqPJ6+X4cv1bqaJOh7cn4g/a3JL8KMfgT6F+1UDZDtMtBN4WxZPqwLhp7h3ypsBQ
jMnjPQpJVfkuDCv/JlCH7eYDXzvn0yvcKb9i8tAe3Ikf/lZp3B4U/NLtkDqq/WhJghW1MLzi
F46nXUsINksCnxekCZG7E+mSNzZYuQuM2eInFinHi9APp4QC0KEShGwHLghsEBhFGBZZjtlP
HLJUlyBBqyK+zQbzIX2MhoqBMYZwlQ0tzuyecGXBgg9aHhUyguxduIgD/UqDkx3vIlZtXodp
JJ50UA9a3RtNV4SZihODd9dQ5I62L0ycGiqMacw+rKMmbCtQk6pHnqlaFOObuxIq0U8hIc5O
MlEI3vnTWxbYuDmpmfjW/3fAUVVhBY2KlVD/TQvH1nMPf74/PWmbV46qt88xU0q3+YhVKRo7
i7VB1Qvl0zsg1pLEwPQj29VelZqCcJmLTjwWg0o9A3FyZhYUCyXiGz6V1aiEXhjAZHS7U2Os
a0vNdJEZTs8KueWWcvOaUtH4aV50J6oFG2UqfxjY7z53T25iKeOaQr0g32HZanzvWwbxrrML
eKT8XDZ+IzKaxKH+2TRUAnD1pPyTqsLHRY5v39z7l8T7UfU0Xp8nGJ1X1XXqjOXGibdaE+D3
JyslW6PC22Tpch/00Dr2/VUx8/X9yxM1Y4ELbJG0jgjEI26Zd5HaeZMI4I6UMIHDmZMP7MTI
UArY8O2MpK5RqzQUoHPWUEiGJ09TmN8wYWk+bzsh/HnbTeKm7WQmsLJyjSrlXGQbdrp2t8Bn
gdu6MftwI0sGphxrygcNXFU80JE4DrAA27GUCR+6d3AJ7rwNaN8oDuBFLn+mYE0bz0uUokOZ
6KChdsN0e7+8vR5f0Hj77T+90/v18O8B/jhcH3777bdf9bWnisRn0G6stSSFLcupVOSH2AUr
u0hzOM5zb+9lHVZQ+UCbcAv5bqcwwG/jXSLytUmQ7jLtIU1BZQvr84S0GuSQLv+rENbO1PHp
As9LuIpw8ETiN6r4rDNWsAEwArj9tGm7WZXBNEaXfqmyHlaLRLYwKUlA/zFmque5sKZSkPT1
0AnVcaSOOGvn4V8VlL/TdV+zOlDHhF+aSWaqaec2m0JJHZpvBDtRKAckWLgsgdTRdZxJnYIV
M+SiBaT2GO8Uko3ZJwApbLNESPAIhPGGga23+3BgFIITYa3Cu80+eWCslvxtJcyl8sjlHveg
FVWcB7kNvdoKilzlqkHtBCykCnWWiFg5L0GG/qw87YroYcQSno7XtEmJs2kYp5ktIiUgd4Mu
ttsLeh85d3nMbV/U15Lt0eVwUgBpqpFEqQ27SkWy5mnqa93S2IUMstz5+RqDpZpSVIUOnbiI
cjnuqWuQoEZQLj2kBBk36sieS9gs1LNZBfmoSlNFE+kHitH5fjs3nVVMdpfvejIz0GA0H8vs
6Sg4ansXYMgP7Qs9hYbA/pE7DZuAcYp4Cy4vtOxGKZ3DxRKFeOgdGjsbSyMT6AfFpuNs5U64
xGpCHvz+TMAuFihHwj8/9797yGHb8ZQ4WliXmO2jIoOL3SqCcbAEKZc0UWEpQgqykubz2wEa
g5V+Jk/GnUfWF0bgqdi8lLgK7Zj0RBrcVa8bTAUyfE8uFQa6HrtFaN5MistxJjpuXMAFr6MK
rMSeYLEMiozNEosTivZC5j5visCmqHCv6WdnLDrl4euNjIte9vezfivPmTgYvwGPK+TfxPVe
w0Yx3EFGbdMaLFbHTi+h8Pj0Kw1F0Xl8Milk9eTYrvgwbSK0TpcB5OMWCuF6eKREWOPrxrAd
Q1z18s6lmeyoMmtOZUxyFPrs/BgTKV882LMxKWC7SZGtEr2b46yIdspsEg5XbZvWcPXYJBkr
4zKZHR7eL2jr3nmFQy0ZubvCL6lVFlSUVtn8oNOIh4200kZyUX3HSn0FfOfWlZDXNWnJUGFY
k4+70l3DRHgq+S2VGD2nSP0c8HB1k+bSeeo7eZegC1lyxVSa7c4bmgzEgw/wgTCPePoIphVS
7pdsHvGGTr8EVJaZe/NQl4bYEYwOygBOnNyp24AwrqIdMl5UAWaC9l/KsJV/nMtlCh0vxfx0
ay9IqJDAolVHvvz+9ufx5ff3t8MFs3R9/XF4fkWD3+74ZKER0KVLAos+vuNjDTY0IoGNHPIO
/jXNnQiFPsSrajW0DKcGlhmcWwLlZo7paOWAWBB6IkMRO3FAnnP33wZ9is29MKkiybUVARyv
8xWK535Ak/k8ESGpeV1TzZfj6f4LR4E6+TJbi4Heeor+9uXtx/1A+1r5BSRx4Dt3ZhfwMbpC
WVoHE5MKn16zKLR9B9GYAPscWDez3ebC6XL8Zo9/aTohOUpcvyk4l4/X67n3gBkIz5eeWpkk
Kpkkhm210mKAaeBhFw7jwAK7pItg48icc3ZM9yM5NRywS5rSQ6mFsYTEQMlourUlwtb6TZJ0
qf+vsatbalyHwa/CI9B2y4FLx3FaL/kjTvp3k+mynKUXwAyF2T1vfywnTuxILjvDDFN9quy4
sqzIsnzv5jZbCbCKEN1RDNFib2OhJwoeU85Sj2YsZyuiez19TggEA/alwDaWyth9GwrxuVbJ
bH6bNSkCwLkliXgESvN/XNl7MiwfD41oBPqC+Yf1LgvQWVOv9fpKjEDAbexRJTMsbJU2cBbC
mHztvNjZxT4/nuFc4+Px4+nnlXh9hNmm/Yqr36eP5yt2Pr89ngwUHz+OaNZx905T2xD3Cnta
zjXTf/NrbXv2swV5uN/2XjzIDalGa6ZduA3yiCJTHgKWrTPuYEQNH0+otysL1hX1FTJOOnQt
QsOQVlukGWXXHZ+4I7RTO01b/Z4/FGk4np9DD5gxjtpZZ4xoBxqfcm6ysUhIfPr1dPZq1A5q
yxfkUVIPH0rmESBq11D1eKTUFNRgPbuOZYJ1i7SrVqeIn81Cxl8nC8HYORh/Q53M4iWeq1Kr
oXb1MkkpVpXFM7KqgIO7pRhG8nx5Q8waDSzIgtt2rni+gUNslVJiQUjUoG6qgy/KXc7mgxBC
foY1vhdNIyAuiyhZ8OT0Fygy+UzZhUepV9XsDovalssZVkujX63RyjaXfhFIbm4mxDOQCUVo
gqZOyjJivNNJ4oEAtM1fEJE3kVToGVjFKZlRWmyhAHFYnuVAd0JN8WC/OYPCwJI6WzXhsDLQ
1Le4HgI9AmyzG1v7inMeZoWMjkkyroPhWW6obusUww21TADd+WJ4JGKBzb6mLVoRi7HVqfzE
/KfTVPulY80OjEpvsZOFpUqvw3hudfTgA/frdxAIDT7s++DGRFWKHLtOPV0bHjEPq5nloof5
Avf8y19FZWSDpSCLmA7eGPaE622RSGKt6ukhdbRw4Ffw4Xax9S4N8Hm8uTMkdkF5ipNbpG1Q
vcQvnm7dmEOBfqXbb9iepgf805szE9Z8VsfXn28vV/nny4+nd1vMq+sJMn+5gmOAVU5F9Gx/
q2hl7xUgkN4DmkruMHbJChqWzgfEACJ+l3UtKggiFuWeaNBs/cAmRDi9fsKo+ve1v2KuArlF
Uz54sw0/sln0/Ow9i2wJG7VpSxb7e+cYM8sinkkuh17NL3UeWDmn9tMchgeG34V7un4Zvb1b
/uHY6bUMfLHb7YJf5zfzMGhlbxJKy1z5m+Srh7SNbag6GA5fLrWW0V3qoJbnOVzqGOhSV0r7
chucV8IxAkzts0xAVNbEcU1QngLLJkp7HtVEPttueX3XcgGhSwmplxDBV+4Lf3nP1T9DduuA
doYBKrz9a95Oz+Yaw/Pp12tXS8Vkpnp77t1pJjdUXXkRf4wriDqNwckON+ldbo9Dkcwij1m1
n7ZHRTQ7wVFqrlRQdbBrI4eZkyaHYYyLmYjyvV8lvs+mkwcU2u5r5vx4P77/d/X+9vlxenXf
HyOtMgLudnF+qi5C76bs2Rohqq5yXu7hao7Mnj8mWFKRB9Bc1G1TS/dUjIXgbDmcCof70WWN
8ZJLqG7PSgxNyGaLEU548azc8XWX9VKJZMIBm5AJ+IR9AQHph5+4ngXarLtmg88mzh5vuzdU
cjbpftVN6xkmvphPPo4VM14mdD2TRLS/nTQ4IiFvx7CwahvS2I4jIrMrObw0uB30Lz2VEY4B
uHID19mZXB/nUYmG6YOeQIVt0in9oHsCK5XvqhgqcmDcQ6rjGAOVkkwfVp2cUvW4KSm7A5Cn
n/t427h32FFNJZmSHtOeRTLSWe1RVmWEWE2t101GRbh6DqVtLO5kxL8jmq+f4xO3q4P0ctAG
ID24ey0OsDsE+As8rd09MqtLAhISi7TwvGaXCluRtwFIN3gBmjkBiIivvQ/mXIaz6zysfarg
UptLk8FRMS/ZRYFdEtmUBLkArWevTDaEO15qlU7TBSGLpa+Q0KWCOvveTcbUfVskiUkuCmRo
VV6T8YObnZXCsU1n3qcH2Cz1GimqWNI6Gse0kwoXjpRFSkUuslJ6t7DqD0nsGEooKlSJlV72
3PShwWh3t4rInIBKSCnxdoDGZJmuDEhrsja6mg7ulqhJuizcXee6MvlIY0Wj/wHcdAyIx4gB
AA==

--EVF5PPMfhYS0aIcm--
