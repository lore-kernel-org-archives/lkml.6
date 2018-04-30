Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp44SBaAxoZXLf29sgA5EWczqVlGKHBSFY5Aunqaw9VLvkyEFZ3pJk0BWeMAPqN5iYTLyH8
ARC-Seal: i=1; a=rsa-sha256; t=1525116369; cv=none;
        d=google.com; s=arc-20160816;
        b=c9sbMqdf0zT2Hr8A8SDg6hz3RMyJdN8o39TYTjkwvba4gyTKzrRjQ8NaOnlQER/Rtt
         /MnYVQ1539nkUbOV67kzzYEdH2FLx4pEj4DHRzYAag166pMa2AVo7reilT1AljYTUxb1
         enacnE0V2qBSbDVSAiokmKxZR5PJcANrkoO0ENNCMetOweWji8P62pMiL8puoQucmUcc
         6F+kQEOFsMWbD2ubW1z85WJSqrOyiew8n9FUWp9+v0+p4fxcfkj/cVnk9Se2yd4IXoBl
         58EiT3SE+D4PnPXsgC3Wkk1wjMDwaCnvaWlNPOjnz3awX+NTW5WOCoRVKjhINTmLVHI2
         qhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=LzDW5Hn56GEnfeOHzOGt1xed2ZWhhZGwBwC5qYbMcH8=;
        b=ku+D9dFINoRJSKnidmXuUvAI8oUDS4n8637Snq4dpJcMFKoCx9h56LFaFJqESe4DIJ
         c3rGx5eWVwoZnq7qI3qLbed0V7qRJBjTOjDslwB8xRAOTYWiH0uN3K7eDJg8/n/+d8+B
         gCIn4Qv1+AvkLMHarE2uMOeacUOqXxoYPpyniNP3Qoa5O73f5t1DNImOsJ8Pr5K5IJD5
         vBS5Wy4WDrQbeNqWPrMpXD9e3Te5HMVsprjiRW4wMPCtI9SyiOSuwfzGTIwEDXJc463P
         B2/uNZgWC73d8FKyCmJ/Z+b9UWd4Jl70hJ5xYvSoO7DBOU/z8KeZP+8S/ZKK9KKDnZHE
         u5bQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B52E22DBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 21/44] ALSA: asihpi: Hardening for potential Spectre v1
Date: Mon, 30 Apr 2018 12:24:32 -0700
Message-Id: <20180430190947.189947288@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200441146295899?=
X-GMAIL-MSGID: =?utf-8?q?1599200423005305702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -182,7 +183,8 @@ long asihpi_hpi_ioctl(struct file *file,
 		struct hpi_adapter *pa = NULL;
 
 		if (hm->h.adapter_index < ARRAY_SIZE(adapters))
-			pa = &adapters[hm->h.adapter_index];
+			pa = &adapters[array_index_nospec(hm->h.adapter_index,
+							  ARRAY_SIZE(adapters))];
 
 		if (!pa || !pa->adapter || !pa->adapter->type) {
 			hpi_init_response(&hr->r0, hm->h.object,
