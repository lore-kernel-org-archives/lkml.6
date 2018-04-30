Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrkYaHK637wrrP1YCKdvKjqsAXR0wuNekLE8SsJgfjoLvyW0LOGAHvselKb5BhzSCxhYy1T
ARC-Seal: i=1; a=rsa-sha256; t=1525116448; cv=none;
        d=google.com; s=arc-20160816;
        b=zm4yUlU9UaoGERupUt6rqxqjRuDiFya20HFgByD1t1irR1jUX8vg8WeV5cJIm3Q/qS
         6w70h1PhKngcEl51NqSFLKz2BL/GlsT+KmhQylnyrvE8tWcK8/5d59eoQTZrtM/faJAx
         nrbBl75955tJamf6VV1zK2DC8hVH3601hqygEYXZkdkLjReJu2Jqj0FnltJ/lauNF8Fs
         7GMaOeE/EafXzZm03WIHZklhn2olUzZXxvRbIFzg1DQyJcAm1tSLaPRb3NEspZ3ihOGF
         CwJzEoOvOAOonmCrIDRqeexozX2+YZAA1EyuE3XWNDykN16KLjgW4CgXv/U1MmPf5lG/
         aHqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=BKneYm+Yj88iPQU7gzv9favF9xHQ115WNkNHkGe87ns=;
        b=yx5YXBBlIYvxOpYiYVcz8b2yFrfbdzVrPJjp++JOZU4kVJ5WcIgNLyYe3MnEbQBFZb
         yoqVr302vQit7klyAG5W7DRcByCWk2IlS5RymcsMQWnhfeEm9f9NWe021Nkchovw8slK
         qyJv27IZs/uoSKP0iPPnz74cXVpCuCc0FmTJOm1vt8CFZacqaSLE7hymPBmNE0jTBK/B
         CvRskv1f/0zOWjPqdKQqqsF4pcZe8typKGAB9Z5rmVMAoLn1ek6r1SsqvgKA47u6NXLi
         f3Yyn77Sdvf+BdCP49PpeDBowNUCVPpWbsU7I2vzkaPZkhY7k3iDYNt0EPuPpRmuFEjP
         vGkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30522DCB
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
Subject: [PATCH 4.14 60/91] PCI: aardvark: Fix logic in advk_pcie_{rd,wr}_conf()
Date: Mon, 30 Apr 2018 12:24:42 -0700
Message-Id: <20180430184007.306152047@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200461394286923?=
X-GMAIL-MSGID: =?utf-8?q?1599200504752038090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -440,7 +440,7 @@ static int advk_pcie_rd_conf(struct pci_
 	u32 reg;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0) {
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0) {
 		*val = 0xffffffff;
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
@@ -494,7 +494,7 @@ static int advk_pcie_wr_conf(struct pci_
 	int offset;
 	int ret;
 
-	if (PCI_SLOT(devfn) != 0)
+	if ((bus->number == pcie->root_bus_nr) && PCI_SLOT(devfn) != 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	if (where % size)
