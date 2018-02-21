Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2242m6l2kiupOI+urOl0JrdP/XDToYfL3J1iNFLYS5CN/MXi5aYfpYMQqO4LGAqb8nn/VrZ1
ARC-Seal: i=1; a=rsa-sha256; t=1519218673; cv=none;
        d=google.com; s=arc-20160816;
        b=VTy+xIzKkj7Vt08ahzFBW+bbaqlVdCM9w8epfHdyQVSXrBFphu2WVw97SYn5gntAeO
         OKhs+pmjkK2CZSNr4P9QV9hoAtayPqmbhQNzGx4W7WbB/8iHRZMLBj3nYU/OWU+3iGLV
         w/viZDooYqhIN9LyvS+cwno1sdH4gDqrNtWZmyPyIdk2WOjEcPRpc96P4ba1tg0nV79i
         dlr8GYPsFx2f+BXPnyKe45TkXA2b2qzakNCBITLpip+peCG6S+e+BmzUkzHJN4jJYRL4
         lVj41XLL2BS0+ehx2Z2sxtRIx4Bod0X3XHy9WASTDiDv4AiVzKYkSLYecUHfs9ZFToDl
         LT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lN9+M/0E6+Yglned9kcF0w1VCzjqkJ3McQwtjJH5+5w=;
        b=xfduME5ff9nWDiNKfCjCP3w6TQZUcacks9QZqAgyB+GRbWklwr+St9i7x0XjT/1Bnk
         JMnGj1rCn6nUDrYV0h9VjjvrQs5wcy5O/pJEgZbZ3OYFfj3vqshZFyqieokhq4VqZJ79
         2xyilv7CpdAXc5JHMno9pxLguoZ1CP13Q3PoaNaWS+AmPIQZHB+g61wkMFs9bybhi/w2
         sGSUuHrNedpLVxEHKIq//7mscIx+sHw5QcsdJu3XG10aoD67ygj6Eg5GjuZYeo1QttK7
         is+WOUZUhCntKejGlI7CM8i2vUQXfx2GWrZXmz12GcpH7cOsr4KaPW+AZhx8EDNrYNCU
         wgxQ==
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
Subject: [PATCH 4.15 118/163] PCI: keystone: Fix interrupt-controller-node lookup
Date: Wed, 21 Feb 2018 13:49:07 +0100
Message-Id: <20180221124536.658501195@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015295362303272?=
X-GMAIL-MSGID: =?utf-8?q?1593016240086732462?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/pci/dwc/pci-keystone.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/dwc/pci-keystone.c
+++ b/drivers/pci/dwc/pci-keystone.c
@@ -178,7 +178,7 @@ static int ks_pcie_get_irq_controller_in
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		return -EINVAL;
@@ -187,6 +187,7 @@ static int ks_pcie_get_irq_controller_in
 	temp = of_irq_count(*np_temp);
 	if (!temp) {
 		dev_err(dev, "No IRQ entries in %s\n", controller);
+		of_node_put(*np_temp);
 		return -EINVAL;
 	}
 
@@ -204,6 +205,8 @@ static int ks_pcie_get_irq_controller_in
 			break;
 	}
 
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		return 0;
