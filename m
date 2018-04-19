Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx48YUr1Qm2Acw56ZiY+kTRTBfJqrwyJc3Qp8GFwdaETFXtgKYAQnHd6AOta5QB9eqSKDPHmV
ARC-Seal: i=1; a=rsa-sha256; t=1524141709; cv=none;
        d=google.com; s=arc-20160816;
        b=od4KW/HO9MB0gsHQ2tMUZQjAVYh+ByEncz6zJ8JfqS8iiveZoKB1/nOE1VPaepOBqs
         hOgz+LahE08B5gzBHaElKWLJk+hxFRAsHHdxLiU/n9G42uNScGIb5gHFyWGIWUUBJ4Ik
         VirQ3l/xthtVas7GrkB2Hw1oa8sRPJ495zJHB2MCjgvo78WXtA6Ql0Sxx+qPbs7UCj7c
         FwpzyHTWfv6vdLIVmjR2NNk/BYcMPnSrmoIE9WwlnvfI+8aimJ+8NqB1UTiZHj638vdm
         Tn50hqF6kzXFEEMwAxBL971Qx6Sd3VaeVTEMpA50RL3EBNy+tY3nPt2BmUJ+erDCCrxg
         avUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=4qj+eU6qx0I6g69pd3CenUyPDi/JgJGt5ljbNpVMvj0=;
        b=D6hKTiounZpRiF5O2ecAu4qMCjuyKUAcr3V2hIxE4jz4Xz+FJF8RTH6aw6hMonwyTA
         x+nWFNodnBSXRq5Fdbd13+bDWZeVWZiPySdBcCdpzULN4NEX+XsGc3drT8fpAB6sDiBz
         QA9gXPYh5cz+5Av7fauDoQku6Ch//nnN2mqIUJGphOqI45wr+mqK3wzFy6RhU9ugNYQw
         SzZC7VVDRcBHGlQROxGBkR8uQymqOplqI8rZX2+KHfPqUSxW8jmOMiiD6AG+rM+5YF6P
         bH2nS1M7RlvmTSTOtIDy9SIuvG/V9dAmB0nxVKy2GtZHWje90/AOROuEy4kAQ0d5IJRN
         N9iA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=h+DQLOOh;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=h+DQLOOh;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>,
	Corey Minyard <minyard@acm.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-acpi@vger.kernel.org,
	drbd-dev@lists.linbit.com,
	linux-ide@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-afs@lists.infradead.org,
	linux-ext4@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: simplify procfs code for seq_file instances
Date: Thu, 19 Apr 2018 14:41:01 +0200
Message-Id: <20180419124140.9309-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178416995714531?=
X-GMAIL-MSGID: =?utf-8?q?1598178416995714531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We currently have hundreds of proc files that implement plain, read-only
seq_file based interfaces.  This series consolidates them using new
procfs helpers that take the seq_operations or simple show callback
directly.

A git tree is available at:

    git://git.infradead.org/users/hch/misc.git proc_create

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/proc_create

Diffstat:  268 files changed, 1193 insertions(+), 6194 deletions(-)
