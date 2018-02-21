Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227fxUebb/NpNpCYUzMpknubb9r+1KCT6nwk83eIReXKsbGTRiH74hbV0ktxa02j+xoIxdA0
ARC-Seal: i=1; a=rsa-sha256; t=1519217772; cv=none;
        d=google.com; s=arc-20160816;
        b=boxMRqvKYYHrofBoUjQhey4D+7UmA1qzd6hq1zyHZDLMIfOerhVlsjfdyWNti2Mhxl
         pPS7HQzQNI7BnS3o2hFRvOgG/cwRltG8Ycs59WdlBygVMfEjnOdFI/BKArkQYzeOiTlY
         wmTl8LGhAlrVrsiBVHIYG8AxnyCGi0OZtyZ/lZOETfDlV0UdpGx6nYuzux0MOz4pjAF5
         RCIco2aO2uu7YGePEgZylbANe9DVI0esuZHHxixuvzJE84ntmUUn41AoKHM0zXdxiL26
         gY0OMeEOPmTqqsM4OXxZzwUnMCrWc6wsoNfKMTHSDsguFeF3f0gvIuFeI/kp7DUAsQRF
         MGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9kaLt3d2IJgSBFc46ur3KCgJHaD8blU3+XK/MC/Iz4g=;
        b=Xdni01kGYSTUjSf5Snq9fAN+AnsqU/jg6ljhk5pJOP9PspVYHWYPHxxIib2LSLCxBQ
         UJa6HDY54u1HUiDhJka/UueUsJw/DEwJQy0P4tM81Ir/joEAhXisYANU0XycUvZhw4o9
         Kv0Lw0Al7KF4BGTynwd0lFKxUfnLaps3i6d6LZv2s8NEzE0M9afO9DS8H3NfqhWw5FWN
         1mSpWYF/NV1rnAGc01anUgmmkUJN0tacV9ulSCEy6qny5yeOXxSKKcoBdtHt9Nn4d8AY
         rms0qruRTUUyxJjmDZI25GV0gLTsWMGRktHUaiModv+eDK1maVihK2j2nqCxtbxJgj+d
         okaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Murali Karicheri <m-karicheri2@ti.com>,
	Johan Hovold <johan@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 4.9 13/77] PCI: keystone: Fix interrupt-controller-node lookup
Date: Wed, 21 Feb 2018 13:48:22 +0100
Message-Id: <20180221124432.718096781@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015295362303272?=
X-GMAIL-MSGID: =?utf-8?q?1593015295362303272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit eac56aa3bc8af3d9b9850345d0f2da9d83529134 upstream.

Fix child-node lookup during initialisation which was using the wrong
OF-helper and ended up searching the whole device tree depth-first
starting at the parent rather than just matching on its children.

To make things worse, the parent pci node could end up being prematurely
freed as of_find_node_by_name() drops a reference to its first argument.
Any matching child interrupt-controller node was also leaked.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Cc: stable <stable@vger.kernel.org>     # 3.18
Acked-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
[lorenzo.pieralisi@arm.com: updated commit subject]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-keystone.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -181,7 +181,7 @@ static int ks_pcie_get_irq_controller_in
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		return -EINVAL;
@@ -190,6 +190,7 @@ static int ks_pcie_get_irq_controller_in
 	temp = of_irq_count(*np_temp);
 	if (!temp) {
 		dev_err(dev, "No IRQ entries in %s\n", controller);
+		of_node_put(*np_temp);
 		return -EINVAL;
 	}
 
@@ -207,6 +208,8 @@ static int ks_pcie_get_irq_controller_in
 			break;
 	}
 
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		return 0;
