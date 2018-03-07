Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvYZThyNMIEo85ociHUHTCMeQEiOG2inuIUWoorxhV5C7NGpy2K6N/MXPABKi1u7HpW1B9U
ARC-Seal: i=1; a=rsa-sha256; t=1520451887; cv=none;
        d=google.com; s=arc-20160816;
        b=uewO4/pvsk3Xb5BU2d9W1S2tVoD6OUC+xULK90LzAYt8VhT9nIMu0LYP53yMsuUYGx
         o/amEsHVNApejJ63NDSNuOhJ5/ACFPw7bFJ1DG+sV/YaaFhywcToAy/Ua2og8jD7aDzg
         JA7jlSZevEh16sqyVuR2zL+odnfDcubaYH05eDmvqWmdVImE8hwQ0O5OVoB7O1H1/WDr
         z3l/YFoSBzAJu0XboBQSBuPfrRY2LllG1Jb31xhSZWEDBZTyHYAj0zui/MsXxTNr1oW0
         tMnR+lpSjwKqxP3G4C//rYtS6OfFZfmrxMUDW/0Qr0d4XzkEK/O3edNBNrtlcXDksKFE
         Nx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RjNDxqQLiQrT6cuhJSgkypFNo1ihqLVru63JRZy4kmk=;
        b=tEBiA6IrgoxkpJl6Vf/ATXBzDbssLMiOu0DmqQVixX6LCnIGvc9YcBw0rgl8tLuvIG
         acZlVoDOAKwmyWm5voKvd843za36+Q8cSFlNuuS6yANt3Tw+hznALDzDrag7JI1F6C0W
         DZp4L92b5328YN9rt917PhPvvDxNfObRYR+DcG0RhBtBUAv/NFsS2JVJMWtRawPKdW2Q
         aU3xqD2LS0QMOYMBvrDehDKeUyU4SnV6x5RMOr7exE+hXMfnzlnwXHSukvL1Y1AMkQ+j
         +pxqxMgX8PR31PAiqN6fleSoY/1AS9C94t5D8ksq51r8LdrGo997FFUyMZ2WpNdNJg3y
         C/HA==
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
Subject: [PATCH 4.14 007/110] tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:50 -0800
Message-Id: <20180307191040.693986189@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309045256523851?=
X-GMAIL-MSGID: =?utf-8?q?1594309357996810306?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -202,7 +202,8 @@ static int tpm_tis_recv(struct tpm_chip
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	int size = 0;
-	int expected, status;
+	int status;
+	u32 expected;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -217,7 +218,7 @@ static int tpm_tis_recv(struct tpm_chip
 	}
 
 	expected = be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
