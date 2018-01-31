Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeAaMM2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:12:28 -0500
Received: from mga02.intel.com ([134.134.136.20]:27853 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752179AbeAaMM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:12:27 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,440,1511856000";
   d="gz'50?scan'50,208,50";a="23836105"
Date: Wed, 31 Jan 2018 20:12:11 +0800
From: kbuild test robot <lkp@intel.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: kbuild-all@01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
Message-ID: <201801312036.gXYpKLF3%fengguang.wu@intel.com>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <20180129234900.11121-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Anders,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.15 next-20180126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Anders-Roxell/arch-arm-Kconfig-enable-ARM_MODULE_PLTS-when-LOCKDEP-y/20180131-115917
config: arm-moxart_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/module-plts.c: In function 'in_init':
>> arch/arm/kernel/module-plts.c:36:23: error: dereferencing pointer to incomplete type 'const struct module'
     return loc - (u32)mod->init_layout.base < mod->init_layout.size;
                          ^~
   arch/arm/kernel/module-plts.c: In function 'get_module_plt':
>> arch/arm/kernel/module-plts.c:41:56: error: dereferencing pointer to incomplete type 'struct module'
     struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
                                                           ^~

vim +36 arch/arm/kernel/module-plts.c

7d485f64 Ard Biesheuvel 2014-11-24  33  
b7ede5a1 Ard Biesheuvel 2017-02-22  34  static bool in_init(const struct module *mod, unsigned long loc)
b7ede5a1 Ard Biesheuvel 2017-02-22  35  {
b7ede5a1 Ard Biesheuvel 2017-02-22 @36  	return loc - (u32)mod->init_layout.base < mod->init_layout.size;
b7ede5a1 Ard Biesheuvel 2017-02-22  37  }
b7ede5a1 Ard Biesheuvel 2017-02-22  38  
7d485f64 Ard Biesheuvel 2014-11-24  39  u32 get_module_plt(struct module *mod, unsigned long loc, Elf32_Addr val)
7d485f64 Ard Biesheuvel 2014-11-24  40  {
b7ede5a1 Ard Biesheuvel 2017-02-22 @41  	struct mod_plt_sec *pltsec = !in_init(mod, loc) ? &mod->arch.core :
b7ede5a1 Ard Biesheuvel 2017-02-22  42  							  &mod->arch.init;
b7ede5a1 Ard Biesheuvel 2017-02-22  43  
b7ede5a1 Ard Biesheuvel 2017-02-22  44  	struct plt_entries *plt = (struct plt_entries *)pltsec->plt->sh_addr;
66e94ba3 Ard Biesheuvel 2016-08-18  45  	int idx = 0;
35fa91ee Ard Biesheuvel 2016-08-16  46  
66e94ba3 Ard Biesheuvel 2016-08-18  47  	/*
66e94ba3 Ard Biesheuvel 2016-08-18  48  	 * Look for an existing entry pointing to 'val'. Given that the
66e94ba3 Ard Biesheuvel 2016-08-18  49  	 * relocations are sorted, this will be the last entry we allocated.
66e94ba3 Ard Biesheuvel 2016-08-18  50  	 * (if one exists).
66e94ba3 Ard Biesheuvel 2016-08-18  51  	 */
b7ede5a1 Ard Biesheuvel 2017-02-22  52  	if (pltsec->plt_count > 0) {
b7ede5a1 Ard Biesheuvel 2017-02-22  53  		plt += (pltsec->plt_count - 1) / PLT_ENT_COUNT;
b7ede5a1 Ard Biesheuvel 2017-02-22  54  		idx = (pltsec->plt_count - 1) % PLT_ENT_COUNT;
7d485f64 Ard Biesheuvel 2014-11-24  55  
66e94ba3 Ard Biesheuvel 2016-08-18  56  		if (plt->lit[idx] == val)
66e94ba3 Ard Biesheuvel 2016-08-18  57  			return (u32)&plt->ldr[idx];
66e94ba3 Ard Biesheuvel 2016-08-18  58  
66e94ba3 Ard Biesheuvel 2016-08-18  59  		idx = (idx + 1) % PLT_ENT_COUNT;
66e94ba3 Ard Biesheuvel 2016-08-18  60  		if (!idx)
66e94ba3 Ard Biesheuvel 2016-08-18  61  			plt++;
66e94ba3 Ard Biesheuvel 2016-08-18  62  	}
66e94ba3 Ard Biesheuvel 2016-08-18  63  
b7ede5a1 Ard Biesheuvel 2017-02-22  64  	pltsec->plt_count++;
b7ede5a1 Ard Biesheuvel 2017-02-22  65  	BUG_ON(pltsec->plt_count * PLT_ENT_SIZE > pltsec->plt->sh_size);
7d485f64 Ard Biesheuvel 2014-11-24  66  
66e94ba3 Ard Biesheuvel 2016-08-18  67  	if (!idx)
7d485f64 Ard Biesheuvel 2014-11-24  68  		/* Populate a new set of entries */
7d485f64 Ard Biesheuvel 2014-11-24  69  		*plt = (struct plt_entries){
7d485f64 Ard Biesheuvel 2014-11-24  70  			{ [0 ... PLT_ENT_COUNT - 1] = PLT_ENT_LDR, },
7d485f64 Ard Biesheuvel 2014-11-24  71  			{ val, }
7d485f64 Ard Biesheuvel 2014-11-24  72  		};
66e94ba3 Ard Biesheuvel 2016-08-18  73  	else
66e94ba3 Ard Biesheuvel 2016-08-18  74  		plt->lit[idx] = val;
66e94ba3 Ard Biesheuvel 2016-08-18  75  
66e94ba3 Ard Biesheuvel 2016-08-18  76  	return (u32)&plt->ldr[idx];
7d485f64 Ard Biesheuvel 2014-11-24  77  }
7d485f64 Ard Biesheuvel 2014-11-24  78  

:::::: The code at line 36 was first introduced by commit
:::::: b7ede5a1f5905ac394cc8e61712a13e3c5cb7b8f ARM: 8662/1: module: split core and init PLT sections

:::::: TO: Ard Biesheuvel <ard.biesheuvel@linaro.org>
:::::: CC: Russell King <rmk+kernel@armlinux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
h8UAAA==

--tKW2IUtsqtDRztdT--
