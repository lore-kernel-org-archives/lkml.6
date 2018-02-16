Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932276AbeBPJny (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:43:54 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:21530 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932120AbeBPJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:43:52 -0500
X-IronPort-AV: E=Sophos;i="5.46,519,1511827200";
   d="scan'208";a="332212275"
From: Norbert Manthey <nmanthey@amazon.de>
To: <amd-gfx@lists.freedesktop.org>
CC: Norbert Manthey <nmanthey@amazon.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Harry Wentland <harry.wentland@amd.com>,
        Tony Cheng <tony.cheng@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
        "Aric Cyr" <Aric.Cyr@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Corbin McElhanney" <corbin.mcelhanney@amd.com>,
        Jordan Lazare <Jordan.Lazare@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: fix off-by-one in logger
Date: Fri, 16 Feb 2018 10:43:22 +0100
Message-ID: <1518774202-19750-1-git-send-email-nmanthey@amazon.de>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1G9hv7E002889

The current implementation will leak a byte to the log via memmove. The
specified 27 bytes are off-by-one, as the payload is 25 bytes, and the
termination character is only one byte large. To avoid this, factor out
the error message, and furthermore make the second parameter of the
append_entry function const.

Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")

The full trace is as follows:

In function ‘memmove’,
   from ‘append_entry’ at
        drivers/gpu/drm/amd/display/dc/basics/logger.c:257:2,
   from ‘dm_logger_append_va’ at
        drivers/gpu/drm/amd/display/dc/basics/logger.c:348:4
   detected read beyond size of object passed as 2nd parameter

Signed-off-by: Norbert Manthey <nmanthey@amazon.de>

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tony Cheng <tony.cheng@amd.com>
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Aric Cyr <Aric.Cyr@amd.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Corbin McElhanney <corbin.mcelhanney@amd.com>
Cc: Jordan Lazare <Jordan.Lazare@amd.com>
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
 drivers/gpu/drm/amd/display/dc/basics/logger.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/logger.c b/drivers/gpu/drm/amd/display/dc/basics/logger.c
index 180a9d6..958070c 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/logger.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/logger.c
@@ -243,7 +243,7 @@ static void log_heading(struct log_entry *entry)
 
 static void append_entry(
 		struct log_entry *entry,
-		char *buffer,
+		const char *buffer,
 		uint32_t buf_size)
 {
 	if (!entry->buf ||
@@ -345,7 +345,9 @@ void dm_logger_append_va(
 		if (size < LOG_MAX_LINE_SIZE - 1) {
 			append_entry(entry, buffer, size);
 		} else {
-			append_entry(entry, "LOG_ERROR, line too long\n", 27);
+			static const char msg[] = "LOG_ERROR, line too long\n";
+
+			append_entry(entry, msg, sizeof(msg));
 		}
 	}
 }
-- 
2.7.4

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
