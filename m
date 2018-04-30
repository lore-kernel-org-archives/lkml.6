Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrTepJ++5wOMHDH3mzBjWcFVDc0WscgwkzJifAPatmixrafwX/BVV1k/dFk/UDFcnjuGjx4
ARC-Seal: i=1; a=rsa-sha256; t=1525116457; cv=none;
        d=google.com; s=arc-20160816;
        b=dKnZ8T4333WFwBexs1r3ybvZAXJPUCQHu11PArTD0uy4ElVuBDoa/k+bM1CqYUUaqV
         K1SiI2wth5SxidEgWEQYGSU2VGzOAXWS5OoP23qnKNfBkZlV3TBw1CKVV3nTxLUvHkA1
         rwZeD1WuO2jCBQ3jaQoFs9FVTPWfrLQeHIPmZSFIrhFMAyjIdQlJXjE20cT9rUi3FBEX
         dE3HSm1My8tYLufAd+w7Pxd0q7wMWxaclePqu6xH7HgHyYEvd4f64xkVDHqq/qN5ZkD5
         HCf/CUVyYiyKxAtTgQmBqrgn39hgOIbDcuaunvKy4xQNrbt/cW0ZppZcmB1+dSCmr9z7
         lO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=M9SZJkrjY796x9wx/7E4xJdUe5LI1dyep7y6FBTyGbM=;
        b=qyNHUd7Q17fWBjzcjPg2ZNffMFuwO4NUrh/l7W2dnRNUDCZNWwrI6ebHifMpkQw11R
         HKWuqDMnOFdhcug49xdMPQziAx6WfhgzRXqpd6C68jCl6R0C/WTWKp8DvXRsI9G9TSPL
         L636raQZmRr/hPc3dnK3qr/BqQkqw9X3rLCW+ZnE28LtvAzbrgz8un/UAURbPvCkkXkr
         VI+bqkSHtViYLrLTgvGsVOpkJTmd7H9FOpXEwPYB/V7t+90Qx5xN2TdUdBuC2QnuuVJ1
         0YabAx0FdFAd9Ow9pbrEow2/pz4ZhLZAqyeH6KB9xsi5/eWHkFy452YMz/0DuAZI5CdV
         typQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CF922E02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Kurtz <djkurtz@chromium.org>,
	Aaron Durbin <adurbin@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 4.14 77/91] earlycon: Use a pointer table to fix __earlycon_table stride
Date: Mon, 30 Apr 2018 12:24:59 -0700
Message-Id: <20180430184008.308714534@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200457375038545?=
X-GMAIL-MSGID: =?utf-8?q?1599200514832295093?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Kurtz <djkurtz@chromium.org>

commit dd709e72cb934eefd44de8d9969097173fbf45dc upstream.

Commit 99492c39f39f ("earlycon: Fix __earlycon_table stride") tried to fix
__earlycon_table stride by forcing the earlycon_id struct alignment to 32
and asking the linker to 32-byte align the __earlycon_table symbol.  This
fix was based on commit 07fca0e57fca92 ("tracing: Properly align linker
defined symbols") which tried a similar fix for the tracing subsystem.

However, this fix doesn't quite work because there is no guarantee that
gcc will place structures packed into an array format.  In fact, gcc 4.9
chooses to 64-byte align these structs by inserting additional padding
between the entries because it has no clue that they are supposed to be in
an array.  If we are unlucky, the linker will assign symbol
"__earlycon_table" to a 32-byte aligned address which does not correspond
to the 64-byte aligned contents of section "__earlycon_table".

To address this same problem, the fix to the tracing system was
subsequently re-implemented using a more robust table of pointers approach
by commits:
 3d56e331b653 ("tracing: Replace syscall_meta_data struct array with pointer array")
 654986462939 ("tracepoints: Fix section alignment using pointer array")
 e4a9ea5ee7c8 ("tracing: Replace trace_event struct array with pointer array")

Let's use this same "array of pointers to structs" approach for
EARLYCON_TABLE.

Fixes: 99492c39f39f ("earlycon: Fix __earlycon_table stride")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
Suggested-by: Aaron Durbin <adurbin@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Guenter Roeck <groeck@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/of/fdt.c                  |    7 +++++--
 drivers/tty/serial/earlycon.c     |    6 ++++--
 include/asm-generic/vmlinux.lds.h |    2 +-
 include/linux/serial_core.h       |   21 ++++++++++++++-------
 4 files changed, 24 insertions(+), 12 deletions(-)

--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -975,7 +975,7 @@ int __init early_init_dt_scan_chosen_std
 	int offset;
 	const char *p, *q, *options = NULL;
 	int l;
-	const struct earlycon_id *match;
+	const struct earlycon_id **p_match;
 	const void *fdt = initial_boot_params;
 
 	offset = fdt_path_offset(fdt, "/chosen");
@@ -1002,7 +1002,10 @@ int __init early_init_dt_scan_chosen_std
 		return 0;
 	}
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
+	     p_match++) {
+		const struct earlycon_id *match = *p_match;
+
 		if (!match->compatible[0])
 			continue;
 
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -172,7 +172,7 @@ static int __init register_earlycon(char
  */
 int __init setup_earlycon(char *buf)
 {
-	const struct earlycon_id *match;
+	const struct earlycon_id **p_match;
 
 	if (!buf || !buf[0])
 		return -EINVAL;
@@ -180,7 +180,9 @@ int __init setup_earlycon(char *buf)
 	if (early_con.flags & CON_ENABLED)
 		return -EALREADY;
 
-	for (match = __earlycon_table; match < __earlycon_table_end; match++) {
+	for (p_match = __earlycon_table; p_match < __earlycon_table_end;
+	     p_match++) {
+		const struct earlycon_id *match = *p_match;
 		size_t len = strlen(match->name);
 
 		if (strncmp(buf, match->name, len))
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -170,7 +170,7 @@
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
-#define EARLYCON_TABLE() STRUCT_ALIGN();			\
+#define EARLYCON_TABLE() . = ALIGN(8);				\
 			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
 			 KEEP(*(__earlycon_table))		\
 			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -351,10 +351,10 @@ struct earlycon_id {
 	char	name[16];
 	char	compatible[128];
 	int	(*setup)(struct earlycon_device *, const char *options);
-} __aligned(32);
+};
 
-extern const struct earlycon_id __earlycon_table[];
-extern const struct earlycon_id __earlycon_table_end[];
+extern const struct earlycon_id *__earlycon_table[];
+extern const struct earlycon_id *__earlycon_table_end[];
 
 #if defined(CONFIG_SERIAL_EARLYCON) && !defined(MODULE)
 #define EARLYCON_USED_OR_UNUSED	__used
@@ -362,12 +362,19 @@ extern const struct earlycon_id __earlyc
 #define EARLYCON_USED_OR_UNUSED	__maybe_unused
 #endif
 
-#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
-	static const struct earlycon_id __UNIQUE_ID(__earlycon_##_name)	\
-	     EARLYCON_USED_OR_UNUSED __section(__earlycon_table)	\
+#define _OF_EARLYCON_DECLARE(_name, compat, fn, unique_id)		\
+	static const struct earlycon_id unique_id			\
+	     EARLYCON_USED_OR_UNUSED __initconst			\
 		= { .name = __stringify(_name),				\
 		    .compatible = compat,				\
-		    .setup = fn  }
+		    .setup = fn  };					\
+	static const struct earlycon_id EARLYCON_USED_OR_UNUSED		\
+		__section(__earlycon_table)				\
+		* const __PASTE(__p, unique_id) = &unique_id
+
+#define OF_EARLYCON_DECLARE(_name, compat, fn)				\
+	_OF_EARLYCON_DECLARE(_name, compat, fn,				\
+			     __UNIQUE_ID(__earlycon_##_name))
 
 #define EARLYCON_DECLARE(_name, fn)	OF_EARLYCON_DECLARE(_name, "", fn)
 
