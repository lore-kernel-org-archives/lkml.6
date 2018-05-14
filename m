Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrr4p52Rpcnb4f7vwNS+S+k9FD2HLbrqXDrfANnCPzHVoDuRMfu5kWsnlZFAGkqlwJQPDCU
ARC-Seal: i=1; a=rsa-sha256; t=1526281006; cv=none;
        d=google.com; s=arc-20160816;
        b=SKW6NX3oRRzUnJZw7K92qiZiciI41eFP0TdrmXV32KfnrZup8eoa+pcth3++hQFbFg
         55KWigS9s0FR7VeoVy+/8P5RLH//SgT/cy2DqkqkmHsv8Erp5HqIG8OorhG51vosanIG
         s4ibIu2r7yJAf/2nmC5LzE6yJdEfkR+Z/yqvBLfyIOzvNxFcoJVrfJmrepzN1tId7xqj
         e962Scvb+n1J4G+ouhdFpqyzvVjLl+9AWGIo50u+m7y5NBm+rPiHgW/xZZKwRtYnQaxm
         YqxmosdlqOURF87NwQqdfixfHLs6Y8d5g8q5x9O2ABQP2m6Z3r1T4Zv61Hn65J+ZMSmZ
         t7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=GuwJGVg+vMTKAUR5DapNBRdVpewBL9PE66AV+pdMXJk=;
        b=ME8NnTAhY7PCougrjrq30xwJr4c327oW9HPvg98GDuO4KjPgy6lWTmAalgEyTdfHnW
         tG6ryAvO6B87rPKpLfJT8lZg1KJQ/cbXI8NCg6Zza/8Ao2OLg8pLaDkDpD++UMPTf3xK
         5aL4Hs9z2O1SipJJWpCwaUaHLmIU7YpI8zdN3UVVvZQkcp5bfSk6fEM2QxidIQjsNyK2
         gaJyoprwpYSdicJeE2/SiNwFuszLlN6BmAaX4bRRRs6ctPIn5i3r76d2YBP9ynU0R3pT
         XXaKBf+vnvaEASp7EUWhiV3M3zTikR+N808BTDUapAlwzoNcPuWYMuuSLwaA34Ft5Z2d
         dLGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rbhs3XoT;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rbhs3XoT;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Joseph Salisbury <joseph.salisbury@canonical.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.14 45/62] PCI / PM: Check device_may_wakeup() in pci_enable_wake()
Date: Mon, 14 May 2018 08:49:01 +0200
Message-Id: <20180514064818.990880654@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421633007831027?=
X-GMAIL-MSGID: =?utf-8?q?1600421633007831027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit cfcadfaad7251d8b640713724b388164d75465b2 upstream.

Commit 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
went too far and dropped the device_may_wakeup() check from
pci_enable_wake() which causes wakeup to be enabled during system
suspend, hibernation or shutdown for some PCI devices that are not
allowed by user space to wake up the system from sleep (or power off).

As a result of this, excessive power is drawn by some of the affected
systems while in sleep states or off.

Restore the device_may_wakeup() check in pci_enable_wake(), but make
sure that the PCI bus type's runtime suspend callback will not call
device_may_wakeup() which is about system wakeup from sleep and not
about device wakeup from runtime suspend.

Fixes: 0847684cfc5f0 (PCI / PM: Simplify device wakeup settings code)
Reported-by: Joseph Salisbury <joseph.salisbury@canonical.com>
Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1892,7 +1892,7 @@ void pci_pme_active(struct pci_dev *dev,
 EXPORT_SYMBOL(pci_pme_active);
 
 /**
- * pci_enable_wake - enable PCI device as wakeup event source
+ * __pci_enable_wake - enable PCI device as wakeup event source
  * @dev: PCI device affected
  * @state: PCI state from which device will issue wakeup events
  * @enable: True to enable event generation; false to disable
@@ -1910,7 +1910,7 @@ EXPORT_SYMBOL(pci_pme_active);
  * Error code depending on the platform is returned if both the platform and
  * the native mechanism fail to enable the generation of wake-up events
  */
-int pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
+static int __pci_enable_wake(struct pci_dev *dev, pci_power_t state, bool enable)
 {
 	int ret = 0;
 
@@ -1951,6 +1951,23 @@ int pci_enable_wake(struct pci_dev *dev,
 
 	return ret;
 }
+
+/**
+ * pci_enable_wake - change wakeup settings for a PCI device
+ * @pci_dev: Target device
+ * @state: PCI state from which device will issue wakeup events
+ * @enable: Whether or not to enable event generation
+ *
+ * If @enable is set, check device_may_wakeup() for the device before calling
+ * __pci_enable_wake() for it.
+ */
+int pci_enable_wake(struct pci_dev *pci_dev, pci_power_t state, bool enable)
+{
+	if (enable && !device_may_wakeup(&pci_dev->dev))
+		return -EINVAL;
+
+	return __pci_enable_wake(pci_dev, state, enable);
+}
 EXPORT_SYMBOL(pci_enable_wake);
 
 /**
@@ -1963,9 +1980,9 @@ EXPORT_SYMBOL(pci_enable_wake);
  * should not be called twice in a row to enable wake-up due to PCI PM vs ACPI
  * ordering constraints.
  *
- * This function only returns error code if the device is not capable of
- * generating PME# from both D3_hot and D3_cold, and the platform is unable to
- * enable wake-up power for it.
+ * This function only returns error code if the device is not allowed to wake
+ * up the system from sleep or it is not capable of generating PME# from both
+ * D3_hot and D3_cold and the platform is unable to enable wake-up power for it.
  */
 int pci_wake_from_d3(struct pci_dev *dev, bool enable)
 {
@@ -2096,7 +2113,7 @@ int pci_finish_runtime_suspend(struct pc
 
 	dev->runtime_d3cold = target_state == PCI_D3cold;
 
-	pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
+	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
 
