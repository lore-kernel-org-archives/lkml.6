Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuEaNKQSZpJxPRBx8N1MrWKHLnUKa6U/oupM0EmavdNAoAuu3GCN+iAUh4eXlK4iPrSAa4w
ARC-Seal: i=1; a=rsa-sha256; t=1521483515; cv=none;
        d=google.com; s=arc-20160816;
        b=svHTA8RcMuYV65BCE6TM4EJTkEYu4eGunSRaF4BmreTjZpVmzMW+xdjwP4ZI+rI+pM
         euZIWY+teelSQjmL6VcbMaoxx1gb+E1sEvcKegENNlyxpFKIjqMNF3qs/liyOTTOYMgc
         ZO7AxVtpLvAHI70iPxzc3+oTsrJjZHPXJhPzWk3HfjGCQEEZAYZozUfIkS92U6ro/Afq
         p1RR5VcAKr2dYBnz38px8MHaFTQFLFA11rodQyv4J/J4J8SNK8/+ISc0FvtnejH/hB5/
         UmUbRW7cYkq6UYl1SS59F9mRWNy4HEM5jAJez0EvDmD/XtDsNX2+iYsNcNydTWHwgDUE
         RTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1Wl4Djimu/dLk4GQhVqfhdWyhGMwPRoJ5Gb4WxzL134=;
        b=XQaVsDelgll13nQYcqI3tVdyV2HxWpGW4nkILCJAZqDHQYXAzea7kMydErm4xzIiK6
         s6w58BNSE8Ia88w7nFPTdOUfL7taRZvgZo2lrDz9QV+pL6U3x70XwxjYftYTwDeSH9je
         eIdmTyB4S3Po4b4hrWHiCLWXrznpus7gWLV5FNExVonxiKNE4xyLIR8L29k5+mPoKh4P
         YROoT5KD0dreOQdRi6R6k/07WNKqsE2ZhePxoKtyYppoc3Sv60bNrHDsHtxgQmv/YzzD
         kw5ZHdrQ2ssrQn1YlMxzHpiihzlcTQizLrQL4D/yk8e8J67CT9j35/NfkDq7vbyRYSR4
         Jf2g==
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
Subject: [PATCH 4.9 018/241] PCI/MSI: Stop disabling MSI/MSI-X in pci_device_shutdown()
Date: Mon, 19 Mar 2018 19:04:43 +0100
Message-Id: <20180319180751.920812867@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390574168988527?=
X-GMAIL-MSGID: =?utf-8?q?1595391099191949383?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -463,8 +463,6 @@ static void pci_device_shutdown(struct d
 
 	if (drv && drv->shutdown)
 		drv->shutdown(pci_dev);
-	pci_msi_shutdown(pci_dev);
-	pci_msix_shutdown(pci_dev);
 
 	/*
 	 * If this is a kexec reboot, turn off Bus Master bit on the
