Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpBK3RMlHYWtobi693ufMlF4ZZk4POh3L8GoeaWehOoQ75RBx6pjLsODgsnztIxQdHR+Wsj
ARC-Seal: i=1; a=rsa-sha256; t=1525116405; cv=none;
        d=google.com; s=arc-20160816;
        b=ehEsMZ8JScZEkMx8QZ4HpTTjaeXZ3bd5hdsj9lA4geymeB23i15xeiXUsaq/XqyO2H
         oZJhxoev0UL0R0bpVVb8DQlBox98Kna6sUjbkNCMQONoPNdfHjAugyDLmstqpRvI+R5X
         2TEj8JT4O4jBm6fLrz40A/ihVbRdNTRvje03zUa1DP/A35EfHlctCuLdOjRHob33gK2+
         ReeSCz1iu4pZMqL2BW2cOAMmfqTkLU8QMUw+gI/iorRkpPtybjQw3ebYBJW4LWcoXMh8
         qXVHinGN+rPQ2bXv6w3kcimkgXVOgTNtpLZVc8+6v/AkKQokTdJNvRhuajap8wGwoBjW
         v68w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=2DkoLwQMQUpbvR9ZRnjI7eBFrRHyCiUnwh9jX4JtU3U=;
        b=tkBBXjo/W31ZCO0x9zFFW9chg4bh0xRRVpbXKbaSCVRaiOrSiNlpV3JJieFwlZozf3
         o+3R3XKZSwbQlTKeVWaYrfiZXA0rpj7zzDEArsdkTiRU4dJ4brUWtPfNWpuuirGLN1VL
         2/CRwJ0JrQJNngyxSDAzOgpulnpGNH7xPl4gBa6Js6qTSUzloUcGAXEbbpjHdYJtgz4G
         qyEND7PK4wnKvPrxwAmWoICj0VbfwWcZNfrnxp7zbKul9pfln7CQXydu89yW4Mx2CMBy
         AaQQrfC/YUN+FyhunDUCsj0fnu1CxOCw3JPvM99biDV9Ys+9SvDoq0722g1sy4imrzbz
         fkCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B935A22E03
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
Subject: [PATCH 4.9 56/61] objtool, perf: Fix GCC 8 -Wrestrict error
Date: Mon, 30 Apr 2018 12:24:59 -0700
Message-Id: <20180430183956.047089363@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200594550452578?=
X-GMAIL-MSGID: =?utf-8?q?1599200459798761288?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -21,6 +21,6 @@ char *str_error_r(int errnum, char *buf,
 {
 	int err = strerror_r(errnum, buf, buflen);
 	if (err)
-		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, %p, %zd)=%d", errnum, buf, buflen, err);
+		snprintf(buf, buflen, "INTERNAL ERROR: strerror_r(%d, [buf], %zd)=%d", errnum, buflen, err);
 	return buf;
 }
