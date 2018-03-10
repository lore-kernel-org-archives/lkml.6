Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvcnuRQqzLKd/JbPHiQBL0dN6v5ZsuW27N2LKb/uwjyxSUEMTdZDAB/fFUrkOu3e6AJGXqZ
ARC-Seal: i=1; a=rsa-sha256; t=1520641138; cv=none;
        d=google.com; s=arc-20160816;
        b=C08McuLWbVxw0WFoDUSzckv/vrkHSZdtx9ms/wowPqjUB+g9yncJqptQp2xWHbb85C
         k3c+A/ibzvA8ZdyTyvKUGN+VS5IndvCAo5zPpx6ec0WBVqBQm3L2bDwOCZ/h07JaKixh
         DvqwZGfpb7959E7mmwOlUfzPDb7u+nfa7vWwOFRjrBZhIS2mv7rkKR0ASezNy40A5Cd6
         2m6puPLhIFs9sPGixI93pGH3Pkf1oIMLRYI2P9BoB6FXbNdgEeUgAkIcjCq5ZfTD8WRG
         ADjtrh3LmpnsEcMS4s5GhFLQAYaZZDNnne+eujjf4AVpy0jnR9qOGhsPFfmTJgmZlwzJ
         6hnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VxFTtUp+CRN7U9x0c6GMkQPa7CufQXJoTB/8uLOnDW0=;
        b=tgrmayiYRHvQpkuAfvFctJ7Ofg908aWzK5q5vPVKTVrFJVnOiPwlX7qmRZajEX+rFh
         /I8yq2tdgrjm/VVdGiEuEMksv4Ok2/LrnDTgjhal5cQir6E/K5wUqGBRlszc8zO8RjKk
         iNKdmRMrn3E6R/gH8dKFWE2zJQlsqnBojwYhQf09Zrn2KBJeLwEzTEn7z80NlR2uSlTy
         wOtBUsO6RfpopdW4LK3k4v4M2K8xTh5C7Stmo6HQxYNdTP4lZbh3NmAY7HbXg/unmvAR
         sOR96JmxsvYY9R4IcoK2e7KTe2ssgyzZeFiO9UDHHGEv9vgcaYvLC8xuUJUehYZWECqs
         ljOg==
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
Subject: [PATCH 3.18 02/21] tpm_i2c_nuvoton: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:24 -0800
Message-Id: <20180310001801.206082552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507802508927264?=
X-GMAIL-MSGID: =?utf-8?q?1594507802508927264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 	struct device *dev = chip->dev;
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
