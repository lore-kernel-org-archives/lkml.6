Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuMrbbmI5/wwueQ43LBvIXpwORcrWbbIsljBYn6A5SNKWa90+ybJ0ZoGxQ9KpyezxBTjtRD
ARC-Seal: i=1; a=rsa-sha256; t=1520641178; cv=none;
        d=google.com; s=arc-20160816;
        b=iipLot8HXPsARa71mrCwNJJ+mySKvcQE+BbvMtcCXnGnFpa3FChV/djlomZRXLcwXr
         f/g5ucNCcq/F0twWOppdFqfTY6LbhdncTxtJPYmlK0f7wqnL5QoF1IXpiXIHV9kVA8hD
         hF/OqYnps40Urme/rCvR4XfhLdalFzGbQfkMSCP3fLr5qn7wUpRviKJD1gTJQ+IcxfRG
         gSDVJmxc5b9VHgLNy3P3B6L9FwFOrnBfxyPLly3Yhi3xF5w/tRBf/shYJbAal17bxf0R
         Ye/YQ9JcuTltCUs0uC2bqIqAF6ydrq/KBTzj4ExKdigYfUaNa6StjOd03zWmyBK84fsx
         GeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lFor2EgS4di7IPuWURKevC9vW/cia9Yr6JLv2UDF1BY=;
        b=f7CZggNuq0cCmKfWe7MOZMFmfpJKlFvyrRCynVLsZq7OrAEMSdqS+EucOc6pUvQpyL
         ofBjHhf/NwhhjZf3MrkiX1DFjot0O//NkVyGmcfi1/xYpGvBgr/pz3IU6HD3tKLCmiCt
         t9bHvGuL94PO4ajiNnf2jKT1rO0zoM9/C/dq3UhgtWEGwPvVyRqSJOguv4KpyS9szXcW
         +z6s9jGX8A9P3Q0+z0eZp2xBi7ok7W9qGx3bmykVpbBbtuPlJejr6815A2/pQtZLCb2o
         WygUIzOc4L2EuBEIOiKK72MRYqr/KINsamCl9DdUIJTVLk36SkuNh4Up4SiRYYMQ/lsM
         4NJg==
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
Subject: [PATCH 4.4 01/36] tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:17 -0800
Message-Id: <20180310001807.284827871@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507844701877180?=
X-GMAIL-MSGID: =?utf-8?q?1594507844701877180?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -485,7 +485,7 @@ static int st33zp24_recv(struct tpm_chip
 			    size_t count)
 {
 	int size = 0;
-	int expected;
+	u32 expected;
 
 	if (!chip)
 		return -EBUSY;
@@ -502,7 +502,7 @@ static int st33zp24_recv(struct tpm_chip
 	}
 
 	expected = be32_to_cpu(*(__be32 *)(buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size = -EIO;
 		goto out;
 	}
