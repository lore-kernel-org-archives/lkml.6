Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/vRjLkeB5EQ8CMvhGA2V/r2YwwvGZdlVJcilEHjx53beR8AXtL+yMruipDhLjR88KJDYDi
ARC-Seal: i=1; a=rsa-sha256; t=1524652950; cv=none;
        d=google.com; s=arc-20160816;
        b=ZiFFh5GID4dvcSbR9BtGbgZNjdrjoMgipPdFvSaJtn77H4jtsuUJt4ivrJ5rzEJRPU
         m22okIHAGPtiNlB3f6MzWI8FI6mYTgDwsX0Ir1jOpKd4v8jTLuysU13dOCPsg3tfkUii
         SiN3fHlmHMv/byH5REwKtym4yoF34VBYGmKcQj/WhWjAEvKJqIITdCNg21BmPdvd7v8o
         1WRJdAUZ0za8npunN8q7xGYwQwR5FqZkNtH7Jpyqs7c/5aawfN12YEehybgJDyYZ+0gy
         Lfxh8ymQLguYR0+pgXNU8boOCzFdiRXEh3MGkEH7vxQ2IeJ51HgRUxoNq9shzlC8ma85
         dqmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=J1W5uDS7B8TYNOPq34YPTPIzxv1Xazls7K1gc27Ujqk=;
        b=WQ0qs0k9icXy17DP3ODQII8NPnKrSocHhZf3DpN2Ktm8vEclq8vijzAb+rqfQtEt/n
         zhaa4bmLKBvxcMt3BBlkPkKUEmTBBH6fTVE8ZeVJr2xbN5MnqpqJh2pm2mj2EO6Fkv+U
         S4Lt2Z0eEhRbyqImi9pU8BmqQDjW780NyvbPnq9ICdjcoV/bxe/ikHeXoc6QB4cQSzVq
         Pbffcj6OaySTI9azzttIgPCCn8S+b8a5+1+Mh70uog3RIthBZivnvmKcsOZFd/2iV/1n
         sQo4ZJEmJ4nFh3l5xUsQZsomxqwZh/+dxHjI3UE4/UEa6NYmuiQmyVuRsFV8YsA5Dov9
         6VgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jean Delvare <jdelvare@suse.de>,
	Parag Warudkar <parag.warudkar@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 129/183] firmware: dmi_scan: Fix handling of empty DMI strings
Date: Wed, 25 Apr 2018 12:35:49 +0200
Message-Id: <20180425103247.613786336@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714492432959509?=
X-GMAIL-MSGID: =?utf-8?q?1598714492432959509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jean Delvare <jdelvare@suse.de>


[ Upstream commit a7770ae194569e96a93c48aceb304edded9cc648 ]

The handling of empty DMI strings looks quite broken to me:
* Strings from 1 to 7 spaces are not considered empty.
* True empty DMI strings (string index set to 0) are not considered
  empty, and result in allocating a 0-char string.
* Strings with invalid index also result in allocating a 0-char
  string.
* Strings starting with 8 spaces are all considered empty, even if
  non-space characters follow (sounds like a weird thing to do, but
  I have actually seen occurrences of this in DMI tables before.)
* Strings which are considered empty are reported as 8 spaces,
  instead of being actually empty.

Some of these issues are the result of an off-by-one error in memcmp,
the rest is incorrect by design.

So let's get it square: missing strings and strings made of only
spaces, regardless of their length, should be treated as empty and
no memory should be allocated for them. All other strings are
non-empty and should be allocated.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 79da4721117f ("x86: fix DMI out of memory problems")
Cc: Parag Warudkar <parag.warudkar@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/dmi_scan.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -18,7 +18,7 @@ EXPORT_SYMBOL_GPL(dmi_kobj);
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static const char dmi_empty_string[] = "        ";
+static const char dmi_empty_string[] = "";
 
 static u32 dmi_ver __initdata;
 static u32 dmi_len;
@@ -44,25 +44,21 @@ static int dmi_memdev_nr;
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, u8 s)
 {
 	const u8 *bp = ((u8 *) dm) + dm->length;
+	const u8 *nsp;
 
 	if (s) {
-		s--;
-		while (s > 0 && *bp) {
+		while (--s > 0 && *bp)
 			bp += strlen(bp) + 1;
-			s--;
-		}
 
-		if (*bp != 0) {
-			size_t len = strlen(bp)+1;
-			size_t cmp_len = len > 8 ? 8 : len;
-
-			if (!memcmp(bp, dmi_empty_string, cmp_len))
-				return dmi_empty_string;
+		/* Strings containing only spaces are considered empty */
+		nsp = bp;
+		while (*nsp == ' ')
+			nsp++;
+		if (*nsp != '\0')
 			return bp;
-		}
 	}
 
-	return "";
+	return dmi_empty_string;
 }
 
 static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
