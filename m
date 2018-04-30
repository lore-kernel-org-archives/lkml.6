Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqXk6o1zSa1AcVdycYhUoFc8zfJqDxaIMzdhhQvU0jBDKE0WSYjSQvUVExTCTtxBtkwxznI
ARC-Seal: i=1; a=rsa-sha256; t=1525116433; cv=none;
        d=google.com; s=arc-20160816;
        b=u7fy0eejYDFPqVwNM1MuFLPbgW5w58jAzXkUN3GqTeI9e2rPMc7nlX+B+Xpg/55QH6
         v9PZLlnJCwaCeoXmsWgp2NUXuuIDUVIQdj7g3UfkuqrE1wev7uuODqbRebK0VxTULoG+
         tEoVHomqhyKR1h31Fj6xPydN7N87nPzNov0jkhhfqldYlrZAdQ7U4Qa24ifPC3UYk74T
         ls7vLU0jAEmKVevyZRIiQ+DT8l7RuntLdKcESge4Kqb5RdL5/qCO0re8eETPlZwwq/7K
         6LZoG7OLY6x9HDrg5ZyS0ML2tJGbOpLW/Nocw2V3K+bkq9EKQjqLPQmb8thof11qM+FO
         WzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=+H4B1hVk29OhuNyMYAaMBlF6iliilSrI3KpPK5orw8U=;
        b=RReOqQR65dchIPykAF0smp3KmQ13pDAuNeoiFvz932lqOZuv5KxlLG/Wz7NRlSM4lJ
         AbOt3qBD5RQeheymC24dZ3a55sk1wwp4bVGNKNt2DBLrdiVI3GScRgXY0MnElkSqovn1
         dNog45bFnNPNw3ikB0WtWN0NgsKDAycVVAGsG9VHx2U/EVB7Sc4DVtD4UWVP0gMp2Q5w
         d14mWkA8tAzylxqF25AVdpym7Kqb0WERmg+EviPkD7XFPWCbLQxuQNN+qHaacN0Z+kcE
         kpAGYlLogDfKIJEauV3HDsbYD3rfP48xlzU/IxwhhrvMHJyj4kKfBcx9jR7Dnwn8VSw/
         g5VA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CC522DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 38/91] ALSA: asihpi: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:20 -0700
Message-Id: <20180430184006.150619209@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200441146295899?=
X-GMAIL-MSGID: =?utf-8?q?1599200489115798894?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit f9d94b57e30fd1575b4935045b32d738668aa74b upstream.

As recently Smatch suggested, a couple of places in ASIHPI driver may
expand the array directly from the user-space value with speculation:
  sound/pci/asihpi/hpimsginit.c:70 hpi_init_response() warn: potential spectre issue 'res_size' (local cap)
  sound/pci/asihpi/hpioctl.c:189 asihpi_hpi_ioctl() warn: potential spectre issue 'adapters'

This patch puts array_index_nospec() for hardening against them.

BugLink: https://marc.info/?l=linux-kernel&m=152411496503418&w=2
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/asihpi/hpimsginit.c |   13 +++++++++----
 sound/pci/asihpi/hpioctl.c    |    4 +++-
 2 files changed, 12 insertions(+), 5 deletions(-)

--- a/sound/pci/asihpi/hpimsginit.c
+++ b/sound/pci/asihpi/hpimsginit.c
@@ -23,6 +23,7 @@
 
 #include "hpi_internal.h"
 #include "hpimsginit.h"
+#include <linux/nospec.h>
 
 /* The actual message size for each object type */
 static u16 msg_size[HPI_OBJ_MAXINDEX + 1] = HPI_MESSAGE_SIZE_BY_OBJECT;
@@ -39,10 +40,12 @@ static void hpi_init_message(struct hpi_
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = msg_size[object];
-	else
+	} else {
 		size = sizeof(*phm);
+	}
 
 	memset(phm, 0, size);
 	phm->size = size;
@@ -66,10 +69,12 @@ void hpi_init_response(struct hpi_respon
 {
 	u16 size;
 
-	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX))
+	if ((object > 0) && (object <= HPI_OBJ_MAXINDEX)) {
+		object = array_index_nospec(object, HPI_OBJ_MAXINDEX + 1);
 		size = res_size[object];
-	else
+	} else {
 		size = sizeof(*phr);
+	}
 
 	memset(phr, 0, sizeof(*phr));
 	phr->size = size;
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -33,6 +33,7 @@
 #include <linux/stringify.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/nospec.h>
 
 #ifdef MODULE_FIRMWARE
 MODULE_FIRMWARE("asihpi/dsp5000.bin");
@@ -186,7 +187,8 @@ long asihpi_hpi_ioctl(struct file *file,
 		struct hpi_adapter *pa = NULL;
 
 		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
-			pa = &adapters[hm->h.adapter_index];
+			pa = &adapters[array_index_nospec(hm->h.adapter_index,
+							  ARRAY_SIZE(adapters))];
 
 		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,
