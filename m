Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELudEOzRsPMyxmAl4SngHEgucJ+AI46KHjShLzessRMqX59S8eGdpC9C9vFSPiWmVqy7FfpN
ARC-Seal: i=1; a=rsa-sha256; t=1520451583; cv=none;
        d=google.com; s=arc-20160816;
        b=cb0X1RPLIUsmWZkbe0UVxXFfP5mAXaDUU80eYOSuxjDp72EaUGUKcjN582wQH0qjFP
         Yqbd6AjTBFIRP1I9OQNwjlRKDzlwHnV+Co/HYWsxHjOszAnRihBZDFV4ahIuuFRR06ng
         I/09fSNg5Fnu+jBhZKV/loYR/0Iqg8N6Y+sETnqP0eoMOXp4GPZNxz7MuvEbtvu4kYbM
         A3GctBjyGvsxhm7yhSm/6i4GCZcp24/wS0VSuddnipwXyIpOpMZYd58p7cNwZronZGJU
         TyVPduhedagrz930qvMqen0rFz1o9zNQ6EYgGfCn+ZducMsjMKK738CNESS4AYrnk1Ge
         wdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ss7HwkzFBZwxrHkJJCuDkBA7rxobGKmCUi1u7y0w2U0=;
        b=dUHraYtwWfDRxAi0l8NL+OErrgzEZEZFlrEkSpUW3A0RUMGMD+mbnd3vVHO/HsIl1f
         VUoNUbyO9NDqApYOmTkw7W0zEEgbSycL33uAUbcsyF59NHuHoQIEEmhflqbrG/26ZS9Z
         /YpyYuu+jDw5u3IHw1qGWFBBfiTHePQLGeTJKDDScMGhaQAA0W8Aoeq1Q/SFT6NER16h
         OKaACDCNv4hM6yrpWQq5GFmPsMp5J7IonOGd7vp0D9LPZk0WL8ZgBIt79rCOSrneDp4A
         m9kh0/o8LsHqq26P/rnMOJZUT5qQKh/3qoY7M9GwMCquE1Lt9LG/JAesb30tqCqCVKT1
         1HKA==
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
Subject: [PATCH 4.15 010/122] tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:02 -0800
Message-Id: <20180307191730.714925568@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309040040928003?=
X-GMAIL-MSGID: =?utf-8?q?1594309040040928003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit 9b8cb28d7c62568a5916bdd7ea1c9176d7f8f2ed upstream.

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
 drivers/char/tpm/tpm_i2c_infineon.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_i2c_infineon.c
+++ b/drivers/char/tpm/tpm_i2c_infineon.c
@@ -473,7 +473,8 @@ static int recv_data(struct tpm_chip *ch
 static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -488,7 +489,7 @@ static int tpm_tis_i2c_recv(struct tpm_c
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if ((size_t) expected > count) {
+	if (((size_t) expected > count) || (expected < TPM_HEADER_SIZE)) {
 		size = -EIO;
 		goto out;
 	}
