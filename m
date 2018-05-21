Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrFv/YNOtMwa5yPKs+/+4rHtQfYk6YdQgMZp+dVdfifo5ygx9GGIV6bTV66OTeaKGbg8X2X
ARC-Seal: i=1; a=rsa-sha256; t=1526937828; cv=none;
        d=google.com; s=arc-20160816;
        b=zHKd+18vpUbaXyF/V/Qa7uB0YdXksyTZqzyv2xvAP9oTtBEXCnoO9EI41fGWVK7zvy
         PngDbgCvV1KE6vTDvXnsRvW7yiXLrQoMZVwgYDTgh6jSMHLKXeY+PPSqsyI0Jnn1NufW
         d/U0QqKMgSzzFs3qeEYhlugv05XDDR1YbmPI6KpOw+8CYt36x+bBIDyzOx3ssfJzEBM6
         hJuBM1U5ooXsW0o39Gq5HZVjaxN+SL+gvckpqGxzf+uNaAJx6mgOqNYh7xR9GlEffVC8
         rcYcXOR75U2z05hwgfIHAancR0BNPeBpAQlcIupVTDF5OLl+an1Wmn9dcWz37qnAQk2K
         PLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fQj77HYFB9KP5nHAsLxPJwUZNS+2cChzr3mTy8+9+98=;
        b=ZPTQHTqwACXXu3QiWKKEXrzEEPNS7x5kf50maHQp676X6mP5jWT5GG6lr/nGNT4/07
         0dFN1wIB3/Nq7Stsh4spRiTIRznuIFJ9iQ4xB1112YbU36XyE8D+yt9O8ineT+m+KtJZ
         /+Dpi82dZNFgHejmisiqB38+yAAbmmOSgFcsbv/e+JaIIzaCam7pvSh4505pOnZwG1tp
         xDQ5pfR8HiyK9hotBt78UC7UNw/5EOGaFukBCYnjd2CsTwkIHIH91FFDn0dTwUP2Wlaa
         l7iMVRwFKuNpVdeydF11BCtjsSNF9Q0taUgA+m4cR196N8BJzZQugYVo8jHzgOw1uxB/
         7ODw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jYz9inbU;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=jYz9inbU;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 041/110] s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero
Date: Mon, 21 May 2018 23:11:38 +0200
Message-Id: <20180521210507.731353876@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109875373566358?=
X-GMAIL-MSGID: =?utf-8?q?1601110360515462791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -753,6 +753,10 @@ static int __hw_perf_event_init(struct p
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
