Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtgFa30np5prTRRG9Bl+hrLWT/N8UxLPxnREX7xy83V3e8/cCWx+NAElE0hBm3+avJdK2Zy
ARC-Seal: i=1; a=rsa-sha256; t=1521483439; cv=none;
        d=google.com; s=arc-20160816;
        b=o3a2rbi8DNxw+4txVIxfmKDAePQr7iFFxdbjqAqHZUjMIFWGBxfsXwupZoHxLHIesM
         IajlO6kwAlybmEoIAJUNLfcRbFdUh05ursu4XUNRYON7lQLeznVWjcwx8Jky62sTL098
         RloXHQpHhoD1cNXmJml73wFH/LLsRwop7bYz3mDPV8M9Oglxhwm8lICBvBLKkMIQYw5+
         Ymo0Ui7DpI24nQ1YDbQ++RqRwrWgFHq+JwGgx+qMnm8KEz3rlWfbij2Mp1/fL14HNzby
         lJ9Dy0vlQNsrx0+abUs57gJJp1NNP4BZUrdxWV/dSJpOySU+jxrCJGjeAcGwqNXV1OSk
         QYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Kb7dvoYRhthGdirEQVoHI3BITRqnlMeBy6o4RAeqDMo=;
        b=POky78I5WduMADRnjUX+3z4D5+XLhYLXcvyS2Okj5gVoILnYT5T3VJ5NyVbk2wOplr
         55JAwDU+eaJywWsM/B+53Mk7L9poZfF9A6vwEF+GA0eEKZRvZF1UpfyFvx5oZlBk5vGq
         SKmw2R1NzhWzLH4mbXsnxfvSvljyrtzpjsnsy63IIh3XA4UZTfctD6NIWnNci0TBlBa9
         bW5BiXr2SF8iWTNWd27sFF5oItYHKZa/wTjQTKLFpYCAnByq2f6/E8ijfmy6KMB3Y5mn
         qD/xV5O75WTGDOtVtlRA3TLiBCF2UdFr+eSHjSr9/4c5+5sOmNwJOX8sr7CpEKCiX6Zd
         vh4g==
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
Subject: [PATCH 4.4 125/134] irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis
Date: Mon, 19 Mar 2018 19:06:48 +0100
Message-Id: <20180319171907.316294556@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391018593755377?=
X-GMAIL-MSGID: =?utf-8?q?1595391018593755377?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[ardb: trivial tweak of unrelated context]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/irqchip/irq-gic-v3-its.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -663,7 +663,7 @@ static struct irq_chip its_irq_chip = {
  * This gives us (((1UL << id_bits) - 8192) >> 5) possible allocations.
  */
 #define IRQS_PER_CHUNK_SHIFT	5
-#define IRQS_PER_CHUNK		(1 << IRQS_PER_CHUNK_SHIFT)
+#define IRQS_PER_CHUNK		(1UL << IRQS_PER_CHUNK_SHIFT)
 
 static unsigned long *lpi_bitmap;
 static u32 lpi_chunks;
@@ -1168,11 +1168,10 @@ static struct its_device *its_create_dev
 
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
