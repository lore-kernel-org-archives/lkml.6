Return-Path: <osmithde@osmithde-lnx.cisco.com>
X-Google-Smtp-Source: AIpwx49fo6PCKpW45/gT3e2/lF9Ki/rgJ4DyzJ8uoQSn2ZH4ckgduI0Nr1TEpyBcQV59BtnzMVoh
ARC-Seal: i=1; a=rsa-sha256; t=1522962952; cv=none;
        d=google.com; s=arc-20160816;
        b=rQ2B0wOx3A2ES1pcLE9tWWreIv7IpqhcSNHX8vkbjmDt1LBcoRNzBCOMx7/7jQRFAz
         PvQ6EackXWB7AWh1bjsrJHxRiFCKp/M4SL8/Cm8B56O2kwKt5UNqvLEK4Jin8v0mIPT2
         IZu7nLwy3D/vONHzJ/8szTlRqwemoliDe5rXa4aeQbSnkJPTIuOVSKfBtp3khEYnG0ec
         sKODra0hz8sShhIjAD4hc5O6nTPisG42z9rgRLYYbPMz/xgAK/BklvAJPEdZkJRS+FpD
         mndwJU+vHRKl+y/zUgkW3airaHatHZTNwAPwbpNrty5ERdlEx74Wef/c3LLYQ7r/CvE+
         VXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=tChUZTn4MRDkHi0KUIzxNsr/rOfbju6k2bU3QFIll+M=;
        b=dsDVrc/EKrGh6k2uFTSOu2z0yl66g9aPct0O2fN+YeifUigkYlmImGrsThzOUMWYe+
         KG8ZSuor/V7/g1GSRt/42OxWKHXQEIcf+sWvgmJ/Xs213pkJkRqdIk00TRM831V33XaT
         NC55HlXRSHL4ORlcUHEUsHAoMXRekNNXiOdiG/Hps6wHYHcxFN1ZdX42ftZn/wfaBcdv
         mnr6pZWuP9qXfBagG8aoJkjkmslLx0dnhcWJRFzuiSGFrQUT+ktZy91TgbxAzUPnO6zK
         j+XCHukySDfFO3/sVosmfP2E+6qQZ6FI2wpWBujSBQTizbmgJ92HQi0jJ+rsw9u7yMSO
         gWPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=VOcRP3fP;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@cisco.com header.s=iport header.b=VOcRP3fP;
       spf=pass (google.com: best guess record for domain of osmithde@osmithde-lnx.cisco.com designates 173.37.142.93 as permitted sender) smtp.mailfrom=osmithde@osmithde-lnx.cisco.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=cisco.com
X-IronPort-AV: E=Sophos;i="5.48,412,1517875200";
   d="scan'208";a="94258012"
Date: Thu, 5 Apr 2018 14:18:37 -0700
From: Oliver Smith-Denny <osmithde@cisco.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sesidhar Baddela <sebaddel@cisco.com>,
        Gian Carlo Boffa <gcboffa@cisco.com>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Smith-Denny <osmithde@cisco.com>
Subject: [PATCH 03/10] staging: fnic2 add fip handling
Message-ID: <20180405211837.GD12584@osmithde-lnx.cisco.com>
References: <20180405211519.GA12584@osmithde-lnx.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405211519.GA12584@osmithde-lnx.cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596942401158018124?=
X-GMAIL-MSGID: =?utf-8?q?1596942401158018124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These files contain structures and functions for handling
FIP frames.

Signed-off-by: Oliver Smith-Denny <osmithde@cisco.com>
Signed-off-by: Sesidhar Baddela <sebaddel@cisco.com>
Signed-off-by: Anil Chintalapati <achintal@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-Developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-Developed-by: Oliver Smith-Denny <osmithde@cisco.com>
---
 drivers/staging/fnic2/src/fip.c | 804 ++++++++++++++++++++++++++++++++++++++++
 drivers/staging/fnic2/src/fip.h | 336 +++++++++++++++++
 2 files changed, 1140 insertions(+)
 create mode 100644 drivers/staging/fnic2/src/fip.c
 create mode 100644 drivers/staging/fnic2/src/fip.h

diff --git a/drivers/staging/fnic2/src/fip.c b/drivers/staging/fnic2/src/fip.c
new file mode 100644
index 0000000..42c2cf3
--- /dev/null
+++ b/drivers/staging/fnic2/src/fip.c
@@ -0,0 +1,804 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+/*! \file */
+#include "fnic2.h"
+#include "fip.h"
+
+extern struct workqueue_struct *fip_event_queue;
+
+void fnic2_fcoe_send_vlan_req(struct fnic2 *fnic2);
+static void fnic2_fcoe_start_fcf_discovery(struct fnic2 *fnic2);
+static void fnic2_fcoe_start_flogi(struct fnic2 *fnic2);
+static void fnic2_fcoe_process_cvl(struct fnic2 *fnic2, struct fip_header *fiph);
+static void fnic2_vlan_discovery_timeout(struct fnic2 *fnic2);
+
+int drop_rsp = true;
+
+/****************************** Functions ***********************************/
+
+/**
+ * fnic2_fcoe_reset_vlans
+ *
+ * Frees up the list of discovered vlans
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+void fnic2_fcoe_reset_vlans(struct fnic2 *fnic2)
+{
+	unsigned long flags;
+	struct fcoe_vlan *vlan, *next;
+
+        pr_debug("fnic2 0x%pK enter reset vlan\n", fnic2);
+	spin_lock_irqsave(&fnic2->vlans_lock, flags);
+	if (!list_empty(&fnic2->vlan_list)) {
+	    list_for_each_entry_safe(vlan, next, &fnic2->vlan_list, list) {
+		list_del(&vlan->list);
+		kfree(vlan);
+	    }
+	}
+
+	spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+        pr_debug("fnic2 0x%pK reset vlan done\n", fnic2);
+}
+
+/*
+ * fnic2_fcoe_send_vlan_req
+ *
+ * Sends FIP vlan request to all FCFs MAC
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+void fnic2_fcoe_send_vlan_req(struct fnic2 *fnic2)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+	uint64_t vlan_tov;
+
+	int fr_len;
+	struct fip_vlan_req vlan_req;
+
+	pr_debug("fnic2 0x%pK Enter send vlan req\n", fnic2);
+	fnic2_fcoe_reset_vlans(fnic2);
+
+	fnic2->set_vlan(fnic2, 0);
+	pr_debug("fnic2 0x%pK set vlan done\n", fnic2);
+
+	fr_len = sizeof(struct fip_vlan_req);
+
+	pr_debug("got MAC %x %x %x %x %x %x\n",
+		lport->hwmac[0], lport->hwmac[1], lport->hwmac[2],
+		lport->hwmac[3], lport->hwmac[4], lport->hwmac[5]);
+
+	memcpy(&vlan_req, &fip_vlan_reqmpl, fr_len);
+	memcpy(vlan_req.eth.smac, lport->hwmac, ETH_ALEN);
+	memcpy(vlan_req.mac_desc.mac, lport->hwmac, ETH_ALEN);
+
+	fnic2_send_fip_frame(lport, &vlan_req, fr_len);
+	pr_debug("fnic2 0x%pK vlan req frame sent\n", fnic2);
+
+	lport->fip.state = FDLS_FIP_VLAN_DISCOVERY_STARTED;
+
+	pr_debug("fnic2 0x%pK set timer\n", fnic2);
+	vlan_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FIPVLAN_TOV);
+	mod_timer(&fnic2->retry_fip_timer, round_jiffies(vlan_tov));
+	pr_debug("fnic2 0x%pK timer done\n", fnic2);
+}
+
+/**
+ * fnic2_fcoe_process_vlan_resp
+ *
+ * Processes the vlan response from one FCF and populates VLAN list.
+ * Will wait for responses from multiple FCFs until timeout.
+ *
+ * @param fnic2 fnic2 driver instance
+ * @param fiph received fip frame
+ */
+
+static void fnic2_fcoe_process_vlan_resp(struct fnic2 *fnic2, struct fip_header *fiph)
+{
+	struct fip_vlan_notif *vlan_notif = (struct fip_vlan_notif *) fiph;
+	uint16_t vid;
+	int num_vlan = 0;
+	int cur_desc, desc_len;
+	struct fcoe_vlan *vlan;
+	struct fip_vlan_desc *vlan_desc;
+	unsigned long flags;
+
+        pr_debug("fnic2 0x%pK got vlan resp\n", fnic2);
+
+	desc_len = ntohs(vlan_notif->fip.desc_len);
+        pr_debug("desc_len %d\n", desc_len);
+
+	spin_lock_irqsave(&fnic2->vlans_lock, flags);
+
+	cur_desc = 0;
+	while (desc_len > 0) {
+		vlan_desc = (struct fip_vlan_desc *)
+		    (((char *)vlan_notif->vlans_desc) + cur_desc * 4);
+		if (vlan_desc->type == FIP_TYPE_VLAN) {
+			if (vlan_desc->len != 1) {
+				pr_debug("Invalid descriptor length %x in VLan response\n",
+					vlan_desc->len);
+
+			}
+			num_vlan++;
+			vid = ntohs(vlan_desc->vlan);
+			pr_debug("process_vlan_resp: FIP VLAN %d\n", vid);
+			vlan = kmalloc(sizeof(*vlan), GFP_ATOMIC);
+
+			if (!vlan) {
+				/* retry from timer */
+				spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+				goto out;
+			}
+			memset(vlan, 0, sizeof(struct fcoe_vlan));
+			vlan->vid = vid & 0x0fff;
+			vlan->state = FIP_VLAN_AVAIL;
+			list_add_tail(&vlan->list, &fnic2->vlan_list);
+			break;
+		} else {
+                        pr_debug("Invalid descriptor type %x in VLan response\n",
+				vlan_desc->type);
+			// Note : received a type=2 descriptor here i.e. FIP
+			// MAC Address Descriptor
+		}
+		cur_desc += vlan_desc->len;
+		desc_len -= vlan_desc->len;
+	}
+
+	/* any VLAN descriptors present ? */
+	if (num_vlan == 0) {
+		pr_debug("fnic2 0x%pK No VLAN descriptors in FIP VLAN response\n", fnic2);
+	}
+
+	spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+
+out:
+	return;
+}
+
+/**
+ * fnic2_fcoe_start_fcf_discovery
+ *
+ * Starts FIP FCF discovery in a selected vlan
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+static void fnic2_fcoe_start_fcf_discovery(struct fnic2 *fnic2)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+	uint64_t fcs_tov;
+
+	int fr_len;
+	struct fip_discovery disc_sol;
+
+	pr_debug("fnic2 0x%pK start fcf discovery\n", fnic2);
+	fr_len = sizeof(struct fip_discovery);
+	memset(lport->selected_fcf.fcf_mac, 0, ETH_ALEN);
+
+	memcpy(&disc_sol, &fip_discoverympl, fr_len);
+	memcpy(disc_sol.eth.smac, lport->hwmac, ETH_ALEN);
+	memcpy(disc_sol.mac_desc.mac, lport->hwmac, ETH_ALEN);
+	lport->selected_fcf.fcf_priority = 0xFF;
+
+	disc_sol.name_desc.name = cpu_to_be64(lport->wwnn);
+	fnic2_send_fip_frame(lport, &disc_sol, fr_len);
+
+	lport->fip.state = FDLS_FIP_FCF_DISCOVERY_STARTED;
+
+	fcs_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FCS_TOV);
+	mod_timer(&fnic2->retry_fip_timer, round_jiffies(fcs_tov));
+
+	pr_debug("fnic2 0x%pK Started FCF discovery", fnic2);
+
+}
+
+/*
+ * fnic2_fcoe_fip_discovery_resp
+ *
+ * Processes FCF advertisements.
+ * They can be:
+ * solicited   Sent in response of a discover FCF FIP request
+ *             We will only store the information of the FCF with
+ *             highest priority.
+ *             We wait until timeout in case of multiple FCFs.
+ * unsolicited Sent periodically by the FCF for keep alive.
+ *             If FLOGI is in progress or completed and the advertisement is
+ *             received by our selected FCF, refresh the keep alive timer.
+ *
+ * @param fnic2 fnic2 driver instance
+ * @param fiph received frame
+ */
+
+static void fnic2_fcoe_fip_discovery_resp(struct fnic2 *fnic2, struct fip_header *fiph)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+	struct fip_disc_adv *disc_adv = (struct fip_disc_adv *) fiph;
+	uint64_t fcs_ka_tov;
+	int desc_len = ntohs(disc_adv->fip.desc_len);
+
+        pr_debug("fnic2 0x%pK In fcf discovery resp\n", fnic2);
+        pr_debug("fip state %d\n", lport->fip.state);
+
+	if (!(desc_len == 12)) {
+		pr_debug("struct fip_disc_adv invalid Descriptor List len %x\n",
+			desc_len);
+	}
+        if (!((disc_adv->prio_desc.type == 1) && (disc_adv->prio_desc.len == 1)) ||
+		!((disc_adv->mac_desc.type == 2) && (disc_adv->mac_desc.len == 2)) ||
+		!((disc_adv->name_desc.type == 4) && (disc_adv->name_desc.len == 3)) ||
+		!((disc_adv->fabric_desc.type == 5) &&
+		(disc_adv->fabric_desc.len == 4)) ||
+		!((disc_adv->fka_adv_desc.type == 12) &&
+		(disc_adv->fabric_desc.len == 2))) {// this len comes 4 ??
+		pr_debug("struct fip_disc_adv invalid Descriptor type and len mix:  type %x len %x | type %x len %x | type %x len%x |type %x len %x | type %x len %x\n",
+			disc_adv->prio_desc.type, disc_adv->prio_desc.len,
+			disc_adv->mac_desc.type, disc_adv->mac_desc.len,
+			disc_adv->name_desc.type, disc_adv->name_desc.len,
+			disc_adv->fabric_desc.type, disc_adv->fabric_desc.len,
+			disc_adv->fka_adv_desc.type, disc_adv->fabric_desc.len);
+	}
+
+	if (lport->fip.state == FDLS_FIP_FCF_DISCOVERY_STARTED) {
+		if (ntohs(disc_adv->fip.flags) & FIP_FLAG_S) {
+			pr_debug("fnic2 0x%pK Solicited adv\n", fnic2);
+
+			if ((disc_adv->prio_desc.priority <
+				lport->selected_fcf.fcf_priority) &&
+				(ntohs(disc_adv->fip.flags) & FIP_FLAG_A)) {
+
+				pr_debug("fnic2 0x%pK FCF Available\n", fnic2);
+				memcpy(lport->selected_fcf.fcf_mac,
+					disc_adv->mac_desc.mac, ETH_ALEN);
+				lport->selected_fcf.fcf_priority =
+					disc_adv->prio_desc.priority;
+				lport->selected_fcf.fka_adv_period =
+					ntohl(disc_adv->fka_adv_desc.fka_adv);
+				pr_debug("adv time %d",
+					lport->selected_fcf.fka_adv_period);
+				lport->selected_fcf.ka_disabled =
+					(disc_adv->fka_adv_desc.rsvd_D & 1);
+			}
+		} else {
+			// ignore
+		}
+	} else if ((lport->fip.state == FDLS_FIP_FLOGI_STARTED) ||
+		(lport->fip.state == FDLS_FIP_FLOGI_COMPLETE)) {
+		if (!(ntohs(disc_adv->fip.flags) & FIP_FLAG_S)) {
+			//  same fcf
+			if (memcmp(lport->selected_fcf.fcf_mac,
+				disc_adv->mac_desc.mac, ETH_ALEN) == 0) {
+				if (lport->selected_fcf.fka_adv_period !=
+					ntohl(disc_adv->fka_adv_desc.fka_adv)) {
+					lport->selected_fcf.fka_adv_period =
+						ntohl(disc_adv->fka_adv_desc.fka_adv);
+					pr_debug("change fka to %d",
+						lport->selected_fcf.fka_adv_period);
+				}
+				if (!((lport->selected_fcf.ka_disabled) ||
+					(lport->selected_fcf.fka_adv_period == 0))) {
+
+					fcs_ka_tov = jiffies +
+						3 * msecs_to_jiffies(lport->selected_fcf.fka_adv_period);
+					mod_timer(&fnic2->fcs_ka_timer, round_jiffies(fcs_ka_tov));
+
+				}
+			}
+		}
+	}
+}
+
+/*
+ * fnic2_fcoe_start_flogi
+ *
+ * Sends FIP FLOGI to the selected FCF
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+static void fnic2_fcoe_start_flogi(struct fnic2 *fnic2)
+{
+        struct fnic2_lport *lport = &fnic2->lport;
+
+	int fr_len;
+	struct fip_flogi flogi_req;
+	uint64_t flogi_tov;
+
+	fr_len = sizeof(struct fip_flogi);
+        pr_debug("fnic2 0x%pK Start fip FLOGI\n", fnic2);
+
+	memcpy(&flogi_req, &fip_flogimpl, fr_len);
+	memcpy(flogi_req.eth.smac, lport->hwmac, ETH_ALEN);
+	if (lport->usefip) {
+	    memcpy(flogi_req.eth.dmac, lport->selected_fcf.fcf_mac, ETH_ALEN);
+	}
+	flogi_req.flogi_desc.flogi.nport_name = cpu_to_be64(lport->wwpn);
+	flogi_req.flogi_desc.flogi.node_name = cpu_to_be64(lport->wwnn);
+
+	fnic2_send_fip_frame(lport, &flogi_req, fr_len);
+	lport->fip.flogi_retry++;
+
+	lport->fip.state = FDLS_FIP_FLOGI_STARTED;
+        flogi_tov = jiffies + msecs_to_jiffies(fnic2->config.flogi_timeout);
+	mod_timer(&fnic2->retry_fip_timer, round_jiffies(flogi_tov));
+}
+
+/*
+ * fnic2_fcoe_process_flogi_resp
+ *
+ * Processes FLOGI response from FCF.
+ * If successful saves assigned fc_id and MAC, programs firmware
+ * and starts fdls discovery.
+ * Else restarts vlan discovery.
+ *
+ * @param fnic2 fnic2 driver instance
+ * @param fiph received frame
+ */
+
+void fnic2_fcoe_process_flogi_resp(struct fnic2 *fnic2, struct fip_header *fiph)
+{
+	struct fnic2_lport *lport = &fnic2->lport;
+	struct fip_flogi_rsp *flogi_rsp = (struct fip_flogi_rsp *) fiph;
+	int desc_len;
+	uint32_t s_id;
+
+        pr_debug("fnic2 0x%pK FIP FLOGI rsp\n", fnic2);
+	desc_len = ntohs(flogi_rsp->fip.desc_len);
+	if (desc_len != 38) {
+		pr_debug("%s invalid Descriptor List len %x\n",
+			__func__, desc_len);
+	}
+	if (!((flogi_rsp->rsp_desc.type == 7) && (flogi_rsp->rsp_desc.len == 36)) ||
+		!((flogi_rsp->mac_desc.type == 2) && (flogi_rsp->mac_desc.len == 2))) {
+                pr_debug("dropping frame. %s invalid Descriptor type and len mix:\n flogi_rsp->rsp_desc.type %x flogi_rsp->rsp_desc.len %x flogi_rsp->mac_desc.type %x flogi_rsp->mac_desc.len %x\n",
+			__func__, flogi_rsp->rsp_desc.type, flogi_rsp->rsp_desc.len,
+			flogi_rsp->mac_desc.type, flogi_rsp->mac_desc.len);
+
+	}
+	s_id = ntoh24(flogi_rsp->rsp_desc.els.fchdr.s_id);
+	if ((flogi_rsp->rsp_desc.els.fchdr.f_ctl[0] != 0x98) ||
+		(flogi_rsp->rsp_desc.els.fchdr.r_ctl != 0x23) ||
+		(s_id != 0xFFFFFE) ||
+		(flogi_rsp->rsp_desc.els.fchdr.ox_id != FNIC2_FLOGI_OXID) ||
+		(flogi_rsp->rsp_desc.els.fchdr.type != 0x01)) {
+                pr_debug("fnic2_fcoe_process_flogi_resp received Flogi resp with some Invalid fc frame bits s_id %x FCTL %x R_CTL %x type %x OX_ID %x Dropping the frame\n",
+			s_id,
+			ntoh24(flogi_rsp->rsp_desc.els.fchdr.f_ctl),
+			flogi_rsp->rsp_desc.els.fchdr.r_ctl,
+			flogi_rsp->rsp_desc.els.fchdr.type,
+			flogi_rsp->rsp_desc.els.fchdr.ox_id);
+		return;
+	}
+
+	if (lport->fip.state == FDLS_FIP_FLOGI_STARTED) {
+		pr_debug("fnic2 0x%pK rsp for pending FLOGI\n", fnic2);
+
+		del_timer_sync(&fnic2->retry_fip_timer);
+
+		if ((ntohs(flogi_rsp->fip.desc_len) == 38) &&
+			(flogi_rsp->rsp_desc.els.command == FC_LS_ACC)) {
+
+			pr_debug("fnic2 0x%pK FLOGI success\n", fnic2);
+			memcpy(lport->fpma, flogi_rsp->mac_desc.mac, ETH_ALEN);
+			lport->fcid = ntoh24(flogi_rsp->rsp_desc.els.fchdr.d_id);
+
+			lport->r_a_tov =
+				ntohl(flogi_rsp->rsp_desc.els.u.csp_flogi.r_a_tov);
+			lport->e_d_tov =
+				ntohl(flogi_rsp->rsp_desc.els.u.csp_flogi.e_d_tov);
+			memcpy(fnic2->lport.fcfmac, lport->selected_fcf.fcf_mac,
+				ETH_ALEN);
+			vnic_dev_add_addr(fnic2->vdev, flogi_rsp->mac_desc.mac);
+
+			if (fnic2_fdls_register_portid(lport, lport->fcid, NULL) != 0) {
+				pr_debug("fnic2 0x%pK flogi registration failed\n", fnic2);
+				return;
+			}
+
+			lport->fip.state = FDLS_FIP_FLOGI_COMPLETE;
+			lport->state = FNIC2_IPORT_STATE_FABRIC_DISC;
+			pr_debug("lport->state: %d\n",
+				lport->state);
+			fnic2_fdls_disc_start(lport);
+			if (!lport->selected_fcf.ka_disabled) {
+				uint64_t tov;
+
+				tov = jiffies + msecs_to_jiffies(FCOE_CTLR_ENODE_KA_TOV);
+				mod_timer(&fnic2->enode_ka_timer, round_jiffies(tov));
+
+				tov = jiffies + msecs_to_jiffies(FCOE_CTLR_VN_KA_TOV);
+				mod_timer(&fnic2->vn_ka_timer, round_jiffies(tov));
+
+			}
+		} else {
+			/*
+			 * If there's FLOGI rejects - clear all
+			 * fcf's & restart from scratch
+			 * start FCoE VLAN discovery
+			 */
+			fnic2_fcoe_send_vlan_req(fnic2);
+
+			lport->fip.state = FDLS_FIP_VLAN_DISCOVERY_STARTED;
+		}
+	}
+}
+
+/*
+ * fnic2_common_fip_cleanup
+ *
+ * Cleans up FCF info and timers in case of link down/CVL
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+void fnic2_common_fip_cleanup(struct fnic2 *fnic2)
+{
+
+        struct fnic2_lport *lport = &fnic2->lport;
+
+	if (!lport->usefip)
+		return;
+        pr_debug("fnic2 0x%pK fip cleanup\n", fnic2);
+
+	// cleanup flogi form hw
+	fnic2_fw_reset_handler(fnic2);
+
+	lport->fip.state = FDLS_FIP_INIT;
+
+	del_timer_sync(&fnic2->retry_fip_timer);
+	del_timer_sync(&fnic2->fcs_ka_timer);
+	del_timer_sync(&fnic2->enode_ka_timer);
+	del_timer_sync(&fnic2->vn_ka_timer);
+
+	vnic_dev_del_addr(fnic2->vdev, lport->fpma);
+
+	memset(lport->fpma, 0, ETH_ALEN);
+	lport->fcid = 0;
+	lport->r_a_tov = 0;
+	lport->e_d_tov = 0;
+	memset(fnic2->lport.fcfmac, 0, ETH_ALEN);
+	memset(lport->selected_fcf.fcf_mac, 0, ETH_ALEN);
+	lport->selected_fcf.fcf_priority = 0;
+	lport->selected_fcf.fka_adv_period = 0;
+	lport->selected_fcf.ka_disabled = 0;
+
+	fnic2_fcoe_reset_vlans(fnic2);
+}
+
+/*
+ * fnic2_fcoe_process_cvl
+ *
+ * Processes Clear Virtual Link from FCF
+ * Verifies that cvl is received from our current FCF for our assigned MAC
+ * Cleans up and restarts the vlan discovery
+ *
+ * @param fnic2 fnic2 driver instance
+ * @param fiph received frame
+ */
+
+static void fnic2_fcoe_process_cvl(struct fnic2 *fnic2, struct fip_header *fiph)
+{
+        struct fnic2_lport *lport = &fnic2->lport;
+	struct fip_cvl *cvl_msg = (struct fip_cvl *) fiph;
+	int i;
+	int found = false;
+
+        pr_debug("fnic2 0x%pK clear virtual link handler\n", fnic2);
+
+	if (!((cvl_msg->fcf_mac_desc.type == 2) &&
+		(cvl_msg->fcf_mac_desc.len == 2)) ||
+		!((cvl_msg->name_desc.type == 4) &&
+		(cvl_msg->name_desc.len == 3))) {
+
+                pr_debug("fnic2_fcoe_process_cvl invalid Descriptor type and len mix: fcf_mac_desc.type %x fcf_mac_desc.len %x  cvl_msg->name_desc.type %x cvl_msg->name_desc.len %x\n",
+			cvl_msg->fcf_mac_desc.type, cvl_msg->fcf_mac_desc.len,
+			cvl_msg->name_desc.type, cvl_msg->name_desc.len);
+	}
+
+	if (memcmp(lport->selected_fcf.fcf_mac, cvl_msg->fcf_mac_desc.mac,
+	    ETH_ALEN) == 0) {
+		for (i = 0; i < ((ntohs(fiph->desc_len) / 5) - 1); i++) {
+			if (!((cvl_msg->vn_ports_desc[i].type == 11) &&
+			    (cvl_msg->vn_ports_desc[i].len == 5))) {
+
+				pr_debug("fnic2_fcoe_process_cvl invalid Descriptor type and len mix: vn_ports_desc[i].type %d vn_ports_desc[i].len %d\n",
+					cvl_msg->vn_ports_desc[i].type,
+					cvl_msg->vn_ports_desc[i].len);
+			}
+			if (memcmp(lport->fpma,
+			    cvl_msg->vn_ports_desc[i].vn_port_mac,
+			    ETH_ALEN) == 0) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return;
+		fnic2_common_fip_cleanup(fnic2);
+		fnic2_fdls_link_down(lport);
+
+		fnic2_fcoe_send_vlan_req(fnic2);
+	}
+}
+
+/*
+ * fdls_fip_recv_frame
+ *
+ * Demultiplexer for FIP frames
+ *
+ * @param fnic2 driver instance
+ * @param frame received ethernet frame
+ * @return Frame processed by FIP
+ */
+
+int fdls_fip_recv_frame(struct fnic2 *fnic2, void *frame)
+{
+    struct eth_hdr *eth = (struct eth_hdr *) frame;
+    struct fip_header *fiph;
+    uint16_t protocol;
+    uint8_t sub;
+
+    if (eth->eth_type == ntohs(FIP_ETH_TYPE)) {
+
+	fiph = (struct fip_header *) (eth+1);
+	protocol = ntohs(fiph->protocol);
+	sub = ntohs(fiph->subcode);
+
+	pr_debug("recv fip frame op %x sub %x\n",
+		protocol, sub);
+
+	if (protocol == FIP_DISCOVERY && sub == FIP_SUBCODE_RESP) {
+		fnic2_fcoe_fip_discovery_resp(fnic2, fiph);
+	} else if (protocol == FIP_VLAN_DISC && sub == FIP_SUBCODE_RESP) {
+		fnic2_fcoe_process_vlan_resp(fnic2, fiph);
+	} else if (protocol == FIP_KA_CVL && sub == FIP_SUBCODE_RESP) {
+		fnic2_fcoe_process_cvl(fnic2, fiph);
+	} else if (protocol == FIP_FLOGI && sub == FIP_SUBCODE_RESP) {
+		fnic2_fcoe_process_flogi_resp(fnic2, fiph);
+	}
+	return 1;
+    }
+    return 0;
+}
+
+/*
+ * fnic2_handle_fip_timer
+ *
+ * Timeout handler for FIP discover phase.
+ * Based on the current state, starts next phase or restarts discovery
+ *
+ * @param data Opaque pointer to fnic2 structure
+ */
+
+void fnic2_handle_fip_timer(struct timer_list *timer)
+{
+	struct fnic2 *fnic2 = container_of(timer, struct fnic2, retry_fip_timer);
+        struct fnic2_lport *lport = &fnic2->lport;
+
+        pr_debug("fnic2 0x%pK fip timeout\n", fnic2);
+
+	if (lport->fip.state == FDLS_FIP_VLAN_DISCOVERY_STARTED) {
+		// pr_debug("vlan discovey timeout\n");
+		fnic2_vlan_discovery_timeout(fnic2);
+	} else if (lport->fip.state == FDLS_FIP_FCF_DISCOVERY_STARTED) {
+		uint8_t zmac[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
+
+		pr_debug("fnic2 0x%pK fcf discovey timeout\n", fnic2);
+		if (memcmp(lport->selected_fcf.fcf_mac, zmac, ETH_ALEN) != 0) {
+			fnic2_fcoe_start_flogi(fnic2);
+			if (!((lport->selected_fcf.ka_disabled) ||
+				(lport->selected_fcf.fka_adv_period == 0))) {
+				uint64_t fcf_tov;
+
+				fcf_tov = jiffies +
+					3 * msecs_to_jiffies(lport->selected_fcf.fka_adv_period);
+				mod_timer(&fnic2->fcs_ka_timer, round_jiffies(fcf_tov));
+			}
+		} else {
+			pr_debug("fnic2 0x%pK FCF discovey timeout\n", fnic2);
+			fnic2_vlan_discovery_timeout(fnic2);
+		}
+	} else if (lport->fip.state == FDLS_FIP_FLOGI_STARTED) {
+		pr_debug("fnic2 0x%pK flogi timeout\n", fnic2);
+		if (lport->fip.flogi_retry < fnic2->config.flogi_retries) {
+			fnic2_fcoe_start_flogi(fnic2);
+		} else {
+			fnic2_vlan_discovery_timeout(fnic2);
+		}
+	}
+}
+
+/*
+ * fnic2_handle_enode_ka_timer
+ *
+ * FIP node keep alive.
+ *
+ * @param data Opaque pointer to fnic2 struct
+ */
+void fnic2_handle_enode_ka_timer(struct timer_list *timer)
+{
+    struct fnic2 *fnic2 = container_of(timer, struct fnic2, enode_ka_timer);
+    struct fnic2_lport *lport = &fnic2->lport;
+    int fr_len;
+    struct fip_enode_ka enode_ka;
+    uint64_t enode_ka_tov;
+
+    pr_debug("fnic2 0x%pK ka timer\n", fnic2);
+
+    if (lport->fip.state != FDLS_FIP_FLOGI_COMPLETE) {
+	return;
+    }
+
+    fr_len = sizeof(struct fip_enode_ka);
+
+    memcpy(&enode_ka, &fip_enode_kampl, fr_len);
+    memcpy(enode_ka.eth.smac, lport->hwmac, ETH_ALEN);
+    memcpy(enode_ka.eth.dmac, lport->selected_fcf.fcf_mac, ETH_ALEN);
+    memcpy(enode_ka.mac_desc.mac, lport->hwmac, ETH_ALEN);
+
+    fnic2_send_fip_frame(lport, &enode_ka, fr_len);
+    enode_ka_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_ENODE_KA_TOV);
+    mod_timer(&fnic2->enode_ka_timer, round_jiffies(enode_ka_tov));
+}
+
+/*
+ * fnic2_handle_vn_ka_timer
+ *
+ * FIP virtual port keep alive.
+ *
+ * @param data Opaque pointer to fnic2 structure
+ */
+
+void fnic2_handle_vn_ka_timer(struct timer_list *timer)
+{
+	struct fnic2 *fnic2 = container_of(timer, struct fnic2, vn_ka_timer);
+        struct fnic2_lport *lport = &fnic2->lport;
+	int fr_len;
+	struct fip_vn_port_ka vn_port_ka;
+	uint64_t vn_ka_tov;
+	uint8_t fcid[3];
+
+        pr_debug("fnic2 0x%pK vn port ka timer\n", fnic2);
+
+	if (lport->fip.state != FDLS_FIP_FLOGI_COMPLETE) {
+		return;
+	}
+
+	fr_len = sizeof(struct fip_vn_port_ka);
+
+	memcpy(&vn_port_ka, &fip_vn_port_kampl, fr_len);
+	memcpy(vn_port_ka.eth.smac, lport->hwmac, ETH_ALEN);
+        memcpy(vn_port_ka.eth.dmac, lport->selected_fcf.fcf_mac, ETH_ALEN);
+	memcpy(vn_port_ka.mac_desc.mac, lport->hwmac, ETH_ALEN);
+	memcpy(vn_port_ka.vn_port_desc.vn_port_mac, lport->fpma, ETH_ALEN);
+	hton24(fcid, lport->fcid);
+	memcpy(vn_port_ka.vn_port_desc.vn_port_id, fcid, 3);
+	vn_port_ka.vn_port_desc.vn_port_name = cpu_to_be64(lport->wwpn);
+
+	fnic2_send_fip_frame(lport, &vn_port_ka, fr_len);
+	vn_ka_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_VN_KA_TOV);
+	mod_timer(&fnic2->vn_ka_timer, round_jiffies(vn_ka_tov));
+}
+
+/*
+ * fnic2_vlan_discovery_timeout
+ *
+ * End of VLAN discovery or FCF discovery time window
+ * Start the FCF discovery if VLAN was never used
+ * Retry in case of FCF not responding or move to next VLAN
+ *
+ * @param fnic2 fnic2 driver instance
+ */
+
+static void fnic2_vlan_discovery_timeout(struct fnic2 *fnic2)
+{
+	struct fcoe_vlan *vlan;
+        struct fnic2_lport *lport = &fnic2->lport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic2->fnic2_lock, flags);
+	if (fnic2->stop_rx_link_events) {
+		spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&fnic2->fnic2_lock, flags);
+
+	if (!lport->usefip)
+		 return;
+
+	spin_lock_irqsave(&fnic2->vlans_lock, flags);
+	if (list_empty(&fnic2->vlan_list)) {
+		/* no vlans available, try again */
+		spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+		fnic2_fcoe_send_vlan_req(fnic2);
+		return;
+	}
+
+	vlan = list_first_entry(&fnic2->vlan_list, struct fcoe_vlan, list);
+
+	if (vlan->state == FIP_VLAN_SENT) {
+		if (vlan->sol_count >= FCOE_CTLR_MAX_SOL) {
+			/*
+			 * no response on this vlan, remove  from the list.
+			 * Try the next vlan
+			 */
+			list_del(&vlan->list);
+			kfree(vlan);
+			vlan = NULL;
+			if (list_empty(&fnic2->vlan_list)) {
+			    /* we exhausted all vlans, restart vlan disc */
+			    spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+			    fnic2_fcoe_send_vlan_req(fnic2);
+			    return;
+			}
+			/* check the next vlan */
+			vlan = list_first_entry(&fnic2->vlan_list, struct fcoe_vlan, list);
+
+			fnic2->set_vlan(fnic2, vlan->vid);
+			vlan->state = FIP_VLAN_SENT; /* sent now */
+
+		}
+	} else {
+		fnic2->set_vlan(fnic2, vlan->vid);
+		vlan->state = FIP_VLAN_SENT; /* sent now */
+	}
+	vlan->sol_count++;
+	spin_unlock_irqrestore(&fnic2->vlans_lock, flags);
+	fnic2_fcoe_start_fcf_discovery(fnic2);
+}
+
+/*
+ * fnic2_work_on_fcs_ka_timer - finish handling fcs_ka_timer in process context
+ *
+ * We need to finish this timer in a process context so that we do
+ * not hand in fip_common_cleanup. Here we clean up, bring the link down
+ * and restart all FIP discovery.
+ *
+ * @work - the work queue that we will be servicing
+ */
+void fnic2_work_on_fcs_ka_timer(struct work_struct *work)
+{
+	struct fnic2 *fnic2 = container_of(work, struct fnic2, fip_work);
+	struct fnic2_lport *lport = &fnic2->lport;
+
+	pr_debug("fnic2 0x%pK fcs ka timeout\n", fnic2);
+
+	fnic2_common_fip_cleanup(fnic2);
+	fnic2_fdls_link_down(lport);
+
+	lport->state = FNIC2_IPORT_STATE_FIP;
+	fnic2_fcoe_send_vlan_req(fnic2);
+}
+
+/*
+ * fnic2_handle_fcs_ka_timer
+ *
+ * No keep alives received from FCF. Clean up, bring the link down
+ * and restart all the FIP discovery.
+ *
+ * @param data Opaque pointer to fnic2 structure
+ */
+void fnic2_handle_fcs_ka_timer(struct timer_list *timer)
+{
+	struct fnic2 *fnic2 = container_of(timer, struct fnic2, fcs_ka_timer);
+	INIT_WORK(&fnic2->fip_work, fnic2_work_on_fcs_ka_timer);
+	queue_work(fip_event_queue, &fnic2->fip_work);
+}
diff --git a/drivers/staging/fnic2/src/fip.h b/drivers/staging/fnic2/src/fip.h
new file mode 100644
index 0000000..04a522e
--- /dev/null
+++ b/drivers/staging/fnic2/src/fip.h
@@ -0,0 +1,336 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0
+ * Copyright 2018 Cisco Systems, Inc.  All rights reserved.
+ *
+ * This program is free software; you may redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef _FIP_H_
+#define _FIP_H_
+
+#include "fdls_fc.h"
+
+#define FCOE_ALL_FCFS_MAC {0x01, 0x10, 0x18, 0x01, 0x00, 0x02}
+#define FIP_ETH_TYPE 0x8914
+
+#define FIP_ETH_TYPE_LE 0x1489
+#define FCOE_MAX_SIZE_LE 0x2E08
+
+enum fcoe_ctlr {
+	FCOE_CTLR_MAX_SOL       = 5,
+	FCOE_CTLR_FIPVLAN_TOV	= (3*1000),
+	FCOE_CTLR_FCS_TOV	= (3*1000),
+	FCOE_CTLR_ENODE_KA_TOV	= (8*1000),
+	FCOE_CTLR_VN_KA_TOV	= (90*1000),
+};
+
+/*
+ * VLAN entry.
+ */
+struct fcoe_vlan {
+	struct list_head	list;
+	uint16_t		vid;		/* vlan ID */
+	uint16_t		sol_count;	/* no. of sols sent */
+	uint16_t		state;		/* state */
+};
+
+enum fdls_vlan_state {
+	FIP_VLAN_AVAIL,
+	FIP_VLAN_SENT
+};
+
+enum fdls_fip_state {
+	FDLS_FIP_INIT,
+	FDLS_FIP_VLAN_DISCOVERY_STARTED,
+	FDLS_FIP_FCF_DISCOVERY_STARTED,
+	FDLS_FIP_FLOGI_STARTED,
+	FDLS_FIP_FLOGI_COMPLETE,
+};
+
+enum fip_protocol_code {
+	FIP_DISCOVERY = 1,
+	FIP_FLOGI,
+	FIP_KA_CVL,
+	FIP_VLAN_DISC
+};
+
+#define FIP_SUBCODE_REQ  1
+#define FIP_SUBCODE_RESP 2
+
+struct eth_hdr {
+	uint8_t		dmac[6];
+	uint8_t		smac[6];
+	uint16_t	eth_type;
+};
+
+struct fip_header {
+	uint16_t	ver;
+
+	uint16_t	protocol;
+	uint16_t	subcode;
+
+	uint16_t	desc_len;
+	uint16_t	flags;
+} __attribute__((__packed__));
+
+#define FIP_FLAG_S 0x2
+#define FIP_FLAG_A 0x4
+
+enum fip_desc_type {
+	FIP_TYPE_MAC		= 2,
+	FIP_TYPE_NAME_ID	= 4,
+	FIP_TYPE_MAX_FCOE	= 6,
+	FIP_TYPE_FLOGI		= 7,
+	FIP_TYPE_VX_PORT	= 11,
+	FIP_TYPE_VLAN		= 14
+};
+
+struct fip_mac_desc {
+	uint8_t	type;
+	uint8_t len;
+	uint8_t mac[6];
+}  __attribute__((__packed__));
+
+struct fip_vlan_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint16_t	vlan;
+}  __attribute__((__packed__));
+
+struct fip_vlan_req {
+	struct eth_hdr		eth;
+	struct fip_header	fip;
+	struct fip_mac_desc	mac_desc;
+}  __attribute__((__packed__));
+
+ /*
+  * Variables:
+  * eth.smac, mac_desc.mac
+  */
+struct fip_vlan_req fip_vlan_reqmpl = {
+	.eth = { .dmac = FCOE_ALL_FCFS_MAC,
+		.eth_type = FIP_ETH_TYPE_LE},
+	.fip = { .ver = 0x10,
+		 .protocol = FIP_VLAN_DISC << 8,
+		 .subcode = FIP_SUBCODE_REQ << 8,
+		 .desc_len = 2 << 8},
+	.mac_desc = {.type = FIP_TYPE_MAC, .len = 2 }
+};
+
+struct fip_vlan_notif {
+	struct fip_header	fip;
+	struct fip_vlan_desc	vlans_desc[0];
+} __attribute__((__packed__));
+
+struct fip_vn_port_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint8_t		vn_port_mac[6];
+	uint8_t		rsvd[1];
+	uint8_t		vn_port_id[3];
+	uint64_t	vn_port_name;
+} __attribute__((__packed__));
+
+struct fip_vn_port_ka {
+	struct eth_hdr		eth;
+	struct fip_header	fip;
+	struct fip_mac_desc	mac_desc;
+	struct fip_vn_port_desc	vn_port_desc;
+} __attribute__((__packed__));
+
+/*
+ * Variables:
+ * fcf_mac, eth.smac, mac_desc.enode_mac
+ * vn_port_desc:mac, id, port_name
+ */
+struct fip_vn_port_ka fip_vn_port_kampl = {
+
+	.eth = {
+		.eth_type = FIP_ETH_TYPE_LE},
+	.fip = {
+		.ver = 0x10,
+		.protocol = FIP_KA_CVL << 8,
+		.subcode = FIP_SUBCODE_REQ << 8,
+		.desc_len = 7 << 8
+	       },
+	.mac_desc = {.type = FIP_TYPE_MAC, .len = 2 },
+	.vn_port_desc = {.type = FIP_TYPE_VX_PORT, .len = 5}
+};
+
+struct fip_enode_ka {
+	struct eth_hdr		eth;
+	struct fip_header	fip;
+	struct fip_mac_desc	mac_desc;
+} __attribute__((__packed__));
+
+/*
+ * Variables:
+ * fcf_mac, eth.smac, mac_desc.enode_mac
+ */
+struct fip_enode_ka fip_enode_kampl = {
+
+	.eth = {
+		.eth_type = FIP_ETH_TYPE_LE},
+	.fip = {
+		.ver = 0x10,
+		.protocol = FIP_KA_CVL << 8,
+		.subcode = FIP_SUBCODE_REQ << 8,
+		.desc_len = 2 << 8
+	       },
+	.mac_desc = {.type = FIP_TYPE_MAC, .len = 2 }
+};
+
+struct fip_name_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint8_t		rsvd[2];
+	uint64_t	name;
+} __attribute__((__packed__));
+
+struct fip_cvl {
+	struct fip_header	fip;
+	struct fip_mac_desc	fcf_mac_desc;
+	struct fip_name_desc	name_desc;
+	struct fip_vn_port_desc	vn_ports_desc[0];
+} __attribute__((__packed__));
+
+struct fip_flogi_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint16_t	rsvd;
+	struct fc_els	flogi;
+} __attribute__((__packed__));
+
+struct fip_flogi_rsp_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint16_t	rsvd;
+	struct fc_els	els;
+} __attribute__((__packed__));
+
+struct fip_flogi {
+	struct eth_hdr		eth;
+	struct fip_header	fip;
+	struct fip_flogi_desc	flogi_desc;
+	struct fip_mac_desc	mac_desc;
+} __attribute__((__packed__));
+
+struct fip_flogi_rsp {
+	struct fip_header		fip;
+	struct fip_flogi_rsp_desc	rsp_desc;
+	struct fip_mac_desc		mac_desc;
+} __attribute__((__packed__));
+
+/*
+ * Variables:
+ * fcf_mac, eth.smac, mac_desc.enode_mac
+ */
+struct fip_flogi fip_flogimpl = {
+
+	.eth = {
+		.eth_type = FIP_ETH_TYPE_LE},
+	.fip = {
+		.ver = 0x10,
+		.protocol = FIP_FLOGI << 8,
+		.subcode = FIP_SUBCODE_REQ << 8,
+		.desc_len = 38 << 8,
+		.flags = 0x80 },
+	.flogi_desc = {
+		.type = FIP_TYPE_FLOGI, .len = 36,
+		.flogi = {
+			.fchdr = {
+				.r_ctl = 0x22,
+				.d_id = {0xFF, 0xFF, 0xFE},
+				.type = 0x01,
+				.f_ctl = {FNIC2_ELS_REQ_FCTL, 0x00, 0x00},
+				.ox_id = FNIC2_FLOGI_OXID,
+				.rx_id = 0xFFFF },
+			.command = FC_ELS_FLOGI_REQ,
+			.u.csp_flogi = {
+				.fc_ph_ver = FNIC2_FC_PH_VER,
+				.b2b_credits = FNIC2_FC_B2B_CREDIT,
+				.b2b_rdf_size = FNIC2_FC_B2B_RDF_SZ },
+			.spc3 = {0x88, 0x00}
+		}
+	},
+	.mac_desc = {.type = FIP_TYPE_MAC, .len = 2 }
+};
+
+struct fip_fcoe_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint16_t	max_fcoe_size;
+} __attribute__((__packed__));
+
+struct fip_discovery {
+	struct eth_hdr		eth;
+	struct fip_header	fip;
+	struct fip_mac_desc	mac_desc;
+	struct fip_name_desc	name_desc;
+	struct fip_fcoe_desc	fcoe_desc;
+} __attribute__((__packed__));
+
+/*
+ * Variables:
+ * eth.smac, mac_desc.enode_mac, node_name
+ */
+struct fip_discovery fip_discoverympl = {
+
+	.eth = {.dmac = FCOE_ALL_FCFS_MAC,
+		.eth_type = FIP_ETH_TYPE_LE},
+	.fip = {
+		.ver = 0x10, .protocol = FIP_DISCOVERY << 8,
+		.subcode = FIP_SUBCODE_REQ << 8, .desc_len = 6 << 8,
+		.flags = 0x80},
+	.mac_desc = {.type = FIP_TYPE_MAC, .len = 2 },
+	.name_desc = {.type = FIP_TYPE_NAME_ID, .len = 3},
+	.fcoe_desc = {
+	    .type = FIP_TYPE_MAX_FCOE, .len = 1,
+	    .max_fcoe_size = FCOE_MAX_SIZE_LE
+	}
+};
+
+struct fip_prio_desc {
+	uint8_t type;
+	uint8_t len;
+	uint8_t rsvd;
+	uint8_t priority;
+} __attribute__((__packed__));
+
+struct fip_fabric_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint16_t	vf_id;
+	uint8_t		rsvd;
+	uint8_t		fc_map[3];
+	uint64_t	fabric_name;
+} __attribute__((__packed__));
+
+struct fip_fka_adv_desc {
+	uint8_t		type;
+	uint8_t		len;
+	uint8_t		rsvd;
+	uint8_t		rsvd_D;
+	uint32_t	fka_adv;
+} __attribute__((__packed__));
+
+struct fip_disc_adv {
+	struct fip_header	fip;
+	struct fip_prio_desc	prio_desc;
+	struct fip_mac_desc	mac_desc;
+	struct fip_name_desc	name_desc;
+	struct fip_fabric_desc	fabric_desc;
+	struct fip_fka_adv_desc	fka_adv_desc;
+} __attribute__((__packed__));
+#endif /* _FIP_H_ */
-- 
1.8.3.1
