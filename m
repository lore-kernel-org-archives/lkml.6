Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754796AbeDTMe2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:34:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:26716 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754752AbeDTMe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:34:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="218081357"
Message-ID: <1524227663.21176.465.camel@linux.intel.com>
Subject: Re: sound/soc/intel/atom/sst/sst_loader.c:357:9: warning: 'fw' is
 used uninitialized in this function
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kbuild test robot <lkp@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Date: Fri, 20 Apr 2018 15:34:23 +0300
In-Reply-To: <201804181935.hpD7xutn%fengguang.wu@intel.com>
References: <201804181935.hpD7xutn%fengguang.wu@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-18 at 19:42 +0800, kbuild test robot wrote:


>    sound/soc/intel/atom/sst/sst_loader.c: In function
> 'sst_request_fw':
> > > sound/soc/intel/atom/sst/sst_loader.c:357:9: warning: 'fw' is used
> > > uninitialized in this function [-Wuninitialized]
> 
>      if (fw == NULL) {
>             ^
> 

Looks like semi-false-positive.

We should check retval first, then check fw. The API has to return an
error in case when fw is not filled correctly.

Otherwise it breaks a rule that input parameters are not altered on
error path (when they are not about error itself of course).

> vim +/fw +357 sound/soc/intel/atom/sst/sst_loader.c
> 
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  344  
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  345  /*
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  346   * sst_request_fw - requests audio fw from kernel and saves a
> copy
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  347   *
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  348   * This function requests the SST FW from the kernel, parses
> it and
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  349   * saves a copy in the driver context
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  350   */
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  351  static int sst_request_fw(struct intel_sst_drv *sst)
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  352  {
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  353  	int retval = 0;
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  354  	const struct firmware *fw;
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  355  
> 5794b7ec sound/soc/intel/sst/sst_loader.c Fang, Yang A 2014-10-
> 30  356  	retval = request_firmware(&fw, sst->firmware_name,
> sst->dev);
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-16
> @357  	if (fw == NULL) {
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  358  		dev_err(sst->dev, "fw is returning as
> null\n");
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  359  		return -EINVAL;
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  360  	}
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  361  	if (retval) {
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  362  		dev_err(sst->dev, "request fw failed %d\n",
> retval);
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  363  		return retval;
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  364  	}
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  365  	mutex_lock(&sst->sst_lock);
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  366  	retval = sst_cache_and_parse_fw(sst, fw);
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  367  	mutex_unlock(&sst->sst_lock);
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  368  
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  369  	return retval;
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  370  }
> 9012c954 sound/soc/intel/sst/sst_loader.c Vinod Koul   2014-10-
> 16  371  
> 
> :::::: The code at line 357 was first introduced by commit
> :::::: 9012c9544eeac485b2193fea721233907f0847fa ASoC: Intel: mrfld -
> Add DSP load and management
> 
> :::::: TO: Vinod Koul <vinod.koul@intel.com>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology
> Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
