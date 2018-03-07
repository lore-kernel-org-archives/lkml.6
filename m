Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt1jKPqaePFSGN/nutGC2tXhriGQyENpjaDJ3xDEcuC1B/s85Mf4n9aeAH8tHhm0etMkBeD
ARC-Seal: i=1; a=rsa-sha256; t=1520451649; cv=none;
        d=google.com; s=arc-20160816;
        b=pTcsdIGqoIsAdoNpEgdOzF3kf/VOLBo52lSF0Shsjt/sBmicxreEsFr+119gj6kUOC
         t+woLwLiRkHVlzjppKR3aeSY37D4jBGhoG+yLOPPwCdAvzYzGC1jChNm4IFqVdfL8Aq2
         /KRSGI5fsADBraB1Mres661Uiopb701w6o8IwsPzzqBJ9O2UpTPOh7Nyh2kxO3CSC3gT
         CByNXjTzTaRJu9s6JfemB8vrduiWT4TNfx361usCbNAKusZ7LpQyIKl43aelD3tLJUO1
         7sS3IcdbsLIDslfTHWTz0zwnHIxWpnPRRQZR5ItwPg4tmXSAG8ZlEFxy9aD8Ik4Jcxvq
         rrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IPtMTPEhCiGXD85ayXM857513sn9T9Qi16HATCPf5HU=;
        b=dCppqjsBuzdZlenyBLxn+In6Wy9NqKOBkOvtLPHskGz9RsJ3uooYSXTiGn8+s6HXT6
         coHC6eJbzYEAVjCcpa9X3vrzMI0TI8q0iNzcLQL90Re8fbli7TpRULNt5rsGO2dnuHZZ
         YAkLAPv/jbtSbmjZ25P0BGlyTiLmDepEnd/X8A8Ry9wVzyuji0HuXFVGzo9F6I1Qd+yQ
         SfCcSWlaX5AZrqrp42uuDmPWzzUHtX4NKYu9ljzFRbhTgQ+o0JQGzKl3j0D35E1tlo7o
         AomVirHVe05Az4GnV68WcDxs02HF11swLtLllFCApP+FON7tLDUuUv/oJA0rQul9vK23
         85EA==
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
Subject: [PATCH 4.15 008/122] tpm: st33zp24: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:00 -0800
Message-Id: <20180307191730.479765771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309108141640090?=
X-GMAIL-MSGID: =?utf-8?q?1594309108141640090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
