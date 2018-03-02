Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3jJe7P+J2shOtMZJHvUd9wEZSt8SiPKZVbPI6TmTdkEA1CRN7HKs09hcN2SmaiH+O+0it
ARC-Seal: i=1; a=rsa-sha256; t=1519981027; cv=none;
        d=google.com; s=arc-20160816;
        b=OKndloD2Y1/bnaRCDlPdkAzcCrP/D7VvbgtYy9sLDURicUty8TeK4GdjGuox/dUdeP
         AImGM7ngx3RrtXllnBw6a5iHzhY0psByT9W5k6q1P2hpPRxZgNJu5IWR6gRaFf+EPJ4u
         336sVwCjnPANSbFN5w53qZV/ba2v14QQRsfquEzvLcIwkDQ7hjJdEXzsl2tCQPyFGs3q
         VpBARO4tAIGyZb3zJaRMP0JzcL+iasQYAeqftvVj+b38xTXrYEHT+t6ItYZHoFzgYCdL
         j+aGQ8++/9icSjnUKhtgQjF7lUtH6YJyE9HOS3Jr/41K6QXsI51QB2ZOudo5fS2VB/ho
         w/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J7U737q8e5Nw3K0RvdJtebmnSo4PifS4FfH97NbxqOU=;
        b=T5rnYyuXTnGB44cL6WA4R4LLWJfff6FzUivYurUpWo3TXqLJwB5Wg8gykUZf06EtXr
         7ZK6rpc59ipX4I6/l5+Sk4NyoRpEulbgbc3tT2oovdFVoW/UVRogWWIJ+ZBIOiWuPvY8
         hRfHUbqdGZ+uV+BFnnf0HGpwecBpRqzv0cPiZK4JO4/FbQR+kywfDo05a1zZiijsi3rE
         izSCWH61TWursu6cOmtpS5H+uQ6k1EN/YCCxkK05GlAS9EInLI8BeHVUMuD4JKy2KKW7
         4C1EZxyv53SFAUYsipV9ntQBoZ1bqy9qT2Pijj5RFtmOlQ8zxq19hj7p9vjg1gUGEx2I
         8YeQ==
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
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 29/56] bnx2x: Improve reliability in case of nested PCI errors
Date: Fri,  2 Mar 2018 09:51:15 +0100
Message-Id: <20180302084451.063532041@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815281429758311?=
X-GMAIL-MSGID: =?utf-8?q?1593815626513722691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |    4 ++--
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c |   14 +++++++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -3034,7 +3034,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
 
 	del_timer_sync(&bp->timer);
 
-	if (IS_PF(bp)) {
+	if (IS_PF(bp) && !BP_NOMCP(bp)) {
 		/* Set ALWAYS_ALIVE bit in shmem */
 		bp->fw_drv_pulse_wr_seq |= DRV_PULSE_ALWAYS_ALIVE;
 		bnx2x_drv_pulse(bp);
@@ -3120,7 +3120,7 @@ int bnx2x_nic_unload(struct bnx2x *bp, i
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
@@ -14312,7 +14321,10 @@ static pci_ers_result_t bnx2x_io_slot_re
 		BNX2X_ERR("IO slot reset --> driver unload\n");
 
 		/* MCP should have been reset; Need to wait for validity */
-		bnx2x_init_shmem(bp);
+		if (bnx2x_init_shmem(bp)) {
+			rtnl_unlock();
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
 
 		if (IS_PF(bp) && SHMEM2_HAS(bp, drv_capabilities_flag)) {
 			u32 v;
