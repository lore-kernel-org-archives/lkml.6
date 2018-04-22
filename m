Return-Path: <kernel-hardening-return-13085-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+D3MLrULrmRrNf54de3R7Eyp68yHtGrgtoQpb9SQB5LhXfrSr5V2SHiC6scaPr94lohfD3
ARC-Seal: i=1; a=rsa-sha256; t=1524414824; cv=none;
        d=google.com; s=arc-20160816;
        b=sS7jHyl90g9nz6OUPZIqbZqdAbpLHSEqqyODGxxHoJ3V903pmvwoX6c9/KWfuT5QFJ
         o4X38rX8E/SFSbteB9FZD+8cVzabPpJhHHgexQuXCkyp13unGUH5sxGGv4n4I2/KshKU
         qDKl7IO87aLrnvo3CH8UKO1fZIb+UJg0zcjI8FrP0ThywDLnRxxvvbxMTDHuiN1kfneQ
         B5yCX/iGIt0x9eaWCNURjLSW+T38T8UvCa1mvX8wYR0+T+VOXQMmd3SO14L0T03fHkGx
         zhGTI//nZGfT8FfFpubUHy3+mAiPO951T4To4k+aHrE46LMw7FxosfjjAuCT0e2XFj6T
         QUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:references:subject:cc:to:from:date
         :user-agent:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=Tsqpwv7K0hcTZTKO/vCUIJqpo0LDAnnAESc7J1Tqes8=;
        b=KG9GylFD8DkwSk0ZFfMf+9KqBVGRIvo9GnqFiJxdis4utI6acr5t8pD9QDQWSNArFF
         lC/SVxEaDwd3zuidgppmoxJ3r9zmsmfFZQpED7RX56UX6IpwhQlpaI2Lgm4cyUmG5ghf
         rmjUE44wLY/mC+0eXpiwDzJnaUERE/iJqMuL10mZsHr8M03SR+KA7kANbMkex8GFmonA
         J4Qp3yhCyAsLrJ//oNEh4UT/p1O24Nq7ceNcz1ror13a6QfYSie2mZh3VvMDy6XONk4I
         G9KFLJlPuLpW924mF572LeS7Dp77+7viicvdfk/XELJ5YiIbqjNuKQKWm5kTAtIJLLps
         6AtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13085-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13085-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-13085-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13085-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Message-Id: <20180422162512.458372618@linutronix.de>
User-Agent: quilt/0.63-1
Date: Sun, 22 Apr 2018 18:23:47 +0200
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
 Tony Luck <tony.luck@intel.com>, Neil Brown <neilb@suse.com>
Subject: [patch V3 02/10] dm/verity_fec: Use GFP aware reed solomon init
References: <20180422162345.004292133@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=dm-verity_fec--Use-GFP-aware-reed-solomon-init.patch
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598464799247851272?=
X-GMAIL-MSGID: =?utf-8?q?1598464799247851272?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allocations from the rs_pool can invoke init_rs() from the mempool
allocation callback. This is problematic in fec_alloc_bufs() which invokes
mempool_alloc() with GFP_NOIO to prevent a swap deadlock because init_rs()
uses GFP_KERNEL allocations.

Switch it to init_rs_gfp() and invoke it with the gfp_t flags which are
handed in from the allocator.

Note: This is not a problem today because the rs control struct is shared
between the instances and its created when the mempool is initialized. But
the upcoming changes which switch to a rs_control struct per instance to
embed decoder buffers will trigger the swap vs. GFP_KERNEL issue.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Neil Brown <neilb@suse.com>
---
 drivers/md/dm-verity-fec.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -570,7 +570,7 @@ static void *fec_rs_alloc(gfp_t gfp_mask
 {
 	struct dm_verity *v = (struct dm_verity *)pool_data;
 
-	return init_rs(8, 0x11d, 0, 1, v->fec->roots);
+	return init_rs_gfp(8, 0x11d, 0, 1, v->fec->roots, gfp_mask);
 }
 
 static void fec_rs_free(void *element, void *pool_data)
