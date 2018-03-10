Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsSkZWlJo4LE3x9UvcY/pCt0jEWgiTwsoKfz2Mv+9qlXQRWNw58sssPSvce+yj2y9kOpSrc
ARC-Seal: i=1; a=rsa-sha256; t=1520641290; cv=none;
        d=google.com; s=arc-20160816;
        b=L2F2hkvV2Q7bE2AXaTTUKy0jCjDcpjSS2a5KaIaB5WPJ3sWFK9zQabH/PDuR5dWVlV
         GPE2y1ejVXUFZCzRkoN7M4eACkXtGHAZZNM9A/8a4h7M/aSYSNn2vLyTdAcZ2c6I2mez
         4chVDTl5Rag8ttdMQGDVre+QUkVo5TeLQYIFYGN2Ah+05MMrHQ16PGzGB+FC5xzhE32B
         uu4BzEZoU0eTOCrOFn+kG4TkI+Gg5SV6O/70Diq65Oyjvn3P++DC+iwVfpfMC2D8Npo6
         aH275C1QOd8Gxj2mVLeMfyX/kIlb8jO385ddfXKCyCGjphXKn0Lta5UGF4UmIycINZDI
         xCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Q+Z2vL2u/NaAW7kobK2oeLXFawnJWU2iBXWyjQPQUt8=;
        b=PjW8i/EvHmwu0tWU6iEOdn28bny/wZA7P7vWIiDcoPk/LBXUXyk3uiYR8jG3xLEhdQ
         PAZ3AIqfiIUOffqfamC8FdfNYZVn/x57CUs8EPhCPp1Z+j2PREHkhZ+j9x1RiNVXJPi1
         e5BYHVk+1p1K1yztleqYXL1R078qdlWs/uOD/6tjgfXtXC3iQ61DNhcRJjcb/ose5ND1
         Tf+89gEGEajiLYr/xEMZV2X1z8OVzeavxeHuGnSq+slKItbDt0KID8nsq2DR0OXMSLtc
         DsYspO7fsvP31wCMBnBeqMpEIbsbJUKmYZ+tKJbdizUKx3SCaeFL2R86KLvr44mrNKIr
         Dh7w==
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
Subject: [PATCH 4.9 04/65] tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:04 -0800
Message-Id: <20180310001825.268027029@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507961790979150?=
X-GMAIL-MSGID: =?utf-8?q?1594507961790979150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit 6bb320ca4a4a7b5b3db8c8d7250cc40002046878 upstream.

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
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -208,7 +208,8 @@ static int tpm_tis_recv(struct tpm_chip
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -223,7 +224,7 @@ static int tpm_tis_recv(struct tpm_chip
 	}
 
 	expected = be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
