Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtOk/p9HkLgwbAym1KSWojo/Az/4cKUDCFmBK0jwvovIn26dTwt49zEFcA6ugBTrSkIzs3l
ARC-Seal: i=1; a=rsa-sha256; t=1520452082; cv=none;
        d=google.com; s=arc-20160816;
        b=WfnI4m5kDfCeRDELd9PKwYmY4EA9L1/Kc583GJTVRzrcPJkFAsRHu6SOcKzhVHssND
         cNmOM4htqst+YtW03Z0vc7J4C5Eaq/xb6OkDYQaC793LM+Mz5kemW/5BD7jNYi0RH91n
         KNiZJdRn5Gq4qyBdWw/uF7KL6zic1/Mxu0f6Y7JcY9FPMhKxWFkIaQUkftymLqtbOoS3
         KgW7viJsV0HtguxRHvXaJ0Ovl5EL7OW6r0SblbJyuRCAaeiw3QMdiOowDjvsHKchXiKz
         wFF7Nca6UXMPjAdb0QweyYITHWc+i7zIdsgkq7NmlY2VY2n7KkdKmbLpx08YMtohGf5Z
         IYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/hTcqy2zkie+gZP3I1ZZIjvsiXT1i4AIg59CxD1tOSE=;
        b=dNRJvhhILy4C/qqzGIVCFtQ8FILwLgMXZ6b0GNYeFBpLN/Fna8D9f7xexonIg9qgBn
         fDJO8bZoeNiiNYkBw8mmYk1uzOQzGganxueKdYOIEZxf8WHVGSoM/SwhcRrXL6wi90FT
         4dZbV7OV+vR3eJiq1qgqro7E0hvtTPqvYbPNhV6W4yyn1hc4VszC1yrSzBewfTsk1BNX
         mYwdsGpCW0NJ0YkBRVcbdA/1QVkXSn9W9bMO72EJOSuFihkOxI2ScarK5AeuNU62Kjhb
         D3RgBiARUaeeew5rtNJ6EPnolKAnRgzVyJcva3bWfWHcHkQ2Dtpdpg6LARftTfkpkT6w
         XcBQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 103/110] PCI/ASPM: Deal with missing root ports in link state handling
Date: Wed,  7 Mar 2018 11:39:26 -0800
Message-Id: <20180307191053.128762401@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309562962341196?=
X-GMAIL-MSGID: =?utf-8?q?1594309562962341196?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit ee8bdfb6568d86bb93f55f8d99c4c643e77304ee upstream.

Even though it is unconventional, some PCIe host implementations omit the
root ports entirely, and simply consist of a host bridge (which is not
modeled as a device in the PCI hierarchy) and a link.

When the downstream device is an endpoint, our current code does not seem
to mind this unusual configuration. However, when PCIe switches are
involved, the ASPM code assumes that any downstream switch port has a
parent, and blindly dereferences the bus->parent->self field of the pci_dev
struct to chain the downstream link state to the link state of the root
port. Given that the root port is missing, the link is not modeled at all,
and nor is the link state, and attempting to access it results in a NULL
pointer dereference and a crash.

Avoid this by allowing the link state chain to terminate at the downstream
port if no root port exists.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -803,10 +803,14 @@ static struct pcie_link_state *alloc_pci
 
 	/*
 	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
-	 * hierarchies.
+	 * hierarchies.  Note that some PCIe host implementations omit
+	 * the root ports entirely, in which case a downstream port on
+	 * a switch may become the root of the link state chain for all
+	 * its subordinate endpoints.
 	 */
 	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
-	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE) {
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_PCIE_BRIDGE ||
+	    !pdev->bus->parent->self) {
 		link->root = link;
 	} else {
 		struct pcie_link_state *parent;
