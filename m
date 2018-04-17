Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbeDQL0O (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:26:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbeDQL0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:26:11 -0400
Date: Tue, 17 Apr 2018 14:25:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: kbuild@01.org, Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: kbuild-all@01.org, lee.jones@linaro.org, alexandre.torgue@st.com,
        thierry.reding@gmail.com, benjamin.gaignard@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        mcoquelin.stm32@gmail.com, fabrice.gasnier@st.com,
        benjamin.gaignard@st.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 2/6] mfd: stm32-timers: add support for dmas
Message-ID: <20180417112518.pmvx4rubgxtr4nea@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523895561-4073-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170103
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on pwm/for-next]
[also build test WARNING on v4.17-rc1 next-20180416]
[cannot apply to ljones-mfd/for-mfd-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fabrice-Gasnier/Add-support-for-PWM-input-capture-on-STM32/20180417-052347
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next

smatch warnings:
drivers/mfd/stm32-timers.c:165 stm32_timers_dma_burst_read() warn: warn: dma_mapping_error() doesn't return an error code

# https://github.com/0day-ci/linux/commit/402362a100e6b02b807fbebdc05b7159b565ffa5
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 402362a100e6b02b807fbebdc05b7159b565ffa5
vim +165 drivers/mfd/stm32-timers.c

402362a1 Fabrice Gasnier 2018-04-16   54  
402362a1 Fabrice Gasnier 2018-04-16   55  /**
402362a1 Fabrice Gasnier 2018-04-16   56   * stm32_timers_dma_burst_read - Read from timers registers using DMA.
402362a1 Fabrice Gasnier 2018-04-16   57   *
402362a1 Fabrice Gasnier 2018-04-16   58   * Read from STM32 timers registers using DMA on a single event.
402362a1 Fabrice Gasnier 2018-04-16   59   * @dev: reference to stm32_timers MFD device
402362a1 Fabrice Gasnier 2018-04-16   60   * @buf: DMA'able destination buffer
402362a1 Fabrice Gasnier 2018-04-16   61   * @id: stm32_timers_dmas event identifier (ch[1..4], up, trig or com)
402362a1 Fabrice Gasnier 2018-04-16   62   * @reg: registers start offset for DMA to read from (like CCRx for capture)
402362a1 Fabrice Gasnier 2018-04-16   63   * @num_reg: number of registers to read upon each DMA request, starting @reg.
402362a1 Fabrice Gasnier 2018-04-16   64   * @bursts: number of bursts to read (e.g. like two for pwm period capture)
402362a1 Fabrice Gasnier 2018-04-16   65   * @tmo_ms: timeout (milliseconds)
402362a1 Fabrice Gasnier 2018-04-16   66   */
402362a1 Fabrice Gasnier 2018-04-16   67  int stm32_timers_dma_burst_read(struct device *dev, u32 *buf,
402362a1 Fabrice Gasnier 2018-04-16   68  				enum stm32_timers_dmas id, u32 reg,
402362a1 Fabrice Gasnier 2018-04-16   69  				unsigned int num_reg, unsigned int bursts,
402362a1 Fabrice Gasnier 2018-04-16   70  				unsigned long tmo_ms)
402362a1 Fabrice Gasnier 2018-04-16   71  {
402362a1 Fabrice Gasnier 2018-04-16   72  	struct stm32_timers *ddata = dev_get_drvdata(dev);
402362a1 Fabrice Gasnier 2018-04-16   73  	unsigned long timeout = msecs_to_jiffies(tmo_ms);
402362a1 Fabrice Gasnier 2018-04-16   74  	struct regmap *regmap = ddata->regmap;
402362a1 Fabrice Gasnier 2018-04-16   75  	struct stm32_timers_dma *dma = ddata->dma;
402362a1 Fabrice Gasnier 2018-04-16   76  	size_t len = num_reg * bursts * sizeof(u32);
402362a1 Fabrice Gasnier 2018-04-16   77  	struct dma_async_tx_descriptor *desc;
402362a1 Fabrice Gasnier 2018-04-16   78  	struct dma_slave_config config;
402362a1 Fabrice Gasnier 2018-04-16   79  	dma_cookie_t cookie;
402362a1 Fabrice Gasnier 2018-04-16   80  	dma_addr_t dma_buf;
402362a1 Fabrice Gasnier 2018-04-16   81  	u32 dbl, dba;
402362a1 Fabrice Gasnier 2018-04-16   82  	long err;
402362a1 Fabrice Gasnier 2018-04-16   83  	int ret;
402362a1 Fabrice Gasnier 2018-04-16   84  
402362a1 Fabrice Gasnier 2018-04-16   85  	/* Sanity check */
402362a1 Fabrice Gasnier 2018-04-16   86  	if (id < STM32_TIMERS_DMA_CH1 || id >= STM32_TIMERS_MAX_DMAS)
402362a1 Fabrice Gasnier 2018-04-16   87  		return -EINVAL;
402362a1 Fabrice Gasnier 2018-04-16   88  
402362a1 Fabrice Gasnier 2018-04-16   89  	if (!num_reg || !bursts || reg > STM32_TIMERS_MAX_REGISTERS ||
402362a1 Fabrice Gasnier 2018-04-16   90  	    (reg + num_reg * sizeof(u32)) > STM32_TIMERS_MAX_REGISTERS)
402362a1 Fabrice Gasnier 2018-04-16   91  		return -EINVAL;
402362a1 Fabrice Gasnier 2018-04-16   92  
402362a1 Fabrice Gasnier 2018-04-16   93  	if (!dma->chans[id])
402362a1 Fabrice Gasnier 2018-04-16   94  		return -ENODEV;
402362a1 Fabrice Gasnier 2018-04-16   95  	mutex_lock(&dma->lock);
402362a1 Fabrice Gasnier 2018-04-16   96  
402362a1 Fabrice Gasnier 2018-04-16   97  	/* Select DMA channel in use */
402362a1 Fabrice Gasnier 2018-04-16   98  	dma->chan = dma->chans[id];
402362a1 Fabrice Gasnier 2018-04-16   99  	dma_buf = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
402362a1 Fabrice Gasnier 2018-04-16  100  	ret = dma_mapping_error(dev, dma_buf);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This should be:

	if (dma_mapping_error(dev, dma_buf)) {
		ret = -ENOMEM;
		goto unlock;
	}

402362a1 Fabrice Gasnier 2018-04-16  101  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  102  		goto unlock;
402362a1 Fabrice Gasnier 2018-04-16  103  
402362a1 Fabrice Gasnier 2018-04-16  104  	/* Prepare DMA read from timer registers, using DMA burst mode */
402362a1 Fabrice Gasnier 2018-04-16  105  	memset(&config, 0, sizeof(config));
402362a1 Fabrice Gasnier 2018-04-16  106  	config.src_addr = (dma_addr_t)dma->phys_base + TIM_DMAR;
402362a1 Fabrice Gasnier 2018-04-16  107  	config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
402362a1 Fabrice Gasnier 2018-04-16  108  	ret = dmaengine_slave_config(dma->chan, &config);
402362a1 Fabrice Gasnier 2018-04-16  109  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  110  		goto unmap;
402362a1 Fabrice Gasnier 2018-04-16  111  
402362a1 Fabrice Gasnier 2018-04-16  112  	desc = dmaengine_prep_slave_single(dma->chan, dma_buf, len,
402362a1 Fabrice Gasnier 2018-04-16  113  					   DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
402362a1 Fabrice Gasnier 2018-04-16  114  	if (!desc) {
402362a1 Fabrice Gasnier 2018-04-16  115  		ret = -EBUSY;
402362a1 Fabrice Gasnier 2018-04-16  116  		goto unmap;
402362a1 Fabrice Gasnier 2018-04-16  117  	}
402362a1 Fabrice Gasnier 2018-04-16  118  
402362a1 Fabrice Gasnier 2018-04-16  119  	desc->callback = stm32_timers_dma_done;
402362a1 Fabrice Gasnier 2018-04-16  120  	desc->callback_param = dma;
402362a1 Fabrice Gasnier 2018-04-16  121  	cookie = dmaengine_submit(desc);
402362a1 Fabrice Gasnier 2018-04-16  122  	ret = dma_submit_error(cookie);
402362a1 Fabrice Gasnier 2018-04-16  123  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  124  		goto dma_term;
402362a1 Fabrice Gasnier 2018-04-16  125  
402362a1 Fabrice Gasnier 2018-04-16  126  	reinit_completion(&dma->completion);
402362a1 Fabrice Gasnier 2018-04-16  127  	dma_async_issue_pending(dma->chan);
402362a1 Fabrice Gasnier 2018-04-16  128  
402362a1 Fabrice Gasnier 2018-04-16  129  	/* Setup and enable timer DMA burst mode */
402362a1 Fabrice Gasnier 2018-04-16  130  	dbl = FIELD_PREP(TIM_DCR_DBL, bursts - 1);
402362a1 Fabrice Gasnier 2018-04-16  131  	dba = FIELD_PREP(TIM_DCR_DBA, reg >> 2);
402362a1 Fabrice Gasnier 2018-04-16  132  	ret = regmap_write(regmap, TIM_DCR, dbl | dba);
402362a1 Fabrice Gasnier 2018-04-16  133  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  134  		goto dma_term;
402362a1 Fabrice Gasnier 2018-04-16  135  
402362a1 Fabrice Gasnier 2018-04-16  136  	/* Clear pending flags before enabling DMA request */
402362a1 Fabrice Gasnier 2018-04-16  137  	ret = regmap_write(regmap, TIM_SR, 0);
402362a1 Fabrice Gasnier 2018-04-16  138  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  139  		goto dcr_clr;
402362a1 Fabrice Gasnier 2018-04-16  140  
402362a1 Fabrice Gasnier 2018-04-16  141  	ret = regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id],
402362a1 Fabrice Gasnier 2018-04-16  142  				 stm32_timers_dier_dmaen[id]);
402362a1 Fabrice Gasnier 2018-04-16  143  	if (ret)
402362a1 Fabrice Gasnier 2018-04-16  144  		goto dcr_clr;
402362a1 Fabrice Gasnier 2018-04-16  145  
402362a1 Fabrice Gasnier 2018-04-16  146  	err = wait_for_completion_interruptible_timeout(&dma->completion,
402362a1 Fabrice Gasnier 2018-04-16  147  							timeout);
402362a1 Fabrice Gasnier 2018-04-16  148  	if (err == 0)
402362a1 Fabrice Gasnier 2018-04-16  149  		ret = -ETIMEDOUT;
402362a1 Fabrice Gasnier 2018-04-16  150  	else if (err < 0)
402362a1 Fabrice Gasnier 2018-04-16  151  		ret = err;
402362a1 Fabrice Gasnier 2018-04-16  152  
402362a1 Fabrice Gasnier 2018-04-16  153  	regmap_update_bits(regmap, TIM_DIER, stm32_timers_dier_dmaen[id], 0);
402362a1 Fabrice Gasnier 2018-04-16  154  	regmap_write(regmap, TIM_SR, 0);
402362a1 Fabrice Gasnier 2018-04-16  155  dcr_clr:
402362a1 Fabrice Gasnier 2018-04-16  156  	regmap_write(regmap, TIM_DCR, 0);
402362a1 Fabrice Gasnier 2018-04-16  157  dma_term:
402362a1 Fabrice Gasnier 2018-04-16  158  	dmaengine_terminate_all(dma->chan);
402362a1 Fabrice Gasnier 2018-04-16  159  unmap:
402362a1 Fabrice Gasnier 2018-04-16  160  	dma_unmap_single(dev, dma_buf, len, DMA_FROM_DEVICE);
402362a1 Fabrice Gasnier 2018-04-16  161  unlock:
402362a1 Fabrice Gasnier 2018-04-16  162  	dma->chan = NULL;
402362a1 Fabrice Gasnier 2018-04-16  163  	mutex_unlock(&dma->lock);
402362a1 Fabrice Gasnier 2018-04-16  164  
402362a1 Fabrice Gasnier 2018-04-16 @165  	return ret;
402362a1 Fabrice Gasnier 2018-04-16  166  }
402362a1 Fabrice Gasnier 2018-04-16  167  EXPORT_SYMBOL_GPL(stm32_timers_dma_burst_read);
402362a1 Fabrice Gasnier 2018-04-16  168  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
