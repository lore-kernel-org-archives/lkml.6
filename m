Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqGZnoDkKFR1hjbS1XaxQUbWv5XPpDm/V4lECIuughG10h8xvOQN5AhQ4PVXUHYN/A6B+vQ
ARC-Seal: i=1; a=rsa-sha256; t=1525116407; cv=none;
        d=google.com; s=arc-20160816;
        b=VvamAZw5pW1ILCxGg/RdpWcaFfpJ6WEUg7AnF/uD3wbc6QAhwYF8bC3M+YnmOb6Yc5
         bM+emn26kqhym8LY/++lC4BqDC81ilzPlX3janUMpGhRX/wdgXJuPW8+ysI9i+zEg8rN
         GmFCvWkCBOkIX26CU4w4Jg5Vu2A2mLpXkiTfuTFqHmFR+WsI/EST8GwMtmfgpUvwKuye
         L09jniyuQZ7mGCRjaGLhLQQ81eUmBfxBZA9UVvUfZdfS1+w4FftAES7W1AVdtFiW5CEr
         bSY1ewtmtQcI0a/rOenSx/nRRcJ6aNbLkEjVn4cEZIPeOij2c2Ij8AIZnA9y3i8B3zeF
         efdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Zs4vI/tEVv9WbzZDkMUBmqON3HW2yGDZyDkb92o+ewI=;
        b=TKE83ZYTXAx9nhQf2GdFz72PhDSlywrpRZM3znbqbNbzDL209fzlSo83g4nVD7wr2V
         6b4uPDBpT3JRuv+3Ty84+erYKhz+glC1gR7ens6udPUj+loPbo7l3zA9GGCUHpxIeDMq
         VsjFXKeSi+T7VnytedysiKhcOU/qqWQThIrr+Zx8w4o6eHs7oj1P0Lnj8/mO7oQL93NH
         FFW6xlC4YkUG2QdXK1NUb7cdSblm+boPeS5UAfX1J1bCMej40ZEg4oa2xHmJkMunZ7cc
         eIEoFgMmSovdwr4maRDXS4mlMfItDy+14CmKjoZ+Oh4O5Zd7ocaBIVRf2n6yJZ/pUj49
         uvuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69DE22DAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Victor Gu <xigu@marvell.com>,
	Wilson Ding <dingwei@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.9 41/61] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
Date: Mon, 30 Apr 2018 12:24:44 -0700
Message-Id: <20180430183954.816681682@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200461394286923?=
X-GMAIL-MSGID: =?utf-8?q?1599200461394286923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Gu <xigu@marvell.com>

commit 660661afcd40ed7f515ef3369721ed58e80c0fc5 upstream.

The PCI configuration space read/write functions were special casing
the situation where PCI_SLOT(devfn) != 0, and returned
PCIBIOS_DEVICE_NOT_FOUND in this case.

However, while this is what is intended for the root bus, it is not
intended for the child busses, as it prevents discovering devices with
PCI_SLOT(x) != 0. Therefore, we return PCIBIOS_DEVICE_NOT_FOUND only
if we're on the root bus.

Fixes: 8c39d710363c1 ("PCI: aardvark: Add Aardvark PCI host controller driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Victor Gu <xigu@marvell.com>
Reviewed-by: Wilson Ding <dingwei@marvell.com>
Reviewed-by: Nadav Haklai <nadavh@marvell.com>
[Thomas: tweak commit log.]
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-aardvark.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -439,7 +439,7 @@ static int advk_pcie_rd_conf(struct pci_
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -493,7 +493,7 @@ static int advk_pcie_wr_conf(struct pci_
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
