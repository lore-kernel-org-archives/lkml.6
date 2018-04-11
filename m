Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bPyGnPJsSM0L2DvMiBgTqEQkCdyfmJSgjjNDRXxFUFjxL7zgCXZ9JDUS7roQu5QEsxycL
ARC-Seal: i=1; a=rsa-sha256; t=1523473137; cv=none;
        d=google.com; s=arc-20160816;
        b=jAYaCOS5v3nqi31r+waKthpAjZbLbcF9dKADJ2xyxIiJM4+d+eRi0emwUNPygsPrE8
         qi/9CkNZ84QzdXcu4qGVf1r96dWjJ2u/8KUT6B7E/96b9mefapYDlRyC8Qiwy8yCvVxy
         VGCW+H7dokm564rLe3hGiHhZfQnsQP44J+RKeeYafZIggyI3XyaN/HMDl3xQAn/EKmw6
         9CkNNPtS+zlD8XBfBE0bd0rZb3qzAr6gH+dmBQdw5O6KBHOSTU5O4QYilb/U2JEnZPpo
         QAQgRT/fHiabJpLcFOWZpN68Do3xXx+TUAOGGl+sraNPlYSdj1vD9bh4fyT8fof5XR2f
         74eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iFVG0ouWJ2+Vamv3mBDIVvG+PfKwWMGyu0ZyZdule4I=;
        b=X/StEEJQa7xKIV8ABcT64EC1lKA9K7Phiz00E0k1HnFLHIbv6Q5rFKeaeHUly/F1bH
         xYZZZlYDY1e+5Ehh/gmyY2XzKxgYmtMRuHz7RPk4sIL7PRl8d6aXmOuqH0NDPIwT2MyM
         HAaV1nm6rilXY2wMsMNoWESKcRp0kThQ29LNih4tlutqk5zGP9knb9Lc87zo6ckC69nn
         x/fC00OuAkQsFFQT6PwH3+9ArHZ/L808SUInszADkTfts/6CzOzPhWEd+3CdM8rlplC+
         aHB9OvdvuuDpuhebhv0Pu7kbxuucWfYXAtyfBht2yZrpQ+K2ly6aKtfkg63gFalGqW08
         nUTg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tomasz Nowicki <tn@semihalf.com>,
	Timmy Li <lixiaoping3@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 108/310] ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure path
Date: Wed, 11 Apr 2018 20:34:07 +0200
Message-Id: <20180411183626.848924609@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477369031246039?=
X-GMAIL-MSGID: =?utf-8?q?1597477369031246039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timmy Li <lixiaoping3@huawei.com>


[ Upstream commit 717902cc93118119a6fce7765da6cf2786987418 ]

Commit 093d24a20442 ("arm64: PCI: Manage controller-specific data on
per-controller basis") added code to allocate ACPI PCI root_ops
dynamically on a per host bridge basis but failed to update the
corresponding memory allocation failure path in pci_acpi_scan_root()
leading to a potential memory leakage.

Fix it by adding the required kfree call.

Fixes: 093d24a20442 ("arm64: PCI: Manage controller-specific data on per-controller basis")
Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
Signed-off-by: Timmy Li <lixiaoping3@huawei.com>
[lorenzo.pieralisi@arm.com: refactored code, rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -175,8 +175,10 @@ struct pci_bus *pci_acpi_scan_root(struc
 		return NULL;
 
 	root_ops = kzalloc_node(sizeof(*root_ops), GFP_KERNEL, node);
-	if (!root_ops)
+	if (!root_ops) {
+		kfree(ri);
 		return NULL;
+	}
 
 	ri->cfg = pci_acpi_setup_ecam_mapping(root);
 	if (!ri->cfg) {
