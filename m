Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225ZIaFtBo6vCSlnNGSAaoOakHJXMBSPk3OPteMl8Wt6xun2veujzGD/KYdh/lYU1Rf09Jcq
ARC-Seal: i=1; a=rsa-sha256; t=1519411103; cv=none;
        d=google.com; s=arc-20160816;
        b=TGfpOrfioKmtJzr3oFO53GVSkcOlyJE/SiO+ZSvdRSyT5o6dHH5BPR9VIssfv33qVR
         56paai7CwaIN8R3u5TK0MnU+bTPmDtgRUAmFWmB7JfCnB5jWBvII2dEaZu8Umqp7yPpk
         OEQhhsRjS4gpMdckZxXacwToH8FcAlVUVF7guNCw73JvECqkddGRWNPJ6XsuBPdujXw+
         ek0IPpDnskLjpcrWrxr/eP1KMYz9oI6icnkP/YyxMSOZbMStADvDZJxbsSpSVRgHgsU2
         ZRHVvJEi4MRZav0nnBkUEOKVQAMDw4s114GbtKUmdX8vSZwAidHepsjE3Wvi/0E/Oefx
         Lr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FDcO9begceRxMQBetTELvJuBkX3p4lAvH9UQ45TzxlE=;
        b=jY8tkGDwcuatkP/LN2NRKBYjMuLX2VA1cBVyo+vopBYwWhuzPEy4G46Cklfor5V8WB
         kk4xIvy+IcsnH90wQxuZ5eur9qwC8kRBrSo9LvmTE1cS6zBE7q2hZOODvBd/gnw6UTZG
         9rrZIshkwiUpNDpft0WgrvD1F1R1Hkahz4uarChDZi5YQjiIGRNWTqZALE1b44Lmc2BL
         0TO+0ne+IJd9dWfF8JWAIyfZCo01B5eCwdPLsFvBi/wngJmHbeCcOwWlZS27BfcZXp7f
         fUPH4eDhkFoznh7mbUs4GFcTEvb5VoKJH9MlhqEy0BPwws36O1q/krWigLEIim0948Vx
         RNSw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.4 123/193] genirq/msi: Add stubs for get_cached_msi_msg/pci_write_msi_msg
Date: Fri, 23 Feb 2018 19:25:56 +0100
Message-Id: <20180223170345.141549331@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218016816246449?=
X-GMAIL-MSGID: =?utf-8?q?1593218016816246449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 2f44e29cef006a4b0a4ecf7d4c5aac7d0fbb505c upstream.

A bug fix to the MSIx handling in vfio added references to functions
that may not be defined if MSI is disabled in the kernel, resulting in
this link error:

drivers/built-in.o: In function `vfio_msi_set_vector_signal':
:(.text+0x450808): undefined reference to `get_cached_msi_msg'
:(.text+0x45080c): undefined reference to `write_msi_msg'

As suggested by Alex Williamson, add stub implementations for
get_cached_msi_msg() and pci_write_msi_msg().

In case this bugfix gets backported, please note that the #ifdef
has changed over time, originally both functions were implemented
in drivers/pci/msi.c and controlled by CONFIG_PCI_MSI, while nowadays
get_cached_msi_msg() is part of the generic MSI support and can be
used without PCI.

Fixes: b8f02af096b1 ("vfio/pci: Restore MSIx message prior to enabling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>
Link: http://lkml.kernel.org/r/1413190208.4202.34.camel@ul30vt.home
Link: http://lkml.kernel.org/r/20170214215343.3307861-1-arnd@arndb.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/msi.h |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -17,7 +17,13 @@ struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
+#ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
+#else
+static inline void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
+{
+}
+#endif
 
 typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
 				    struct msi_msg *msg);
@@ -105,18 +111,21 @@ struct msi_desc {
 
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc);
 void *msi_desc_to_pci_sysdata(struct msi_desc *desc);
+void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else /* CONFIG_PCI_MSI */
 static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 {
 	return NULL;
 }
+static inline void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg)
+{
+}
 #endif /* CONFIG_PCI_MSI */
 
 struct msi_desc *alloc_msi_entry(struct device *dev);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
-void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
 
 u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
 u32 __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
