Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuw17mCB+yhzJI9z+i+qgoRKCC0uG6SFiL/9vGFUE12J5koS3+ySwOyhp3lest9mL5CrKlr
ARC-Seal: i=1; a=rsa-sha256; t=1520641257; cv=none;
        d=google.com; s=arc-20160816;
        b=pw+NOi4AN+IPArTDa+HK9sRWXOkOdidp9hiAHtIMz1kEWe8mdTWm8ZFAFXQWk9OyEt
         ZsB2XWjapOSlYzy9H+KkHHMM6eiLR+d8WiIzMvaqUl8Nt+GkIn6r+DPfihw3wBb8Xt47
         rE9OAY73vmHCqyn5NoNQHfZ+hvIa/cY+NQJa8Udyr8FpMCHFRPlkZjPstTEbG0CkY2uB
         fYvpf59UuTTociYag1e4jV78UFVq87j5LcG8nYePu6+okfSkPTyZcjCftiNPXS3nrRnb
         rHe0uceO5AGEEQHoV8QvCcGErCNSI4aO2ylFRyUnAc4FakfCbNRYAPqMmTuSkU3VKWtb
         3qFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Va09WJsaxsQQkmW8/BoYpbmGhQCopeXEQQdeG17U9jU=;
        b=kvSHmIWnSxV1IOm8HyoaF/wT93EWQb/fkN9Tdx9Sl6LKDyUR93Fhm+qK7Yvy+zmhDj
         0nSG4DTsJ3JMIUIEELwkJU0F8OtwWmWUWOYq7c5bWSmgaoU3FTzGhn4wOkKuvjFc99TH
         W004XtparnpXTPVg146P+FeJup8Ggh/vhdA4aBToZDDj5vDxHE0SQnl48THglTkbL2kR
         NGzltlaCoWxkNJBr2erYX9QZ/CtyZRLnIqsT09dPwpqYQebq9ko09dnIUpJE/t2l2FxN
         B74zibHUVgs/9aAOEx/Bpfm8b8tsVvrnjvR9ekH9X9FhbwmLfO76s9M9ea+QbZcndUfb
         B+4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeremy Boone <jeremy.boone@nccgroup.trust>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
	James Morris <james.morris@microsoft.com>
Subject: [PATCH 4.9 01/65] tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:01 -0800
Message-Id: <20180310001825.054746800@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507844701877180?=
X-GMAIL-MSGID: =?utf-8?q?1594507927249200885?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit 6d24cd186d9fead3722108dec1b1c993354645ff upstream.

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  In all the
driver _recv() functions, we need to use a u32 to unmarshal the
response size, otherwise a bit flip of the 31st bit would cause the
expected variable to go negative, which would then try to read a huge
amount of data.  Also sanity check that the expected amount of data is
large enough for the TPM header.

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/st33zp24/st33zp24.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -458,7 +458,7 @@ static int st33zp24_recv(struct tpm_chip
 			    size_t count)
 {
 	int size = 0;
-	int expected;
+	u32 expected;
 
 	if (!chip)
 		return -EBUSY;
@@ -475,7 +475,7 @@ static int st33zp24_recv(struct tpm_chip
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
