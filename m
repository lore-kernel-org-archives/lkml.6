Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvr8zSbsK/5rI6go2HXyQhkxdFuks60uOns4gUUbPp1LqURPhioRm4nkTObw2rIh1fOs4Eq
ARC-Seal: i=1; a=rsa-sha256; t=1519981359; cv=none;
        d=google.com; s=arc-20160816;
        b=WXR1G1LigApTQkHI/H12+gSMkPz6OvwGN/xIylymEhickcO0neexVgn/B0DqGdhRim
         mlk+Tmmvio0K8YkwWQHwX2m8MHrhYlrGmGcno5Q6fIp2Lpxy9AY4acAjvOZjWsNeb3v/
         FrUpvL1fm0RsKtYW/7i23zmb4gSY9MihAg1MiD3Lj0gMdpOcz+AjV/LG020awH6DDP8W
         p4o3oVt1eKSQXQ4fi6Pu+NbsmcG7M5ZQWWHcNvr9qFInIOZIdGkKaC5QpOyR/EPWqKqp
         2bR+96l+/9pIrCg08DQi0wXPQyy8F8u4qt62n2sOmt/QQzhBoCG7dJqHebHumkVXrx7p
         DzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gHutvph1JCnQ2i9PWS7UAIpT40avEO9jYxKM1Wt3btc=;
        b=sndUe8a1ypsaEfGr2IplVNu+ujuIfjF01nev3Tdm4diATFAlw+Mxyc8+mHUTNeU0a/
         dLGLzk7wnIBC5savIlYNdpTnvlLMm8H1NHX/8k/SVWFUS177Pw4SXZUCPgeN/bVmuKYj
         V0aV/A5B0P46yGhDSx3GS+WHIz4910YSmPPolYXOetdfBt8ojzk/N4hk/x+wFgSUs3mU
         3Za9aZ4KB+cLG9MEJkNuOt7MN/nRNziAYkkxPxxw3jNEXA1n/vZlE2Yf14S+UOFlW1au
         K0e+ww9wx/5RRHTrJLO10TP0tiuVnnu9U1qxWfU+KNvMvHOq/8zhcx2YBJprkuuMi5xq
         KxNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
	"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
	Shahed Shaikh <Shahed.Shaikh@cavium.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 060/115] bnx2x: Improve reliability in case of nested PCI errors
Date: Fri,  2 Mar 2018 09:51:03 +0100
Message-Id: <20180302084506.311872406@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815281429758311?=
X-GMAIL-MSGID: =?utf-8?q?1593815974413539990?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>


[ Upstream commit f7084059a9cb9e56a186e1677b1dcffd76c2cd24 ]

While in recovery process of PCI error (called EEH on PowerPC arch),
another PCI transaction could be corrupted causing a situation of
nested PCI errors. Also, this scenario could be reproduced with
error injection mechanisms (for debug purposes).

We observe that in case of nested PCI errors, bnx2x might attempt to
initialize its shmem and cause a kernel crash due to bad addresses
read from MCP. Multiple different stack traces were observed depending
on the point the second PCI error happens.

This patch avoids the crashes by:

 * failing PCI recovery in case of nested errors (since multiple
 PCI errors in a row are not expected to lead to a functional
 adapter anyway), and by,

 * preventing access to adapter FW when MCP is failed (we mark it as
 failed when shmem cannot get initialized properly).

Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Acked-by: Shahed Shaikh <Shahed.Shaikh@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3030,7 +3030,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 
 	del_timer_sync(&bp->timer);
 
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |= DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3116,7 +3116,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 	bp->cnic_loaded = false;
 
 	/* Clear driver version indication in shmem */
-	if (IS_PF(bp))
+	if (IS_PF(bp) && !BP_NOMCP(bp))
 		bnx2x_update_mng_version(bp);
 
 	/* Check if there are pending parity attentions. If there are - set
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -9578,6 +9578,15 @@ static int bnx2x_init_shmem(struct bnx2x
 
 	do {
 		bp->common.shmem_base = REG_RD(bp, MISC_REG_SHARED_MEM_ADDR);
+
+		/* If we read all 0xFFs, means we are in PCI error state and
+		 * should bail out to avoid crashes on adapter's FW reads.
+		 */
+		if (bp->common.shmem_base == 0xFFFFFFFF) {
+			bp->flags |= NO_MCP_FLAG;
+			return -ENODEV;
+		}
+
 		if (bp->common.shmem_base) {
 			val = SHMEM_RD(bp, validity_map[BP_PORT(bp)]);
 			if (val & SHR_MEM_VALIDITY_MB)
@@ -14315,7 +14324,10 @@ static pci_ers_result_t bnx2x_io_slot_re
 		BNX2X_ERR("IO slot reset --> driver unload\n");
 
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
 
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
