Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeCQTQd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 15:16:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:7454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753192AbeCQTQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 15:16:31 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,321,1517904000";
   d="scan'208";a="34699479"
Date: Sun, 18 Mar 2018 03:16:08 +0800
From: kbuild test robot <lkp@intel.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: kbuild-all@01.org, linus.walleij@linaro.org, andy.shevchenko@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [PATCH v2 3/8] gpio: pci-idio-16: Implement get_multiple callback
Message-ID: <201803180345.UikgMo06%fengguang.wu@intel.com>
References: <b856f88b5f52e1787860f7dbca44673905f79744.1521128287.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b856f88b5f52e1787860f7dbca44673905f79744.1521128287.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/William-Breathitt-Gray/Implement-get_multiple-for-ACCES-and-PC-104-drivers/20180317-224135
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/gpio/gpio-pci-idio-16.c:139:17: sparse: undefined identifier 'word_mask'
   drivers/gpio/gpio-pci-idio-16.c:140:22: sparse: undefined identifier 'word_mask'
>> drivers/gpio/gpio-pci-idio-16.c:120:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pci-idio-16.c:120:52: sparse: dereference of noderef expression
   drivers/gpio/gpio-pci-idio-16.c:121:27: sparse: dereference of noderef expression
   drivers/gpio/gpio-pci-idio-16.c:121:51: sparse: dereference of noderef expression
>> drivers/gpio/gpio-pci-idio-16.c:139:17: sparse: generating address of non-lvalue (3)
   drivers/gpio/gpio-pci-idio-16.c: In function 'idio_16_gpio_get_multiple':
   drivers/gpio/gpio-pci-idio-16.c:139:3: error: 'word_mask' undeclared (first use in this function); did you mean 'port_mask'?
      word_mask = mask[word_index] & (port_mask << word_offset);
      ^~~~~~~~~
      port_mask
   drivers/gpio/gpio-pci-idio-16.c:139:3: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpio/gpio-pci-idio-16.c:146:24: warning: passing argument 1 of 'ioread8' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      port_state = ioread8(ports + i);
                           ^~~~~
   In file included from arch/x86/include/asm/io.h:223:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from arch/x86/include/asm/mmzone_64.h:11,
                    from arch/x86/include/asm/mmzone.h:5,
                    from include/linux/mmzone.h:912,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from drivers/gpio/gpio-pci-idio-16.c:16:
   include/asm-generic/iomap.h:29:21: note: expected 'void *' but argument is of type 'const u8 * {aka const unsigned char *}'
    extern unsigned int ioread8(void __iomem *);
                        ^~~~~~~
   drivers/gpio/gpio-pci-idio-16.c:116:16: warning: unused variable 'mask_word' [-Wunused-variable]
     unsigned long mask_word;
                   ^~~~~~~~~

vim +120 drivers/gpio/gpio-pci-idio-16.c

   106	
   107	static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
   108		unsigned long *mask, unsigned long *bits)
   109	{
   110		struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
   111		size_t i;
   112		const unsigned int gpio_reg_size = 8;
   113		unsigned int bits_offset;
   114		size_t word_index;
   115		unsigned int word_offset;
   116		unsigned long mask_word;
   117		const unsigned long port_mask = GENMASK(gpio_reg_size, 0);
   118		unsigned long port_state;
   119		const u8 __iomem ports[] = {
 > 120			idio16gpio->reg->out0_7, idio16gpio->reg->out8_15,
   121			idio16gpio->reg->in0_7, idio16gpio->reg->in8_15
   122		};
   123	
   124		/* clear bits array to a clean slate */
   125		bitmap_zero(bits, chip->ngpio);
   126	
   127		/* get bits are evaluated a gpio port register at a time */
   128		for (i = 0; i < ARRAY_SIZE(ports); i++) {
   129			/* gpio offset in bits array */
   130			bits_offset = i * gpio_reg_size;
   131	
   132			/* word index for bits array */
   133			word_index = BIT_WORD(bits_offset);
   134	
   135			/* gpio offset within current word of bits array */
   136			word_offset = bits_offset % BITS_PER_LONG;
   137	
   138			/* mask of get bits for current gpio within current word */
 > 139			word_mask = mask[word_index] & (port_mask << word_offset);
   140			if (!word_mask) {
   141				/* no get bits in this port so skip to next one */
   142				continue;
   143			}
   144	
   145			/* read bits from current gpio port */
   146			port_state = ioread8(ports + i);
   147	
   148			/* store acquired bits at respective bits array offset */
   149			bits[word_index] |= port_state << word_offset;
   150		}
   151	
   152		return 0;
   153	}
   154	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
