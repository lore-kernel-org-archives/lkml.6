Return-Path: <mcgrof@kernel.org>
X-Google-Smtp-Source: AG47ELufSuuVnRdPy6Ljgkj8WwajkTXdiageEAfKBb24BqDpJC4Y2ulJfNyqIWyxxGuqhd+Pkkjs
ARC-Seal: i=1; a=rsa-sha256; t=1520691318; cv=none;
        d=google.com; s=arc-20160816;
        b=XFJlFf87dJkWwHtIZe9S43ge0QSiXz9GAeRigwtq+FNk6eK4UvAflr2StIrXUgggfm
         M4Ih+pu9BFQG1yIKPwneIKXEPYbgIKx+owhZ+W11CfuCHoL5D1h83HtJRt7AjBD3EtEh
         LBkwrJ56TBE8dxwlFZkFI3v3nOch8xT++ht+ql/buXqgl0oDZ7z7sUHifQ/FuWYqH4bM
         K9+y6zf0V/0Q4lNxrfiTlfdGLfBsq4bV0ysuxekiLANeu3ZqVFTbxQLX6v42t4pvl83I
         5a11YdI59PLOaSTPfi0wJZESMKaq5SIDkhQKMwWk7yNuzKu+C0HSTgfJtIUGWFg8dAM1
         xuJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dmarc-filter:arc-authentication-results;
        bh=B6/oJg/hA0NPXRqP9gnM4Ltvx76C4Zm7as8g1lDSodY=;
        b=JwWZ95P8t04ZpoMdiz6TNy8TcG7vEO3Og2UBifn2Qrmo15gmy+GV+m7EZl94/zkZG5
         s89CfBavB+OjzjPFTLwAwKL8L2BoArtdDJPiIWWP8Dh+Z+Tw2Ps6rA5KN7D5DPSkgwMP
         EGIPUG95m6p6D5btnjxLDattV9m5NVx6XtNipEh8qePhak3eiNWvvd7RRtVvC4hi4mQg
         a5xtoLHEDzs39bMuSW1oHL4eynUk52xiC6GZydwM4M+byreedob/OnMqR0HAOo7k4vGp
         PfwwJ2skfbU0fZM1/2aUY+hhPPoCMr88u2kdkCoubQGTC8crheUX9K6yxwFNpWbomCv2
         /SNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mcgrof@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=mcgrof@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9306A217A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mcgrof@kernel.org
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	cantabile.desu@gmail.com,
	kubakici@wp.pl,
	linux-wireless@vger.kernel.org,
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
	broonie@kernel.org,
	dmitry.torokhov@gmail.com,
	dwmw2@infradead.org,
	torvalds@linux-foundation.org,
	Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com,
	oneukum@suse.com,
	ast@fb.com,
	andresx7@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v3 04/20] firmware: enable to split firmware_class into separate target files
Date: Sat, 10 Mar 2018 06:14:45 -0800
Message-Id: <20180310141501.2214-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.13.2
In-Reply-To: <20180310141501.2214-1-mcgrof@kernel.org>
References: <20180310141501.2214-1-mcgrof@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560420523608987?=
X-GMAIL-MSGID: =?utf-8?q?1594560420523608987?=
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
