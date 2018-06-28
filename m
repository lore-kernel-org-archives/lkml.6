Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61DDC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AA7275BB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AA7275BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967276AbeF1Phb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:37:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:22741 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965559AbeF1Ph3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:37:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 08:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,284,1526367600"; 
   d="scan'208";a="241426875"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2018 08:37:26 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fYYz4-000MbM-4C; Thu, 28 Jun 2018 23:37:22 +0800
Date:   Thu, 28 Jun 2018 23:37:08 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     kbuild-all@01.org, jic23@kernel.org, Michael.Hennerich@analog.com,
        lars@metafoo.de, knaack.h@gmx.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        linus.walleij@linaro.org, rdunlap@infradead.org, lukas@wunner.de,
        Ismail.Kose@maximintegrated.com, vilhelm.gray@gmail.com,
        sean.nyekjaer@prevas.dk, pombredanne@nexb.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stefan.popa@analog.com
Subject: Re: [PATCH v3 1/2] iio: dac: Add AD5758 support
Message-ID: <201806282224.bSOTwPPO%fengguang.wu@intel.com>
References: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530188012-28253-1-git-send-email-stefan.popa@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.18-rc2 next-20180628]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Popa/iio-dac-Add-AD5758-support/20180628-205028
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/dac/ad5758.c:402:27: sparse: constant 65535000000 is so big it is long
   drivers/iio/dac/ad5758.c:413:34: sparse: constant 65535000000 is so big it is long
>> drivers/iio/dac/ad5758.c:237:5: sparse: symbol 'cmpfunc' was not declared. Should it be static?

Please review and possibly fold the followup patch.

vim +402 drivers/iio/dac/ad5758.c

   236	
 > 237	int cmpfunc(const void *a, const void *b)
   238	{
   239		return (*(int *)a - *(int *)b);
   240	}
   241	
   242	static int ad5758_find_closest_match(const int *array,
   243					     unsigned int size, int val)
   244	{
   245		int i;
   246	
   247		for (i = 0; i < size; i++) {
   248			if (val <= array[i])
   249				return i;
   250		}
   251	
   252		return size - 1;
   253	}
   254	
   255	static int ad5758_wait_for_task_complete(struct ad5758_state *st,
   256						 unsigned int reg,
   257						 unsigned int mask)
   258	{
   259		unsigned int timeout;
   260		int ret;
   261	
   262		timeout = 10;
   263		do {
   264			ret = ad5758_spi_reg_read(st, reg);
   265			if (ret < 0)
   266				return ret;
   267	
   268			if (!(ret & mask))
   269				return 0;
   270	
   271			udelay(100);
   272		} while (--timeout);
   273	
   274		dev_err(&st->spi->dev,
   275			"Error reading bit 0x%x in 0x%x register\n", mask, reg);
   276	
   277		return -EIO;
   278	}
   279	
   280	static int ad5758_calib_mem_refresh(struct ad5758_state *st)
   281	{
   282		int ret;
   283	
   284		ret = ad5758_spi_reg_write(st, AD5758_KEY,
   285					   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
   286		if (ret < 0) {
   287			dev_err(&st->spi->dev,
   288				"Failed to initiate a calibration memory refresh\n");
   289			return ret;
   290		}
   291	
   292		/* Wait to allow time for the internal calibrations to complete */
   293		return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
   294						     AD5758_CAL_MEM_UNREFRESHED_MSK);
   295	}
   296	
   297	static int ad5758_soft_reset(struct ad5758_state *st)
   298	{
   299		int ret;
   300	
   301		ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
   302		if (ret < 0)
   303			return ret;
   304	
   305		ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
   306	
   307		/* Perform a software reset and wait 100us */
   308		udelay(100);
   309	
   310		return ret;
   311	}
   312	
   313	static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
   314					      enum ad5758_dc_dc_mode mode)
   315	{
   316		int ret;
   317	
   318		ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
   319					    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
   320					    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
   321		if (ret < 0)
   322			return ret;
   323	
   324		/*
   325		 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
   326		 * This allows the 3-wire interface communication to complete.
   327		 */
   328		ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
   329						    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
   330		if (ret < 0)
   331			return ret;
   332	
   333		st->dc_dc_mode = mode;
   334	
   335		return ret;
   336	}
   337	
   338	static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
   339	{
   340		int ret;
   341	
   342		ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
   343					    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
   344					    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
   345		if (ret < 0)
   346			return ret;
   347		/*
   348		 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
   349		 * This allows the 3-wire interface communication to complete.
   350		 */
   351		return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
   352						     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
   353	}
   354	
   355	static int ad5758_slew_rate_set(struct ad5758_state *st,
   356					unsigned int sr_clk_idx,
   357					unsigned int sr_step_idx)
   358	{
   359		unsigned int mode;
   360		unsigned long int mask;
   361		int ret;
   362	
   363		mask = AD5758_DAC_CONFIG_SR_EN_MSK |
   364		       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
   365		       AD5758_DAC_CONFIG_SR_STEP_MSK;
   366		mode = AD5758_DAC_CONFIG_SR_EN_MODE(1) |
   367			AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step_idx) |
   368			AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk_idx);
   369	
   370		ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
   371		if (ret < 0)
   372			return ret;
   373	
   374		/* Wait to allow time for the internal calibrations to complete */
   375		return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
   376						     AD5758_CAL_MEM_UNREFRESHED_MSK);
   377	}
   378	
   379	static int ad5758_slew_rate_config(struct ad5758_state *st)
   380	{
   381		unsigned int sr_clk_idx, sr_step_idx;
   382		int i, res;
   383		s64 diff_new, diff_old;
   384		u64 sr_step, calc_slew_time;
   385	
   386		sr_clk_idx = 0;
   387		sr_step_idx = 0;
   388		diff_old = S64_MAX;
   389		/*
   390		 * The slew time can be determined by using the formula:
   391		 * Slew Time = (Full Scale Out / (Step Size x Update Clk Freq))
   392		 * where Slew time is expressed in microseconds
   393		 * Given the desired slew time, the following algorithm determines the
   394		 * best match for the step size and the update clock frequency.
   395		 */
   396		for (i = 0; i < ARRAY_SIZE(ad5758_sr_clk); i++) {
   397			/*
   398			 * Go through each valid update clock freq and determine a raw
   399			 * value for the step size by using the formula:
   400			 * Step Size = Full Scale Out / (Update Clk Freq * Slew Time)
   401			 */
 > 402			sr_step = AD5758_FULL_SCALE_MICRO;
   403			do_div(sr_step, ad5758_sr_clk[i]);
   404			do_div(sr_step, st->slew_time);
   405			/*
   406			 * After a raw value for step size was determined, find the
   407			 * closest valid match
   408			 */
   409			res = ad5758_find_closest_match(ad5758_sr_step,
   410							ARRAY_SIZE(ad5758_sr_step),
   411							sr_step);
   412			/* Calculate the slew time */
   413			calc_slew_time = AD5758_FULL_SCALE_MICRO;
   414			do_div(calc_slew_time, ad5758_sr_step[res]);
   415			do_div(calc_slew_time, ad5758_sr_clk[i]);
   416			/*
   417			 * Determine with how many microseconds the calculated slew time
   418			 * is different from the desired slew time and store the diff
   419			 * for the next iteration
   420			 */
   421			diff_new = abs(st->slew_time - calc_slew_time);
   422			if (diff_new < diff_old) {
   423				diff_old = diff_new;
   424				sr_clk_idx = i;
   425				sr_step_idx = res;
   426			}
   427		}
   428	
   429		return ad5758_slew_rate_set(st, sr_clk_idx, sr_step_idx);
   430	}
   431	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
