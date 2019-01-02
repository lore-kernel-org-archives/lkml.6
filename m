Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB62C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE782171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 02:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfABCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 21:19:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:23730 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbfABCT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 21:19:26 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2019 18:19:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,429,1539673200"; 
   d="scan'208";a="111443182"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jan 2019 18:19:24 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1geW7v-000HSF-Vj; Wed, 02 Jan 2019 10:19:23 +0800
Date:   Wed, 2 Jan 2019 10:18:41 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: drivers/pci/controller/pcie-mediatek.c:720:13-16: WARNING:
 Suspicious code. resource_size is maybe missing with mem
Message-ID: <201901021019.m2FWggcs%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8e143b90e4d45cca3dc53760d3cfab988bc74571
commit: 031337ace2d1c22a447da6390716fe92592cdd6e PCI: mediatek: Add loadable kernel module support
date:   3 months ago


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pcie-mediatek.c:720:13-16: WARNING: Suspicious code. resource_size is maybe missing with mem

vim +720 drivers/pci/controller/pcie-mediatek.c

b099631d drivers/pci/host/pcie-mediatek.c       Ryder Lee     2017-08-10  661  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  662  static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  663  {
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  664  	struct mtk_pcie *pcie = port->pcie;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  665  	struct resource *mem = &pcie->mem;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  666  	const struct mtk_pcie_soc *soc = port->pcie->soc;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  667  	u32 val;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  668  	size_t size;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  669  	int err;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  670  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  671  	/* MT7622 platforms need to enable LTSSM and ASPM from PCIe subsys */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  672  	if (pcie->base) {
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  673  		val = readl(pcie->base + PCIE_SYS_CFG_V2);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  674  		val |= PCIE_CSR_LTSSM_EN(port->slot) |
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  675  		       PCIE_CSR_ASPM_L1_EN(port->slot);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  676  		writel(val, pcie->base + PCIE_SYS_CFG_V2);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  677  	}
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  678  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  679  	/* Assert all reset signals */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  680  	writel(0, port->base + PCIE_RST_CTRL);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  681  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  682  	/*
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  683  	 * Enable PCIe link down reset, if link status changed from link up to
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  684  	 * link down, this will reset MAC control registers and configuration
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  685  	 * space.
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  686  	 */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  687  	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  688  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  689  	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  690  	val = readl(port->base + PCIE_RST_CTRL);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  691  	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  692  	       PCIE_MAC_SRSTB | PCIE_CRSTB;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  693  	writel(val, port->base + PCIE_RST_CTRL);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  694  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  695  	/* Set up vendor ID and class code */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  696  	if (soc->need_fix_class_id) {
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  697  		val = PCI_VENDOR_ID_MEDIATEK;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  698  		writew(val, port->base + PCIE_CONF_VEND_ID);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  699  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  700  		val = PCI_CLASS_BRIDGE_PCI;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  701  		writew(val, port->base + PCIE_CONF_CLASS_ID);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  702  	}
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  703  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  704  	/* 100ms timeout value should be enough for Gen1/2 training */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  705  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  706  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  707  				 100 * USEC_PER_MSEC);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  708  	if (err)
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  709  		return -ETIMEDOUT;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  710  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  711  	/* Set INTx mask */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  712  	val = readl(port->base + PCIE_INT_MASK);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  713  	val &= ~INTX_MASK;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  714  	writel(val, port->base + PCIE_INT_MASK);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  715  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  716  	if (IS_ENABLED(CONFIG_PCI_MSI))
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  717  		mtk_pcie_enable_msi(port);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  718  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  719  	/* Set AHB to PCIe translation windows */
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15 @720  	size = mem->end - mem->start;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  721  	val = lower_32_bits(mem->start) | AHB2PCIE_SIZE(fls(size));
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  722  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  723  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  724  	val = upper_32_bits(mem->start);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  725  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_H);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  726  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  727  	/* Set PCIe to AXI translation memory space.*/
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  728  	val = fls(0xffffffff) | WIN_ENABLE;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  729  	writel(val, port->base + PCIE_AXI_WINDOW0);
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  730  
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  731  	return 0;
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  732  }
3828d60f drivers/pci/controller/pcie-mediatek.c Honghui Zhang 2018-10-15  733  

:::::: The code at line 720 was first introduced by commit
:::::: 3828d60fd2ef99f97a677c1f95af2ab3e65e2576 PCI: mediatek: Fixup MSI enablement logic by enabling MSI before clocks

:::::: TO: Honghui Zhang <honghui.zhang@mediatek.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
