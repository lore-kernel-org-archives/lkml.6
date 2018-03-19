Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt13/cFirBNlb5pedKut9+oFkumsa4m35Hz8VwcOaIwvs9fiUDPWdm1s8sxLvdFdujrm14f
ARC-Seal: i=1; a=rsa-sha256; t=1521483015; cv=none;
        d=google.com; s=arc-20160816;
        b=X7N3jgZg+xSKDr1rcsucV4NjmBWGjQqKX6UISJg8ECM7hIia7hYspZuCgXwZw0cyJh
         NoBpgoUrSw5qvl+ZZolHpR3lMK5YIzcbslCqYoBFsFl/qHJri10rKI0VnFgEY22OYwWd
         unpOTSxz3AL6s3ms3hbDEsiFkDwNjwGfcpK3dPhJkZiN2t09zw4FJmpjtfAwMD7gIg6y
         cunsty4KbhhJ9/Av/h6MnTlebtIGvktXvqd7mbT/iqe2+TJntIY0/w0XnKhpnc8KqjId
         GVvcz4QoIiwbPO4DjTR3GOxxp86s4OsJtJsfs24U2PnQIOufV7yzKHAsXmKxBcx1jIIr
         jy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xzwOvCdO0jIF+YlbNilo/cXBhy8E2zWZERm/NRJ8zl0=;
        b=SHeIgvYIMTaF+Sd/rKVTb81AXh8wPvWFtyz3wvGxDUKW54j2KgDtkRodIE7UGoDGCG
         m5NYKLOLaz+oXy0J5JcSpJU6i38rk5W0Fbvjx8atolJ38zqUZfBYAAaIkijl6PhXun50
         sKd1fjUQ8hn2jRG9QtC8i2n+I9hJTpjh6cWTVAQlBnmJBXio4gGn1pT3AefjhDUTacHf
         AobtSdHsoidOvZmGHMbqQQZ6kR/ypYHsP3r3g4ZVse1pNuoBlWCicDUFeiqT3PYM0/7V
         I+TCpbAoS8FAIpzc4F9yZXnWru4e2jmN1W/cyqvF7D1gAfkU8hhx2U6YxHBPZFnjrLAq
         s8hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Prarit Bhargava <prarit@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	David Arcari <darcari@redhat.com>,
	Myron Stowe <mstowe@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Keith Busch <keith.busch@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 04/68] PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()
Date: Mon, 19 Mar 2018 19:05:42 +0100
Message-Id: <20180319171828.506078873@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390574168988527?=
X-GMAIL-MSGID: =?utf-8?q?1595390574168988527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prarit Bhargava <prarit@redhat.com>


[ Upstream commit fda78d7a0ead144f4b2cdb582dcba47911f4952c ]

The pci_bus_type .shutdown method, pci_device_shutdown(), is called from
device_shutdown() in the kernel restart and shutdown paths.

Previously, pci_device_shutdown() called pci_msi_shutdown() and
pci_msix_shutdown().  This disables MSI and MSI-X, which causes the device
to fall back to raising interrupts via INTx.  But the driver is still bound
to the device, it doesn't know about this change, and it likely doesn't
have an INTx handler, so these INTx interrupts cause "nobody cared"
warnings like this:

  irq 16: nobody cared (try booting with the "irqpoll" option)
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.8.2-1.el7_UNSUPPORTED.x86_64 #1
  Hardware name: Hewlett-Packard HP Z820 Workstation/158B, BIOS J63 v03.90 06/
  ...

The MSI disabling code was added by d52877c7b1af ("pci/irq: let
pci_device_shutdown to call pci_msi_shutdown v2") because a driver left MSI
enabled and kdump failed because the kexeced kernel wasn't prepared to
receive the MSI interrupts.

Subsequent commits 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even
if kernel doesn't support MSI") and  e80e7edc55ba ("PCI/MSI: Initialize MSI
capability for all architectures") changed the kexeced kernel to disable
all MSIs itself so it no longer depends on the crashed kernel to clean up
after itself.

Stop disabling MSI/MSI-X in pci_device_shutdown().  This resolves the
"nobody cared" unhandled IRQ issue above.  It also allows PCI serial
devices, which may rely on the MSI interrupts, to continue outputting
messages during reboot/shutdown.

[bhelgaas: changelog, drop pci_msi_shutdown() and pci_msix_shutdown() calls
altogether]
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=187351
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Alex Williamson <alex.williamson@redhat.com>
CC: David Arcari <darcari@redhat.com>
CC: Myron Stowe <mstowe@redhat.com>
CC: Lukas Wunner <lukas@wunner.de>
CC: Keith Busch <keith.busch@intel.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/pci-driver.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -450,8 +450,6 @@ static void pci_device_shutdown(struct d
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
 
 #ifdef CONFIG_KEXEC
 	/*
