Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227uaerSuTcNm5eq2Z3P02gtzXddnWwBsD/dsgJSeI0yHzWmJBVERwqPYqFM/SANp2Z5zKKK
ARC-Seal: i=1; a=rsa-sha256; t=1519412100; cv=none;
        d=google.com; s=arc-20160816;
        b=vlvn8M5vEny+DwxV+ySygF3ibudTX2Yj0nRwUw0zzj/bGrwsOFOoSBdavY9ZOPC6cW
         2517/7FjCGg+H7ZLprh9NbNkWCedqwibKVbokDNd/Nx15TcP6opy/HPQDkvA3cIkLTd+
         WWsNVfLNIrDRm5dmb/I0hyF9SbnwEuUx3uFo8rHCzuhemZ5mJRkbNf5BnVLljSVrbspV
         4Sh661ywYz5+KKLYDeuEL1Qzo4OSH3c5EotnC1LKD6eLXjzP5KH7Ou5audCFu33QRiiU
         Cehuy8O36aYsZZtTkLVQveu9Z0+SkTJgOHcSOmdBe134MOXGgkLD22zfpSEyKVSLXguo
         r+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1g9PAakW2s68J7YQpqdTvjd5FpJlLSFCV9zPPeyvyFU=;
        b=rwTJlQDrDS8/FrkvFu+h8z+ihxjQRScPuRJMMksAz//xCrpCyV12WH9qDNgprM1Spu
         w9aA6C6/5j/giidBBNZYJMNXlm9nJT3h5foP3k7MGMhrtdKzfsU6GHJlV6HgrsKfmRN/
         kTCd2pLfELREPdj2FrKOLrb48PBJ4EHJn9NZ8SU1VnCvpqeZvQ3JQCnJpTkdjqr+AumB
         doW+QpyBkKVD1f/qJYEE4A/wOaRWarBg8aOcEk0NIgll3QIZ2i8asxaNeqHjwJf86rjI
         kHdiFKOuy392s1ACs55X4ML6tXEJhhKAcHt98iaERnNV5/nYeRJqQbyO54S3xqXOJ8Qj
         A1eQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	David Howells <dhowells@redhat.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 126/159] 509: fix printing uninitialized stack memory when OID is empty
Date: Fri, 23 Feb 2018 19:27:14 +0100
Message-Id: <20180223170758.414548522@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217663662387476?=
X-GMAIL-MSGID: =?utf-8?q?1593219063006561403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers3@gmail.com>


[ Upstream commit 8dfd2f22d3bf3ab7714f7495ad5d897b8845e8c1 ]

Callers of sprint_oid() do not check its return value before printing
the result.  In the case where the OID is zero-length, -EBADMSG was
being returned without anything being written to the buffer, resulting
in uninitialized stack memory being printed.  Fix this by writing
"(bad)" to the buffer in the cases where -EBADMSG is returned.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 lib/oid_registry.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -116,7 +116,7 @@ int sprint_oid(const void *data, size_t
 	int count;
 
 	if (v >= end)
-		return -EBADMSG;
+		goto bad;
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
@@ -134,7 +134,7 @@ int sprint_oid(const void *data, size_t
 			num = n & 0x7f;
 			do {
 				if (v >= end)
-					return -EBADMSG;
+					goto bad;
 				n = *v++;
 				num <<= 7;
 				num |= n & 0x7f;
@@ -148,6 +148,10 @@ int sprint_oid(const void *data, size_t
 	}
 
 	return ret;
+
+bad:
+	snprintf(buffer, bufsize, "(bad)");
+	return -EBADMSG;
 }
 EXPORT_SYMBOL_GPL(sprint_oid);
 
