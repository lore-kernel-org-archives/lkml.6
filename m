Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZogB3DD6t6+8/cGvEu7W0vVXo4M1bsXVWs0X4BC7zky5gj+1DXoFeNc27IZf8VdOr+OySH3
ARC-Seal: i=1; a=rsa-sha256; t=1525116522; cv=none;
        d=google.com; s=arc-20160816;
        b=KoXzhv+g0DqD7UkxV+gp8qnngsRCnP9dyvM7L2ttU4s8mpwNEgL0crPDdGhkPnXQRh
         8CEr/Dx+NwV8Op2O8ogcB1x9iU7V/XnsvBQQGMUB5Wgtjhaq1XRMq8KS1yBRfNXm1llc
         HvcWMpRpIogwRQuoM4RsOKoi2PZqHEruYzcfpHY102DiJC+2KwvIJ1eMUlxJJYNpSKmU
         mzJbEytSDEyQh5csd0sUV3Ho4TTZTXk3OnLN+FgIPo+1UCE4U0OlqdF2P0qkaoPpwin9
         5F9D4kohD4OQgVPZk4w5RmPuf9qJ+obM3EAb2zKl+Esbo7/LjHCUGWAIQzcWQrRWaUNI
         IGqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=p7ert98goCYXo55PSOWnxv/uxl4/HprvYwhjy1daR8M=;
        b=KhX/PWluU6S/zu+rNbwLo/YWf6R6PjSgbwS39hqv2MqVo2OVCZzFnLzZzuYytANuAH
         TuVlJzn82yHlJqGmJLcnWChM/K4OM4QqAMQSXFh7w3WXbRgjUFBhRPriJ4mF2gnyFzJA
         lOqJp5XSVa0k2/NTt2mcYUyLDeu0Qi+C/kpZnCxzvr05+EaXYS95OUn2b2MblazEUBRU
         pgyRLwY7DFEkJQOe8hLG1J42EUsql4X9GOLNYkKwUS0C6Ww4vosmpK2+PtSvpQ7nNAjX
         H1d9mUxSAfSxFiKswNOrI5u6S9SM2q/TAnBljd8WEuRDOdrPJmhctO5ZEGgIDcuNiIwR
         EeSQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8CD22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 089/113] PCI / PM: Do not clear state_saved in pci_pm_freeze() when smart suspend is set
Date: Mon, 30 Apr 2018 12:25:00 -0700
Message-Id: <20180430184018.963429646@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200582252476647?=
X-GMAIL-MSGID: =?utf-8?q?1599200582252476647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit ae860a19f37c686e7c5816e96640168b7174a096 upstream.

If a driver uses DPM_FLAG_SMART_SUSPEND and the device is already
runtime suspended when hibernate is started PCI core skips runtime
resuming the device but still clears pci_dev->state_saved. After the
hibernation image is written pci_pm_thaw_noirq() makes sure subsequent
thaw phases for the device are also skipped leaving it runtime suspended
with pci_dev->state_saved == false.

When the device is eventually runtime resumed pci_pm_runtime_resume()
restores config space by calling pci_restore_standard_config(), however
because pci_dev->state_saved == false pci_restore_state() never actually
restores the config space leaving the device in a state that is not what
the driver might expect.

For example here is what happens for intel-lpss I2C devices once the
hibernation snapshot is taken:

  intel-lpss 0000:00:15.0: power state changed by ACPI to D0
  intel-lpss 0000:00:1e.0: power state changed by ACPI to D3cold
  video LNXVIDEO:00: Restoring backlight state
  PM: hibernation exit
  i2c_designware i2c_designware.1: Unknown Synopsys component type: 0xffffffff
  i2c_designware i2c_designware.0: Unknown Synopsys component type: 0xffffffff
  i2c_designware i2c_designware.1: timeout in disabling adapter
  i2c_designware i2c_designware.0: timeout in disabling adapter

Since PCI config space is not restored the device is still in D3hot
making MMIO register reads return 0xffffffff.

Fix this by clearing pci_dev->state_saved only if we actually end up
runtime resuming the device.

Fixes: c4b65157aeef (PCI / PM: Take SMART_SUSPEND driver flag into account)
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci-driver.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -945,10 +945,11 @@ static int pci_pm_freeze(struct device *
 	 * devices should not be touched during freeze/thaw transitions,
 	 * however.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev_pm_smart_suspend_and_suspended(dev)) {
 		pm_runtime_resume(dev);
+		pci_dev->state_saved = false;
+	}
 
-	pci_dev->state_saved = false;
 	if (pm->freeze) {
 		int error;
 
