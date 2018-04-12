Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDLQBk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:01:40 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33005 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751870AbeDLQBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:01:36 -0400
X-Google-Smtp-Source: AIpwx4/jv4RBKrnikBzd+PErEvkPZ0D7mZtqrEKH7lwDsFdl6WeSCDmAkd2CYL5MpWzLlyzGdhDJ2Q==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
X-Google-Original-From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
To: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc: boris.ostrovsky@oracle.com, jgross@suse.com,
        iurii.konovalenko@globallogic.com,
        oleksandr.dmytryshyn@globallogic.com, konrad.wilk@oracle.com,
        tiwai@suse.de, andr2000@gmail.com
Subject: [PATCH 5/5] xen/sndif: Add explicit back and front parameter negotiation
Date: Thu, 12 Apr 2018 19:01:02 +0300
Message-Id: <20180412160102.15833-6-oleksandr_andrushchenko@epam.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to provide explicit stream parameter negotiation between
backend and frontend the following changes are introduced in the protocol:
add XENSND_OP_HW_PARAM_QUERY request to read/update
configuration space for the parameters given: request passes
desired parameter's intervals/masks and the response to this request
returns allowed min/max intervals/masks to be used.

Parameters supported by this request/response:
 - format mask
 - sample rate interval
 - number of channels interval
 - buffer size, interval, frames
 - period size, interval, frames

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Takashi Iwai <tiwai@suse.de>
---
 include/xen/interface/io/sndif.h | 133 +++++++++++++++++++++++++++++--
 1 file changed, 126 insertions(+), 7 deletions(-)

diff --git a/include/xen/interface/io/sndif.h b/include/xen/interface/io/sndif.h
index 131c3b469d4a..78bb5d9f8d83 100644
--- a/include/xen/interface/io/sndif.h
+++ b/include/xen/interface/io/sndif.h
@@ -465,6 +465,7 @@
 #define XENSND_OP_MUTE			6
 #define XENSND_OP_UNMUTE		7
 #define XENSND_OP_TRIGGER		8
+#define XENSND_OP_HW_PARAM_QUERY	9
 
 #define XENSND_OP_TRIGGER_START		0
 #define XENSND_OP_TRIGGER_PAUSE		1
@@ -832,28 +833,142 @@ struct xensnd_trigger_req {
 };
 
 /*
- *---------------------------------- Responses --------------------------------
+ * Request stream parameter ranges: request intervals and
+ *   masks of supported ranges for stream configuration values.
  *
- * All response packets have the same length (64 octets)
+ *   Sound device configuration for a particular stream is a limited subset
+ *   of the multidimensional configuration available on XenStore, e.g.
+ *   once the frame rate has been selected there is a limited supported range
+ *   for sample rates becomes available (which might be the same set configured
+ *   on XenStore or less). For example, selecting 96kHz sample rate may limit
+ *   number of channels available for such configuration from 4 to 2, etc.
+ *   Thus, each call to XENSND_OP_HW_PARAM_QUERY may reduce configuration
+ *   space making it possible to iteratively get the final stream configuration,
+ *   used in XENSND_OP_OPEN request.
+ *
+ *   See response format for this request.
  *
- * Response for all requests:
  *         0                1                 2               3        octet
  * +----------------+----------------+----------------+----------------+
- * |               id                |    operation   |    reserved    | 4
+ * |               id                | _HW_PARAM_QUERY|    reserved    | 4
  * +----------------+----------------+----------------+----------------+
- * |                              status                               | 8
+ * |                             reserved                              | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                     formats mask low 32-bit                       | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                     formats mask high 32-bit                      | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                              min rate                             | 20
+ * +----------------+----------------+----------------+----------------+
+ * |                              max rate                             | 24
+ * +----------------+----------------+----------------+----------------+
+ * |                            min channels                           | 28
+ * +----------------+----------------+----------------+----------------+
+ * |                            max channels                           | 32
+ * +----------------+----------------+----------------+----------------+
+ * |                         min buffer frames                         | 36
+ * +----------------+----------------+----------------+----------------+
+ * |                         max buffer frames                         | 40
+ * +----------------+----------------+----------------+----------------+
+ * |                         min period frames                         | 44
+ * +----------------+----------------+----------------+----------------+
+ * |                         max period frames                         | 48
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 12
+ * |                             reserved                              | 52
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
  * |                             reserved                              | 64
  * +----------------+----------------+----------------+----------------+
  *
+ * formats - uint64_t, bit mask representing values of the parameter
+ *     made as bitwise OR of (1 << XENSND_PCM_FORMAT_XXX) values
+ *
+ * For interval parameters:
+ *   min - uint32_t, minimum value of the parameter
+ *   max - uint32_t, maximum value of the parameter
+ *
+ * Frame is defined as a product of the number of channels by the
+ * number of octets per one sample.
+ */
+
+struct xensnd_query_hw_param {
+	uint64_t formats;
+	struct {
+		uint32_t min;
+		uint32_t max;
+	} rates;
+	struct {
+		uint32_t min;
+		uint32_t max;
+	} channels;
+	struct {
+		uint32_t min;
+		uint32_t max;
+	} buffer;
+	struct {
+		uint32_t min;
+		uint32_t max;
+	} period;
+};
+
+/*
+ *---------------------------------- Responses --------------------------------
+ *
+ * All response packets have the same length (64 octets)
+ *
+ * All response packets have common header:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |    operation   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              status                               | 8
+ * +----------------+----------------+----------------+----------------+
+ *
  * id - uint16_t, copied from the request
  * operation - uint8_t, XENSND_OP_* - copied from request
  * status - int32_t, response status, zero on success and -XEN_EXX on failure
  *
+ *
+ * HW parameter query response - response for XENSND_OP_HW_PARAM_QUERY:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |    operation   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              status                               | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                     formats mask low 32-bit                       | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                     formats mask high 32-bit                      | 16
+ * +----------------+----------------+----------------+----------------+
+ * |                              min rate                             | 20
+ * +----------------+----------------+----------------+----------------+
+ * |                              max rate                             | 24
+ * +----------------+----------------+----------------+----------------+
+ * |                            min channels                           | 28
+ * +----------------+----------------+----------------+----------------+
+ * |                            max channels                           | 32
+ * +----------------+----------------+----------------+----------------+
+ * |                         min buffer frames                         | 36
+ * +----------------+----------------+----------------+----------------+
+ * |                         max buffer frames                         | 40
+ * +----------------+----------------+----------------+----------------+
+ * |                         min period frames                         | 44
+ * +----------------+----------------+----------------+----------------+
+ * |                         max period frames                         | 48
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 52
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 64
+ * +----------------+----------------+----------------+----------------+
+ *
+ * Meaning of the values in this response is the same as for
+ * XENSND_OP_HW_PARAM_QUERY request.
+ */
+
+/*
  *----------------------------------- Events ----------------------------------
  *
  * Events are sent via shared page allocated by the front and propagated by
@@ -906,6 +1021,7 @@ struct xensnd_req {
 		struct xensnd_open_req open;
 		struct xensnd_rw_req rw;
 		struct xensnd_trigger_req trigger;
+		struct xensnd_query_hw_param hw_param;
 		uint8_t reserved[56];
 	} op;
 };
@@ -915,7 +1031,10 @@ struct xensnd_resp {
 	uint8_t operation;
 	uint8_t reserved;
 	int32_t status;
-	uint8_t reserved1[56];
+	union {
+		struct xensnd_query_hw_param hw_param;
+		uint8_t reserved1[56];
+	} resp;
 };
 
 struct xensnd_evt {
-- 
2.17.0
