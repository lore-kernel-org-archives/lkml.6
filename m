Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49vl1u/4ZXfGiDnQE6ecJw9DNKikiHdijDqJbVvmr1a6dUQSDbxrzvBX7oLLwWF0xx3nTHt
ARC-Seal: i=1; a=rsa-sha256; t=1524406719; cv=none;
        d=google.com; s=arc-20160816;
        b=fDLe7wBKma5fHF6P+s5ME9SBAW7+xCzDuqhgzK7u9lKGjR1I4cH+HPPqBLvZssh/xS
         oYZww/dciAwxyNoPPVADu3xs3p5XABL7kO+AI5nuMRZd3eFpBKqN/cwsFx2qLpH55zm+
         +fgZp02KzCUCadRl0XTFzHzN4WaqZqnGr4u65plfaKavrCwhXkREnoJ4MTaB1fRrjHyy
         yXTzDu2GiDMVenzJ2BMnzuRCPl9yfGZlhygyYVIdfHUHv2TuH79gxa7cNerXepnq476e
         4gOMQiSl/IBBZXDfFmMwtx/vE2IVlc/1MeGPgWG2N10A/hmVbbicQnaOTHlVhUhUn1gu
         nP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kXn0BcyF7+2iqRHUHM20Br5cf4i/vZurYTNh/tNGPvk=;
        b=mO9HqqenU+3/9lOOBVKg1e5ZhajiS5mL6CDA/6n26hphzqk9O2S9PImV955sBc5b0+
         U4wHRhYdodhfk8v4iEpxtaTXvzaizQ4NbTpbfepi3iw+59jlG8l3HPlO4shwrKr3sq++
         yhQ0RPrBPRVlf7j4zAoNiKVqJW//9wwrGerrqBLG1S5iFruLudbe6Qw/aZSrVuydyS2y
         dHMqpWS32bQpbQ+StZm7OSvoDqRPfeq2UQfYdrQJJQHoL3iuXOr79R0q1RUzEaqDWxrx
         Dc/LYmsHM0Vc/Dou79aVs4taoss/piPiiDiO2q+Z31cBxJNhJByI3AJAnXt/Iw/BGini
         NPdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Greg Rose <grose@lightfleet.com>
Subject: [PATCH 4.4 71/97] vfio-pci: Virtualize PCIe & AF FLR
Date: Sun, 22 Apr 2018 15:53:49 +0200
Message-Id: <20180422135309.141199435@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456300137171934?=
X-GMAIL-MSGID: =?utf-8?q?1598456300137171934?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

commit ddf9dc0eb5314d6dac8b19b1cc37c739c6896e7e upstream.

We use a BAR restore trick to try to detect when a user has performed
a device reset, possibly through FLR or other backdoors, to put things
back into a working state.  This is important for backdoor resets, but
we can actually just virtualize the "front door" resets provided via
PCIe and AF FLR.  Set these bits as virtualized + writable, allowing
the default write to set them in vconfig, then we can simply check the
bit, perform an FLR of our own, and clear the bit.  We don't actually
have the granularity in PCI to specify the type of reset we want to
do, but generally devices don't implement both PCIe and AF FLR and
we'll favor these over other types of reset, so we should generally
lineup.  We do test whether the device provides the requested FLR type
to stay consistent with hardware capabilities though.

This seems to fix several instance of devices getting into bad states
with userspace drivers, like dpdk, running inside a VM.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Greg Rose <grose@lightfleet.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/pci/vfio_pci_config.c |   82 ++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 5 deletions(-)

--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -752,6 +752,40 @@ static int __init init_pci_cap_pcix_perm
 	return 0;
 }
 
+static int vfio_exp_config_write(struct vfio_pci_device *vdev, int pos,
+				 int count, struct perm_bits *perm,
+				 int offset, __le32 val)
+{
+	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
+				  offset + PCI_EXP_DEVCTL);
+
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (count < 0)
+		return count;
+
+	/*
+	 * The FLR bit is virtualized, if set and the device supports PCIe
+	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
+	 * requires it to be always read as zero.  NB, reset_function might
+	 * not use a PCIe FLR, we don't have that level of granularity.
+	 */
+	if (*ctrl & cpu_to_le16(PCI_EXP_DEVCTL_BCR_FLR)) {
+		u32 cap;
+		int ret;
+
+		*ctrl &= ~cpu_to_le16(PCI_EXP_DEVCTL_BCR_FLR);
+
+		ret = pci_user_read_config_dword(vdev->pdev,
+						 pos - offset + PCI_EXP_DEVCAP,
+						 &cap);
+
+		if (!ret && (cap & PCI_EXP_DEVCAP_FLR))
+			pci_try_reset_function(vdev->pdev);
+	}
+
+	return count;
+}
+
 /* Permissions for PCI Express capability */
 static int __init init_pci_cap_exp_perm(struct perm_bits *perm)
 {
@@ -759,26 +793,64 @@ static int __init init_pci_cap_exp_perm(
 	if (alloc_perm_bits(perm, PCI_CAP_EXP_ENDPOINT_SIZEOF_V2))
 		return -ENOMEM;
 
+	perm->writefn = vfio_exp_config_write;
+
 	p_setb(perm, PCI_CAP_LIST_NEXT, (u8)ALL_VIRT, NO_WRITE);
 
 	/*
-	 * Allow writes to device control fields (includes FLR!)
-	 * but not to devctl_phantom which could confuse IOMMU
-	 * or to the ARI bit in devctl2 which is set at probe time
+	 * Allow writes to device control fields, except devctl_phantom,
+	 * which could confuse IOMMU, and the ARI bit in devctl2, which
+	 * is set at probe time.  FLR gets virtualized via our writefn.
 	 */
-	p_setw(perm, PCI_EXP_DEVCTL, NO_VIRT, ~PCI_EXP_DEVCTL_PHANTOM);
+	p_setw(perm, PCI_EXP_DEVCTL,
+	       PCI_EXP_DEVCTL_BCR_FLR, ~PCI_EXP_DEVCTL_PHANTOM);
 	p_setw(perm, PCI_EXP_DEVCTL2, NO_VIRT, ~PCI_EXP_DEVCTL2_ARI);
 	return 0;
 }
 
+static int vfio_af_config_write(struct vfio_pci_device *vdev, int pos,
+				int count, struct perm_bits *perm,
+				int offset, __le32 val)
+{
+	u8 *ctrl = vdev->vconfig + pos - offset + PCI_AF_CTRL;
+
+	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
+	if (count < 0)
+		return count;
+
+	/*
+	 * The FLR bit is virtualized, if set and the device supports AF
+	 * FLR, issue a reset_function.  Regardless, clear the bit, the spec
+	 * requires it to be always read as zero.  NB, reset_function might
+	 * not use an AF FLR, we don't have that level of granularity.
+	 */
+	if (*ctrl & PCI_AF_CTRL_FLR) {
+		u8 cap;
+		int ret;
+
+		*ctrl &= ~PCI_AF_CTRL_FLR;
+
+		ret = pci_user_read_config_byte(vdev->pdev,
+						pos - offset + PCI_AF_CAP,
+						&cap);
+
+		if (!ret && (cap & PCI_AF_CAP_FLR) && (cap & PCI_AF_CAP_TP))
+			pci_try_reset_function(vdev->pdev);
+	}
+
+	return count;
+}
+
 /* Permissions for Advanced Function capability */
 static int __init init_pci_cap_af_perm(struct perm_bits *perm)
 {
 	if (alloc_perm_bits(perm, pci_cap_length[PCI_CAP_ID_AF]))
 		return -ENOMEM;
 
+	perm->writefn = vfio_af_config_write;
+
 	p_setb(perm, PCI_CAP_LIST_NEXT, (u8)ALL_VIRT, NO_WRITE);
-	p_setb(perm, PCI_AF_CTRL, NO_VIRT, PCI_AF_CTRL_FLR);
+	p_setb(perm, PCI_AF_CTRL, PCI_AF_CTRL_FLR, PCI_AF_CTRL_FLR);
 	return 0;
 }
 
