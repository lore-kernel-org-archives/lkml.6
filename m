Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx493aGsLhASX6DozOA0wa9noFhGmLInE2epF7Sx8gJB8LMU8SObaW2sefV2nmfDD2IiuBy4y
ARC-Seal: i=1; a=rsa-sha256; t=1524652709; cv=none;
        d=google.com; s=arc-20160816;
        b=vskI6+hYBCZ9NKcmJium7zGBZf8ipEylu755mZFi1foltCM1vJpe5D3N1SMBzULQio
         S4lp/tqsFQmvlXSopiYdo7ZboOxtLsZqMEWXxFZNhLqoUk/C/8VMue6gAjNvId/XWz3Q
         1QqnXrZ/qTPwau2xOWfeKnws0Z55ZmannLi2i6/ebRCq8nNW9bNew+Jk0riE7B7MQfIO
         t6xQJ/WSkiFkEwlrIzw+WI0VffadHLzPPKJ8rQtdUGWZdHlB97dXbBGrgOm8ZOdv08Ds
         Hu/3kbY8FBehuuOhWFeBp3tXRDch5qXZ6lfrivsd8/WR14hmSAqoL2bWZR37HeDaBZrM
         4aSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fxv0OqhGvrzEO/2woNPXGKGAEQFXtpa5I5oOW8JvGKo=;
        b=E8vZbi4th6gI+2QQG89U3h5RFbH1Zqy24A4fQTAQ8e1tPj5AqnZxl8jHki1prCEFx0
         N8J2CBm8qmzXXrD8wIMRQkAKSd0UngbzEy8Gn8hWRkWsjsk+YYpwA1dGZNGQsU60/z0w
         OuD2tT6aHkilmPHt2mwsmEtv0/lPF8JIns1V4tpZbgN386o1FCBl2yT+ITKZCzzFhg49
         iYFRpHPPJe0cDCb7mPgPJA49L6hpXEQUYiyStqkI+heCXvuD7o/0WUyEkYkI5AD/UoWn
         /F/Iad+D8VAsL9itP3tRbuEwRY4koYXdHkRZmU5rD09sMcRUzdl4tmIgwA27oAMb5VhK
         FITA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gopanapalli Pradeep <prap_hai@yahoo.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 041/183] tools lib traceevent: Fix get_field_str() for dynamic strings
Date: Wed, 25 Apr 2018 12:34:21 +0200
Message-Id: <20180425103244.222005220@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714238977332261?=
X-GMAIL-MSGID: =?utf-8?q?1598714238977332261?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>


[ Upstream commit d777f8de99b05d399c0e4e51cdce016f26bd971b ]

If a field is a dynamic string, get_field_str() returned just the
offset/size value and not the string. Have it parse the offset/size
correctly to return the actual string. Otherwise filtering fails when
trying to filter fields that are dynamic strings.

Reported-by: Gopanapalli Pradeep <prap_hai@yahoo.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004823.146333275@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/lib/traceevent/parse-filter.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1879,17 +1879,25 @@ static const char *get_field_str(struct
 	struct pevent *pevent;
 	unsigned long long addr;
 	const char *val = NULL;
+	unsigned int size;
 	char hex[64];
 
 	/* If the field is not a string convert it */
 	if (arg->str.field->flags & FIELD_IS_STRING) {
 		val = record->data + arg->str.field->offset;
+		size = arg->str.field->size;
+
+		if (arg->str.field->flags & FIELD_IS_DYNAMIC) {
+			addr = *(unsigned int *)val;
+			val = record->data + (addr & 0xffff);
+			size = addr >> 16;
+		}
 
 		/*
 		 * We need to copy the data since we can't be sure the field
 		 * is null terminated.
 		 */
-		if (*(val + arg->str.field->size - 1)) {
+		if (*(val + size - 1)) {
 			/* copy it */
 			memcpy(arg->str.buffer, val, arg->str.field->size);
 			/* the buffer is already NULL terminated */
