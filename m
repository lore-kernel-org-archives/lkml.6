Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu8f00GA9kU7jN/aE52Z38clBj1PqgNUM80Q2yVi2FhCj1giNLmIxmTWtb9RYDIXrrAGC9R
ARC-Seal: i=1; a=rsa-sha256; t=1520451588; cv=none;
        d=google.com; s=arc-20160816;
        b=WUDpdIA2E7z5bNtomHsqF1lq53Uh4RVAZLD2x2Cgqcip7+T8f53BGJoAJ8oUbiMGid
         807D7fWkkWnfjDWeb5DrAc7Sct1Szl7YACX1wLvJlppyXYCA0HB0Y4sa8ALjWDijfw1N
         JJ5j/0uEJMxSVXLvs7r5J4z8wNIxKv4nJpHW/1lyd67483kNLt7Kn9D2B6ZCl5nxVneo
         1JAStMxU6EIxx5JgF9/FUfYqf1ltJ/ySEXXxAeZiRYBkU1kYyFSxGPnT+CdMEAF5YhrG
         bHTwBiCPBp6KarYW2B5UajWSmYQSKkb56IlrOeREbnSeo4RbZixRekwb8IZhEHLZAhyk
         nrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=S8q+DM+PZKKLS/neJJovvrwEz3o8olyOEeYerAGqeFg=;
        b=TEi+V7k/snrohryUhD4dZU/tV8wuz2BKbLFIKVyVNqTDJ05nOAYDoVEwbdR31k49Gk
         9LnLxVPlvF8v5hAM/jG7xfcwxkyakRrMbc1wdunl7oa4eUFYt9bPn6QUWoHrAUr/3mth
         Op+Y9pvfIgSnvbYP8jcLZgD1jC4SpMa9oudr2qdxOymUR//HF+Owgrxap/giIcBrwby3
         +4rdrT8c2CoUsCkg+uhsgn6I91Cm9FYqElwm/V5kzW7vnOPeiJ4ahpEz6hJycKLwbsq5
         dCMSNjxoymJ5qHXM9NMK0Q8qZim4RTAMCPVhGf35eq0sVhaRD7vBtJCnXlTTmT5g+Y8Q
         nAdg==
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
Subject: [PATCH 4.15 012/122] tpm_tis: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:04 -0800
Message-Id: <20180307191730.988938822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309045256523851?=
X-GMAIL-MSGID: =?utf-8?q?1594309045256523851?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
