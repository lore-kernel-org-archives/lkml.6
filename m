Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+CqRFAzQWhymyG+2hDmmMpYIefO4IeGMmkKEj3WK5QKwPTPbpOu8XcfFeE7qT1qOa1qcKS
ARC-Seal: i=1; a=rsa-sha256; t=1524406251; cv=none;
        d=google.com; s=arc-20160816;
        b=zus44juEtYPPIogkmoVsCLV4AFiw64Gu8FNy+jaf7VeywSyM2P7rJrGe9vBGCEe5H+
         GDbWSxHFNTxRU9ja68V5LyVGDPftnghHQHNcdhBBv2X9Iq7KXsiec7LKCYS1tUzeOzi2
         KI9/cRqQ82q9UQWpYAmN7mrsqtuRAPfTY2HBpOs77x3Y/BKBDIqRbySMdyyzA4rNe7ro
         Z5JMpYlu3u5epy4PHAefFeyI3cTRtbexZNvKOaw79JvnxKYAECDfFkn89C1fzelRp/Vz
         rB6ufGPDZZNF5LtIst/0WeunV3bB8X/SZBxiqpFW6KcgV4PHEfRcxk4wFd8y1enMvjR1
         8Jaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=V0PZt0VGuklk/XXIVuerEppIRzlYdPb74X3S2oktJfg=;
        b=UopqERb9HFVEEqWn2SZG5vaHGhcDIKo8GxRcVf1mFwBraFeEReoxgffRWHeuk3RMMD
         9tgF6qF9qn967TrjrIO1xiDoE/iann4KycqZEyJqdK7pTBTBm6IIQ87UvKIF2bGRdMoh
         ZThpfyFjM3rY3Y8C3+4XwRXoik2dfRHp7Ehd2ANwwOlEXoWoo9p0wZS5SLKRZVH3N8M9
         02Yctszh7Xgj6iItxE/fs+n54sKrd6pvUyufMz6s159RHqBY63rj7froM9Hbt6tVaGPa
         2e2OtGtoZYJ+/zx9wLxyFgkQ3UtHpW0Tfq0V9IOGAIQ9dS0NARU5PZL8wHfS2c5x9qTT
         4SMw==
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
Subject: [PATCH 4.14 148/164] udf: Fix leak of UTF-16 surrogates into encoded strings
Date: Sun, 22 Apr 2018 15:53:35 +0200
Message-Id: <20180422135141.575253048@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455282047443898?=
X-GMAIL-MSGID: =?utf-8?q?1598455809685599761?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
