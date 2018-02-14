Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AH8x226ovfV5kXoWqwpSc9WAip/hmoqMCnG1mvK5lJ1BPVyK/rX5ht4S+uAqM8l4/VesHJPeQ4xE
ARC-Seal: i=1; a=rsa-sha256; t=1518568919; cv=none;
        d=google.com; s=arc-20160816;
        b=TOJSkBFx0zg05ICqsCUzIc0HedgC4Tzmmny2lORLw8xhPCtsm8j/PQcTh8aQmVTccu
         h9fRgBr2voi/7C0vY5Ur4Doc5iR+Om4hGKYlfhHFbJiziqlNp1C7siRboKKCNe3ZlbRm
         mABAGEEcoRDBVT9zzrwN7ceNlIU8TDiyGtGBrPPfT5CSNR/hqJhrPDcI6n49+Ug9YXe9
         TZg7G2DSi+AoYi0Fntg/SBNsTu2nO1GxPICSxkRn4kZCDldtYDSaLTo1sidMfvgLNTH5
         eMIAqG8pJytH5kGh7DpvXa32htSSLtbgomzxO3Ko8kdNl0+abnO1fRQMrCWavOHUqMGu
         axHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=FzJPY7Rs0tXogbffVGzuc1BTBpDdEUco86vHRvCahus=;
        b=jzLQar65XzcTq/q7E96f+1TGozt9ObT2rRj32WDeDpPXPI5vrxjNHFGigbAjfa1TF2
         o+pG3QybsmrTHh9nSDZq6sBlcC+xuoBFZcWTvomBdINIYw/EOSEo+y+FsXvo+El6KtQu
         quIEu4NzCgVAg4C5FTzpIUZ22QemgKL9BhpBnjtDYoSj0ZpPM73uFXyhq4rSf73G0t2e
         MuNTYXtX68Px6SfrAutqwFtfbQy0C3fEVm/yIVVE1XNAA/SDDQwzu5z4ownWydJ06dQZ
         eIGMWvmG7DVsY3TDzOVnDv3Emg+xiVcjv5G296Y1hJzCYWWL4HxsE/uEN47XMIoaohJj
         U0tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C7F217CA
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
Date: Tue, 13 Feb 2018 16:41:40 -0800
Message-Id: <20180214004148.14452-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180214004148.14452-1-mcgrof@kernel.org>
References: <20180214004148.14452-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592334923625330486?=
X-GMAIL-MSGID: =?utf-8?q?1592334923625330486?=
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
2.16.1
