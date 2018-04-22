Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49m5R9aVbhaxstgbgNTR2UPIvxpIoUSX0a48JLhKhYb0MCfdv/VZpi9+l6Pv782drlZ7lN3
ARC-Seal: i=1; a=rsa-sha256; t=1524406476; cv=none;
        d=google.com; s=arc-20160816;
        b=h+h7M+lMMp9/c4cFXJbqDizZzKAge7qvoG/Bm3/C6JQ+4HoHztV5QEgIrPVk6/LnZx
         YMyK9s9d+Z+AmBoiXHxGGFXVig1OH5o8ze+BfIpwAyM+rE9yreA1j4NiWdZ5jgGqk6cW
         dPwqOBWu9qGRg/yyVCJ4p1wg01sDT37zvDlxY1rKT/2s+MmMUO6IzQRHFPEe5HaphfYk
         78ZIYMciNEvd/75RFPly6D1FWJXxSHod+xgC3erQQtP04Xbug6IdHvndM5DziNRl/wBE
         Bep/j8FX8kM1vXY00x8Cwp+M5anXnfbuxwLUWxqYFLLZxICa8LpzVWKK5eguW//LLzq3
         VulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HUhHDrPmtuv41farWj3p8rpSy4CGdS/6182KY6pe4Cs=;
        b=zdfqlKDlvimJt2zKQdaddodQo5jFblb5kZeSKCDJVFA9Duke0GwBj1N++Ot0cwbhXQ
         CvX9R8xvatFNce9nSUy72o9FXw29v45W2L14PWRAHUaBRU4MPWW34uk934+d49DN2/45
         95LHusQIeAbfr4Y3HzcPGQUePX4PAUNrVJ4bll+zsu9LgdWbfBD+uaAx3kuLMwSOqdrm
         DcOJUEmnLQRX3GLQFSOpvOtkR1ud0xT+gXS3xTS8Z4O8AJDnEv1srlyoOXXf1NlQ9yRF
         oC/vjrzwZvvcxXje1GmezlX1yQrP+wh5iSWIiglc36CaRc9w9J/g8lkARg0OkmglPXx/
         qMUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mingye Wang <arthur200126@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4.9 85/95] udf: Fix leak of UTF-16 surrogates into encoded strings
Date: Sun, 22 Apr 2018 15:53:54 +0200
Message-Id: <20180422135213.907799808@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455282047443898?=
X-GMAIL-MSGID: =?utf-8?q?1598456045022625496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 44f06ba8297c7e9dfd0e49b40cbe119113cca094 upstream.

OSTA UDF specification does not mention whether the CS0 charset in case
of two bytes per character encoding should be treated in UTF-16 or
UCS-2. The sample code in the standard does not treat UTF-16 surrogates
in any special way but on systems such as Windows which work in UTF-16
internally, filenames would be treated as being in UTF-16 effectively.
In Linux it is more difficult to handle characters outside of Base
Multilingual plane (beyond 0xffff) as NLS framework works with 2-byte
characters only. Just make sure we don't leak UTF-16 surrogates into the
resulting string when loading names from the filesystem for now.

CC: stable@vger.kernel.org # >= v4.6
Reported-by: Mingye Wang <arthur200126@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/udf/unicode.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/udf/unicode.c
+++ b/fs/udf/unicode.c
@@ -28,6 +28,9 @@
 
 #include "udf_sb.h"
 
+#define SURROGATE_MASK 0xfffff800
+#define SURROGATE_PAIR 0x0000d800
+
 static int udf_uni2char_utf8(wchar_t uni,
 			     unsigned char *out,
 			     int boundlen)
@@ -37,6 +40,9 @@ static int udf_uni2char_utf8(wchar_t uni
 	if (boundlen <= 0)
 		return -ENAMETOOLONG;
 
+	if ((uni & SURROGATE_MASK) == SURROGATE_PAIR)
+		return -EINVAL;
+
 	if (uni < 0x80) {
 		out[u_len++] = (unsigned char)uni;
 	} else if (uni < 0x800) {
