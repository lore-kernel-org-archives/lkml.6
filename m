Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+od0DsMPgz7hSDanrIoMeKRwnsI9PYA5VmwnNFqoycFCStfR/vnpx2RNWBuAt4oKGso4Pf
ARC-Seal: i=1; a=rsa-sha256; t=1523399751; cv=none;
        d=google.com; s=arc-20160816;
        b=zO3mRqmxbFtA7R8Wppj+ot23guvsQ9waQyDLW5mnmY+katiyGwU23aF5BBalnBH/I8
         B8wY1q3ZEjNgiTHC8CeifvIjop5mbIviHsEAkebGGUt1kiFwIizr4UG44ejjs9u9HUNj
         hkMuJIlI8q3yF+w0fuFGXyz5kUS/k5s/dTwq7IDe4lRu5KOwaY6w+e0P5RSXDyOLLnDd
         fd8cILpKfndG6CVzPv7qTT9UBdoKeGyVtuv7Mi4G72JGJHERc4wR7GhLCmFAOTE+zDTV
         h/1EvFdQ0iQhZtRypKCL9Cyr5rfiT0fAAjmPrPu7VUCfxAroWlf/iDUtlLVE8Dnohyw5
         rh+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Sk57AJKNQGqUkzdBCA94XFlJHFvyZ7xI+x3Io7LoAU=;
        b=wYMsHX0ReEMAE0jN0kSjIWrwVzEvdl1o5lwoablP7IxirqN2XXkhaRWfeSHcmfCvhL
         iEX6zhRBuepcK5l0wx+VOLFxrzMN+iL6UzNAVjtU/XzO9SgfnRBG3Gh4itFcenvQ5tWB
         h/fMxh1Iw9QpVmTq1WeScrIN0ItutPwW4rXUzO50FN3oPnSrANnPaL/nQViz2MHQjDy0
         qxA8URvMiWmrZxQI6Y1Gq2yVliprA3vHYvxdLqJgmMXaYRds/z1wjreDHLt3WrajpdWg
         tltncdNFPFS3PlNXpfzg+iry2CaP+DSa+VJAxmICc3urp8Ht1InNumxq4x9D2kpk9jmu
         Whqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 033/138] ACPI: EC: Fix debugfs_create_*() usage
Date: Wed, 11 Apr 2018 00:23:43 +0200
Message-Id: <20180410212905.947917290@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399902846957647?=
X-GMAIL-MSGID: =?utf-8?q?1597400417427396946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit 3522f867c13b63cf62acdf1b8ca5664c549a716a ]

acpi_ec.gpe is "unsigned long", hence treating it as "u32" would expose
the wrong half on big-endian 64-bit systems.  Fix this by changing its
type to "u32" and removing the cast, as all other code already uses u32
or sometimes even only u8.

Fixes: 1195a098168fcacf (ACPI: Provide /sys/kernel/debug/ec/...)
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/ec.c       |    2 +-
 drivers/acpi/ec_sys.c   |    2 +-
 drivers/acpi/internal.h |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1516,7 +1516,7 @@ static int acpi_ec_setup(struct acpi_ec
 	}
 
 	acpi_handle_info(ec->handle,
-			 "GPE=0x%lx, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
+			 "GPE=0x%x, EC_CMD/EC_SC=0x%lx, EC_DATA=0x%lx\n",
 			 ec->gpe, ec->command_addr, ec->data_addr);
 	return ret;
 }
--- a/drivers/acpi/ec_sys.c
+++ b/drivers/acpi/ec_sys.c
@@ -128,7 +128,7 @@ static int acpi_ec_add_debugfs(struct ac
 		return -ENOMEM;
 	}
 
-	if (!debugfs_create_x32("gpe", 0444, dev_dir, (u32 *)&first_ec->gpe))
+	if (!debugfs_create_x32("gpe", 0444, dev_dir, &first_ec->gpe))
 		goto error;
 	if (!debugfs_create_bool("use_global_lock", 0444, dev_dir,
 				 &first_ec->global_lock))
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -159,7 +159,7 @@ static inline void acpi_early_processor_
    -------------------------------------------------------------------------- */
 struct acpi_ec {
 	acpi_handle handle;
-	unsigned long gpe;
+	u32 gpe;
 	unsigned long command_addr;
 	unsigned long data_addr;
 	bool global_lock;
