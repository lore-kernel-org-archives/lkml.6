Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A869C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC0EE22561
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgYI0vyW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC0EE22561
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbeFUXs4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:48:56 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:57439 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933639AbeFUXso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:48:44 -0400
Received: by mail-it0-f74.google.com with SMTP id 13-v6so295149itl.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=LuiekMZ5mGYd4fayhOXV0MbkpMytrPkCNiDTREQ8swU=;
        b=RgYI0vyWgCzvsvk9eHdGNGh8Va1v+P8+h4hbE3tHmCGy6rMa1+i2/ic8XM4VwRfLeS
         FAAUooxkY6al1S/dPIq5Y7zqc5aHGiIFYFjVL7iix97vtrWCQBaLsK3xHIKhA6bODssx
         tb6siFtCT/SlYSU1t9UE885VncWrNTmxsuYpK/q+H80SKFI5xqXejR87SeqsoLrmkcuV
         nXZqhObhczqebhJN905mb/2c1lVGLanoEHdumNxYo3yzjDduZrHCFne6jtnjo5noUY+U
         P9NnmfNlaX4VFDVrKMZqQj2qR5yVrHtZacyCYOfUwrWkq97lm1ZIYMQ/p8Woftou2f4l
         LEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=LuiekMZ5mGYd4fayhOXV0MbkpMytrPkCNiDTREQ8swU=;
        b=ozDGWMcYzgoUkf21obZoBCTKU5DysKXN8xcinSuUaryZAk7JOdc8EnUOR1u1mO1mMr
         8md6rnvNQn1niwgzsuZvDdXmHCnMKc0XYqzKTJQVehbT+ju0OcQK+5UimGsz4CN48v8Z
         PvEdhwO3h/6Qveolj/sCFWl/8PMhzbXwo6SOhdNCGJPIFxWoh14S5HoOPsEcEQCsnJi9
         hmO0tFoAzj+3MutyShT2JyMDczZ1y2Ui+buLdN7v0myPJLEhT2pAWka1x62MhBVlJn3t
         MT720DnAqnHdIoJHVz11TKwO7yjJIr4sxsV8MIzcuEEBmCXArV7kZrlwSvF60YwTj0uy
         v8pg==
X-Gm-Message-State: APt69E2JkqTFo2kqwOf/kvFQNTl832TN5VY5WSVGsE/o9+lbviJAsd27
        U356grAJco//nyXF8QNrt7cUtJa2QFFL
X-Google-Smtp-Source: ADUXVKLOAQi1Fr2UPyJ/LLqQ2CqpPbdRnjFwatUbQuFim1cynUUc8d7BQTSWqHm76zFtmx+fYYutt3oAWkMw
MIME-Version: 1.0
X-Received: by 2002:a24:b257:: with SMTP id h23-v6mr3507176iti.44.1529624924043;
 Thu, 21 Jun 2018 16:48:44 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:48:27 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-3-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH 2/4] PCI/AER: Define and allocate aer_stats structure for AER
 capable devices
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a structure to hold the AER statistics. There are 2 groups
of statistics: dev_* counters that are to be collected for all AER
capable devices and rootport_* counters that are collected for all
(AER capable) rootports only. Allocate and free this structure when
device is added or released (thus counters survive the lifetime of the
device).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 drivers/pci/probe.c    |  1 +
 include/linux/pci.h    |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9a1af85aca77..0759a7be9ef2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -455,9 +455,11 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
 void pci_aer_init(struct pci_dev *dev);
+void pci_aer_exit(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+static inline void pci_aer_exit(struct pci_dev *d) { }
 #endif
 
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 11482669b93b..6aa5284d5805 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -33,6 +33,9 @@
 #define AER_ERROR_SOURCES_MAX		100
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+#define AER_MAX_TYPEOF_COR_ERRS		16	/* as per PCI_ERR_COR_STATUS */
+#define AER_MAX_TYPEOF_UNCOR_ERRS	26	/* as per PCI_ERR_UNCOR_STATUS*/
+
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
@@ -76,6 +79,42 @@ struct aer_rpc {
 					 */
 };
 
+/* AER stats for the device */
+struct aer_stats {
+
+	/*
+	 * Fields for all AER capable devices. They indicate the errors
+	 * "as seen by this device". Note that this may mean that if an
+	 * end point is causing problems, the AER counters may increment
+	 * at its link partner (e.g. root port) because the errors will be
+	 * "seen" by the link partner and not the the problematic end point
+	 * itself (which may report all counters as 0 as it never saw any
+	 * problems).
+	 */
+	/* Counters for different type of correctable errors */
+	u64 dev_cor_errs[AER_MAX_TYPEOF_COR_ERRS];
+	/* Counters for different type of fatal uncorrectable errors */
+	u64 dev_fatal_errs[AER_MAX_TYPEOF_UNCOR_ERRS];
+	/* Counters for different type of nonfatal uncorrectable errors */
+	u64 dev_nonfatal_errs[AER_MAX_TYPEOF_UNCOR_ERRS];
+	/* Total number of ERR_COR sent by this device */
+	u64 dev_total_cor_errs;
+	/* Total number of ERR_FATAL sent by this device */
+	u64 dev_total_fatal_errs;
+	/* Total number of ERR_NONFATAL sent by this device */
+	u64 dev_total_nonfatal_errs;
+
+	/*
+	 * Fields for Root ports  & root complex event collectors only, these
+	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
+	 * messages received by the root port / event collector, INCLUDING the
+	 * ones that are generated internally (by the rootport itself)
+	 */
+	u64 rootport_total_cor_errs;
+	u64 rootport_total_fatal_errs;
+	u64 rootport_total_nonfatal_errs;
+};
+
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
 					PCI_ERR_UNC_ECRC|		\
 					PCI_ERR_UNC_UNSUP|		\
@@ -405,9 +444,19 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+
+	if (dev->aer_cap)
+		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+
 	pci_cleanup_aer_error_status_regs(dev);
 }
 
+void pci_aer_exit(struct pci_dev *dev)
+{
+	kfree(dev->aer_stats);
+	dev->aer_stats = NULL;
+}
+
 #define AER_AGENT_RECEIVER		0
 #define AER_AGENT_REQUESTER		1
 #define AER_AGENT_COMPLETER		2
@@ -458,7 +507,7 @@ static const char *aer_error_layer[] = {
 	"Transaction Layer"
 };
 
-static const char *aer_correctable_error_string[] = {
+static const char *aer_correctable_error_string[AER_MAX_TYPEOF_COR_ERRS] = {
 	"Receiver Error",		/* Bit Position 0	*/
 	NULL,
 	NULL,
@@ -477,7 +526,7 @@ static const char *aer_correctable_error_string[] = {
 	"Header Log Overflow",		/* Bit Position 15	*/
 };
 
-static const char *aer_uncorrectable_error_string[] = {
+static const char *aer_uncorrectable_error_string[AER_MAX_TYPEOF_UNCOR_ERRS] = {
 	"Undefined",			/* Bit Position 0	*/
 	NULL,
 	NULL,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..48edd0c9e4bc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2064,6 +2064,7 @@ static void pci_configure_device(struct pci_dev *dev)
 
 static void pci_release_capabilities(struct pci_dev *dev)
 {
+	pci_aer_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b4ffea05c999..6bc0aa0fc33f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -299,6 +299,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
+	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
-- 
2.18.0.rc2.346.g013aa6912e-goog

