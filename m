Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvLiVle9mus3tr2+bahNxJjGCMXYfUNvhF586iR5ptNEeKjR8931KVUqWp83AkhR1DrVgZO
ARC-Seal: i=1; a=rsa-sha256; t=1519981155; cv=none;
        d=google.com; s=arc-20160816;
        b=mtgykmFF2r+8U8WYF6o0rmZbuqY/PzoS198ccrwxwZVS/O7E90Nl42wuUEQ3vNiPAq
         sT+lS+NI4/jy/rltq7ohpmgPrD9vJZDaX6w7ad88SBYyubA6QhOF5aAg8CI1LJ5gJrWn
         A10ll7w994hAMTACSDK/yHGic/HyI9tlMKbPIka24heP/13fX4UAABvJ7Z1+MlpRW/t8
         9Un4tSES1WmE1hQk9qm7rWe0J0hY873ALGy4EJz+rn+Z2VEyYuYcSOMxa8PrlaA8oASJ
         5IUMx87qE84jwfTrsYECHKZ1G1ggTukfSadLGk2h1q0BxyylZgyU954q7OvrtalPeC96
         Xzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R0JDcJtL7huzwAMuFsRMTHBFKbzHR/Iq7V+AHfLpnHE=;
        b=LHUu11tLY7Xn0F44rw3fleR0psAsoGKnd4PxtejUSTq4zj4Ag2MlveQCx7kQC2Oy1+
         wDHEyaRKbU4SPbabd1yYpeDRdVr7rHOa8Sm9aDWjRf+EFTLN9Bb2c8NuZ2s45mB6GRxy
         uUueTpf5Grh7ZVmw/BY//83QRx8D4lWN/HDreJTsR1sqyfkNoN5T2k7NsIsdm2DH4W9e
         H+InUXBYvu3YJc//VzRMjjcX3EreCiM5Ke4UvnfSYCvYPa+EHaltV/Ntiux21nlYgw6N
         ohHLyiu9v9M89YvdsJE1spTqoHfDIn/tQFdmDrV1jGfVTCHHSvpGPky/u+QjK/3ID3hJ
         AWEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Pavel Belous <pavel.belous@aquantia.com>,
	Igor Russkikh <igor.russkikh@aquantia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 010/115] net: aquantia: Fix hardware DMA stream overload on large MRRS
Date: Fri,  2 Mar 2018 09:50:13 +0100
Message-Id: <20180302084504.276580260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815760033241594?=
X-GMAIL-MSGID: =?utf-8?q?1593815760033241594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>


[ Upstream commit 1e366161510f266516107a69db91f1f2edaea11c ]

Systems with large MRRS on device (2K, 4K) with high data rates and/or
large MTU, atlantic observes DMA packet buffer overflow. On some systems
that causes PCIe transaction errors, hardware NMIs or datapath freeze.
This patch
1) Limits MRRS from device side to 2K (thats maximum our hardware supports)
2) Limit maximum size of outstanding TX DMA data read requests. This makes
hardware buffers running fine.

Signed-off-by: Pavel Belous <pavel.belous@aquantia.com>
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c           |   12 ++++++++++
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |    6 +++++
 2 files changed, 18 insertions(+)

--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c
@@ -16,6 +16,7 @@
 #include "hw_atl_utils.h"
 #include "hw_atl_llh.h"
 #include "hw_atl_b0_internal.h"
+#include "hw_atl_llh_internal.h"
 
 static int hw_atl_b0_get_hw_caps(struct aq_hw_s *self,
 				 struct aq_hw_caps_s *aq_hw_caps,
@@ -368,6 +369,7 @@ static int hw_atl_b0_hw_init(struct aq_h
 	};
 
 	int err = 0;
+	u32 val;
 
 	self->aq_nic_cfg = aq_nic_cfg;
 
@@ -385,6 +387,16 @@ static int hw_atl_b0_hw_init(struct aq_h
 	hw_atl_b0_hw_rss_set(self, &aq_nic_cfg->aq_rss);
 	hw_atl_b0_hw_rss_hash_set(self, &aq_nic_cfg->aq_rss);
 
+	/* Force limit MRRS on RDM/TDM to 2K */
+	val = aq_hw_read_reg(self, pci_reg_control6_adr);
+	aq_hw_write_reg(self, pci_reg_control6_adr, (val & ~0x707) | 0x404);
+
+	/* TX DMA total request limit. B0 hardware is not capable to
+	 * handle more than (8K-MRRS) incoming DMA data.
+	 * Value 24 in 256byte units
+	 */
+	aq_hw_write_reg(self, tx_dma_total_req_limit_adr, 24);
+
 	err = aq_hw_err_from_flags(self);
 	if (err < 0)
 		goto err_exit;
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -2343,6 +2343,9 @@
 #define tx_dma_desc_base_addrmsw_adr(descriptor) \
 			(0x00007c04u + (descriptor) * 0x40)
 
+/* tx dma total request limit */
+#define tx_dma_total_req_limit_adr 0x00007b20u
+
 /* tx interrupt moderation control register definitions
  * Preprocessor definitions for TX Interrupt Moderation Control Register
  * Base Address: 0x00008980
@@ -2369,6 +2372,9 @@
 /* default value of bitfield reg_res_dsbl */
 #define pci_reg_res_dsbl_default 0x1
 
+/* PCI core control register */
+#define pci_reg_control6_adr 0x1014u
+
 /* global microprocessor scratch pad definitions */
 #define glb_cpu_scratch_scp_adr(scratch_scp) (0x00000300u + (scratch_scp) * 0x4)
 
