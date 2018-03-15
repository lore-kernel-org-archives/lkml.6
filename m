Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbeCOKhL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:37:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56102 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbeCOKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:37:08 -0400
Date: Thu, 15 Mar 2018 13:35:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Mike Looijmans <mike.looijmans@topic.nl>
Cc: kbuild-all@01.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] clk: Add driver for the si544 clock generator chip
Message-ID: <20180315103517.qkdqagrasoogp3yj@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520930639-11642-1-git-send-email-mike.looijmans@topic.nl>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803150120
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180314]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mike-Looijmans/clk-Add-driver-for-the-si544-clock-generator-chip/20180314-122736

smatch warnings:
drivers/clk/clk-si544.c:188 si544_calc_muldiv() warn: impossible condition '((frequency * tmp) >= 10800000000) => (0-u32max >= 10800000000)'

# https://github.com/0day-ci/linux/commit/aba3d3de8751c1457bcf0b75bcc901f289a18426
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout aba3d3de8751c1457bcf0b75bcc901f289a18426
vim +188 drivers/clk/clk-si544.c

aba3d3de Mike Looijmans 2018-03-13  168  
aba3d3de Mike Looijmans 2018-03-13  169  /* Calculate divider settings for a given frequency */
aba3d3de Mike Looijmans 2018-03-13  170  static int si544_calc_muldiv(struct clk_si544_muldiv *settings,
aba3d3de Mike Looijmans 2018-03-13  171  	unsigned long frequency)
aba3d3de Mike Looijmans 2018-03-13  172  {
aba3d3de Mike Looijmans 2018-03-13  173  	u64 vco;
aba3d3de Mike Looijmans 2018-03-13  174  	u32 ls_freq;
aba3d3de Mike Looijmans 2018-03-13  175  	u32 tmp;
aba3d3de Mike Looijmans 2018-03-13  176  	u8 res;
aba3d3de Mike Looijmans 2018-03-13  177  
aba3d3de Mike Looijmans 2018-03-13  178  	/* Determine the minimum value of LS_DIV and resulting target freq. */
aba3d3de Mike Looijmans 2018-03-13  179  	ls_freq = frequency;
aba3d3de Mike Looijmans 2018-03-13  180  	settings->ls_div_bits = 0;
aba3d3de Mike Looijmans 2018-03-13  181  
aba3d3de Mike Looijmans 2018-03-13  182  	if (frequency >= (FVCO_MIN / HS_DIV_MAX))
aba3d3de Mike Looijmans 2018-03-13  183  		settings->ls_div_bits = 0;
aba3d3de Mike Looijmans 2018-03-13  184  	else {
aba3d3de Mike Looijmans 2018-03-13  185  		res = 1;
aba3d3de Mike Looijmans 2018-03-13  186  		tmp = 2 * HS_DIV_MAX;
aba3d3de Mike Looijmans 2018-03-13  187  		while (tmp <= (HS_DIV_MAX * 32)) {
aba3d3de Mike Looijmans 2018-03-13 @188  			if ((frequency * tmp) >= FVCO_MIN)
aba3d3de Mike Looijmans 2018-03-13  189  				break;
aba3d3de Mike Looijmans 2018-03-13  190  			++res;
aba3d3de Mike Looijmans 2018-03-13  191  			tmp <<= 1;
aba3d3de Mike Looijmans 2018-03-13  192  		}
aba3d3de Mike Looijmans 2018-03-13  193  		settings->ls_div_bits = res;
aba3d3de Mike Looijmans 2018-03-13  194  		ls_freq = frequency << res;
aba3d3de Mike Looijmans 2018-03-13  195  	}
aba3d3de Mike Looijmans 2018-03-13  196  
aba3d3de Mike Looijmans 2018-03-13  197  	/* Determine minimum HS_DIV by rounding up */
aba3d3de Mike Looijmans 2018-03-13  198  	vco = FVCO_MIN + ls_freq - 1;
aba3d3de Mike Looijmans 2018-03-13  199  	do_div(vco, ls_freq);
aba3d3de Mike Looijmans 2018-03-13  200  	settings->hs_div = vco;
aba3d3de Mike Looijmans 2018-03-13  201  	/* round up to even number if needed */
aba3d3de Mike Looijmans 2018-03-13  202  	if ((settings->hs_div > HS_DIV_MAX_ODD) && (settings->hs_div & 1))
aba3d3de Mike Looijmans 2018-03-13  203  		++settings->hs_div;
aba3d3de Mike Looijmans 2018-03-13  204  	/* Calculate VCO frequency (in 10..12GHz range) */
aba3d3de Mike Looijmans 2018-03-13  205  	vco = (u64)ls_freq * settings->hs_div;
aba3d3de Mike Looijmans 2018-03-13  206  	/* Calculate the integer part of the feedback divider */
aba3d3de Mike Looijmans 2018-03-13  207  	tmp = do_div(vco, FXO);
aba3d3de Mike Looijmans 2018-03-13  208  	settings->fb_div_int = vco;
aba3d3de Mike Looijmans 2018-03-13  209  	/* And the fractional bits using the remainder */
aba3d3de Mike Looijmans 2018-03-13  210  	vco = (u64)tmp << 32;
aba3d3de Mike Looijmans 2018-03-13  211  	do_div(vco, FXO);
aba3d3de Mike Looijmans 2018-03-13  212  	settings->fb_div_frac = vco;
aba3d3de Mike Looijmans 2018-03-13  213  
aba3d3de Mike Looijmans 2018-03-13  214  	return 0;
aba3d3de Mike Looijmans 2018-03-13  215  }
aba3d3de Mike Looijmans 2018-03-13  216  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
