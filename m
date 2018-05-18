Return-Path: <kim.phillips@arm.com>
X-Google-Smtp-Source: AB8JxZqFszw/gRRjXVZVAsy4t8IMdWkyDJeoaff7Y8n7REt6JEJHX87bb1oXnu8C+KnSwkG+PcFw
ARC-Seal: i=1; a=rsa-sha256; t=1526606466; cv=none;
        d=google.com; s=arc-20160816;
        b=Ho5EL6l0sdNdbZ0dRhWFN03JAKW4Tr1dYoijGeZIH6TLtlGmUuMxDpBOlaBwwUXXv5
         QZm/9zocAaxdlbsSJMNgRLsib/Blk0GilxUTVn5S1CCSzTbBq8oHIaioP8ZHitqkf2O0
         L5nCtMEu8TN2ViNoKMLJnutzlVv3AL8xcSaRw1dwpWStCA4M56eouzhgHmIGwGePRNtp
         JP+GhTUxbQOyPjq4ftbFNvvMLjt6eRmUjUDmSuc9kvK7TN76IodvXSdzDGg/PcQmetwS
         pMl+qSMvZpgN8ViMqlCobCHL4eZ9DX7vZXVG/59eAq8dSRR3Cr/+tnxOBlwxq4f+Xc9M
         YmjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vYaLpCV96YTdv3A+4mCCYGwYzj+/7EwbmFZiWxo7g/c=;
        b=nbSIm/S2Fla/7YB8LgrBDaqGTeuMgHb4XFJVW+OxSystdkHIyDNFXjpN72JZ/nHZ6V
         vubfWCiaXDKxs3cDVoBeOGTUZ4anWknEkzNUHJ73X1p493ebwnPvwDntijA7feKzsXZ/
         oJURf2GZvBCNkv8fOgGNtv6LITAnev1FJcY/WupHOInpimWAG5jK+42V+epCupU2i2jg
         uPa8tIwnFzt+D3p1/tlqPJnV/ts2eek6057oAdUZO8dd/bNbIo5fKygIXEE0rMHxlDxa
         cUEuJCVCo7ZtlRJanTAk08EXeBsaaEp8QaSvq7ZTypKOfKl9Ao2HEEUmjiDpQDVUgtiQ
         KpdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kim.phillips@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=kim.phillips@arm.com
From: Kim Phillips <kim.phillips@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Gargi Sharma <gs051095@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Kirill Tkhai <ktkhai@virtuozzo.com>,
	Mike Rapoport <rppt@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Rik van Riel <riel@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Russell King <linux@armlinux.org.uk>,
	Thierry Reding <treding@nvidia.com>,
	Todd Kjos <tkjos@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@arm.com>
Subject: [PATCH 2/6] coresight: fix CORESIGHT_STM -- STM dependency
Date: Thu, 17 May 2018 20:20:20 -0500
Message-Id: <20180518012024.22645-2-kim.phillips@arm.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180518012024.22645-1-kim.phillips@arm.com>
References: <20180517070643.GC13919@kroah.com>
 <20180518012024.22645-1-kim.phillips@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600762902062675063?=
X-GMAIL-MSGID: =?utf-8?q?1600762902062675063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

coresight-stm unconditionally calls stm_register_device.  This
patch makes it therefore depend on STM instead of just selecting STM.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
 drivers/hwtracing/coresight/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 83fb78651ef9..f9abdef5b0d9 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -74,8 +74,7 @@ config CORESIGHT_DYNAMIC_REPLICATOR
 
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
-	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
-	select STM
+	depends on STM && ((ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64)
 	help
 	  This driver provides support for hardware assisted software
 	  instrumentation based tracing. This is primarily used for
-- 
2.17.0
