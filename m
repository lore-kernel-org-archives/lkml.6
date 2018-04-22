Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48pYCzLZ2OkfAhDAkc54u0RAKiq1iq6fWcWQdPcoarabvDat7bQYA+caaD6K88X62Y4KOAa
ARC-Seal: i=1; a=rsa-sha256; t=1524406774; cv=none;
        d=google.com; s=arc-20160816;
        b=lRYeL9SIBTpJ8ICVy6wUvBlJ0gkgBBZxuFCbU6uKxAIHQvvUx7QKW6+3mdbG5Mne2U
         PEyPGfdEYbWJAc1lnFZEHJH4DxXr+CzAsW0SlqPO/W61Q7EjTU62Jo+2OtZbVOZzX1y8
         vZtC6oSNN2/peu85lbT5rNSVpIRmFz3zODFUjWZ6ttCQhN73yWd+uG+WyDQVshR8jYyh
         04GsQAzN4mo4v/7W8xqg0DMgL0NzcHlwKy8HyuklYeienrD/lVtsy6Y+RCeV3uIaR8C8
         mXVoPQM74posqhOmrTCOs9FH9uqZ50j5PkP1JewKxgooENsvmjkc1cvy2sBKCtnZg/om
         /7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P1pav3ZJGCYZ5yhGSMd0DjMe2abob3Pnlffi0Wbi8uo=;
        b=00p9DXTdFhGGsYTmnLLG+/jYQDebX9rNuxM3mHG2jpx/v6L2JEwppCGIroz1huSCFN
         P2+nvbAgaI8VQk5rLtzaQa3YKUOfikxSz0sZfgspbAqPdz8i5qbPZXQq/cNSoifrCKdQ
         VKTh8SeTV4uOPrHdR74Sc+ZYutDcIsBx2Dulp+vdW6qBfc5DN3Z2bL9u+KYkSOVGMmqR
         KA7z1Jj6S0OEI15o7aUx8NpPNF1eeBWcFnkxQskrG0/S2RR+BqUYgPtXFSdBIb0NGaAR
         HLpPRSh9s8i1qm/JPPfkZKbU+R0zVXo/tjlB4fIW0ODFoe+qoFe9mPkV5AGtPS5w7FUZ
         /Vsg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 4.4 73/97] vfio/pci: Virtualize Maximum Read Request Size
Date: Sun, 22 Apr 2018 15:53:51 +0200
Message-Id: <20180422135309.234572729@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455756318310028?=
X-GMAIL-MSGID: =?utf-8?q?1598456357800884041?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -758,6 +758,7 @@ static int vfio_exp_config_write(struct
 {
 	__le16 *ctrl = (__le16 *)(vdev->vconfig + pos -
 				  offset + PCI_EXP_DEVCTL);
+	int readrq = le16_to_cpu(*ctrl) & PCI_EXP_DEVCTL_READRQ;
 
 	count = vfio_default_config_write(vdev, pos, count, perm, offset, val);
 	if (count < 0)
@@ -783,6 +784,27 @@ static int vfio_exp_config_write(struct
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
 
@@ -801,11 +823,12 @@ static int __init init_pci_cap_exp_perm(
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
