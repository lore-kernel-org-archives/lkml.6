Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+KVyluoSeIn46IGJ6tph/dIkuud2reThAZpuRykKWR2RvWntR1UBCFCgYewl9QpHzxdPG4
ARC-Seal: i=1; a=rsa-sha256; t=1523021573; cv=none;
        d=google.com; s=arc-20160816;
        b=bKSmEglvhLmXakhynviFJXsijBwntihq5WRmzaHn79AdHNsAzpM2WKcnmw2jyZoxKb
         /T47sOrlMLfiMfHQGMDzjl/iHj4NysKYQhqvrmGU+qJxrIcfFEcAfdrsjZr6iJIDKBb5
         gMpjmaxfy4fZoYUDlgM9axaAmQj0F3IHMfy00oz/8Lqn+wLG0dY3YVMJZ1qrbIJY9L7M
         vLJ844kKDjHVej6696kp+tOVKOxoHlaP0J1RKOi3yVNIzAJtI7RGA8DBEVBztGJQ4E6e
         FKrDExXYJLtzG2fls5rDvZOEcLWfsROZOsYlX6x0TpNPeJw4eN3s0/MPjd77p51WRpra
         72lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TVEwuBiyTFjW/iduPe+5y+q0h18WMq2VVW2728aPwec=;
        b=ewlNOHlz5M+3YrKIIM4iuioYxhoN08CXAQ9yKjwGHpqLaJ4LoJbpzMyZ6W9U850uBc
         82919gD1zwXvsVci/+L+/ZY9LyWhJGPNRqBVFWi58uH72L/4MCK0DTOB/AxxNXr6HVHp
         CHzP88UTZrcupy6kTB3qTlrsYDr855tL/QGZNe6Gl/m7JrFHTfIMfAYIhXlSpf+OCqU1
         EWpS6vSX6QarUhkUciCQsvk4X97fWAIEgzh7m6R0Dverfgj6maw5aDqljAG7IKwvzkca
         HWgw5WINgrGOp2tr/AKvU0TXHs0M4ko1IbZy+0e22s/Sb/nYeumENjkHYpHN0Du3LW+s
         vidw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 013/102] PCI: Make PCI_ROM_ADDRESS_MASK a 32-bit constant
Date: Fri,  6 Apr 2018 15:22:54 +0200
Message-Id: <20180406084333.495241476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003742924969692?=
X-GMAIL-MSGID: =?utf-8?q?1597003869064916597?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Kaehlcke <mka@chromium.org>

commit 76dc52684d0f72971d9f6cc7d5ae198061b715bd upstream.

A 64-bit value is not needed since a PCI ROM address consists in 32 bits.
This fixes a clang warning about "implicit conversion from 'unsigned long'
to 'u32'".

Also remove now unnecessary casts to u32 from __pci_read_base() and
pci_std_update_resource().

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c           |    2 +-
 drivers/pci/setup-res.c       |    2 +-
 include/uapi/linux/pci_regs.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -231,7 +231,7 @@ int __pci_read_base(struct pci_dev *dev,
 			res->flags |= IORESOURCE_ROM_ENABLE;
 		l64 = l & PCI_ROM_ADDRESS_MASK;
 		sz64 = sz & PCI_ROM_ADDRESS_MASK;
-		mask64 = (u32)PCI_ROM_ADDRESS_MASK;
+		mask64 = PCI_ROM_ADDRESS_MASK;
 	}
 
 	if (res->flags & IORESOURCE_MEM_64) {
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -63,7 +63,7 @@ static void pci_std_update_resource(stru
 		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
 		new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		mask = (u32)PCI_ROM_ADDRESS_MASK;
+		mask = PCI_ROM_ADDRESS_MASK;
 	} else {
 		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
 		new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -106,7 +106,7 @@
 #define PCI_SUBSYSTEM_ID	0x2e
 #define PCI_ROM_ADDRESS		0x30	/* Bits 31..11 are address, 10..1 reserved */
 #define  PCI_ROM_ADDRESS_ENABLE	0x01
-#define PCI_ROM_ADDRESS_MASK	(~0x7ffUL)
+#define PCI_ROM_ADDRESS_MASK	(~0x7ffU)
 
 #define PCI_CAPABILITY_LIST	0x34	/* Offset of first capability list entry */
 
