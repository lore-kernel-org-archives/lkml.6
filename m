Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqBjGYQnCHj9fqIB/AGpC9MB4niv8I9G1UKkxI0c7taIYsf1ZSBJOsAUk6bipKbu6DsdINy
ARC-Seal: i=1; a=rsa-sha256; t=1525767364; cv=none;
        d=google.com; s=arc-20160816;
        b=Hky6MHuyK7sXQn2RntFqa1gRRK8fBbhMrDr4m2+3i70lfCthULzSjwmX7BmIInC0MJ
         kLoVnr8Nf1TRpm7Aln59/gmhXC/xv690pSqKrdLXwz6yMtiaj/zS1ut1wH8duEI2I0LL
         x97GTEyDHJ/jAeadWEaZ6DDjQrrD1fS3VivpU+e+cDwDWNr54qUCWPFmVqASXtjfVt+/
         ssW1ECHsA+hSlEo/aBFgINu1rPNPWUZ3ZTg26bgTPTwixfUPKTC4eBTaxJeEgPbtQnFG
         8HzZgisVpnRgfUgUg78bG8zCkK2WOl3MEyuqBhFN7KVWnwXf3/0bU62vPgcNqO0BiqBH
         rE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Hgz77/ctDKPLNloYgxyuwUURypV/6OUbY3U6gXa/UMU=;
        b=rZ8AXtsD+9zsRxQM/1XX3/QKjFMT113+zsy01IbVZvbXj1YlS5s+40Xhyi0ahh2lNJ
         LtIO4gOm9li+lKyXoEQYcQCsdz6sVgA3X5WFMwhcgfEYfOIsQIljQDQ7vtONNUtwc0Fq
         qSG0GNw5GHS3kixD8hrzo+u9mvQZu1OU3O1tPR8vS0Ln/VhO//M2KN6VO1jaQxqLLaN6
         Vlwze4qOy4TljSXzFaXIots7yujcXuCZCBc8QXuj2kf25b+HrQpktHPDjwTlkBpHWVbP
         /j8oxVudK3XoH97O3np7Y89ShIymSU2c74LcxPRvmC/nkRLBvmCV1NZTE4s2ohTtlwKp
         TqwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kppHRCOg;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kppHRCOg;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mike Marciniszyn <mike.marciniszyn@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Sebastian Sanchez <sebastian.sanchez@intel.com>,
	Dennis Dalessandro <dennis.dalessandro@intel.com>,
	Doug Ledford <dledford@redhat.com>
Subject: [PATCH 4.14 28/43] IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used
Date: Tue,  8 May 2018 10:10:47 +0200
Message-Id: <20180508074008.410397910@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882819236175981?=
X-GMAIL-MSGID: =?utf-8?q?1599883039883026256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Sanchez <sebastian.sanchez@intel.com>

commit 45d924571a5e1329580811f2419da61b07ac3613 upstream.

When an invalid num_vls is used as a module parameter, the code
execution follows an exception path where the macro dd_dev_err()
expects dd->pcidev->dev not to be NULL in hfi1_init_dd(). This
causes a NULL pointer dereference.

Fix hfi1_init_dd() by initializing dd->pcidev and dd->pcidev->dev
earlier in the code. If a dd exists, then dd->pcidev and
dd->pcidev->dev always exists.

BUG: unable to handle kernel NULL pointer dereference
at 00000000000000f0
IP: __dev_printk+0x15/0x90
Workqueue: events work_for_cpu_fn
RIP: 0010:__dev_printk+0x15/0x90
Call Trace:
 dev_err+0x6c/0x90
 ? hfi1_init_pportdata+0x38d/0x3f0 [hfi1]
 hfi1_init_dd+0xdd/0x2530 [hfi1]
 ? pci_conf1_read+0xb2/0xf0
 ? pci_read_config_word.part.9+0x64/0x80
 ? pci_conf1_write+0xb0/0xf0
 ? pcie_capability_clear_and_set_word+0x57/0x80
 init_one+0x141/0x490 [hfi1]
 local_pci_probe+0x3f/0xa0
 work_for_cpu_fn+0x10/0x20
 process_one_work+0x152/0x350
 worker_thread+0x1cf/0x3e0
 kthread+0xf5/0x130
 ? max_active_store+0x80/0x80
 ? kthread_bind+0x10/0x10
 ? do_syscall_64+0x6e/0x1a0
 ? SyS_exit_group+0x10/0x10
 ret_from_fork+0x35/0x40

Cc: <stable@vger.kernel.org> # 4.9.x
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Sebastian Sanchez <sebastian.sanchez@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/init.c |    2 ++
 drivers/infiniband/hw/hfi1/pcie.c |    3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1234,6 +1234,8 @@ struct hfi1_devdata *hfi1_alloc_devdata(
 		return ERR_PTR(-ENOMEM);
 	dd->num_pports = nports;
 	dd->pport = (struct hfi1_pportdata *)(dd + 1);
+	dd->pcidev = pdev;
+	pci_set_drvdata(pdev, dd);
 
 	INIT_LIST_HEAD(&dd->list);
 	idr_preload(GFP_KERNEL);
--- a/drivers/infiniband/hw/hfi1/pcie.c
+++ b/drivers/infiniband/hw/hfi1/pcie.c
@@ -163,9 +163,6 @@ int hfi1_pcie_ddinit(struct hfi1_devdata
 	resource_size_t addr;
 	int ret = 0;
 
-	dd->pcidev = pdev;
-	pci_set_drvdata(pdev, dd);
-
 	addr = pci_resource_start(pdev, 0);
 	len = pci_resource_len(pdev, 0);
 
