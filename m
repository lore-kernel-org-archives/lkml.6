Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeEGIPQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:15:16 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46274 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGIPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:15:13 -0400
Date: Mon, 7 May 2018 11:14:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Taniya Das <tdas@codeaurora.org>
Cc: kbuild-all@01.org, Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: Re: [PATCH] clk: qcom: Add support for RCG to register for DFS
Message-ID: <20180507081454.cshoweumy46obmve@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525320752-15091-1-git-send-email-tdas@codeaurora.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8885 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805070085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Taniya,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.17-rc3 next-20180503]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Taniya-Das/clk-qcom-Add-support-for-RCG-to-register-for-DFS/20180503-220112
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next

smatch warnings:
drivers/clk/qcom/clk-rcg2.c:820 clk_parent_index_pre_div_and_mode() warn: signedness bug returning '(-22)'

# https://github.com/0day-ci/linux/commit/ac73368dea3e89ee63025d4da64dd908bcde367e
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout ac73368dea3e89ee63025d4da64dd908bcde367e
vim +820 drivers/clk/qcom/clk-rcg2.c

ac73368d Taniya Das 2018-05-03  809  
ac73368d Taniya Das 2018-05-03  810  /* Common APIs to be used for DFS based RCGR */
ac73368d Taniya Das 2018-05-03  811  static u8 clk_parent_index_pre_div_and_mode(struct clk_hw *hw, u32 offset,
ac73368d Taniya Das 2018-05-03  812  		u32 *mode, u32 *pre_div)
ac73368d Taniya Das 2018-05-03  813  {
ac73368d Taniya Das 2018-05-03  814  	struct clk_rcg2 *rcg;
ac73368d Taniya Das 2018-05-03  815  	int num_parents;
ac73368d Taniya Das 2018-05-03  816  	u32 cfg, mask;
ac73368d Taniya Das 2018-05-03  817  	int i, ret;
ac73368d Taniya Das 2018-05-03  818  
ac73368d Taniya Das 2018-05-03  819  	if (!hw)
ac73368d Taniya Das 2018-05-03 @820  		return -EINVAL;
ac73368d Taniya Das 2018-05-03  821  
ac73368d Taniya Das 2018-05-03  822  	num_parents = clk_hw_get_num_parents(hw);
ac73368d Taniya Das 2018-05-03  823  
ac73368d Taniya Das 2018-05-03  824  	rcg = to_clk_rcg2(hw);
ac73368d Taniya Das 2018-05-03  825  
ac73368d Taniya Das 2018-05-03  826  	ret = regmap_read(rcg->clkr.regmap, rcg->cmd_rcgr + offset, &cfg);
ac73368d Taniya Das 2018-05-03  827  	if (ret)
ac73368d Taniya Das 2018-05-03  828  		goto err;
ac73368d Taniya Das 2018-05-03  829  
ac73368d Taniya Das 2018-05-03  830  	mask = BIT(rcg->hid_width) - 1;
ac73368d Taniya Das 2018-05-03  831  	*pre_div = cfg & mask ? (cfg & mask) : 1;
ac73368d Taniya Das 2018-05-03  832  
ac73368d Taniya Das 2018-05-03  833  	*mode = cfg & CFG_MODE_MASK;
ac73368d Taniya Das 2018-05-03  834  	*mode >>= CFG_MODE_SHIFT;
ac73368d Taniya Das 2018-05-03  835  
ac73368d Taniya Das 2018-05-03  836  	cfg &= CFG_SRC_SEL_MASK;
ac73368d Taniya Das 2018-05-03  837  	cfg >>= CFG_SRC_SEL_SHIFT;
ac73368d Taniya Das 2018-05-03  838  
ac73368d Taniya Das 2018-05-03  839  	for (i = 0; i < num_parents; i++)
ac73368d Taniya Das 2018-05-03  840  		if (cfg == rcg->parent_map[i].cfg)
ac73368d Taniya Das 2018-05-03  841  			return i;
ac73368d Taniya Das 2018-05-03  842  err:
ac73368d Taniya Das 2018-05-03  843  	return 0;
ac73368d Taniya Das 2018-05-03  844  }
ac73368d Taniya Das 2018-05-03  845  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
