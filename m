Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELszkOkasGmfKZ1dQdtXjWMVZWnhPinV17bGACrmU8QeGkvB40Q2QxF+HnGdxJ/+NUEOcAVW
ARC-Seal: i=1; a=rsa-sha256; t=1520451586; cv=none;
        d=google.com; s=arc-20160816;
        b=WxSQHhl49KhobNlb8vxj8m7vwvtEpj4Bkt4lhKjEXvxzC2Pze6qwsHB2i5F+jsynhZ
         QB0nrsZtcjeDEAWaOlvzQsh74fvPiFM+PQjg8W0CvoepTgL8oZAf8j0OoO/SsNPgL9LC
         6vmSnGyBpqGnZEEnuWYcN53lvhPcJhuyBbcp8xt9p9Uo2Ks/Zj5Yh5ZK9UcS8mDvhhvR
         ICzoDn08fdjrUV1HguWkzU+LFtlM0BHRxrnzJzt1UEyceosxXVlhzyvICww27ehlA3xl
         wCGBtAnPmhM6IU/aa3BrGnnSUpkoIeDSrPAjyX2S2g5XzLQ7yCSF0t5I2GjVk8d2SAAm
         apwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ShfvcTMy72EHezh7Hs3sOTNHUYQP7nypYbz/tCGgCtc=;
        b=k2rGYXR25e0jhMl/YddTpuTT2TN4wYHcJm19BKOCysLhrM2pqWd8IhnoeO/ATD0ISk
         AlTITD7Nsu70X9DNGDBbt4Y+K+ME0f5UjpX/AKsXPrFLq10nMFzTmymHcnN5AAd47hTp
         BP2/u6VcMpG6jeorkA+/DY8TNJSwYSULVY/QRESdD1yHr05LIn5Yn/P3THALOFxao4X8
         FwLE/BYGVpIzZywwSVxmSk7lGZrxYg59vh0Bmf69Pfzy6EaQEiTCOWmQ6+KGoOOcE7LM
         Y5q52VCpOuYjD8+A7IzraRbRnf1hGxXRbpEVpDns6iRZAvUDkczomvRxiJ8DtI2sj2BE
         qTIg==
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
Subject: [PATCH 4.15 011/122] tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:03 -0800
Message-Id: <20180307191730.829757514@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309042312731785?=
X-GMAIL-MSGID: =?utf-8?q?1594309042312731785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -281,7 +281,11 @@ static int i2c_nuvoton_recv(struct tpm_c
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
@@ -323,7 +327,7 @@ static int i2c_nuvoton_recv(struct tpm_c
 		 * to machine native
 		 */
 		expected = be32_to_cpu(*(__be32 *) (buf + 2));
-		if (expected > count) {
+		if (expected > count || expected < size) {
 			dev_err(dev, "%s() expected > count\n", __func__);
 			size = -EIO;
 			continue;
