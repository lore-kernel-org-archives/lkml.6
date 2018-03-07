Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu7sC0CxMzxZM7ASxIlTzktUxlT53G3Vq5Uw9lGinI/o7WBllmO1YU1HmKfy/0LGMN8dDnd
ARC-Seal: i=1; a=rsa-sha256; t=1520451651; cv=none;
        d=google.com; s=arc-20160816;
        b=FizCofFgQhhB0EF54EUfUirUHjdk5JdRIeX5aFfCkcQbk8cTQKlvbKD8dHYuFfF9Bv
         hTH0BOAcgZxrs7EJvAbLR9nBxL4XcP1Na5fGN4uJ+JwEO7d+9zD4Eyd+bcicI7H1T5jp
         tG8PozRapD2/scsyOVSRJTG0zT+XGftU22Rx6TFUY5ZbtIlylY72norI/l4fE9AzGMA8
         FUs4lqRPWvn2oI4IR0SDjHSmPkfl4yAXbQN6VKgngCn/mW7FE99252ilkqTyjVlkZIvU
         7ViWiydAhCDJyhORXMp3YD0xzhCogvkOTy43MF1z1dJGGL4MXadIuq79ty56vY9aZ71X
         6vzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Om7Z55wEFjz4RhxZBOMxSwuJtXwvN5w0jQ528v3nloo=;
        b=IAGtJqy4SCFZO9Bpl5qfo4nnoHHRAhWhzwTazZCmMDNVVIwGPb9gO+otZACpDOft12
         GqZDD8i6bDDjPR4BdAyZbQIdW/snF+pNPmGvNq4tEaM0erhzT3Jl0iahRkkGYwgzZeXK
         j3wek+pSWSdaO7c6pYMReuy3XDu4lwZJ/Mz3rrtH81FtuRriVjDp9CANxivwrwqOU8fK
         CYC6i3uC3OrkkvAIzH/HlBWQOUYKof34DFPPBgcIntXZYHbKPuoME/mFiZLQlcG46TUU
         MLIW+6MTXSEGG7FC2b7W3FdwR3hM9hrMw/W9hgBEhKbTR6jcc6n8drEh9NvRQOMyL0Lt
         04Lw==
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
Subject: [PATCH 4.15 009/122] tpm: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:01 -0800
Message-Id: <20180307191730.595456756@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309110993937114?=
X-GMAIL-MSGID: =?utf-8?q?1594309110993937114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Boone <jeremy.boone@nccgroup.trust>

commit 3be23274755ee85771270a23af7691dc9b3a95db upstream.

Discrete TPMs are often connected over slow serial buses which, on
some platforms, can have glitches causing bit flips.  If a bit does
flip it could cause an overrun if it's in one of the size parameters,
so sanity check that we're not overrunning the provided buffer when
doing a memcpy().

Signed-off-by: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: stable@vger.kernel.org
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm-interface.c |    4 ++++
 drivers/char/tpm/tpm2-cmd.c      |    4 ++++
 2 files changed, 8 insertions(+)

--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1228,6 +1228,10 @@ int tpm_get_random(u32 chip_num, u8 *out
 			break;
 
 		recd = be32_to_cpu(tpm_cmd.params.getrandom_out.rng_data_len);
+		if (recd > num_bytes) {
+			total = -EFAULT;
+			break;
+		}
 
 		rlength = be32_to_cpu(tpm_cmd.header.out.length);
 		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -683,6 +683,10 @@ static int tpm2_unseal_cmd(struct tpm_ch
 	if (!rc) {
 		data_len = be16_to_cpup(
 			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
+		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
+			rc = -EFAULT;
+			goto out;
+		}
 
 		rlength = be32_to_cpu(((struct tpm2_cmd *)&buf)
 					->header.out.length);
