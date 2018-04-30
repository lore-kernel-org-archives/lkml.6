Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZolHk2Dn5vQAqea9sbbp1s0v5wSDfnInlmPWCUHOdvFqFzJuDNhkcbIeVEDyjYcNxv77nTl
ARC-Seal: i=1; a=rsa-sha256; t=1525116460; cv=none;
        d=google.com; s=arc-20160816;
        b=HQZOIIBetQ3vkV8VaX9y1nB3zvQJR/S+GlaNMHLRAwez6HUo638vssbXdEt7ozYreB
         9EZwHZUo7nQPukSAe58ks+eHXw344MFbAZZJJtSuK9+Y8QMcD418yGKuRpFKtSVu0iZW
         pMXbXYT3vKcmq1bmluzDP8Lh8Tajrem0TyOG3cH4vphBtVraTGmCb8RKexDaDQRIbbPJ
         CNDVL2Ayiz3suv9C9vPwzzbMRQoeHAMAQTW6lEKfLgJtU2dyR/jPMFzPzYPHRUnbz9NG
         WN5LyB9BpMZNNiC+msNLPbu06BEZyX809alGO07BZ8axIBgJL/dWiGjihLHu8GymffNY
         5Q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=uUqA90A1WRxnOeXXjWnAAzy9VQbHuLgXgi/QG0PnJlY=;
        b=oeB6NWzwQ30Fe6ejc1qmSXvDAT3RTenfJodhq3LGUssvkHVRcqYmCMOfjz3MfxS7KK
         5HG/UjciL7bF1XlJ1yVIdMdlYPxid1sYPj7bLaWwdtQC0w/xEbEp0Wkr8h2p5dmMw1A2
         nAX9EMNgr9zMbxArLEUUWQTfbI2mUHWZ6VyV9t0SardoTibG/Uy3cA+6tEF1siAmwMkR
         pZcRK82GI5l9hkhleFFu8DiHHqt4Z9W84MiO2i3vRrS7vvA7lP6IWx6HPbiJftjdGmtU
         ucSHSCaeiKBdtlYgwdbu7ZPmlr83jMxUgXdaC8SCKlblejtQxAyBUeBB2qQIpJPjRziQ
         e/Qw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F6AC22E03
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
Subject: [PATCH 4.14 82/91] objtool, perf: Fix GCC 8 -Wrestrict error
Date: Mon, 30 Apr 2018 12:25:04 -0700
Message-Id: <20180430184008.571548185@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200594550452578?=
X-GMAIL-MSGID: =?utf-8?q?1599200518105585314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
