Return-Path: <kernel-hardening-return-12814-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/NJIV2UbM7ybUnEPsu9OYKZd5lviyX8d+5wkEEXc78c/08RRSE1AqbobVG643tSySBjUYq
ARC-Seal: i=1; a=rsa-sha256; t=1522270718; cv=none;
        d=google.com; s=arc-20160816;
        b=CgqotQapyELxQggVrv7mVW6ZQBaKdQE9+Kix9maCStY/xnWwfNLnP2LakflLK1Vv38
         6gjNp1y4DZXZVpMxFM56TEkRw7reNCD7n/qOAZjkUc9C1v/VoAW9fbUcKjFQzb4OrtQ7
         AXaKg86A9s/n6b/5hTHgI81Qe1KngBrxBte7myC0rdL/XoxGNoVfavn0wxnCprI50Ykp
         BnqQrLkT6SLjD3MQnCMJeH8SgA0z/Fhe41WSnT2qippMqjykacn2LJWUee/6VDed8zal
         +wRJZxWZz9uLZsLxDQaw5w5sHuNt7pEOODIFWw6+5YB/RRJnFPJRK4fFglgkea8APUGs
         qcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=wcIjXqjuzgulaoTe9mKe3kbSWxLYZllxUED0B0Ot8Ts=;
        b=UH5EQMBJZxLV//HekcaVWqh+JgcPjdunxZVUwuwBQVMkYn7X1MpzGG+su3qkJ1dBXj
         sk+i786t8RtC0R3dhjWkj8gpCXijJcelPj0weeA5yQvSJNanMqzjE66ngxGr3/UCB0Ji
         tnhjv7ZnUhWodTn9MF+aVMB5lJTCcZeDlMkBI8hES0BBr2oHAn1PVN7PkfaYubbmZ8oo
         f2fhC3C3f4ittGpESEUt39mQfxS7/IxaRufASd3p/I1zTEQm4/VjVgRCiFmLeG5wLPox
         xuju8loEWkuCv6kwm6SDOEC+f7sWXlQXbm2NwQSILCVp/SMxrlqEeoeG6Rw4wDSKS6Fa
         Fs6A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12814-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12814-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12814-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12814-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180328205554.845997973@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 28 Mar 2018 22:51:45 +0200
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
Subject: [patch 7/8] dm verity fec: Check result of init_rs()
References: <20180328205138.301218351@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=dm-verity-fec--Check-result-of-init_rs--.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596216540833104312?=
X-GMAIL-MSGID: =?utf-8?q?1596216540833104312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The allocation of the reed solomon control structure can fail, but
fec_alloc_bufs() ignores that and subsequent operations in dm verity use
the potential NULL pointer unconditionally.

Add a proper check and abort if init_rs() fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
