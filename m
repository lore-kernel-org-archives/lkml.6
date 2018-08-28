Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D32CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A3208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5A3208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeH1Ie2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:34:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:4151 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbeH1Ie2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:34:28 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2018 21:44:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,298,1531810800"; 
   d="gz'50?scan'50,208,50";a="76099694"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Aug 2018 21:44:11 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fuVrC-00031R-PS; Tue, 28 Aug 2018 12:43:58 +0800
Date:   Tue, 28 Aug 2018 12:43:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] sysctl: do not allow a 64bit value write in a 32bit knob
Message-ID: <201808281147.bOuMfCfN%fengguang.wu@intel.com>
References: <20180827202706.olt3saqjzzzyax6i@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20180827202706.olt3saqjzzzyax6i@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aristeu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.19-rc1 next-20180827]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aristeu-Rozanski/sysctl-do-not-allow-a-64bit-value-write-in-a-32bit-knob/20180828-043801
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=microblaze 

All warnings (new ones prefixed by >>):

   kernel/sysctl.c: In function 'do_proc_dointvec_minmax_conv':
>> kernel/sysctl.c:2558:14: warning: right shift count >= width of type [-Wshift-count-overflow]
          *lvalp >> (sizeof(int) * 8))
                 ^~

vim +2558 kernel/sysctl.c

  2548	
  2549	static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
  2550						int *valp,
  2551						int write, void *data)
  2552	{
  2553		struct do_proc_dointvec_minmax_conv_param *param = data;
  2554		if (write) {
  2555			int val = *negp ? -*lvalp : *lvalp;
  2556			if ((param->min && *param->min > val) ||
  2557			    (param->max && *param->max < val) ||
> 2558			    *lvalp >> (sizeof(int) * 8))
  2559				return -EINVAL;
  2560			*valp = val;
  2561		} else {
  2562			int val = *valp;
  2563			if (val < 0) {
  2564				*negp = true;
  2565				*lvalp = -(unsigned long)val;
  2566			} else {
  2567				*negp = false;
  2568				*lvalp = (unsigned long)val;
  2569			}
  2570		}
  2571		return 0;
  2572	}
  2573	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
mpFP/Q+HuwVk4soAAA==

--+HP7ph2BbKc20aGI--
