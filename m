Return-Path: <kernel-hardening-return-13058-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+o5dhMUO9Yyb1W+kDFn6m5jEqFcPvD47DW82cY2F9WC8FYcKUg62SSfRPpC2wwtn9RSuBB
ARC-Seal: i=1; a=rsa-sha256; t=1524132715; cv=none;
        d=google.com; s=arc-20160816;
        b=R9hTdbyzoIM58ixmrY9K9i6I2EdMyM7J9e2mbSQFsATrMRIyNnaEN8QyvHIqezZAoI
         dIsBKcFxH/kvDnTf81AnQygG4rEjVrEO8xvzGsKlm/JMNDbW8XP2ol6n6zb4LMIrpVYx
         SoCnEwnN8GxZyoan45GB4OctdSRXeSMMCqbv5KzacJK5CS634BPS5Id9ACFdwYYvcTAb
         CUQIVIg7SLoJU6X+9+tgH3r98J8EwG9DMWga3r3AjHxkdEj0cklh3BHmU5Aojc7DLMs7
         3Hc8rahKhns4V1A3No/VNghkuQjvljclehXnESqrwZGWOpI53fdVAgJw+/f9TyEDxqIv
         S2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=gfB842Af8PWCWK746Zpy1GVFG1SIhWGgMQPDQhH/W/0=;
        b=OsHN6i306z+DE0eHxeLX9sGRt8R4vZnU899Offc0gOlqDJyEL5eSefRieAviiUSSdu
         zwbwBKKkLummIJE3sj07wengdC33tev33hB2n2tNzoVIYBYO1sjF2YX0HT8O/NOQPeMc
         CJiWSH7JK6p2m5Nuco1oPOdZlKchvshW+L7cNioEvyCEA//6GccaMpQUycH0VwOhwwfY
         uP2FFnlPry5170SGj2BVvtNhWEvDaU/94OxUs6Sb673Py2Mfvk6O/3Ppbr0pJjeanJ8u
         dU6d9z6QCaqfeWeuHu5PCLH4Mx0ILxD9L9XY41e5NXORbTYHSvDw/PXPaWCGEpweFtRZ
         fIdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13058-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13058-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13058-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13058-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180419100935.340306831@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 19 Apr 2018 12:04:48 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
 Segher Boessenkool <segher@kernel.crashing.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Andrew Morton <akpm@linuxfoundation.org>,
 Boris Brezillon <boris.brezillon@free-electrons.com>,
 Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
 Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
 Tony Luck <tony.luck@intel.com>
Subject: [patch V2 7/8] dm verity fec: Check result of init_rs()
References: <20180419100441.548834519@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=dm_verity_fec--Check_result_of_init_rs--.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598168985985100525?=
X-GMAIL-MSGID: =?utf-8?q?1598168985985100525?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The allocation of the reed solomon control structure can fail, but
fec_alloc_bufs() ignores that and subsequent operations in dm verity use
the potential NULL pointer unconditionally.

Add a proper check and abort if init_rs() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Colin Cross <ccross@android.com>
Cc: Andrew Morton <akpm@linuxfoundation.org>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Alasdair Kergon <agk@redhat.com>

---
 drivers/md/dm-verity-fec.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -308,8 +308,13 @@ static int fec_alloc_bufs(struct dm_veri
 {
 	unsigned n;
 
-	if (!fio->rs)
+	if (!fio->rs) {
 		fio->rs = mempool_alloc(v->fec->rs_pool, GFP_NOIO);
+		if (!fio->rs) {
+			DMERR("failed to allocate RS control structure");
+			return -ENOMEM;
+		}
+	}
 
 	fec_for_each_prealloc_buffer(n) {
 		if (fio->bufs[n])
