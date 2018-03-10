Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvirmPTE0IB/Hixom332JupQVvgYPFqsZ1jHGoIe1laawbCNL74QHp77BCfTpNRo9THFU6s
ARC-Seal: i=1; a=rsa-sha256; t=1520641214; cv=none;
        d=google.com; s=arc-20160816;
        b=n8yyX5AIxvUBgWo55Qj4zbxiNdhWM9CuYLEAEtajVi0oRH9pe6EeV1ilTsE2V/pOKJ
         pg+rD8fUgvUqilhtq0IJPqoiht6acws1FNfrWGRvS0eo0FBA6NuFlSjlrIHdtjrC73CJ
         ZxItznZdYh2OzY4IzYaLvkNHbKaDpvUV0ErqNaCp9dCbRhKMuavoaaH05xK1y8L2u/1s
         Mm9Ac39rIsLCh+c1Z8DFDzYXOJB3kM2JgIoBXP1Z73Wt7xpmm8JJxDdc1kzWDf6FLN1b
         cfkejRi/70+SWMyjVq251tAGTvAbV9G9lKdgScEfnJXITqvX6iiTeJxf93b3HBsll2xU
         gC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dTeY9JFiuNdgLheszxAi9SGOtflXBYUPurApOde3iLw=;
        b=CiloSJnvtsCWG8zqYAU/3IkUW2ot0gWko+h2HbG9MRaKT75n09BwotBnRZHC19vQ3e
         jW7tthoN6Yz3QvmCfcANNArNCIgvd21c2Y1K2PzsqwUVAHeuxDsG7edC3IYgTT2xGvuI
         czy9NQNoypezGF57CkId2ifVje5/mStF3ztQZayXn2ImzL8zh9Jy3OJsvTopfz+ArI5v
         XH+Nq48QpGLzIUW3idGQXZXxLc6IjANrGcQVUcupB+6pHTH9HtpGIVe/wVw0SyIV4poY
         Sm/k+VMJZLv4qjEEBoT62mQv0bJXf2dsOM6n8PrzsNcRZLRk7gmxabhrzdgixCWeWeJu
         kw2Q==
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
Subject: [PATCH 4.4 03/36] tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:19 -0800
Message-Id: <20180310001807.395175410@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507802508927264?=
X-GMAIL-MSGID: =?utf-8?q?1594507881980610203?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit f9d4d9b5a5ef2f017bc344fb65a58a902517173b upstream.

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
 drivers/char/tpm/tpm_i2c_nuvoton.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -267,7 +267,11 @@ static int i2c_nuvoton_recv(struct tpm_c
 	struct device *dev = chip->dev.parent;
 	struct i2c_client *client = to_i2c_client(dev);
 	s32 rc;
-	int expected, status, burst_count, retries, size = 0;
+	int status;
+	int burst_count;
+	int retries;
+	int size = 0;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		i2c_nuvoton_ready(chip);    /* return to idle */
@@ -309,7 +313,7 @@ static int i2c_nuvoton_recv(struct tpm_c
 		 * to machine native
 		 */
 		expected = be32_to_cpu(*(__be32 *) (buf + 2));
-		if (expected > count) {
+		if (expected > count || expected < size) {
 			dev_err(dev, "%s() expected > count\n", __func__);
 			size = -EIO;
 			continue;
