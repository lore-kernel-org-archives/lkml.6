Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx482nBDHWO1cffD2uVkLinjJ/7OPFKqjAykfuzI/mxwRUr2XZtqkdqSiVedRx8WCJ8HzRXlK
ARC-Seal: i=1; a=rsa-sha256; t=1524406200; cv=none;
        d=google.com; s=arc-20160816;
        b=0meTFeohB5rhkD4WPfX8YTAW4X3kzRYOoOfBzVoyR8hE9lRRP2oxzugyYzdA7+nSjZ
         MxmJrxfTleysp4DupWuBnhmLfIIipZ1lt50U4YATa/ke86Do0OIFQmobVIK9gcTIYDdk
         eGzJLktniJzlj2U0ac7PdUn+Npun8uwzhwCyJDTDcGdYa08ImgDOEcrowq3+Fo3PVWo+
         c72qwqJghqI9wLA4rgaDlsPVxmOV0UQmPXjRGUGQoHzIXaWjCAR2WcywDhlli4pLPh3C
         76U1SNDFcmbhBbEfL6qR2GmfQFNnMy3o/KKbVFxISQLwzTt2WdrXfOTtTtXdG0MsZ/0M
         5p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rPRqVyHA05/LBpNYLg7QrfRJwp7IkmemkRmiH/5im5w=;
        b=MpHJSUm9C1fN1kC/YpuuPT/JcZkpakJSdZlZRVuiDyhGjFXkNHBRO2BsfHPOtUlC1D
         W4DgKP/tn19rhZh8Qb0j51oFK9ZcrIg5Q1tzeR2bevAPW8x6LJznPZ3rarGeQtyK2O0s
         FozBcvxgI/E+9ixXxlAJGcGS3AdtJ04surTZOMwMbMrAmeccDqNMDIjji6hPCNq+MR+m
         q4/CgNWetfXP4Am+PFFgudb80jUegGlmwGKmCmpLE1nk5T5MdUGKen1LlIB++8zE1rsN
         nyeOt/um774f7RRiqM+4PKR3FGSj7pHw15+nk076MMtxwc3R5H5qOtBcdZa6ncKe1U/K
         L/wg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.14 114/164] vfio/pci: Virtualize Maximum Read Request Size
Date: Sun, 22 Apr 2018 15:53:01 +0200
Message-Id: <20180422135140.081190793@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455756318310028?=
X-GMAIL-MSGID: =?utf-8?q?1598455756318310028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Williamson <alex.williamson@redhat.com>

commit cf0d53ba4947aad6e471491d5b20a567cbe92e56 upstream.

MRRS defines the maximum read request size a device is allowed to
make.  Drivers will often increase this to allow more data transfer
with a single request.  Completions to this request are bound by the
MPS setting for the bus.  Aside from device quirks (none known), it
doesn't seem to make sense to set an MRRS value less than MPS, yet
this is a likely scenario given that user drivers do not have a
system-wide view of the PCI topology.  Virtualize MRRS such that the
user can set MRRS >= MPS, but use MPS as the floor value that we'll
write to hardware.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vfio/pci/vfio_pci_config.c |   29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -808,6 +808,7 @@ static int vfio_exp_config_write(struct
 {
 	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
 				  offset + PCI_EXP_DEVCTL);
+	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
 
 	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
 	if (count < 0)
@@ -833,6 +834,27 @@ static int vfio_exp_config_write(struct
 			pci_try_reset_function(vdev->pdev);
 	}
 
+	/*
+	 * MPS is virtualized to the user, writes do not change the physical
+	 * register since determining a proper MPS value requires a system wide
+	 * device view.  The MRRS is largely independent of MPS, but since the
+	 * user does not have that system-wide view, they might set a safe, but
+	 * inefficiently low value.  Here we allow writes through to hardware,
+	 * but we set the floor to the physical device MPS setting, so that
+	 * we can at least use full TLPs, as defined by the MPS value.
+	 *
+	 * NB, if any devices actually depend on an artificially low MRRS
+	 * setting, this will need to be revisited, perhaps with a quirk
+	 * though pcie_set_readrq().
+	 */
+	if (readrq != (le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ)) {
+		readrq = 128 <<
+			((le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ) >> 12);
+		readrq = max(readrq, pcie_get_mps(vdev->pdev));
+
+		pcie_set_readrq(vdev->pdev, readrq);
+	}
+
 	return count;
 }
 
@@ -851,11 +873,12 @@ static int __init init_pci_cap_exp_perm(
 	 * Allow writes to device control fields, except devctl_phantom,
 	 * which could confuse IOMMU, MPS, which can break communication
 	 * with other physical devices, and the ARI bit in devctl2, which
-	 * is set at probe time.  FLR gets virtualized via our writefn.
+	 * is set at probe time.  FLR and MRRS get virtualized via our
+	 * writefn.
 	 */
 	p_setw(perm, PCI_EXP_DEVCTL,
-	       PCI_EXP_DEVCTL_BCR_FLR | PCI_EXP_DEVCTL_PAYLOAD,
-	       ~PCI_EXP_DEVCTL_PHANTOM);
+	       PCI_EXP_DEVCTL_BCR_FLR | PCI_EXP_DEVCTL_PAYLOAD |
+	       PCI_EXP_DEVCTL_READRQ, ~PCI_EXP_DEVCTL_PHANTOM);
 	p_setw(perm, PCI_EXP_DEVCTL2, NO_VIRT, ~PCI_EXP_DEVCTL2_ARI);
 	return 0;
 }
