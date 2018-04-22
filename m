Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx494TXNGm0hTyh7mD7+KeKmwzNB8+76qywbOg/9Qb6c6lHLoSX2EEwlPHm9I08lC11VRpIZo
ARC-Seal: i=1; a=rsa-sha256; t=1524406295; cv=none;
        d=google.com; s=arc-20160816;
        b=CLgxCeKt6pj62VDYTvysyFb7gxkar7ScA0QOeViZO0e5znvqvWM0IHY/GVFkEhBUqZ
         JLfrKeBMr/PdB+BqYPxgHGsJ6nW4Z3jEr1Cmtf149AQmeQbJiOFiDkk8QXEuAU1B+1R2
         L6M1fVQ0QPMg+ptNnpgiOWdidopg7UcR+rGbsibaurhKvmzn6zk2NOAS3g9G4KM7FWfa
         gqcMPF2h6H8Ksb5S5BVooXQ3k9k1gQ2XCNC/nwIEZ490+tAzxcp8Wjb+C3JEIrRzJtO/
         IhuVYZYxuQkNCTxsYn4I1WYjM6Ha64zKF6+uWMst+RPeJ4QiNZ8Cs8HABL84MUlU4GVB
         K5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fyuxB7uASPs4V8EwrbccKdCUM8hiD6bv8oGzygKlhA0=;
        b=jpMG/htizZmHXlM8Dx4Ai+m/jq6dg3/CLZ18g3puXvBT8pQ9npSKijX17B9eJ1615z
         QxCD7J6jvX1bS9OWRB1kcmJHE+sIFkld+U1bsG5e9dn6VAaFiSwMyHL9tZEwPdAhgijX
         5/L4maXXIe2XT4YaTb/3Cn5G7boytoSci0Xl7pUPuID7yTFr6j9AjjfmUvMRKOIC7hk7
         Rek2IYz11I6l12gxwkTl/V0TYvSA9mJwgVkGyHnSwzJUWfeRtYDTFmBvjeEnTNUmswe4
         aKkD5HZ+7TpDAi9Q24/tdSA0dcWU+vmMIsHwsSTMDAEdivXW3dvSCy1X8+gsmnq75YL/
         tSWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Lothian <mike@fireburn.co.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.9 19/95] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
Date: Sun, 22 Apr 2018 15:52:48 +0200
Message-Id: <20180422135211.229862795@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454879280610087?=
X-GMAIL-MSGID: =?utf-8?q?1598455855122101976?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 13d3047c81505cc0fb9bdae7810676e70523c8bf upstream.

Mike Lothian reported that plugging in a USB-C device does not work
properly in his Dell Alienware system.  This system has an Intel Alpine
Ridge Thunderbolt controller providing USB-C functionality.  In these
systems the USB controller (xHCI) is hotplugged whenever a device is
connected to the port using ACPI-based hotplug.

The ACPI description of the root port in question is as follows:

  Device (RP01)
  {
      Name (_ADR, 0x001C0000)

      Device (PXSX)
      {
          Name (_ADR, 0x02)

          Method (_RMV, 0, NotSerialized)
          {
              // ...
          }
      }

Here _ADR 0x02 means device 0, function 2 on the bus under root port (RP01)
but that seems to be incorrect because device 0 is the upstream port of the
Alpine Ridge PCIe switch and it has no functions other than 0 (the bridge
itself).  When we get ACPI Notify() to the root port resulting from
connecting a USB-C device, Linux tries to read PCI_VENDOR_ID from device 0,
function 2 which of course always returns 0xffffffff because there is no
such function and we never find the device.

In Windows this works fine.

Now, since we get ACPI Notify() to the root port and not to the PXSX device
we should actually start our scan from there as well and not from the
non-existent PXSX device.  Fix this by checking presence of the slot itself
(function 0) if we fail to do that otherwise.

While there use pci_bus_read_dev_vendor_id() in get_slot_status(), which is
the recommended way to read Device and Vendor IDs of devices on PCI buses.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198557
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/acpiphp_glue.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -587,6 +587,7 @@ static unsigned int get_slot_status(stru
 {
 	unsigned long long sta = 0;
 	struct acpiphp_func *func;
+	u32 dvid;
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->flags & FUNC_HAS_STA) {
@@ -597,19 +598,27 @@ static unsigned int get_slot_status(stru
 			if (ACPI_SUCCESS(status) && sta)
 				break;
 		} else {
-			u32 dvid;
-
-			pci_bus_read_config_dword(slot->bus,
-						  PCI_DEVFN(slot->device,
-							    func->function),
-						  PCI_VENDOR_ID, &dvid);
-			if (dvid != 0xffffffff) {
+			if (pci_bus_read_dev_vendor_id(slot->bus,
+					PCI_DEVFN(slot->device, func->function),
+					&dvid, 0)) {
 				sta = ACPI_STA_ALL;
 				break;
 			}
 		}
 	}
 
+	if (!sta) {
+		/*
+		 * Check for the slot itself since it may be that the
+		 * ACPI slot is a device below PCIe upstream port so in
+		 * that case it may not even be reachable yet.
+		 */
+		if (pci_bus_read_dev_vendor_id(slot->bus,
+				PCI_DEVFN(slot->device, 0), &dvid, 0)) {
+			sta = ACPI_STA_ALL;
+		}
+	}
+
 	return (unsigned int)sta;
 }
 
