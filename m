Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754807AbeEaLuw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:50:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:19894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754522AbeEaLuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:50:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="233248209"
Date: Thu, 31 May 2018 19:49:59 +0800
From: kbuild test robot <lkp@intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: kbuild-all@01.org, Boris Brezillon <boris.brezillon@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Ivan Djelic <ivan.djelic@parrot.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bch: Remove VLA usage
Message-ID: <201805311902.8kOGDiKL%fengguang.wu@intel.com>
References: <20180529224207.GA13354@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529224207.GA13354@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc7 next-20180530]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kees-Cook/lib-bch-Remove-VLA-usage/20180531-055540
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> lib/bch.c:237:26: sparse: restricted __be32 degrades to integer

vim +237 lib/bch.c

437aa565 Ivan Djelic 2011-03-11  171  
437aa565 Ivan Djelic 2011-03-11  172  /**
437aa565 Ivan Djelic 2011-03-11  173   * encode_bch - calculate BCH ecc parity of data
437aa565 Ivan Djelic 2011-03-11  174   * @bch:   BCH control structure
437aa565 Ivan Djelic 2011-03-11  175   * @data:  data to encode
437aa565 Ivan Djelic 2011-03-11  176   * @len:   data length in bytes
437aa565 Ivan Djelic 2011-03-11  177   * @ecc:   ecc parity data, must be initialized by caller
437aa565 Ivan Djelic 2011-03-11  178   *
437aa565 Ivan Djelic 2011-03-11  179   * The @ecc parity array is used both as input and output parameter, in order to
437aa565 Ivan Djelic 2011-03-11  180   * allow incremental computations. It should be of the size indicated by member
437aa565 Ivan Djelic 2011-03-11  181   * @ecc_bytes of @bch, and should be initialized to 0 before the first call.
437aa565 Ivan Djelic 2011-03-11  182   *
437aa565 Ivan Djelic 2011-03-11  183   * The exact number of computed ecc parity bits is given by member @ecc_bits of
437aa565 Ivan Djelic 2011-03-11  184   * @bch; it may be less than m*t for large values of t.
437aa565 Ivan Djelic 2011-03-11  185   */
437aa565 Ivan Djelic 2011-03-11  186  void encode_bch(struct bch_control *bch, const uint8_t *data,
437aa565 Ivan Djelic 2011-03-11  187  		unsigned int len, uint8_t *ecc)
437aa565 Ivan Djelic 2011-03-11  188  {
437aa565 Ivan Djelic 2011-03-11  189  	const unsigned int l = BCH_ECC_WORDS(bch)-1;
437aa565 Ivan Djelic 2011-03-11  190  	unsigned int i, mlen;
437aa565 Ivan Djelic 2011-03-11  191  	unsigned long m;
da5dc7be Kees Cook   2018-05-29  192  	uint32_t w;
437aa565 Ivan Djelic 2011-03-11  193  	const uint32_t * const tab0 = bch->mod8_tab;
437aa565 Ivan Djelic 2011-03-11  194  	const uint32_t * const tab1 = tab0 + 256*(l+1);
437aa565 Ivan Djelic 2011-03-11  195  	const uint32_t * const tab2 = tab1 + 256*(l+1);
437aa565 Ivan Djelic 2011-03-11  196  	const uint32_t * const tab3 = tab2 + 256*(l+1);
437aa565 Ivan Djelic 2011-03-11  197  	const uint32_t *pdata, *p0, *p1, *p2, *p3;
437aa565 Ivan Djelic 2011-03-11  198  
437aa565 Ivan Djelic 2011-03-11  199  	if (ecc) {
437aa565 Ivan Djelic 2011-03-11  200  		/* load ecc parity bytes into internal 32-bit buffer */
437aa565 Ivan Djelic 2011-03-11  201  		load_ecc8(bch, bch->ecc_buf, ecc);
437aa565 Ivan Djelic 2011-03-11  202  	} else {
da5dc7be Kees Cook   2018-05-29  203  		memset(bch->ecc_work, 0, bch->ecc_bytes);
437aa565 Ivan Djelic 2011-03-11  204  	}
437aa565 Ivan Djelic 2011-03-11  205  
437aa565 Ivan Djelic 2011-03-11  206  	/* process first unaligned data bytes */
437aa565 Ivan Djelic 2011-03-11  207  	m = ((unsigned long)data) & 3;
437aa565 Ivan Djelic 2011-03-11  208  	if (m) {
437aa565 Ivan Djelic 2011-03-11  209  		mlen = (len < (4-m)) ? len : 4-m;
437aa565 Ivan Djelic 2011-03-11  210  		encode_bch_unaligned(bch, data, mlen, bch->ecc_buf);
437aa565 Ivan Djelic 2011-03-11  211  		data += mlen;
437aa565 Ivan Djelic 2011-03-11  212  		len  -= mlen;
437aa565 Ivan Djelic 2011-03-11  213  	}
437aa565 Ivan Djelic 2011-03-11  214  
437aa565 Ivan Djelic 2011-03-11  215  	/* process 32-bit aligned data words */
437aa565 Ivan Djelic 2011-03-11  216  	pdata = (uint32_t *)data;
437aa565 Ivan Djelic 2011-03-11  217  	mlen  = len/4;
437aa565 Ivan Djelic 2011-03-11  218  	data += 4*mlen;
437aa565 Ivan Djelic 2011-03-11  219  	len  -= 4*mlen;
da5dc7be Kees Cook   2018-05-29  220  	memcpy(bch->ecc_work, bch->ecc_buf, bch->ecc_bytes);
437aa565 Ivan Djelic 2011-03-11  221  
437aa565 Ivan Djelic 2011-03-11  222  	/*
437aa565 Ivan Djelic 2011-03-11  223  	 * split each 32-bit word into 4 polynomials of weight 8 as follows:
437aa565 Ivan Djelic 2011-03-11  224  	 *
437aa565 Ivan Djelic 2011-03-11  225  	 * 31 ...24  23 ...16  15 ... 8  7 ... 0
437aa565 Ivan Djelic 2011-03-11  226  	 * xxxxxxxx  yyyyyyyy  zzzzzzzz  tttttttt
437aa565 Ivan Djelic 2011-03-11  227  	 *                               tttttttt  mod g = r0 (precomputed)
437aa565 Ivan Djelic 2011-03-11  228  	 *                     zzzzzzzz  00000000  mod g = r1 (precomputed)
437aa565 Ivan Djelic 2011-03-11  229  	 *           yyyyyyyy  00000000  00000000  mod g = r2 (precomputed)
437aa565 Ivan Djelic 2011-03-11  230  	 * xxxxxxxx  00000000  00000000  00000000  mod g = r3 (precomputed)
437aa565 Ivan Djelic 2011-03-11  231  	 * xxxxxxxx  yyyyyyyy  zzzzzzzz  tttttttt  mod g = r0^r1^r2^r3
437aa565 Ivan Djelic 2011-03-11  232  	 */
437aa565 Ivan Djelic 2011-03-11  233  	while (mlen--) {
da5dc7be Kees Cook   2018-05-29  234  		uint32_t *r = bch->ecc_work;
da5dc7be Kees Cook   2018-05-29  235  
437aa565 Ivan Djelic 2011-03-11  236  		/* input data is read in big-endian format */
437aa565 Ivan Djelic 2011-03-11 @237  		w = r[0]^cpu_to_be32(*pdata++);
437aa565 Ivan Djelic 2011-03-11  238  		p0 = tab0 + (l+1)*((w >>  0) & 0xff);
437aa565 Ivan Djelic 2011-03-11  239  		p1 = tab1 + (l+1)*((w >>  8) & 0xff);
437aa565 Ivan Djelic 2011-03-11  240  		p2 = tab2 + (l+1)*((w >> 16) & 0xff);
437aa565 Ivan Djelic 2011-03-11  241  		p3 = tab3 + (l+1)*((w >> 24) & 0xff);
437aa565 Ivan Djelic 2011-03-11  242  
437aa565 Ivan Djelic 2011-03-11  243  		for (i = 0; i < l; i++)
437aa565 Ivan Djelic 2011-03-11  244  			r[i] = r[i+1]^p0[i]^p1[i]^p2[i]^p3[i];
437aa565 Ivan Djelic 2011-03-11  245  
437aa565 Ivan Djelic 2011-03-11  246  		r[l] = p0[l]^p1[l]^p2[l]^p3[l];
437aa565 Ivan Djelic 2011-03-11  247  	}
da5dc7be Kees Cook   2018-05-29  248  	memcpy(bch->ecc_buf, bch->ecc_work, bch->ecc_bytes);
437aa565 Ivan Djelic 2011-03-11  249  
437aa565 Ivan Djelic 2011-03-11  250  	/* process last unaligned bytes */
437aa565 Ivan Djelic 2011-03-11  251  	if (len)
437aa565 Ivan Djelic 2011-03-11  252  		encode_bch_unaligned(bch, data, len, bch->ecc_buf);
437aa565 Ivan Djelic 2011-03-11  253  
437aa565 Ivan Djelic 2011-03-11  254  	/* store ecc parity bytes into original parity buffer */
437aa565 Ivan Djelic 2011-03-11  255  	if (ecc)
437aa565 Ivan Djelic 2011-03-11  256  		store_ecc8(bch, ecc, bch->ecc_buf);
437aa565 Ivan Djelic 2011-03-11  257  }
437aa565 Ivan Djelic 2011-03-11  258  EXPORT_SYMBOL_GPL(encode_bch);
437aa565 Ivan Djelic 2011-03-11  259  

:::::: The code at line 237 was first introduced by commit
:::::: 437aa565e2656776a7104aaacd792fe789ea8b2d lib: add shared BCH ECC library

:::::: TO: Ivan Djelic <ivan.djelic@parrot.com>
:::::: CC: David Woodhouse <David.Woodhouse@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
