Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D139CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9234B214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HzLwcnD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfALSOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:14:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55332 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALSOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:14:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xZdO/6KlvHILux309i0PhGESltdPg78l3efEPchQHTA=; b=HzLwcnD0NRV3NvN+xZWwfBE0o6
        nC3LPkwP+vrsuOKKZkaVNrEzugiT3GYrYcP2avCS1vOLlNQQxLNldEPcsbz0+ORKZM4NNH93g9XCw
        8oCCstKFFgwmM9OLJHXFIPbUmrateNhHKCeI/XMOTQgT0s2QIA7d1YpkW2/8nZNQWKn57hrxDX3Cx
        wyx7J1dv2ZGxbtT7RPW9xPpIcCYNnMXASlGdTXTgbrJUN8uY556Z5Gj7W1mv4GKHdfgsOGSD/WjZE
        HOeo6X/X8vf3nW8mvcLNKfCxfzZV8psh2bwtjCFeL06ouIrq6wYrPNYNKtXrEzKzIiuco80vMOJRu
        K4C5xDoA==;
Received: from 089144213167.atnat0022.highway.a1.net ([89.144.213.167] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1giNnB-0005Ae-TF; Sat, 12 Jan 2019 18:13:58 +0000
Date:   Sat, 12 Jan 2019 19:13:55 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] remove dma_zalloc_coherent
Message-ID: <20190112181355.GA31454@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets see if this works better as a pull request than the
plain patches:

We've always had a weird situation around dma_zalloc_coherent.  To
safely support mapping the allocations to userspace major architectures
like x86 and arm have always zeroed allocations from dma_alloc_coherent,
but a couple other architectures were missing that zeroing either always
or in corner cases.  Then later we grew anothe dma_zalloc_coherent
interface to explicitly request zeroing, but that just added __GFP_ZERO
to the allocation flags, which for some allocators that didn't end
up using the page allocator ended up being a no-op and still not
zeroing the allocations.

So for this merge window I fixed up all remaining architectures to zero
the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
wrapper around dma_alloc_coherent, which fixes all of the above issues.

dma_zalloc_coherent is now pointless and can go away, and Luis helped
me writing a cocchinelle script and patch series to kill it, which I
think we should apply now just after -rc1 to finally settle these
issue.

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/remove-dma_zalloc_coherent-5.0

for you to fetch changes up to dfd32cad146e3624970eee9329e99d2c6ef751b3:

  dma-mapping: remove dma_zalloc_coherent() (2019-01-08 07:58:49 -0500)

----------------------------------------------------------------
remove dma_zalloc_coherent

We've always had a weird situation around dma_zalloc_coherent.  To
safely support mapping the allocations to userspace major architectures
like x86 and arm have always zeroed allocations from dma_alloc_coherent,
but a couple other architectures were missing that zeroing either always
or in corner cases.  Then later we grew anothe dma_zalloc_coherent
interface to explicitly request zeroing, but that just added __GFP_ZERO
to the allocation flags, which for some allocators that didn't end
up using the page allocator ended up being a no-op and still not
zeroing the allocations.

So for this merge window I fixed up all remaining architectures to zero
the memory in dma_alloc_coherent, and made dma_zalloc_coherent a no-op
wrapper around dma_alloc_coherent, which fixes all of the above issues.

dma_zalloc_coherent is now pointless and can go away, and Luis helped
me writing a cocchinelle script and patch series to kill it, which I
think we should apply now just after -rc1 to finally settle these
issue.

----------------------------------------------------------------
Luis Chamberlain (3):
      cross-tree: phase out dma_zalloc_coherent()
      cross-tree: phase out dma_zalloc_coherent() on headers
      dma-mapping: remove dma_zalloc_coherent()

 arch/mips/lantiq/xway/dma.c                        |  6 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |  2 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |  7 ++-
 drivers/ata/sata_fsl.c                             |  4 +-
 drivers/atm/he.c                                   | 39 ++++++-------
 drivers/atm/idt77252.c                             | 16 ++---
 drivers/block/skd_main.c                           |  4 +-
 drivers/crypto/amcc/crypto4xx_core.c               |  6 +-
 drivers/crypto/cavium/cpt/cptpf_main.c             |  4 +-
 drivers/crypto/cavium/cpt/cptvf_main.c             |  7 ++-
 drivers/crypto/cavium/nitrox/nitrox_lib.c          |  6 +-
 drivers/crypto/ccp/ccp-dev-v5.c                    |  6 +-
 drivers/crypto/hisilicon/sec/sec_algs.c            |  4 +-
 drivers/crypto/hisilicon/sec/sec_drv.c             | 15 ++---
 drivers/crypto/ixp4xx_crypto.c                     |  6 +-
 drivers/crypto/mediatek/mtk-platform.c             | 16 ++---
 drivers/crypto/qat/qat_common/adf_admin.c          | 12 ++--
 drivers/crypto/qat/qat_common/qat_algs.c           | 24 ++++----
 drivers/crypto/qat/qat_common/qat_asym_algs.c      | 68 +++++++++++-----------
 drivers/dma/imx-sdma.c                             |  8 +--
 drivers/dma/mediatek/mtk-hsdma.c                   |  4 +-
 drivers/dma/mxs-dma.c                              |  6 +-
 drivers/dma/xgene-dma.c                            |  4 +-
 drivers/dma/xilinx/xilinx_dma.c                    | 14 ++---
 drivers/dma/xilinx/zynqmp_dma.c                    |  6 +-
 drivers/gpu/drm/drm_pci.c                          |  5 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c         |  4 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c          |  8 +--
 drivers/infiniband/hw/cxgb3/cxio_hal.c             |  6 +-
 drivers/infiniband/hw/cxgb4/qp.c                   |  5 +-
 drivers/infiniband/hw/hfi1/init.c                  | 29 ++++-----
 drivers/infiniband/hw/hfi1/pio.c                   |  9 ++-
 drivers/infiniband/hw/hfi1/sdma.c                  | 27 +++------
 drivers/infiniband/hw/hns/hns_roce_alloc.c         | 11 ++--
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c         | 10 ++--
 drivers/infiniband/hw/i40iw/i40iw_utils.c          |  4 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c        |  5 +-
 drivers/infiniband/hw/ocrdma/ocrdma_hw.c           | 14 ++---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |  4 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c        |  6 +-
 drivers/infiniband/hw/qedr/verbs.c                 |  4 +-
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c     |  4 +-
 drivers/input/touchscreen/raspberrypi-ts.c         |  4 +-
 drivers/iommu/mtk_iommu_v1.c                       |  5 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2.c           |  4 +-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |  2 +-
 drivers/misc/genwqe/card_utils.c                   |  4 +-
 drivers/mmc/host/sdhci.c                           |  5 +-
 drivers/net/ethernet/aeroflex/greth.c              | 12 ++--
 drivers/net/ethernet/alacritech/slicoss.c          | 12 ++--
 drivers/net/ethernet/amazon/ena/ena_com.c          | 61 +++++++++----------
 drivers/net/ethernet/apm/xgene-v2/main.c           |  8 +--
 drivers/net/ethernet/atheros/alx/main.c            |  7 +--
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  4 +-
 drivers/net/ethernet/broadcom/bcm63xx_enet.c       |  8 +--
 drivers/net/ethernet/broadcom/bcmsysport.c         |  4 +-
 drivers/net/ethernet/broadcom/bgmac.c              | 12 ++--
 drivers/net/ethernet/broadcom/bnx2.c               |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 16 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c      |  4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c  |  4 +-
 drivers/net/ethernet/broadcom/tg3.c                | 22 +++----
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |  2 +-
 drivers/net/ethernet/chelsio/cxgb3/sge.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c           |  2 +-
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c         |  2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c        | 68 +++++++++++-----------
 drivers/net/ethernet/emulex/benet/be_ethtool.c     | 18 +++---
 drivers/net/ethernet/emulex/benet/be_main.c        | 18 +++---
 drivers/net/ethernet/faraday/ftgmac100.c           | 14 ++---
 drivers/net/ethernet/faraday/ftmac100.c            |  7 +--
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c      |  4 +-
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c    |  5 +-
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  5 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_cmd.c   |  5 +-
 .../net/ethernet/huawei/hinic/hinic_hw_api_cmd.c   | 16 ++---
 drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c   |  8 +--
 drivers/net/ethernet/huawei/hinic/hinic_hw_io.c    |  6 +-
 drivers/net/ethernet/huawei/hinic/hinic_hw_qp.c    | 10 ++--
 drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c    |  8 +--
 drivers/net/ethernet/ibm/emac/mal.c                |  4 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |  8 +--
 drivers/net/ethernet/intel/e1000e/netdev.c         |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  4 +-
 drivers/net/ethernet/intel/ixgb/ixgb_main.c        |  8 +--
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  6 +-
 drivers/net/ethernet/marvell/octeontx2/af/common.h |  2 +-
 drivers/net/ethernet/marvell/pxa168_eth.c          | 18 +++---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 18 +++---
 drivers/net/ethernet/mellanox/mlx4/alloc.c         |  8 +--
 drivers/net/ethernet/mellanox/mlx5/core/alloc.c    |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      | 10 ++--
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c   |  6 +-
 .../net/ethernet/netronome/nfp/nfp_net_common.c    | 12 ++--
 drivers/net/ethernet/ni/nixge.c                    | 12 ++--
 .../net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c   | 12 ++--
 drivers/net/ethernet/pasemi/pasemi_mac.c           |  6 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.c          | 16 ++---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ctx.c    | 28 ++++-----
 drivers/net/ethernet/qualcomm/emac/emac-mac.c      |  2 +-
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c    | 12 ++--
 drivers/net/ethernet/sfc/falcon/nic.c              |  4 +-
 drivers/net/ethernet/sfc/nic.c                     |  4 +-
 drivers/net/ethernet/sgi/meth.c                    |  4 +-
 drivers/net/ethernet/socionext/netsec.c            |  4 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 40 +++++--------
 drivers/net/ethernet/tundra/tsi108_eth.c           |  8 +--
 drivers/net/ethernet/xilinx/ll_temac_main.c        | 12 ++--
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  | 12 ++--
 drivers/net/fddi/defxx.c                           |  6 +-
 drivers/net/fddi/skfp/skfddi.c                     |  8 +--
 drivers/net/vmxnet3/vmxnet3_drv.c                  |  8 +--
 drivers/net/wan/fsl_ucc_hdlc.c                     |  7 +--
 drivers/net/wireless/ath/ath10k/ce.c               |  7 +--
 drivers/net/wireless/ath/ath10k/mac.c              |  8 +--
 drivers/net/wireless/ath/ath10k/pci.c              |  3 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |  2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             | 17 +++---
 drivers/net/wireless/ath/wil6210/txrx_edma.c       |  8 +--
 drivers/net/wireless/broadcom/b43/dma.c            |  6 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c      |  6 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    | 16 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       | 39 +++++--------
 drivers/net/wireless/ralink/rt2x00/rt2x00mmio.c    |  6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c             |  8 +--
 drivers/nvme/host/pci.c                            |  8 +--
 drivers/pci/controller/pcie-iproc-msi.c            |  6 +-
 drivers/pci/switch/switchtec.c                     |  8 +--
 drivers/rapidio/devices/tsi721.c                   | 22 +++----
 drivers/rapidio/devices/tsi721_dma.c               |  8 +--
 drivers/s390/net/ism_drv.c                         | 15 +++--
 drivers/scsi/3w-sas.c                              |  5 +-
 drivers/scsi/a100u2w.c                             |  8 +--
 drivers/scsi/arcmsr/arcmsr_hba.c                   | 18 ++++--
 drivers/scsi/be2iscsi/be_main.c                    |  4 +-
 drivers/scsi/be2iscsi/be_mgmt.c                    | 11 ++--
 drivers/scsi/bfa/bfad_bsg.c                        |  6 +-
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   | 49 ++++++++--------
 drivers/scsi/bnx2fc/bnx2fc_tgt.c                   | 44 +++++++-------
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  8 +--
 drivers/scsi/csiostor/csio_wr.c                    |  4 +-
 drivers/scsi/lpfc/lpfc_bsg.c                       |  4 +-
 drivers/scsi/lpfc/lpfc_init.c                      | 14 ++---
 drivers/scsi/lpfc/lpfc_mbox.c                      |  6 +-
 drivers/scsi/lpfc/lpfc_sli.c                       | 15 +++--
 drivers/scsi/megaraid/megaraid_mbox.c              | 15 ++---
 drivers/scsi/megaraid/megaraid_sas_base.c          | 26 ++++-----
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |  5 +-
 drivers/scsi/mesh.c                                |  5 +-
 drivers/scsi/mvumi.c                               |  9 +--
 drivers/scsi/pm8001/pm8001_sas.c                   |  4 +-
 drivers/scsi/qedf/qedf_main.c                      | 29 +++++----
 drivers/scsi/qedi/qedi_main.c                      | 39 ++++++-------
 drivers/scsi/qla2xxx/qla_attr.c                    |  4 +-
 drivers/scsi/qla2xxx/qla_bsg.c                     |  4 +-
 drivers/scsi/qla2xxx/qla_gs.c                      | 14 +++--
 drivers/scsi/qla2xxx/qla_init.c                    |  8 +--
 drivers/scsi/qla4xxx/ql4_init.c                    |  4 +-
 drivers/scsi/qla4xxx/ql4_mbx.c                     | 18 +++---
 drivers/scsi/qla4xxx/ql4_nx.c                      |  4 +-
 drivers/scsi/qla4xxx/ql4_os.c                      | 10 ++--
 drivers/scsi/smartpqi/smartpqi_init.c              | 32 +++++-----
 drivers/soc/fsl/qbman/dpaa_sys.c                   |  2 +-
 drivers/spi/spi-pic32-sqi.c                        |  6 +-
 drivers/staging/mt7621-eth/mtk_eth_soc.c           |  3 +-
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  6 +-
 drivers/staging/vt6655/device_main.c               | 19 ++----
 drivers/usb/gadget/udc/bdc/bdc_core.c              | 13 ++---
 drivers/usb/host/uhci-hcd.c                        |  6 +-
 drivers/usb/host/xhci-mem.c                        |  8 +--
 drivers/video/fbdev/da8xx-fb.c                     |  6 +-
 include/linux/dma-mapping.h                        |  9 ---
 include/linux/pci-dma-compat.h                     |  2 +-
 scripts/coccinelle/api/alloc/alloc_cast.cocci      |  8 +--
 scripts/coccinelle/api/alloc/zalloc-simple.cocci   | 11 +---
 sound/aoa/soundbus/i2sbus/core.c                   |  4 +-
 sound/sparc/dbri.c                                 |  4 +-
 179 files changed, 923 insertions(+), 975 deletions(-)
