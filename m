Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x224M+YagH+sbsijSvJcKiAZBUJwSWRjZ8F//WmO8UFZUz5JbZUwtBJrEHXSZxxYv4vMVDWlq
ARC-Seal: i=1; a=rsa-sha256; t=1519440379; cv=none;
        d=google.com; s=arc-20160816;
        b=I7UAFfKeQn++KvbQNvtMR2nBCQVb13uMJJTpM24slCxvVIADfXKOkYXQu4tE+lerEJ
         aA31rZrv7hDL3efJeK7xr8iBOrVO18X5wOQPxzuWA99FY4ZG1pVi7oxtDvfwMie2dMiY
         KPyKQ+EE0Wjp8TOEKUf5v8QRufgOJAg+qv/Q7wiLASUhPt6c56fZewTmIFnUe3TevYxp
         Wd90rK2t2ZcYxFa2y0eR8pUCHXV4WUiP6rn2VK2prA8MB/bQnQJGpuNW6zaI9q3JX+8M
         ynBswJdFMIGEPvmRSIUXx0QUCQ70uhv3UzN1xewuV8fxnblwLi3EpXAiLEkK+Nc86df6
         loJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=B6/oJg/hA0NPXRqP9gnM4Ltvx76C4Zm7as8g1lDSodY=;
        b=Nq0HXDa75mdxxjASxP5qPzo484GhRKe4CcPGoZ3cV1pGtPBlHJWsynLboHyyZ/DqQh
         rrDkN0kC7E0hQl8dM6zblfB+CnuWXju9Z5LqVl1Zd8rfY6wQ/E869tfupuNnjgVy3NHJ
         KVMnDVX0t6dFPYRsYcotmr1po8BoHYy38eLwf19w3vg0r3yfAzQdcQlqADspzjbszb4h
         +IKfaKKzi0/bBRloP6WTQczHdhFUpdmI0JpWuFzfJYD0GXGTpszRyNMzQ7FmCAuPcXh+
         ia+1YxqWhqZncyCnQX4K6Rm31gTSvXzBkFxcocf3SqYiFe7F62qNVM8fhcyRAIlti+RC
         droA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9907A217BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	keescook@chromium.org,
	shuah@kernel.org,
	mfuzzey@parkeon.com,
	zohar@linux.vnet.ibm.com,
	dhowells@redhat.com,
	pali.rohar@gmail.com,
	tiwai@suse.de,
	arend.vanspriel@broadcom.com,
	zajec5@gmail.com,
	nbroeking@me.com,
	markivx@codeaurora.org,
	stephen.boyd@linaro.org,
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2 03/11] firmware: enable to split firmware_class into separate target files
Date: Fri, 23 Feb 2018 18:46:05 -0800
Message-Id: <20180224024613.24078-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180224024613.24078-1-mcgrof@kernel.org>
References: <20180224024613.24078-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593248715380192069?=
X-GMAIL-MSGID: =?utf-8?q?1593248715380192069?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The firmware loader code has grown quite a bit over the years.
The practice of stuffing everything we need into one file makes
the code hard to follow.

In order to split the firmware loader code into different components
we must pick a module name and a first object target file. We must
keep the firmware_class name to remain compatible with scripts which
have been relying on the sysfs loader path for years, so the old module
name stays. We can however rename the C file without affecting the
module name.

The firmware_class used to represent the idea that the code was a simple
sysfs firmware loader, provided by the struct class firmware_class.
The sysfs firmware loader used to be the default, today its only the
fallback mechanism.

This only renames the target code then to make emphasis of what the code
does these days. With this change new features can also use a new object
files.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/base/Makefile                                | 1 +
 drivers/base/{firmware_class.c => firmware_loader.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/base/{firmware_class.c => firmware_loader.c} (100%)

diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index e32a52490051..f261143fafbf 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_HAS_DMA)	+= dma-mapping.o
 obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += dma-coherent.o
 obj-$(CONFIG_ISA_BUS_API)	+= isa.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
+firmware_class-objs := firmware_loader.o
 obj-$(CONFIG_NUMA)	+= node.o
 obj-$(CONFIG_MEMORY_HOTPLUG_SPARSE) += memory.o
 ifeq ($(CONFIG_SYSFS),y)
diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_loader.c
similarity index 100%
rename from drivers/base/firmware_class.c
rename to drivers/base/firmware_loader.c
-- 
2.16.2
