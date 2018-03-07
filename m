Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuOG29yY4nz73OMs8pIUaabCLNddLrx9eJ7o4UotW2RFfhcmoEUHA7xwNsxPNyXmFV7rLpg
ARC-Seal: i=1; a=rsa-sha256; t=1520451878; cv=none;
        d=google.com; s=arc-20160816;
        b=iRjf8SsU1+wf2Bxxylq2hDbRYyR3lEvLbhgyjjPHfRppQKkYMIGdlkxEI23doM25tz
         nd3rBPcNNVqDuZpLJs6Nbk/zPtKLi5Pnrgh8Ci6vu/fC/fGfgzCx1GjwKCFPgilzpA7e
         8hyhlBz/RUsGsqfseRI7b1ODPkpvRanW4G/ANSWKY1pNI/ZL70M2ioylDJVgT9jAjPId
         sg9ucTbhBTiL8psoIErRYF3MHMasguuo/Tan76QA0uHojShweWcf0IRB05Y89IPShjrH
         aj3Yatj4BLuZoAfdCPB0fLbB30km6FSFxWwZKW6OyJ4FQ0DyQ+FtOwD1PJWIJDYYrHig
         oAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=joWS3ALae9oUr9WVnjXV4kOSrOJVzPm8BmpwnH2xkL0=;
        b=e+Rbha+T+ONo2NnkpxIs/vNocvWE/rA22EQ2Jxwtzd4lGr/u2fBO7H6jPkDf6mFmkK
         DwenygIk3nqBbD4uvlbqXJtZFLsKW1fNyzZmfSypP/uzcNbia5ZuJlTP85SJO1NCS1V7
         XwgggI5nZssa3V+lB2FbdmGnc7M23tevKznzAuoUjDGA8cYJQfMFXJMKxSjrft9oBYAy
         ZMeKYTPc+I5Ip1qbvfD3yIXWWP7RGXN4sSJwnaPk/QyJDLrNQE623G4RzofHAzS8hQ3X
         BxLPF9J3sD+YQmCDTD7vqamSKCPLxZBDZLI4Pj/F43JUXyaJDdlpnYEtXtz8XibXK+Lt
         9/jQ==
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
Subject: [PATCH 4.14 003/110] tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:46 -0800
Message-Id: <20180307191040.262256297@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309108141640090?=
X-GMAIL-MSGID: =?utf-8?q?1594309348740480530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -457,7 +457,7 @@ static int st33zp24_recv(struct tpm_chip
 			    size_t count)
 {
 	int size = 0;
-	int expected;
+	u32 expected;
 
 	if (!chip)
 		return -EBUSY;
@@ -474,7 +474,7 @@ static int st33zp24_recv(struct tpm_chip
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
