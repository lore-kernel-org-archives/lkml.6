Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262ECC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642C92082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 03:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642C92082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeH2H2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 03:28:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:43382 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725199AbeH2H2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 03:28:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 20:33:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,301,1531810800"; 
   d="gz'50?scan'50,208,50";a="87194694"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2018 20:33:44 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1furER-0008Th-SZ; Wed, 29 Aug 2018 11:33:23 +0800
Date:   Wed, 29 Aug 2018 11:33:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org, marc.zyngier@arm.com,
        mingo@kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 4/4] irqdesc: Add domain handler for NMIs
Message-ID: <201808291120.DNUyZOT5%fengguang.wu@intel.com>
References: <1535470188-38155-5-git-send-email-julien.thierry@arm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <1535470188-38155-5-git-send-email-julien.thierry@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Julien,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.19-rc1 next-20180828]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Julien-Thierry/genirq-Provide-basic-NMI-management-for-interrupt-lines/20180829-063713
config: arm-nuc960_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   kernel/irq/irqdesc.c: In function 'handle_domain_nmi':
>> kernel/irq/irqdesc.c:686:8: error: implicit declaration of function 'irq_find_mapping'; did you mean 'irq_dispose_mapping'? [-Werror=implicit-function-declaration]
     irq = irq_find_mapping(domain, hwirq);
           ^~~~~~~~~~~~~~~~
           irq_dispose_mapping
   cc1: some warnings being treated as errors

vim +686 kernel/irq/irqdesc.c

   668	
   669	/**
   670	 * handle_domain_nmi - Invoke the handler for a HW irq belonging to a domain
   671	 * @domain:	The domain where to perform the lookup
   672	 * @hwirq:	The HW irq number to convert to a logical one
   673	 * @regs:	Register file coming from the low-level handling code
   674	 *
   675	 * Returns:	0 on success, or -EINVAL if conversion has failed
   676	 */
   677	int handle_domain_nmi(struct irq_domain *domain, unsigned int hwirq,
   678			      struct pt_regs *regs)
   679	{
   680		struct pt_regs *old_regs = set_irq_regs(regs);
   681		unsigned int irq;
   682		int ret = 0;
   683	
   684		nmi_enter();
   685	
 > 686		irq = irq_find_mapping(domain, hwirq);
   687	
   688		/*
   689		 * ack_bad_irq is not NMI-safe, just report
   690		 * an invalid interrupt.
   691		 */
   692		if (likely(irq))
   693			generic_handle_irq(irq);
   694		else
   695			ret = -EINVAL;
   696	
   697		nmi_exit();
   698		set_irq_regs(old_regs);
   699		return ret;
   700	}
   701	#endif
   702	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IS0zKkzwUGydFO0o--
