Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELudYPDFhR7rPD03OqRQrAPeX5L49+0V/tJqPpnzMU69uSDbeCCPFv6vQs6LYO+xvtQGaclo
ARC-Seal: i=1; a=rsa-sha256; t=1520641131; cv=none;
        d=google.com; s=arc-20160816;
        b=Pv1Ihhs3VVdPL+vVHuxcoUI9RpNUvEw45ogzYBhSUEYj1huOyWOkk2ML3L4BMiQMuL
         JTZ/2Jk24dFhAAc9ysrI616fgUxTEATNIaG6HdFI4tNSRH4zaS5x7SOflZEICOMBNlgy
         oRpj2JHrZh+odMjelWmm1NTNMJq5zWQ5eAAIb+pDnb4axBY1P7Lf/jnV8umj4sBpR/Oh
         CZ88KThp5DCDdENrVu8vL577NyO23Sr7T7slRduqjfwLOtzHc8pgkw9mjM26J7v4Qnj6
         k75ZzGpeP9HOb5p5ltRup6CD0jSJwIxPRQqmGYPWfCOuR46X98vaJLv2UVSlQb/RGv+B
         +cOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ywLucK/+kezckdmjC7WU1/C24FDw/OUvqiGkeeF0s2I=;
        b=ZQc47xIG4kNLXW0NEUuylr8aRGfHShgKrx+8Kpx6Cd6lv3Mtvb1RxHTk5p+gjWqfaR
         drBhcFP5bywqS5773J6uDip8MT/gftbKYw2vMvusaiLnYFIQfOlq6+S8lm6dUFWHKBda
         ahb20my8ZWP/6DhfGS+yWeS73kdlVcBNPM9Z21YRG+07fBmTqmMf85bRwTp4/+1WAgvz
         T4TB3J8/8dE9qlbShTfnLJOkVt6jhnk2Qrq9vuKOS/6CZ9l9BIAfqbYQvxiUqz2AAYSa
         cGdWbo7F/zfsGq9R/IgnI2utayB7hyR39iABcKV7JG3PpF20i5ZOV6rgeBUk6E//LHON
         cd5Q==
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
Subject: [PATCH 3.18 01/21] tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:23 -0800
Message-Id: <20180310001801.153607760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507795452945508?=
X-GMAIL-MSGID: =?utf-8?q?1594507795452945508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -436,7 +436,8 @@ static int recv_data(struct tpm_chip *ch
 static int tpm_tis_i2c_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -451,7 +452,7 @@ static int tpm_tis_i2c_recv(struct tpm_c
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if ((size_t) expected > count) {
+	if (((size_t) expected > count) || (expected < TPM_HEADER_SIZE)) {
 		size = -EIO;
 		goto out;
 	}
