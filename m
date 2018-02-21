Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/cBtAdzTMe0hx0i10+Q0bkRLY9w6QpyE1lkqzwqF26yGeSI+GZ+KM/dM1ezAB1340/+Yg
ARC-Seal: i=1; a=rsa-sha256; t=1519218177; cv=none;
        d=google.com; s=arc-20160816;
        b=iboESjr12SGkCOHaI6pFJIkAbULIazUc3SVjnFY9yqOkAHmEN9OSFhWpL8WJk0Bx1s
         2qhu997cKBbmW25+oZmzQbkRK1SF+ZO9146pdbzGsWGUAYojat7axIKfskzEHSkmN/jd
         xpl+NrqpEkw5wfeYv+99AV1cR10ILyZyHPggxOfJPvPBMXUsgEc2LypTXuX2pXALZfrG
         PaQbRDi0ZzxyLR3JOhSDJ1nx6EErTrK98OMvqLk/aW07g0gdF7O3cP2Wif09Nq+ye/L6
         78axj3vRotjJczDeghcsr4vI/kftpRZfey2M04M8izOpvFGSVJ05g2J9jz1KryEnZWBO
         wJ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3tzahAloAEOR8g5rdr9tAANXm/R+zKUoxM60RrVy6kw=;
        b=JYh0v672rnoFlkL5/zjwqVNU1csXawPiaqQK8zhzktNV487rzA6Tjbz0vj2Ku2uAUd
         xTz7J10W8cV8ROq9FZgmR4m5JCEiwXG+H/h0j15hFWPMZllYx1flTv2d//ySHBvC8/Q0
         XiyuNbJYFRsprjDX7Xlu+55mLc3+1Kgzuh2feY3ct8tYlQdZ4aRuNvUhG6pYddBvSIeD
         bcuqKU0ySAltmk2FZGSTIwshJ3QdWkfHHBS8sFC2rlW3MrSllZsU0XDHmGmwzYIdHfkD
         4y+BvYfTcJobabLTCRRnFFdGFvzhY1pTMI/EFAoV4ls7E9O5m3+k7RUOHS7Sf252eZGX
         8HMA==
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
Subject: [PATCH 4.14 115/167] PCI: keystone: Fix interrupt-controller-node lookup
Date: Wed, 21 Feb 2018 13:48:46 +0100
Message-Id: <20180221124530.703828747@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015295362303272?=
X-GMAIL-MSGID: =?utf-8?q?1593015719232721627?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
