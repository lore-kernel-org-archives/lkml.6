Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED56C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5722084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545141;
	bh=WJ10DskCPZeuHp5XkDj9HwRPJroaixi4feDWEnj+1d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eHzl4J0ZKON8nrVfjCTDN3nKEC3MO85XvK/lS1PjuIINzU2AXU239uBkCwaVvRl4Y
	 Lbk4Rd0KhEhuuoHIYUJ0l5sd3qIOYs2bYGSTkBE5cnvbJmomWBz5Q8UZWWwWPdFmE7
	 1ajDV2F8d496dJNiw1kfA2/FnpT2ZhnUox2G9UoE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5722084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeLKQTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbeLKPqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD53820870;
        Tue, 11 Dec 2018 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543171;
        bh=WJ10DskCPZeuHp5XkDj9HwRPJroaixi4feDWEnj+1d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcwMk3lp8qr9F4xLyuAwHun+5ly/CRcK21AK4FOGlJmHKGCM3Qt3rLon4C9W5A82t
         YNHUlSQSahmgxPGygjuvnhFrCr+ykU2DgB3vE/ZaH3vCk4YfXuwdqnLh7i3/EoQOkt
         qNjgEAPoH/YJ/kS90urcRR2l1vGka2883C8qB9Z4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.4 39/91] scsi: csiostor: Avoid content leaks and casts
Date:   Tue, 11 Dec 2018 16:40:58 +0100
Message-Id: <20181211151609.046047380@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

commit 42c335f7e67029d2e01711f2f2bc6252277c8993 upstream.

When copying attributes, the len argument was padded out and the
resulting memcpy() would copy beyond the end of the source buffer.
Avoid this, and use size_t for val_len to avoid all the casts.
Similarly, avoid source buffer casts and use void *.

Additionally enforces val_len can be represented by u16 and that the DMA
buffer was not overflowed. Fixes the size of mfa, which is not
FC_FDMI_PORT_ATTR_MAXFRAMESIZE_LEN (but it will be padded up to 4). This
was noticed by the future CONFIG_FORTIFY_SOURCE checks.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/csiostor/csio_lnode.c |   43 ++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 17 deletions(-)

--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -238,14 +238,23 @@ csio_osname(uint8_t *buf, size_t buf_len
 }
 
 static inline void
-csio_append_attrib(uint8_t **ptr, uint16_t type, uint8_t *val, uint16_t len)
+csio_append_attrib(uint8_t **ptr, uint16_t type, void *val, size_t val_len)
 {
+	uint16_t len;
 	struct fc_fdmi_attr_entry *ae = (struct fc_fdmi_attr_entry *)*ptr;
+
+	if (WARN_ON(val_len > U16_MAX))
+		return;
+
+	len = val_len;
+
 	ae->type = htons(type);
 	len += 4;		/* includes attribute type and length */
 	len = (len + 3) & ~3;	/* should be multiple of 4 bytes */
 	ae->len = htons(len);
-	memcpy(ae->value, val, len);
+	memcpy(ae->value, val, val_len);
+	if (len > val_len)
+		memset(ae->value + val_len, 0, len - val_len);
 	*ptr += len;
 }
 
@@ -335,7 +344,7 @@ csio_ln_fdmi_rhba_cbfn(struct csio_hw *h
 	numattrs++;
 	val = htonl(FC_PORTSPEED_1GBIT | FC_PORTSPEED_10GBIT);
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_SUPPORTEDSPEED,
-			   (uint8_t *)&val,
+			   &val,
 			   FC_FDMI_PORT_ATTR_SUPPORTEDSPEED_LEN);
 	numattrs++;
 
@@ -346,23 +355,22 @@ csio_ln_fdmi_rhba_cbfn(struct csio_hw *h
 	else
 		val = htonl(CSIO_HBA_PORTSPEED_UNKNOWN);
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_CURRENTPORTSPEED,
-			   (uint8_t *)&val,
-			   FC_FDMI_PORT_ATTR_CURRENTPORTSPEED_LEN);
+			   &val, FC_FDMI_PORT_ATTR_CURRENTPORTSPEED_LEN);
 	numattrs++;
 
 	mfs = ln->ln_sparm.csp.sp_bb_data;
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_MAXFRAMESIZE,
-			   (uint8_t *)&mfs, FC_FDMI_PORT_ATTR_MAXFRAMESIZE_LEN);
+			   &mfs, sizeof(mfs));
 	numattrs++;
 
 	strcpy(buf, "csiostor");
 	csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_OSDEVICENAME, buf,
-			   (uint16_t)strlen(buf));
+			   strlen(buf));
 	numattrs++;
 
 	if (!csio_hostname(buf, sizeof(buf))) {
 		csio_append_attrib(&pld, FC_FDMI_PORT_ATTR_HOSTNAME,
-				   buf, (uint16_t)strlen(buf));
+				   buf, strlen(buf));
 		numattrs++;
 	}
 	attrib_blk->numattrs = htonl(numattrs);
@@ -444,33 +452,32 @@ csio_ln_fdmi_dprt_cbfn(struct csio_hw *h
 
 	strcpy(buf, "Chelsio Communications");
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MANUFACTURER, buf,
-			   (uint16_t)strlen(buf));
+			   strlen(buf));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_SERIALNUMBER,
-			   hw->vpd.sn, (uint16_t)sizeof(hw->vpd.sn));
+			   hw->vpd.sn, sizeof(hw->vpd.sn));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MODEL, hw->vpd.id,
-			   (uint16_t)sizeof(hw->vpd.id));
+			   sizeof(hw->vpd.id));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MODELDESCRIPTION,
-			   hw->model_desc, (uint16_t)strlen(hw->model_desc));
+			   hw->model_desc, strlen(hw->model_desc));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_HARDWAREVERSION,
-			   hw->hw_ver, (uint16_t)sizeof(hw->hw_ver));
+			   hw->hw_ver, sizeof(hw->hw_ver));
 	numattrs++;
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_FIRMWAREVERSION,
-			   hw->fwrev_str, (uint16_t)strlen(hw->fwrev_str));
+			   hw->fwrev_str, strlen(hw->fwrev_str));
 	numattrs++;
 
 	if (!csio_osname(buf, sizeof(buf))) {
 		csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_OSNAMEVERSION,
-				   buf, (uint16_t)strlen(buf));
+				   buf, strlen(buf));
 		numattrs++;
 	}
 
 	csio_append_attrib(&pld, FC_FDMI_HBA_ATTR_MAXCTPAYLOAD,
-			   (uint8_t *)&maxpayload,
-			   FC_FDMI_HBA_ATTR_MAXCTPAYLOAD_LEN);
+			   &maxpayload, FC_FDMI_HBA_ATTR_MAXCTPAYLOAD_LEN);
 	len = (uint32_t)(pld - (uint8_t *)cmd);
 	numattrs++;
 	attrib_blk->numattrs = htonl(numattrs);
@@ -1794,6 +1801,8 @@ csio_ln_mgmt_submit_req(struct csio_iore
 	struct csio_mgmtm *mgmtm = csio_hw_to_mgmtm(hw);
 	int rv;
 
+	BUG_ON(pld_len > pld->len);
+
 	io_req->io_cbfn = io_cbfn;	/* Upper layer callback handler */
 	io_req->fw_handle = (uintptr_t) (io_req);
 	io_req->eq_idx = mgmtm->eq_idx;


