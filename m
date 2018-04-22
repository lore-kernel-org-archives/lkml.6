Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48n5B4gncNsWGwaywGwAI96CqYexWqg3rK6N5M9jq9JLq1iMmTJ499cA3f7y7dgNGSZs7K/
ARC-Seal: i=1; a=rsa-sha256; t=1524405748; cv=none;
        d=google.com; s=arc-20160816;
        b=qEEEWltuPnH131hyzhCflwMf+tXyKNOITDFnxk9hbHDlHaRDk+0fyDxe9ECpcda+EM
         8zcAxfYBdTpb0xfhQnJkLElKrn9+IpHIZSs+q52vaQXc8ZJImtzD5XfHckPDBLOZdtug
         6g2QJBPqGCwhxbcP3yQPrZOkR/QcdY2DlDeFL0t7+kn6Yo8xPm/TVcf3uB8BTgjhLakP
         s9fUOMX9G9WZEDa/gYpWAfzIrJMMyFbSlRVhrK2vTfl1xu67MUjuIGT0FcsD7LSeV89/
         COzuiElt9u5g9XBie2yG0p9WaToon3/XB0y60Sjv5voXRsIHKZPRLEzVHHSoKmT5Q0P5
         TfIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gSbIv30f7dVrIuo3OisFloMrlG3und0AISsasdIf/iQ=;
        b=nFb6TPg5v8sMNOQYu0mwuaTQjhXVvwqapJCCIr3EFm0bJfondrAK1e+aI3i+pYSLSV
         0wQq0MG0BzBnnxJ+fepaTyA3trxvZqOf/UgXehy73+XOP8WeK5eWSz1+hcpH39UhLO3b
         Ri5On1vmXxAdeFXiPy+0PoCWA/aOkZc3fWUng6djhwiDuY/r4+ZxJRfP1hJW3G2Bswmz
         vjK0ccZHZZw4HGWcej2kRtTflIWNyVV/8CB0IG/jFsMlvQfY8MNcA5ais3ZritbOlTx5
         PruCj06GaRGuhO2ldIBnamDlLNLxH9FXF+N8kulb6bmSEJlnmnyszjhn+DyLMNBd8WHC
         A5bw==
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
Subject: [PATCH 4.16 180/196] udf: Fix leak of UTF-16 surrogates into encoded strings
Date: Sun, 22 Apr 2018 15:53:20 +0200
Message-Id: <20180422135113.563364509@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455282047443898?=
X-GMAIL-MSGID: =?utf-8?q?1598455282047443898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
