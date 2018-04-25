Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/da+yOG2pK1zyNThCFZPmHQrg6cjhjJrMh15ga8dWoWs3vAZ1NJfSjywF65mhhxtIJQGMg
ARC-Seal: i=1; a=rsa-sha256; t=1524652714; cv=none;
        d=google.com; s=arc-20160816;
        b=pDHmUOP0K4kxmA3C74XhM6gA+/friK3wMAwUD8DDCCp0bQD8ynpRTJpG5otvfOQPbf
         k3+U+P7BX0hv21xA9pyfpfO+F2iNrZrVmJEz/F0KcpZGzsNMeVYULd4TxHUhMjE3CiDE
         dYrFTyGs/RXhhBBYSzeOcv0xaJ0hYqm/KNVrZhZQ/LqVDeDFVKfV3sVGQDB1bcxKXVv7
         ozpqNeDDgmWPOMVMnizmPj6UVNro8nW3SDvaAn8dSAlQRDbjsxXfWTX6vFkrMbZJR2ZK
         pAjpFXiwDfKlASMjo8k9WG//6hBvb1QWNt1VvTWRr85tQWqmjx2gpaEcb0dm+rVUbMxB
         NoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZYzpp95qcYRCoGnQFwu/QVSO6bimwrWdi88lR0nVQLU=;
        b=kQYLQtwmoZkEJyv5PURL6ZarL7A6kgEdSvntt2hVoot8w0e1hJh+joFhbOnzU4umbX
         MjIvkZPA5P6Ps1QPcVbwcYbI+w/y/V2iM18AyKUmzSuQcdSBX4yQPuNUV12077HUMiHy
         ghP2m12i7FSC7+wqhk2mwOUvZy3GrtaNIiTw79mgbb8vmE2xw92vm/GW4x6GJhKmzMhK
         2mL435rSU8Yl3hS9tfaqnQefSv62mb3I+dnEIXs5/eg4DqmLTtOEOHFeThA8ocYqaMKA
         cWZ8VLRipv3c14+NAIB3Yo/YBkf7zk/jvuWaHlIbSDcv9+iTvqDp/xluuzLSM9x2M3Qz
         KmDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 043/183] iommu/exynos: Dont unconditionally steal bus ops
Date: Wed, 25 Apr 2018 12:34:23 +0200
Message-Id: <20180425103244.298982923@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714245096584262?=
X-GMAIL-MSGID: =?utf-8?q?1598714245096584262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>


[ Upstream commit dc98b8480d8a68c2ce9aa28b9f0d714fd258bc0b ]

Removing the early device registration hook overlooked the fact that
it only ran conditionally on a compatible device being present in the
DT. With exynos_iommu_init() now running as an unconditional initcall,
problems arise on non-Exynos systems when other IOMMU drivers find
themselves unable to install their ops on the platform bus, or at worst
the Exynos ops get called with someone else's domain and all hell breaks
loose.

The global ops/cache setup could probably all now be triggered from the
first IOMMU probe, as with dma_dev assigment, but for the time being the
simplest fix is to resurrect the logic from commit a7b67cd5d9af
("iommu/exynos: Play nice in multi-platform builds") to explicitly check
the DT for the presence of an Exynos IOMMU before trying anything.

Fixes: 928055a01b3f ("iommu/exynos: Remove custom platform device registration code")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/exynos-iommu.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1344,8 +1344,15 @@ static const struct iommu_ops exynos_iom
 
 static int __init exynos_iommu_init(void)
 {
+	struct device_node *np;
 	int ret;
 
+	np = of_find_matching_node(NULL, sysmmu_of_match);
+	if (!np)
+		return 0;
+
+	of_node_put(np);
+
 	lv2table_kmem_cache = kmem_cache_create("exynos-iommu-lv2table",
 				LV2TABLE_SIZE, LV2TABLE_SIZE, 0, NULL);
 	if (!lv2table_kmem_cache) {
