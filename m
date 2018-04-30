Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpbbg98A2I2eaudGGuVmvUJh0axryG7LE0NMirsfKv55Z1W/bHrngMgysplxBNdlTSFLEyS
ARC-Seal: i=1; a=rsa-sha256; t=1525116534; cv=none;
        d=google.com; s=arc-20160816;
        b=maMP0CDMgcCEVqnFxzeBqPQZ3D/czEwZL5d1DuvkGumjwdHGmyRtwzDHtLYvYrPU5w
         u1XPtXz3ZF2oT2cGwhD4yrPX5ZEJkx07YXoxbimHZa9h4daKFDqrCBXWBuCnc3nAIpqq
         hWBWfCizP2mKE1DxE3uID/Z1PqbiV/2Ten03lC4oHdr85Jfsy0Eq/XB3EX7XTDK/uDDR
         JAYDPW0IAS5qzAn0NXTHlg9LI8PFIGWKKM+fyHLAoLf8LdPjWm0kbF6jtoIn05ufenPI
         5Yc5l+UbBtj5smu/fH/zLuY2VNxRBDY8hEdIGHGHZ6dvhxLjR97rj/T2EfKcuKvZs4XE
         FGlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=bdixK1XGgf3OqWKBVHt8MvCsLaLM8092VJ5eUBejoIA=;
        b=Z+as3+1enIeyNTnlSz4MgLrcxppx38BlO0c30oyjlW4XJPiBMqmMv+Jb1R/bGr+PLm
         V+4BzfOb4VdeJGDJE4IqRNd9ioSvRBK3T7ScmguX4WC0D/UnsTuOHfXKCCqKRnmh5utW
         ch6/TjgHvBS2JGHYXeDUWqxBkDEzpufZ6twFH8xiTotd04YmBYdB45dv2OlWqX5DDA6e
         HQtlQ/fq/gpU0HxpcT12S7TRwJ8GXJAvlccoaAi/vTfcldoAA5QhRbYvDfcXZnFl+lFM
         Rr+GJN0fHrqzAQVhhaiQvZdHgtZTiVa/zsmJbnsBSPAB7Y6ew9fRBUWUVtN+xx+d5NTM
         mqfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F9E72344C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Laura Abbott <labbott@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Wang Nan <wangnan0@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?UTF-8?q?Fredrik=20Sch=C3=B6n?= <fredrikschon@gmail.com>
Subject: [PATCH 4.16 106/113] objtool, perf: Fix GCC 8 -Wrestrict error
Date: Mon, 30 Apr 2018 12:25:17 -0700
Message-Id: <20180430184019.681265563@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200594550452578?=
X-GMAIL-MSGID: =?utf-8?q?1599200594550452578?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 854e55ad289ef8888e7991f0ada85d5846f5afb9 upstream.

Starting with recent GCC 8 builds, objtool and perf fail to build with
the following error:

  ../str_error_r.c: In function ‘str_error_r’:
  ../str_error_r.c:25:3: error: passing argument 1 to restrict-qualified parameter aliases with argument 5 [-Werror=restrict]
     snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);

The code seems harmless, but there's probably no benefit in printing the
'buf' pointer in this situation anyway, so just remove it to make GCC
happy.

Reported-by: Laura Abbott <labbott@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Laura Abbott <labbott@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20180316031154.juk2uncs7baffctp@treble
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Fredrik Schön <fredrikschon@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/lib/str_error_r.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/lib/str_error_r.c
+++ b/tools/lib/str_error_r.c
@@ -22,6 +22,6 @@ char *str_error_r(int errnum, char *buf,
 {
 	int err = strerror_r(errnum, buf, buflen);
 	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
+		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
 	return buf;
 }
