Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELti9MWiCMK/QkQz6FLrW5TLSjtMRCLkXJC4mNGCHR9di37CsPYhjGH8KLW+INwf2vYXa11v
ARC-Seal: i=1; a=rsa-sha256; t=1519412216; cv=none;
        d=google.com; s=arc-20160816;
        b=0M9/NqrU0UctdouIWipYnbM2j3hCc/kMvxiDe5mVsNVmxivdqJN4s6VAwU055WLWt5
         xo4LjZilWSBGm5qSWmbb+QgD8iGhMQ9g9SE+qbSbXYmIyZyxs7T/D6SswA/7ajWTieff
         p7SkB7IQ9K1ZlkVEVSpOl0tcTZSIp0bXUlUUm6YvACy9wcBGoRJ4UcR3LrIXhlNg9zrp
         MX3fFu7IRDnPhClj50rKYKsI8la0n9hqacgBDqPZlCV5AQf4weaETbfdyN6XR0RuZigi
         1UWQdzRTAuBmZmLOGz36skRKaIdgGOtxJWCKoL2VG2EejQ4cxviw+A6btQqMKMlW/LvX
         PxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vBTPK8W7/qyMhbgVOV33rqhJTdDiLps3G1yFox1IptM=;
        b=E92IApbgowOPVkgc3w4DKSs3x+CXDzYF50L7la44RbkZYxGnXfe0/1TXAhSGT/Zc/j
         z8pp5gX4nZFXMPS7T8UQO0rO2DFdO4CRwJqqKNVYHZteqAj+3U4Mg8Pnr9oePY2C3FxS
         2KYWdUedjaoKwu93o55R+l7E0cKhnuqlh8ewECZxK56KJzbWfNr9vt0mDwU49N2VwD1B
         cUh7Kq9jmOqf7L4/MtNj+1gAm0JTDA1IZYLnriURbrJwPDMGwfcEgXSevNN4rzl4R53K
         0ATPR1LNyR67KlCfN8o2igSN2UbvlTHnB+OnzUWuGy51VD8W3OL2Y5zRng94f8ccN+kn
         qR2Q==
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
Subject: [PATCH 4.14 154/159] crypto: talitos - fix Kernel Oops on hashing an empty file
Date: Fri, 23 Feb 2018 19:27:42 +0100
Message-Id: <20180223170801.591220137@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218624011124864?=
X-GMAIL-MSGID: =?utf-8?q?1593219184736246806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/crypto/talitos.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1124,6 +1124,11 @@ int talitos_sg_map(struct device *dev, s
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 
+	if (!src) {
+		*ptr = zero_entry;
+		return 1;
+	}
+
 	to_talitos_ptr_len(ptr, len, is_sec1);
 	to_talitos_ptr_ext_set(ptr, 0, is_sec1);
 
