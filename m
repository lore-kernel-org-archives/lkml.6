Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227GF8UiLtYK8+0WpPdRgCNZj0wSob9dPaDOibz1DffiFKR5qjbMVIk+xlpbX1ewKHx4RmmU
ARC-Seal: i=1; a=rsa-sha256; t=1519836615; cv=none;
        d=google.com; s=arc-20160816;
        b=NnjJPMhZ9YkuoOL6RPVpVTvhsi7d8VTLyiNBYLLzyfZkRHmK2zoXJ0Ecnz6liv7gAM
         kT2AD9VAjg/ASPptkPS6RTDmCz8XGdEdUp+v0B4+f02V+WN5UnlAibn5DbauRx74JutV
         dQARhF4zp01YP1P+HGiaL0i7gn1u0p5XaekFj4ZOqsOvWyGspl/CWPjdlstOvgb2wcNc
         etvQPr+4vi6lbPn8uVDKsAyDZjg6yRQSkIgUCvYDxDCnZw5mdvdXDzOfTE+A0yJJYvnq
         dKAys5+VFuNmiGhalBJeIF5RR2fYWIK9hDMId3zS2mNYXZkajZbMBh3NMwiCK8ai9jHT
         05Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=528fOE4iDxgfWODXRtKd4MJFTQc0tGVDPN/XH5xr9ow=;
        b=I9uYNKLdxGlR/LJxH08uLcD0Tea1V2x6rUNqP+r7PXqeTZg9ngCK2YvfEQwR00zGlT
         hH2OjsFYQa/NBJHx2f/X1LUHmzjD71nN/WUnrq4tRkXbtUnV8GdbRlRsVoyKyyPX8AyR
         CN6IdX4KmwWQS76SG1Q0WWslTEe7/ncY8F0+sNoXVdNf9VepNZTRUFrHJB835JvY/Nex
         PWZaRQ1SDS6FjFk1hjXz569y2LnMnhIrZlWWR6ZYmhW57v1/dHgLY6rSRGC/PKOx2wVA
         wTsbMoOM/90krG8DKFwFXaw09Gv8QyZNwtuGNwmVnQuwmrO+0OPHlFt4ZRylCX8m6caJ
         pUcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Mathias Nyman" <mathias.nyman@linux.intel.com>,
 "Daniel Thompson" <daniel.thompson@linaro.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.113588162@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 142/254] usb: xhci: Add XHCI_TRUST_TX_LENGTH for
 Renesas uPD720201
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593664198706929945?=
X-GMAIL-MSGID: =?utf-8?q?1593664198706929945?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Thompson <daniel.thompson@linaro.org>

commit da99706689481717998d1d48edd389f339eea979 upstream.

When plugging in a USB webcam I see the following message:
xhci_hcd 0000:04:00.0: WARN Successful completion on short TX: needs
XHCI_TRUST_TX_LENGTH quirk?
handle_tx_event: 913 callbacks suppressed

All is quiet again with this patch (and I've done a fair but of soak
testing with the camera since).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-pci.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -183,6 +183,9 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
+			pdev->device == 0x0014)
+		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 			pdev->device == 0x0015)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 	if (pdev->vendor == PCI_VENDOR_ID_VIA)
