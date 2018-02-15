Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227rFoxRdzT2oiwL8gPEuDshwqZDQx4Y7ZsepVsLhfGGPw1L8ng+c8uzPc0UEMLxIXJMLK+2
ARC-Seal: i=1; a=rsa-sha256; t=1518708466; cv=none;
        d=google.com; s=arc-20160816;
        b=q8E2r5FjZot6oxJmlPZAJEUqDx2de8iYDOZQBK2RUrRIJX0N8Dj2ZM/BFRywZhBuTV
         O3rXKdrH+q5zAJmjIr5Y6kGv3NM1Y8DeVz1dEN62LFQ9BcRH0605+P6tXgctOFJGQXFy
         BLOCdEsBxKp7/hRDv1xugX7ORjUK2JdWlpj7G8ybbKPO+PLKziShNOZuzJsdkVpkSCnR
         tehOTTIBiBqSzaiqP/RL8cQruYQeTnFjpBxn2ij4EhFUWOP4a9nJCFk5aKPHL77Hzbdy
         /WFa6Kh4FOGc40MLlODA04tJxnJcQR0yOZKMAkeUdPh5M/aD5cmzAVOW4YFn4cnDanJG
         EwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=24njrcyBDQKwfTbV3SVSh1T/5rUZjOi5xAD+3AB++Cg=;
        b=yDvtR/CPEoGIREEHzIIiQEEXP1g7AJNgByACqFNZtxuXkX3PQ4YMlYpJkoNR9p6NaN
         V/tluO6H1+ytgxkKdto5/KUqDiqXsQeRYKV7kdAYdW9eItsJKjZ2bPXeGV/uzvW656ij
         SvI2t4XRBQixlJ3mtqeb5IXFI6jUuwDMCa9uAKX2Z/9IGMhFvdfpEbn+D4KlHEPQQCej
         ljRILYMdcacgGgcTJvrzCDPKSlQ6lkqDqG7Tmsy8EzUgvYk9o6TXTgSug6CWF6IGUrvH
         15JCwsflv7PwZ9h4BkaZixla+Wa/ZUqeOry1CNmc8BQ4afd/eSn31r+CSQ3yYzEcI5QM
         9Kug==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.9 51/88] crypto: talitos - fix Kernel Oops on hashing an empty file
Date: Thu, 15 Feb 2018 16:17:18 +0100
Message-Id: <20180215151229.786726949@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481248467239227?=
X-GMAIL-MSGID: =?utf-8?q?1592481248467239227?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: LEROY Christophe <christophe.leroy@c-s.fr>

commit 87a81dce53b1ea61acaeefa5191a0376a2d1d721 upstream.

Performing the hash of an empty file leads to a kernel Oops

[   44.504600] Unable to handle kernel paging request for data at address 0x0000000c
[   44.512819] Faulting instruction address: 0xc02d2be8
[   44.524088] Oops: Kernel access of bad area, sig: 11 [#1]
[   44.529171] BE PREEMPT CMPC885
[   44.532232] CPU: 0 PID: 491 Comm: md5sum Not tainted 4.15.0-rc8-00211-g3a968610b6ea #81
[   44.540814] NIP:  c02d2be8 LR: c02d2984 CTR: 00000000
[   44.545812] REGS: c6813c90 TRAP: 0300   Not tainted  (4.15.0-rc8-00211-g3a968610b6ea)
[   44.554223] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 48222822  XER: 20000000
[   44.560855] DAR: 0000000c DSISR: c0000000
[   44.560855] GPR00: c02d28fc c6813d40 c6828000 c646fa40 00000001 00000001 00000001 00000000
[   44.560855] GPR08: 0000004c 00000000 c000bfcc 00000000 28222822 100280d4 00000000 10020008
[   44.560855] GPR16: 00000000 00000020 00000000 00000000 10024008 00000000 c646f9f0 c6179a10
[   44.560855] GPR24: 00000000 00000001 c62f0018 c6179a10 00000000 c6367a30 c62f0000 c646f9c0
[   44.598542] NIP [c02d2be8] ahash_process_req+0x448/0x700
[   44.603751] LR [c02d2984] ahash_process_req+0x1e4/0x700
[   44.608868] Call Trace:
[   44.611329] [c6813d40] [c02d28fc] ahash_process_req+0x15c/0x700 (unreliable)
[   44.618302] [c6813d90] [c02060c4] hash_recvmsg+0x11c/0x210
[   44.623716] [c6813db0] [c0331354] ___sys_recvmsg+0x98/0x138
[   44.629226] [c6813eb0] [c03332c0] __sys_recvmsg+0x40/0x84
[   44.634562] [c6813f10] [c03336c0] SyS_socketcall+0xb8/0x1d4
[   44.640073] [c6813f40] [c000d1ac] ret_from_syscall+0x0/0x38
[   44.645530] Instruction dump:
[   44.648465] 38c00001 7f63db78 4e800421 7c791b78 54690ffe 0f090000 80ff0190 2f870000
[   44.656122] 40befe50 2f990001 409e0210 813f01bc <8129000c> b39e003a 7d29c214 913e003c

This patch fixes that Oops by checking if src is NULL.

Fixes: 6a1e8d14156d4 ("crypto: talitos - making mapping helpers more generic")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/talitos.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1127,6 +1127,10 @@ int talitos_sg_map(struct device *dev, s
 	to_talitos_ptr_len(ptr, len, is_sec1);
 	to_talitos_ptr_ext_set(ptr, 0, is_sec1);
 
+	if (!src) {
+		to_talitos_ptr(ptr, 0, 0, is_sec1);
+		return 1;
+	}
 	if (sg_count == 1) {
 		to_talitos_ptr(ptr, sg_dma_address(src) + offset, is_sec1);
 		return sg_count;
