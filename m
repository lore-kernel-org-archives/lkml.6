Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELslrQFP38uvpBrWkdWz0B2E5LhVnUBqtF3RHB5iBCYugszlf6JyOTSj3VJGB4I7bMdZx9G1
ARC-Seal: i=1; a=rsa-sha256; t=1520451880; cv=none;
        d=google.com; s=arc-20160816;
        b=FnT0VEoNU3eRH5z80sPrmsepT+vjhFGa9Lq94JIWTH2hPO6UC07Y9MhHcpmdLV7Fb1
         6QZlPQZNAi5QYcJSOBhqHrFHBABlmeCIKRbi+GD1YHgSLEXZTIkt4+Iz6sRUH/MrtzwT
         ZXMiQWQRM0pctn8Y/ia+ByIbHUDlhL/rs4rAhOTh+pMU/EV5mFmE17VBdnVrKCfzCxBK
         MeVge1ryuOSu+Z52RjQ2jZqFD+17HUnSsGzPMH6bgjpgT/4tYtSniE6IITrMKQ56mJP1
         tG+qvYDiDqmZfRMXpdaOGXYBMb25bn2gwVK4xArPw3O3mXkAXk6W/pesCTeLOetFpmu0
         VTLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=p/QXb8NcE9HUzzbAKxS9aJds3gWcLERFV4Rbj7cXD4c=;
        b=azUkRR6biIHViDvQsJk2+FpimagIaeDolEZUigzJiPv1GioWp+wmMgqybuG7CKUhNj
         QGMAGymX5YIhPHEYIxCYValxjBb2DMf4bTt/g0shM69PsTuj3ADVeQL0Ryk3NoQ4xiEg
         /fh0Zs4+KHOPFXhHucWvMjdbGv+64m03sLWwT8R8T5bszbqo27t8URcrUUknJuVia8aB
         phB3OkMr1dHS72nZQ0ZYWYlRyE9lAD3XROigINj3C5/z/ObF8OcTrm9Q0He2P8CjN/0V
         LJnb2WIwwRx34MmBRDSk2E+qk8IgKAjxyS8EzpH3ycLEU2Apa3Oh5NGt6TMqLsoB0hG1
         rFtg==
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
Subject: [PATCH 4.14 004/110] tpm: fix potential buffer overruns caused by bit glitches on the bus
Date: Wed,  7 Mar 2018 11:37:47 -0800
Message-Id: <20180307191040.380529457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309110993937114?=
X-GMAIL-MSGID: =?utf-8?q?1594309351450508853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
