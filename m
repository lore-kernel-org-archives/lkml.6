Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp52WtyjkiD1FR2znS8WIGemyxuPIGzVNGSMaZOcuAVXHzM5B+laFcwMEBErpATzIFc1kkU
ARC-Seal: i=1; a=rsa-sha256; t=1526937536; cv=none;
        d=google.com; s=arc-20160816;
        b=XQKl8MUgwmahovULRfTojFpLsMmxdH1STFtrF2FG2sSXo+4a2/zvOyixsql1aydEE5
         +7LWSfTtIRKvD3ETpc+jUtghHuTib2eGih5pg6hy3c/qS1iGkDvX9oFC5Pqrn4rPBkXU
         iBmjR5uRpUC346vAjaKKCBhWdPq7jFKXGsm8/Zwi8mr+dbgexM+feDVWJCsNRML2eCm9
         Jd3vAFyUoQYeFm4OGHZVZezIs+SRjIZm8mKWE3B6soQgODBf8idAdowltqa3Wz2KBVW4
         c+MkB3IphNeHWM5tgPe5u44mfvCyNOANuCBA3RIiSXuNMxMzo4jW8eatR9t7FxArcMHV
         dZwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=L1hTLPyYCYN2SzshRtd4Z6AlyzDrDZct92z2UDO+2n0=;
        b=BMQkRv51lI+/GhDuK7PI3+5vYfC6UKK7pDY1KAxIToKi2xt4wY4xayY9ii1RCOssdU
         8ZkJp/JDp9ZPgpWNMileMCRZxWpJqpcLVOYwHWxWpChtjE/b37jKLtEpxqZVY+FLmiqr
         heHge/+e2pJQ/BJMl+Tc3p7cgKMV8CAkhV1g7Ac9GfiFL2W6UkNfbIAdRPCgEeYL6VlO
         HXEDv1doe3hZZUG0D0CEX+PgH3zcUp6QkwVnaC1KkB+7+ssW08F+nefjbTCRq0RA/RF4
         bBnajsbUxPzOYtI2IR1sLW2naw8dqGA6OOLkl68fBr715l3UNi7J/T25BcNhiUT7nFnH
         o7NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Cs6rqALu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Cs6rqALu;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.14 29/95] s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero
Date: Mon, 21 May 2018 23:11:19 +0200
Message-Id: <20180521210454.248647610@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109875373566358?=
X-GMAIL-MSGID: =?utf-8?q?1601110054214705071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hendrik Brueckner <brueckner@linux.ibm.com>

commit 4bbaf2584b86b0772413edeac22ff448f36351b1 upstream.

Correct a trinity finding for the perf_event_open() system call with
a perf event attribute structure that uses a frequency but has the
sampling frequency set to zero.  This causes a FP divide exception during
the sample rate initialization for the hardware sampling facility.

Fixes: 8c069ff4bd606 ("s390/perf: add support for the CPU-Measurement Sampling Facility")
Cc: stable@vger.kernel.org # 3.14+
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kernel/perf_cpum_sf.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -739,6 +739,10 @@ static int __hw_perf_event_init(struct p
 	 */
 	rate = 0;
 	if (attr->freq) {
+		if (!attr->sample_freq) {
+			err = -EINVAL;
+			goto out;
+		}
 		rate = freq_to_sample_rate(&si, attr->sample_freq);
 		rate = hw_limit_rate(&si, rate);
 		attr->freq = 0;
