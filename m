Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224QHdqN2bn7pyusEZS+YT2fsPUVZacDMg0mc1qQrCjrqN0cMRX4TOjVrOULw0E7KfCg+oHf
ARC-Seal: i=1; a=rsa-sha256; t=1519676175; cv=none;
        d=google.com; s=arc-20160816;
        b=HDUQK5OvdOVLLawoqmzUQu48MJU9qQDQcwpFODzq+CD1A9KvSorrBWr6gq7+3rOkCT
         qlVnLKs3MvELuBhstzIUf62k1nR1MMdbkvwgKZZwFg4Jve+bVA59mkPRK8j9Mk83v/gG
         oDOAZ/VlQlLY63H7B6RA6VUkmiixWRDaJX1gITKwt8plM6KeXqI+DdAqBJVwj4fXusbr
         +VlRV+Hsm0FalavTcWsTpoE6jgvgKScvmtmpZHw6onkmOtJq0JLeWIKWLgei+Riu9l8E
         1n9D/ZXKNTwYoItu7sW8w/ogQyd9h5di+SlYRibLDh/AblF+m+7l71aHyJf35ZDOK9Wo
         f/+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/o/bdl/UNwgsMkUw/2+A2C8I9+GdpvkcjZM6pcmuyNE=;
        b=r9IJVPU6ruCR4MbsgqfznYlLRASCGud7tc4lcy9W9vVkCEoSr+kFiwN5E1tUJgLfrD
         ipkklOaLAWriW4x0xVjQJrP0q6/9dTf5CCMvGyv+3TgJkdcGeaSQQCjM3JTAT9KbZxO5
         xGrNUvWw65xuyYlyYoY25v9icUBW8ZUNzf7fs14CwA1Pl7EpMdMVNoJUuNBIUx7wuElA
         XOReKAtPknkDFtdA2puhXlfalql/baVQ6rbmEGVu4CawZ9DlTJ+pWMY4xivADsdTCqRR
         +CeQ9JRZ6z+upijr+ViQOMkI8dyF33fs2HDIYXiTIYK3x5OcF8kCJXc7tfOPg09g1F5u
         sypA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Murali Karicheri <m-karicheri2@ti.com>,
	Johan Hovold <johan@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 3.18 02/13] PCI: keystone: Fix interrupt-controller-node lookup
Date: Mon, 26 Feb 2018 21:15:30 +0100
Message-Id: <20180226201527.354817968@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495965325088800?=
X-GMAIL-MSGID: =?utf-8?q?1593495965325088800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
[johan: backport to 4.4]
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pci-keystone.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/pci/host/pci-keystone.c
+++ b/drivers/pci/host/pci-keystone.c
@@ -179,14 +179,16 @@ static int ks_pcie_get_irq_controller_in
 	}
 
 	/* interrupt controller is in a child node */
-	*np_temp = of_find_node_by_name(np_pcie, controller);
+	*np_temp = of_get_child_by_name(np_pcie, controller);
 	if (!(*np_temp)) {
 		dev_err(dev, "Node for %s is absent\n", controller);
 		goto out;
 	}
 	temp = of_irq_count(*np_temp);
-	if (!temp)
+	if (!temp) {
+		of_node_put(*np_temp);
 		goto out;
+	}
 	if (temp > max_host_irqs)
 		dev_warn(dev, "Too many %s interrupts defined %u\n",
 			(legacy ? "legacy" : "MSI"), temp);
@@ -200,6 +202,9 @@ static int ks_pcie_get_irq_controller_in
 		if (host_irqs[temp] < 0)
 			break;
 	}
+
+	of_node_put(*np_temp);
+
 	if (temp) {
 		*num_irqs = temp;
 		ret = 0;
