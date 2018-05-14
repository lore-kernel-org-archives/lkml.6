Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrKjr6+etynwaqNd4iPxKYWOP+xd4TVrHNIr/0ryXD2TSJPs1gRdpPPX3BNNkkIqPoayMcE
ARC-Seal: i=1; a=rsa-sha256; t=1526281004; cv=none;
        d=google.com; s=arc-20160816;
        b=sGtzDkX8n1cmH3kp4stZJc4gjiGe3Hji+o51hoL86PFdfQqFqcAqhgQ7OvYdhKUkFx
         0riIYh54KGDRWlgFAuasYp+S8Rtd2WJE0P6ovuNK1u3kT7EYxrqJSOXhlbrzeN61jmXk
         7aDl67NFri6tr6IuxBmbgzlNc/A1e/yZEembQfAG4eEinhPXL+RST8G8nWX06Tfo5Ppw
         GUXqUHeAVhn+Y2xZsM4HWYBAV6HwxMY4nZlCUFf7tRFVCZA0/JayEnJeXF1slm8Zw8iD
         Ykn2AztN5aeoauY8UqSES7JumHz2zuj7+LQi2ssIDkcVqz436/HQfJDLClLP5ZFEhTe9
         0xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=330+pNb4PdXF9M4UdFHcXJx4qyKsHI/ENbzdS2jtd7c=;
        b=r2aqZoxTirisx6796K/r0LF4WUSzgZvvKkqxZqpjAe8T4UcuUGiHNoEVm82Xt0p3ds
         8pD9pvfWg5ReuQOlLsPRaczGS9A+FrCETAxxjva3Ngga77Atcu6+IyQmiC/lNzQufBsQ
         coL7olQE9L+PhlCHrc1BGe6KxXZYjfEKPc2szNwh2qV1dlSpPZW2rpwGlYDPR2cbLYs7
         /jteN3P60WJptPfppPBHHfAcYLWafmh7dLgiFzfmA7MxbnkhT93yjhGlezsgbsbNChe6
         Zb4dSDUs3n88SofT50FzZnSF3D7DFCASbmCjwdHzm9atkzQtsSrFfBd6+8nfJlgcNjvF
         +i3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TrCBNEB2;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=TrCBNEB2;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.14 44/62] PCI / PM: Always check PME wakeup capability for runtime wakeup support
Date: Mon, 14 May 2018 08:49:00 +0200
Message-Id: <20180514064818.935712242@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421630219378440?=
X-GMAIL-MSGID: =?utf-8?q?1600421630219378440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Heng Feng <kai.heng.feng@canonical.com>

commit 8feaec33b9868582654cd3d5355225dcb79aeca6 upstream.

USB controller ASM1042 stops working after commit de3ef1eb1cd0 (PM /
core: Drop run_wake flag from struct dev_pm_info).

The device in question is not power managed by platform firmware,
furthermore, it only supports PME# from D3cold:
Capabilities: [78] Power Management version 3
       Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
       Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-

Before commit de3ef1eb1cd0, the device never gets runtime suspended.
After that commit, the device gets runtime suspended to D3hot, which can
not generate any PME#.

usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
device_can_wakeup() in pci_dev_run_wake() always returns true.

So pci_dev_run_wake() needs to check PME wakeup capability as its first
condition.

In addition, change wakeup flag passed to pci_target_state() from false
to true, because we want to find the deepest state different from D3cold
that the device can still generate PME#. In this case, it's D0 for the
device in question.

Fixes: de3ef1eb1cd0 (PM / core: Drop run_wake flag from struct dev_pm_info)
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: 4.13+ <stable@vger.kernel.org> # 4.13+
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pci.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2120,16 +2120,16 @@ bool pci_dev_run_wake(struct pci_dev *de
 {
 	struct pci_bus *bus = dev->bus;
 
-	if (device_can_wakeup(&dev->dev))
-		return true;
-
 	if (!dev->pme_support)
 		return false;
 
 	/* PME-capable in principle, but not from the target power state */
-	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
+	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
 		return false;
 
+	if (device_can_wakeup(&dev->dev))
+		return true;
+
 	while (bus->parent) {
 		struct pci_dev *bridge = bus->self;
 
