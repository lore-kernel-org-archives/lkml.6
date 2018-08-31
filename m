Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2304EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02B9205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Li8g6ySl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02B9205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbeIABBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 21:01:45 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35367 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIABBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 21:01:44 -0400
Received: by mail-wr1-f54.google.com with SMTP id j26-v6so12326247wre.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SDDwRURgW+9beihRIjWtwTATpIOmHeBgZf9tCXPLsIU=;
        b=Li8g6ySlDuN5rwxc0TZOM0Q8t7r30Q2vg7GCjfGQICD+y8o78ifgDawvOXmw+vyO8/
         11nzgw260iHZVCRNuA4a1WK9OmME+zrY0m67NA02E1glaVL0OkCa7BveXoCMi0GynMVQ
         a3Xr2exPhy3TQBTucl9j18vpcFs/DShaUFlS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SDDwRURgW+9beihRIjWtwTATpIOmHeBgZf9tCXPLsIU=;
        b=sGWFBaC5ocBB6wUJm1Mvkfyt11t4Aa8ytsc1l5hZyf39VjrNF+Int5zWDV8cokoMlp
         RTieSMasW7P3nAWWxDA6rEHjfDzfL1cOl4aFRPgfo61RkNtdJTMxP+VS/nP0WOsgVYQP
         Xjpys9En9k9IsZSiIJ9ilm9b+JIlgmzfn7FE+WPvPxI60tDLk35oc0s8OMoN7Su0epF7
         jrChxfq9Sgi+1WZ0lZ5WLvC2Ptq5nRU6a2OAiUkxV6hQa49tf1NtcqHVexLRGiZW1RnH
         354dBiBoo9cWi5zI3A6uvP91LDATVIKQD77d5cmTCaUHWbwAXUw78aTXamYwAErtpv0I
         bYUg==
X-Gm-Message-State: APzg51DoXyv9qMTDUg1KSjkyxn5mmo2RGPpWWHNRVXsjargkY3SGaENG
        FBrN65AlgTN2SzBPoHghE7bJxg==
X-Google-Smtp-Source: ANB0VdYU4aCGAfMh8OLC3OkJYLrKkb7o26RcSC9GE9RDr8RddSd1WAowzpUaG8F7XH+uk79jxnmziQ==
X-Received: by 2002:a5d:488c:: with SMTP id g12-v6mr12267068wrq.0.1535748750622;
        Fri, 31 Aug 2018 13:52:30 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u4-v6sm7659356wro.47.2018.08.31.13.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 13:52:29 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH 1/5] kdb: Tidy up code to handle escape sequences
Date:   Fri, 31 Aug 2018 21:51:38 +0100
Message-Id: <20180831205142.23609-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831205142.23609-1-daniel.thompson@linaro.org>
References: <20180831205142.23609-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kdb_read_get_key() has extremely complex break/continue control flow
managed by state variables and is very hard to review or modify. In
particular the way the escape sequence handling interacts with the
general control flow is hard to follow. Separate out the escape key
handling, without changing the control flow. This makes the main body of
the code easier to review.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_io.c | 127 ++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 61 deletions(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index ed5d34925ad0..e54e1e185c47 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -49,6 +49,63 @@ static int kgdb_transition_check(char *buffer)
 	return 0;
 }
 
+/*
+ * kdb_read_handle_escape
+ *
+ * Run a validity check on an accumulated escape sequence.
+ *
+ * Returns -1 if the escape sequence is unwanted, 0 if it is incomplete,
+ * otherwise it returns a mapped key value to pass to the upper layers.
+ */
+static int kdb_read_handle_escape(char *buf, size_t sz)
+{
+	char *lastkey = buf + sz - 1;
+
+	switch (sz) {
+	case 1:
+		if (*lastkey == '\e')
+			return 0;
+		break;
+
+	case 2: /* \e<something> */
+		if (*lastkey == '[')
+			return 0;
+		break;
+
+	case 3:
+		switch (*lastkey) {
+		case 'A': /* \e[A, up arrow */
+			return 16;
+		case 'B': /* \e[B, down arrow */
+			return 14;
+		case 'C': /* \e[C, right arrow */
+			return 6;
+		case 'D': /* \e[D, left arrow */
+			return 2;
+		case '1': /* \e[<1,3,4>], may be home, del, end */
+		case '3':
+		case '4':
+			return 0;
+		}
+		break;
+
+	case 4:
+		if (*lastkey == '~') {
+			switch (buf[2]) {
+			case '1': /* \e[1~, home */
+				return 1;
+			case '3': /* \e[3~, del */
+				return 4;
+			case '4': /* \e[4~, end */
+				return 5;
+			}
+		}
+		break;
+	}
+
+	return -1;
+}
+
 static int kdb_read_get_key(char *buffer, size_t bufsize)
 {
 #define ESCAPE_UDELAY 1000
@@ -102,68 +159,16 @@ static int kdb_read_get_key(char *buffer, size_t bufsize)
 				escape_delay = 2;
 				continue;
 			}
-			if (ped - escape_data == 1) {
-				/* \e */
-				continue;
-			} else if (ped - escape_data == 2) {
-				/* \e<something> */
-				if (key != '[')
-					escape_delay = 2;
-				continue;
-			} else if (ped - escape_data == 3) {
-				/* \e[<something> */
-				int mapkey = 0;
-				switch (key) {
-				case 'A': /* \e[A, up arrow */
-					mapkey = 16;
-					break;
-				case 'B': /* \e[B, down arrow */
-					mapkey = 14;
-					break;
-				case 'C': /* \e[C, right arrow */
-					mapkey = 6;
-					break;
-				case 'D': /* \e[D, left arrow */
-					mapkey = 2;
-					break;
-				case '1': /* dropthrough */
-				case '3': /* dropthrough */
-				/* \e[<1,3,4>], may be home, del, end */
-				case '4':
-					mapkey = -1;
-					break;
-				}
-				if (mapkey != -1) {
-					if (mapkey > 0) {
-						escape_data[0] = mapkey;
-						escape_data[1] = '\0';
-					}
-					escape_delay = 2;
-				}
-				continue;
-			} else if (ped - escape_data == 4) {
-				/* \e[<1,3,4><something> */
-				int mapkey = 0;
-				if (key == '~') {
-					switch (escape_data[2]) {
-					case '1': /* \e[1~, home */
-						mapkey = 1;
-						break;
-					case '3': /* \e[3~, del */
-						mapkey = 4;
-						break;
-					case '4': /* \e[4~, end */
-						mapkey = 5;
-						break;
-					}
-				}
-				if (mapkey > 0) {
-					escape_data[0] = mapkey;
-					escape_data[1] = '\0';
-				}
-				escape_delay = 2;
-				continue;
+
+			key = kdb_read_handle_escape(escape_data,
+						     ped - escape_data);
+			if (key > 0) {
+				escape_data[0] = key;
+				escape_data[1] = '\0';
 			}
+			if (key)
+				escape_delay = 2;
+			continue;
 		}
 		break;	/* A key to process */
 	}
-- 
2.17.1

