Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsza0qyKAmj1fYCshtRkgrTALSeJEU1N1nqh8IarSm5bBEWn7YHAHOM6hI4bRudpn5RlKQ2
ARC-Seal: i=1; a=rsa-sha256; t=1521484260; cv=none;
        d=google.com; s=arc-20160816;
        b=FkRcKuWg1qjXb3LFV6tyu7hoFT0KSwoU6sK2eojTfDZ5lEq+DcZ+6xcP+Ez9FwEMT2
         T0eYh4zl+SbnmOppPiJ3F/TFbbrBk55QMhxyJ6jiWXY+ekWW9y+Xah1NpafLpWJXANyU
         Rz5za/nIs/N2VOTC94tWdIK3ZUZCRcORijVJpVaQVOkGcYq9uC1Vm66nG9eWr2iodF/g
         I/SEvETPURIpWxONuFCElrh92q92wte8ouul3+R9cs5mqQebZB4rFdCtzRixybyop41Z
         Gk/WHWq9+eInduaVymP4SwvvIUeoKENy7C62dSazy9f+LRJoHPZwHfRrG1GILEAA4M/E
         7CMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lfMcxfFnbaxQQ6XQn1r8DRLU2wgB1Jz24oqWry0WEKA=;
        b=Mehl9yxS3QQbGiiiI3H4yT+LHEisJSO6lEuTj9zW9lJ6xTfm/IGXXw90QeemGj3ZlC
         D8reoOYyQ5EWho6puiTBPyxW0GUDvJb10TWs0Z9FTSAsqFIIwA4RT4CmOWkJvUs+VTng
         E+/+p0EEF9DZgHnthWS13cvNwUzvolyDMUmgN5t/S7oTuboT/wuXVLEUpSerht3Wp1Jd
         hgeBhPDa4GkfpBHSfbzx4hTFmpbaiPpLwDae0+H8ld4Bnhe4EPSde+LO3W5fbNc5Qtwh
         AhfaXLnJgl5tkaYA7CwBUdd2tn9Rz+4lXEnaAIptwtm7PDNXIkr+sf8rvuQ7U9PYtrtY
         ELtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.14 29/41] irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis
Date: Mon, 19 Mar 2018 19:08:29 +0100
Message-Id: <20180319180734.138841577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391018593755377?=
X-GMAIL-MSGID: =?utf-8?q?1595391879501654589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

commit 4f2c7583e33eb08dc09dd2e25574b80175ba7d93 upstream.

When struct its_device instances are created, the nr_ites member
will be set to a power of 2 that equals or exceeds the requested
number of MSIs passed to the msi_prepare() callback. At the same
time, the LPI map is allocated to be some multiple of 32 in size,
where the allocated size may be less than the requested size
depending on whether a contiguous range of sufficient size is
available in the global LPI bitmap.

This may result in the situation where the nr_ites < nr_lpis, and
since nr_ites is what we program into the hardware when we map the
device, the additional LPIs will be non-functional.

For bog standard hardware, this does not really matter. However,
in cases where ITS device IDs are shared between different PCIe
devices, we may end up allocating these additional LPIs without
taking into account that they don't actually work.

So let's make nr_ites at least 32. This ensures that all allocated
LPIs are 'live', and that its_alloc_device_irq() will fail when
attempts are made to allocate MSIs beyond what was allocated in
the first place.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
[maz: updated comment]
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1310,7 +1310,7 @@ static struct irq_chip its_irq_chip = {
  * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
  */
 #define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 #define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static unsigned long *lpi_bitmap;
@@ -2026,11 +2026,10 @@ static struct its_device *its_create_dev
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	/*
-	 * At least one bit of EventID is being used, hence a minimum
-	 * of two entries. No, the architecture doesn't let you
-	 * express an ITT with a single entry.
+	 * We allocate at least one chunk worth of LPIs bet device,
+	 * and thus that many ITEs. The device may require less though.
 	 */
-	nr_ites = max(2UL, roundup_pow_of_two(nvecs));
+	nr_ites = max(IRQS_PER_CHUNK, roundup_pow_of_two(nvecs));
 	sz = nr_ites * its->ite_size;
 	sz = max(sz, ITS_ITT_ALIGN) + ITS_ITT_ALIGN - 1;
 	itt = kzalloc(sz, GFP_KERNEL);
