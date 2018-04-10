Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+M2IgizWSdBHGiXPLfVzL7QXcnd404/KLsJt4CafRCh3stOhTAokgBScQ5TNElM/h8jg8V
ARC-Seal: i=1; a=rsa-sha256; t=1523399260; cv=none;
        d=google.com; s=arc-20160816;
        b=bByeTr0Sf4AfvsnSKopwClYM8ICSuxLYzA7Jum43WksAX25AjOtXdyXNCqFgaV4Uti
         XnOTA6EPdZZLTPrQv7m6klUGRPiJ1smNGeor0pzus+Tn/6OJrh5HinZXEHkZs6GA9L0p
         weIJeWDHBX3oxnbPNkOIuQMYDg4FxLss7lU2hrUOa1ABZ7xckz7mmzcs4c8WCSm8wSt1
         aOvSOqZ37Q4vrY+rgNSdqm6MED0OdZ8DUK9cJCDqhW1x0gJWaXHkYfRvhNskLbGmtQSx
         mF33L8XqIqjL/kq7qVlM1fZ9Oj+3Vp/G6NeX014zvCRsA8h0eeylvl1obw3dN936lYvA
         v5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AnSVY4HFky6kt5GtXJdX6YPLCwvA+30iik69LXg9NZM=;
        b=hECECjvMjLk4QQs4/xKcy9x4/qu67OM991uE+6yD6PC3O+Rin8HlhNazAN/HpqyCC/
         mkRgjD1PAk1CsgDY6PSb2pai7R8Fs6Vuhj5MnsZLOPuwK1ekYSersJL9aIS01p1W59J+
         7ik3rBWu3D894oKfxGGTOcDUMHh4O9ou9o8LMlW88rxsV5SvCVzKzgTlqMqhNJIjFD02
         xdARSTPRsgF0ddOEvS3zIYnWN/Az3NfaKZ6RLCIbmWeAa3zDa3rcjdUYSKOanofXwuNH
         VubYF0KcI2YN7d1EqeQJ0gs0akDtslWD8DoOLFemYb6HaT7/TCRpzGx1Ko4kQLLiy4g5
         PuSQ==
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
Subject: [PATCH 4.15 044/168] ACPI: EC: Fix debugfs_create_*() usage
Date: Wed, 11 Apr 2018 00:23:06 +0200
Message-Id: <20180410212802.078100959@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399902846957647?=
X-GMAIL-MSGID: =?utf-8?q?1597399902846957647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
