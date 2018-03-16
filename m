Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtvnk8zUg/aK4EETEZF8GewAPgA6bbWtjVdXpM6SHJi9Jaan601Iz387DVff0ZQjeBc5IdJ
ARC-Seal: i=1; a=rsa-sha256; t=1521215031; cv=none;
        d=google.com; s=arc-20160816;
        b=METpZqmtj8/WVm7YWCKI8TT0FAx7EXLgapIn9GO5tY4kN5suYTEeLdzw+RFKR2TEcc
         2urzXKndYS/aGBCAwhPLTeCHuEskhWEeEAIRq1auQvjT+cAGpfmBFptxdI4+5/LnhsPm
         q4O1iqb/Vz7A6K8DapWvcs1iQP1NnoJaTx5fst1+9YXDnpOg3npOxWiVQI2TGHfglEIU
         ytuynm94uzQP5mm6mIKg7RYKCQUR84Uc1Xkn/N7bjpkBgO/6DEptxx7yyLJsDO9hqJX1
         tYO7Y3j2BQdnISU8eFLbMfue8nFV+oqgBa6K2VEIcgH2gQKA0deD5GeJ0TDn/pL8M9lk
         WaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OAlCoW8W/Ve+D8InqicWZIyeE1DdJEAMWdU3IsuvYyg=;
        b=nKXQ7atGyluwl7PrgVhEbvBqlsjvIlufMKZIkGb4wxLrJWjaE67JnZ4EOze41TJhBh
         LDPZsb8f7pxGR2K6k5cPdvHVrE2jpjscOQ4qV+lz+UD9XyVP3jPA0tdiDJOVK/VVb04M
         I1kraTjiiOPWRJHgAn0iTsvvo2+5kKdregQsm7wq+YPEyPxw9QeXN/gJNCXR29PQJL3S
         eBYIJKDiszqaxS9c1DzjdltfupNJYqGG/GrlIdV21tZfOoUGm2tALfiV0iQbai4UE1As
         R2bZ23Klzomtw1VvmIb60rLKG9tReH1FC7L+5Lkf58oUGRXIFD1v2ly6jWG+yPraPQ10
         BUQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ioana Radulescu <ruxandra.radulescu@nxp.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 103/128] staging: fsl-dpaa2/eth: Fix access to FAS field
Date: Fri, 16 Mar 2018 16:24:04 +0100
Message-Id: <20180316152341.680666406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109572177015016?=
X-GMAIL-MSGID: =?utf-8?q?1595109572177015016?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>


[ Upstream commit 54ce891779888e85a2db04942dbaadd3f40fe223 ]

Commit 4b2d9fe87950 ("staging: fsl-dpaa2/eth: Extra headroom in RX
buffers") removes the software annotation (SWA) area from the RX
buffer layout, as it's not used by anyone, but fails to update the
macros for accessing hardware annotation (HWA) fields, which is
right after the SWA in the buffer headroom.

This may lead to some frame annotation status fields (e.g. indication
if L3/L4 checksum is valid) to be read incorrectly.

Turn the accessor macros into inline functions and add a bool param
to specify if SWA is present or not.

Fixes: 4b2d9fe87950 ("staging: fsl-dpaa2/eth: Extra headroom in RX buffers")

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c |    8 ++++----
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h |   13 +++++++++----
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -249,7 +249,7 @@ static void dpaa2_eth_rx(struct dpaa2_et
 	vaddr = dpaa2_iova_to_virt(priv->iommu_domain, addr);
 	dma_unmap_single(dev, addr, DPAA2_ETH_RX_BUF_SIZE, DMA_FROM_DEVICE);
 
-	fas = dpaa2_get_fas(vaddr);
+	fas = dpaa2_get_fas(vaddr, false);
 	prefetch(fas);
 	buf_data = vaddr + dpaa2_fd_get_offset(fd);
 	prefetch(buf_data);
@@ -385,7 +385,7 @@ static int build_sg_fd(struct dpaa2_eth_
 	 * on TX confirmation. We are clearing FAS (Frame Annotation Status)
 	 * field from the hardware annotation area
 	 */
-	fas = dpaa2_get_fas(sgt_buf);
+	fas = dpaa2_get_fas(sgt_buf, true);
 	memset(fas, 0, DPAA2_FAS_SIZE);
 
 	sgt = (struct dpaa2_sg_entry *)(sgt_buf + priv->tx_data_offset);
@@ -458,7 +458,7 @@ static int build_single_fd(struct dpaa2_
 	 * on TX confirmation. We are clearing FAS (Frame Annotation Status)
 	 * field from the hardware annotation area
 	 */
-	fas = dpaa2_get_fas(buffer_start);
+	fas = dpaa2_get_fas(buffer_start, true);
 	memset(fas, 0, DPAA2_FAS_SIZE);
 
 	/* Store a backpointer to the skb at the beginning of the buffer
@@ -510,7 +510,7 @@ static void free_tx_fd(const struct dpaa
 
 	fd_addr = dpaa2_fd_get_addr(fd);
 	skbh = dpaa2_iova_to_virt(priv->iommu_domain, fd_addr);
-	fas = dpaa2_get_fas(skbh);
+	fas = dpaa2_get_fas(skbh, true);
 
 	if (fd_format == dpaa2_fd_single) {
 		skb = *skbh;
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -153,10 +153,15 @@ struct dpaa2_fas {
 #define DPAA2_FAS_SIZE			(sizeof(struct dpaa2_fas))
 
 /* Accessors for the hardware annotation fields that we use */
-#define dpaa2_get_hwa(buf_addr) \
-	((void *)(buf_addr) + DPAA2_ETH_SWA_SIZE)
-#define dpaa2_get_fas(buf_addr) \
-	(struct dpaa2_fas *)(dpaa2_get_hwa(buf_addr) + DPAA2_FAS_OFFSET)
+static inline void *dpaa2_get_hwa(void *buf_addr, bool swa)
+{
+	return buf_addr + (swa ? DPAA2_ETH_SWA_SIZE : 0);
+}
+
+static inline struct dpaa2_fas *dpaa2_get_fas(void *buf_addr, bool swa)
+{
+	return dpaa2_get_hwa(buf_addr, swa) + DPAA2_FAS_OFFSET;
+}
 
 /* Error and status bits in the frame annotation status word */
 /* Debug frame, otherwise supposed to be discarded */
