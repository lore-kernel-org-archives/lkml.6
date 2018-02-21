Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224rGP/XJmoKc7MK2WHklAcVJTLIQWrdW4lEn95VUQbXOfMCoYy/dguDhGXqPIoOF/0e3JkT
ARC-Seal: i=1; a=rsa-sha256; t=1519218673; cv=none;
        d=google.com; s=arc-20160816;
        b=YZERwornPu1xPury95fZKmxilkVjSE9g2hGi6SJfBeKmP4bCbUB28G8nV6iGirfm4C
         RhtEjr8w9LpTYD9YzChzs86zvDZAbZ7Upy/y1ZwCZZIBVd0JKRWaBxjoeXu1rgeBTBcC
         sdgBfJ1YtTY/VrAYEux3T1jEF5L0rUlwglvsPt4hw9NZPj/d7LLhu5NY8uOMdZPHqJC0
         KMrQgauovLFChrUSM0LOnnruivvQN6CUy+sihEXDPIIq1y7tfpBv0n8jMig8OxHRr7Sx
         sjqJRg1GDt3tKSa5gQ2QLZZ/FdsRAe2TRV6hauDRt4Zg7cA3CFd/dBNWeU0Z6DBrQ2h+
         TYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6MW8nKrSIhrb0r8U3a9J89FdhDMFVKDTQu8A7WCp2Ok=;
        b=kOlsWQ8/nD72GynfYQsvbQ0YeV0T5bSbdAY70FGlNQUcgJe97bBN1x/0nz8SXMsovN
         sqZt2I2F3IcBUngx6aU/yQmcs6dV4Zs0mPDOCSw0zeTbb2b3FmkG/5HNtRV4THCmso5q
         LIEYkzYOgGYpk+dKQjprnRXWSeNn2sh/ZRI2lFtv2O+VLg9UDokmDsa3+nRrte/IzcPI
         zkct0HA8f9f0YkaDlIV491XG407oBej7ZrfpatB+nRGT9R+2iiuB5t3iSC7gCyX4nqcw
         kLemRH/jqPgXLSdb+mVYlVa77AUs49HA+J2LFC7Ep0Zy4jY2asmLJUyoOYwfJM708hw5
         B0EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Andreas Noever <andreas.noever@gmail.com>
Subject: [PATCH 4.15 117/163] PCI: pciehp: Assume NoCompl+ for Thunderbolt ports
Date: Wed, 21 Feb 2018 13:49:06 +0100
Message-Id: <20180221124536.606429707@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593016239425186791?=
X-GMAIL-MSGID: =?utf-8?q?1593016239425186791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lukas Wunner <lukas@wunner.de>

commit 493fb50e958c1c6deef7feff0b8c3855def78d75 upstream.

Certain Thunderbolt 1 controllers claim to support Command Completed events
(value of 0b in the No Command Completed Support field of the Slot
Capabilities register) but in reality they neither set the Command
Completed bit in the Slot Status register nor signal a Command Completed
interrupt:

  8086:1513  CV82524  [Light Ridge 4C  2010]
  8086:151a  DSL2310  [Eagle Ridge 2C  2011]
  8086:151b  CVL2510  [Light Peak 2C   2010]
  8086:1547  DSL3510  [Cactus Ridge 4C 2012]
  8086:1548  DSL3310  [Cactus Ridge 2C 2012]
  8086:1549  DSL2210  [Port Ridge 1C   2011]

All known newer chips (Redwood Ridge and onwards) set No Command Completed
Support, indicating that they do not support Command Completed events.

The user-visible impact is that after unplugging such a device, 2 seconds
elapse until pciehp is unbound.  That's because on ->remove,
pcie_write_cmd() is called via pcie_disable_notification() and every call
to pcie_write_cmd() takes 2 seconds (1 second for each invocation of
pcie_wait_cmd()):

  [  337.942727] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x1038 (issued 21176 msec ago)
  [  340.014735] pciehp 0000:0a:00.0:pcie204: Timeout on hotplug command 0x0000 (issued 2072 msec ago)

That by itself has always been unpleasant, but the situation has become
worse with commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
shutdown"):  Now pciehp is unbound on ->shutdown.  Because Thunderbolt
controllers typically have 4 hotplug ports, every reboot and shutdown is
now delayed by 8 seconds, plus another 2 seconds for every attached
Thunderbolt 1 device.

Thunderbolt hotplug slots are not physical slots that one inserts cards
into, but rather logical hotplug slots implemented in silicon.  Devices
appear beyond those logical slots once a PCI tunnel is established on top
of the Thunderbolt Converged I/O switch.  One would expect commands written
to the Slot Control register to be executed immediately by the silicon, so
for simplicity we always assume NoCompl+ for Thunderbolt ports.

Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: stable@vger.kernel.org	# v4.12+
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Yehezkel Bernat <yehezkel.bernat@intel.com>
Cc: Michael Jamet <michael.jamet@intel.com>
Cc: Andreas Noever <andreas.noever@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -848,6 +848,13 @@ struct controller *pcie_init(struct pcie
 	if (pdev->hotplug_user_indicators)
 		slot_cap &= ~(PCI_EXP_SLTCAP_AIP | PCI_EXP_SLTCAP_PIP);
 
+	/*
+	 * We assume no Thunderbolt controllers support Command Complete events,
+	 * but some controllers falsely claim they do.
+	 */
+	if (pdev->is_thunderbolt)
+		slot_cap |= PCI_EXP_SLTCAP_NCCS;
+
 	ctrl->slot_cap = slot_cap;
 	mutex_init(&ctrl->ctrl_lock);
 	init_waitqueue_head(&ctrl->queue);
