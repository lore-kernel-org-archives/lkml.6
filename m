Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt4ovPG5Lzbog/I0Ax0KKOCk7Ae3Mx0w+tsOyjSKMQE7x5m7pCwCtYeqj0MXGt4zKoVir5E
ARC-Seal: i=1; a=rsa-sha256; t=1521483758; cv=none;
        d=google.com; s=arc-20160816;
        b=TSD63N3MV3ZOFkEvFIxzUVGJT5XKTHovxoAjBQ4+wwCxXyrV7K5smXlonwCna7tMZx
         iCpLCzqut1F6oVxqP4bTOIgxkHLVeByHbCWeDD7zlu2hKnPWkBZgm/JhLFXxFPYmKhsq
         dqPyLLTSB2XPVBGT3KSYys1EVmPFUUoy3zFtREwk765eFQ5p5121Ru7icLCz1GI6F4Ms
         YfZ/PrC1miAonItrUZV9Bzgp1km3bFqDsF4GoJtHrSvwJ03ZhWCib1IYlgVhF/gFFBgg
         BRUIkwH+FwWPVmCNS+SeYsZ6AdqQpw+Ahd3wdDhat7OCMMiyo8zQTxlz6j3mPN74Wxb5
         oBQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VFbmXSDDwaMm3+Bu+0xmvHtOKI+C2JmbU5LoRSIjOV8=;
        b=Hmw0DFhLUm0OT3hb9+PWE6yvp7lynU37bEVj+e8psRqGCLMksE0HS0Hn+skLQUEN2r
         BCPrZm1b/xyXliRNGErfKTolUriOxOiLeV79+UK+7KR/jI6fpWnil/2WcUEzLVDXf7pQ
         grkBj7HCBYBfzw0+6Um8kj7jUgFUXfBH5mx5cO92dUOyRi0ZKTfbVeG1PDQmfd/7Bl6n
         1XryV7zYMXoBIbMHF125E8PmEEF/+ElC7JV0eIrVERjzPDwu5MiDdL07lc1vddjd5doY
         KDu29ezd8dNL+3CbeeMDE4bSffVJlXC6LTd+MDA/Kt7BkCKmWXLMflKOl+SkDW8PcSyX
         6v7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Xiaofeng Wang <xiaofwan@redhat.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 061/241] PCI: hv: Lock PCI bus on device eject
Date: Mon, 19 Mar 2018 19:05:26 +0100
Message-Id: <20180319180753.729464994@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391353551929758?=
X-GMAIL-MSGID: =?utf-8?q?1595391353551929758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <longli@microsoft.com>


[ Upstream commit 414428c5da1c71986727c2fa5cdf1ed071e398d7 ]

A PCI_EJECT message can arrive at the same time we are calling
pci_scan_child_bus() in the workqueue for the previous PCI_BUS_RELATIONS
message or in create_root_hv_pci_bus().  In this case we could potentially
modify the bus from multiple places.

Properly lock the bus access.

Thanks Dexuan Cui <decui@microsoft.com> for pointing out the race condition
in create_root_hv_pci_bus().

Reported-by: Xiaofeng Wang <xiaofwan@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pci-hyperv.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/host/pci-hyperv.c
+++ b/drivers/pci/host/pci-hyperv.c
@@ -1206,9 +1206,11 @@ static int create_root_hv_pci_bus(struct
 	hbus->pci_bus->msi = &hbus->msi_chip;
 	hbus->pci_bus->msi->dev = &hbus->hdev->device;
 
+	pci_lock_rescan_remove();
 	pci_scan_child_bus(hbus->pci_bus);
 	pci_bus_assign_resources(hbus->pci_bus);
 	pci_bus_add_devices(hbus->pci_bus);
+	pci_unlock_rescan_remove();
 	hbus->state = hv_pcibus_installed;
 	return 0;
 }
@@ -1597,8 +1599,10 @@ static void hv_eject_device_work(struct
 	pdev = pci_get_domain_bus_and_slot(hpdev->hbus->sysdata.domain, 0,
 					   wslot);
 	if (pdev) {
+		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(pdev);
 		pci_dev_put(pdev);
+		pci_unlock_rescan_remove();
 	}
 
 	memset(&ctxt, 0, sizeof(ctxt));
