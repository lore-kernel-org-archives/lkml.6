Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqfwkkc9rnIf9m0iimZHvq1m3F+Z1gWm9lvIlrIzmgN25pe+Xs3cYhuPG875CAU4UD0ROkF
ARC-Seal: i=1; a=rsa-sha256; t=1525116511; cv=none;
        d=google.com; s=arc-20160816;
        b=e58akmRQm46cOWplvxr5lKRpCSlI+oB0lcKp7kX7lBUf1NI5F6RyY7rbe5YeRG/FEG
         3V18jb+786agqUCfr3z8xJclg/g2tkxaX5tKResk7bJklSdTBBr1m/lQoITGI402ZxkY
         0nbIgGohE25fgp7kftfQefutfY5KusfIGMGshZPbM78geHYj/o+tvT2isGkAGOcRi9D6
         sStwBq5LUKbIhXFcmxTgDz/VqZJaVwA2kiet3Pn8oZY1DFYXLWnyUQ5Ve7dKG4T0SNel
         D7nIoeKygvTrLHs4tzjnZ588xsqgZnc58oHr0B2prYV/Uv+3vzsMBzyTcZTYkwGgdwb/
         lJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=zenE7vJ06nRwXDM1FnObKoL/46KOSb4RZnY6Pucqb1w=;
        b=WadnYuAaqqntAK2qZCAGfCivj6OaQO28kFsxjnaEQSMDrMuyaoIUBl8crPjyqgSfpg
         QWi2OPBK7nIiBln0y4GG4DufuYLsMA3ThzTaRfVhRUVdykdYuKGIDwycwkP9b+go9Z33
         YDb1pz936uN0UoKTTFsuH/Y9U3p9bVS4KNP2BQGr4z35dFy2w1KK+Z1ZrtdR9I/RNGs0
         xYDefwLZEEZgGhz+Jd9bC2AKRCzgnfPdrc2w+DyFMHAkLb3vUdglaElwTLGZzdytrYKK
         uKHrvDBOPnEI6oURmSjRlcuBqEMxfS/nIho2bLf6vJSt2Q+VzBrvMXWbkk9NvaNp22/V
         S+iQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E88A22DCB
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
Subject: [PATCH 4.16 069/113] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
Date: Mon, 30 Apr 2018 12:24:40 -0700
Message-Id: <20180430184018.143435413@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200461394286923?=
X-GMAIL-MSGID: =?utf-8?q?1599200570558331616?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -437,7 +437,7 @@ static int advk_pcie_rd_conf(struct pci_
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -491,7 +491,7 @@ static int advk_pcie_wr_conf(struct pci_
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
