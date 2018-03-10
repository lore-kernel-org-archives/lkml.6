Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWnLW0Fh2i+VYTY4kPQH2QtSqRSLvQw21tN59a2XAah7ckNez6KE6xaplKvOf7SCLukVTA
ARC-Seal: i=1; a=rsa-sha256; t=1520641201; cv=none;
        d=google.com; s=arc-20160816;
        b=w3p3eVMOTLzbfmf5cZeTTw0dNzUBE4qctiEXgHtfiFIMaUPR0pMP3PTGZ0cZjMGr/5
         BXDXRJpznrbCPT6b9c/07uGQ7YqVQUVkn2L5/7BiE+6v60iJxwExdzk11zJSk2cV+urY
         g89IXFY3dGCRYP1jA3w57EjyPh3yqvpZWO4CO/ZnNpvOIG8/ycE4UG4JKxTVikjRajUX
         uUGH6RYihHBsEL5ab5xU5Xfn041mlWUsfFv30ch0bKPNLHm+4Um/sqbIEcT3WR6eIfzS
         dMihUkPeD4yNveEJiu9VZjUE9ddC2Esov0UJRV1Dr6qJpruwLL2PdEDVE8oMwEHFa/0y
         XtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/Hi+4KDesAaNIub1iNnmYL0uco3/CWPm33LfJmDlMIc=;
        b=G2P1pAQ9Im474vbSiH20xLcuv2dp/dp6QBx2zJhMHTfC+S+6rokqqYPkouvvbkuvMC
         UVD9FFYuElLVEBedRvTBuOtk6i5u5s3MXFfZjbv+xYopV05jK5ccdsCdLkeq/o2J2bzF
         vxLVLILgeKqzZnPCXkfVUMK6cN6IHSDwfk4a1Ezslt9KJ2cMGvHOC/1KhB5ifyDtqXXD
         MS8+Z7NGpj/6piHF3kx6kzlerTGegwdLZthnJHsw2WyWBHSzvb3ROeFpWXwDrm04RGTL
         iew+QylQ3I0hvn2PVcKRXYQJiG6pyudP8Cw1ZdOGrEhoiHt4hsA2R6jbH5zMpmftorUg
         aOXw==
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
Subject: [PATCH 4.4 02/36] tpm_i2c_infineon: fix potential buffer overruns caused by bit glitches on the bus
Date: Fri,  9 Mar 2018 16:18:18 -0800
Message-Id: <20180310001807.334957172@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507795452945508?=
X-GMAIL-MSGID: =?utf-8?q?1594507868731185354?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
