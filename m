Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49e377CTPvyda3k87fR4v7dQ0LoGjbrXUw21qd7Pwe4j4oGrXDC/6EH6FRFTFnQthrP1S1O
ARC-Seal: i=1; a=rsa-sha256; t=1524141710; cv=none;
        d=google.com; s=arc-20160816;
        b=af38gCLeSQxUUT8c9gKryTjBv2qMrG8SoBmfiG+8hV7lywasl1sEg33w7YCAl9+cZs
         //sF7iwYdmK07/E6pbJl3DmCuPeQj7Wh3x+jACLaDzApFhmphntBRSu7QT2wf3jpfQ4M
         j+PYg7sQgqWMayWk8hT0mxXrQpbSFQjqUs9d+5nrj5BBsLQhs3twwlusU6nwr8JhRUYm
         Zf6Won7lU+Lq7Cn4frv5ZkfVzSiqpk0KJXwTDkd1m5KeoUp+C1zO5JB278D3d+ogesw/
         PvR441dHPUG3tBPSxlsdYywimL/VP9URQxY9qnm2c7v6hpQDkPzQbo36n2hgG1fahplK
         D/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=cJes1OhW4NH13lzjMc3PXbipHrYVkpl4//zrNZeV84I=;
        b=fW/R7rlGJQ89JDn8AlAEO9lex/cjr/y9Tky/W9CgDfPJDFH3nmSnmJYqrWydmIf6tk
         s4BR7PXqXxpSNpVcHbLpXpoPgTMz8ZiaiP8RY1i/tCPpcybtvwDibfYDhFiUVuoS54Vo
         cU4X/sKcZ5g6uuSaPn/RMhw7Fz9p3YeF3+CPVSNzPvsry7AMAwi68xm5s7u3PEuryLKK
         l8cvvjFq74zOZQ12ybtHbUywTwcSOfJOqPPUtsDCs7QKyOsMnZefCmPnE1wWqpaW9aY1
         StmmeRJ2vTYP51xYGqKatsLRQ72LdhxvzHgxnIZVbuzPKqRaieM3fCWQJJkbuJSV/ffD
         PvSg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=J6DD3veh;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=J6DD3veh;
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
Subject: [PATCH 01/39] net/can: single_open_net needs to be paired with single_release_net
Date: Thu, 19 Apr 2018 14:41:02 +0200
Message-Id: <20180419124140.9309-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178417551173376?=
X-GMAIL-MSGID: =?utf-8?q?1598178417551173376?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Otherwise we will leak a reference to the network namespace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/can/bcm.c  | 2 +-
 net/can/proc.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index ac5e5e34fee3..8073fa14e143 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -249,7 +249,7 @@ static const struct file_operations bcm_proc_fops = {
 	.open		= bcm_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 #endif /* CONFIG_PROC_FS */
 
diff --git a/net/can/proc.c b/net/can/proc.c
index fdf704e9bb8c..fde2fd55b826 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -279,7 +279,7 @@ static const struct file_operations can_stats_proc_fops = {
 	.open		= can_stats_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 static int can_reset_stats_proc_show(struct seq_file *m, void *v)
@@ -449,7 +449,7 @@ static const struct file_operations can_rcvlist_sff_proc_fops = {
 	.open		= can_rcvlist_sff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 
@@ -492,7 +492,7 @@ static const struct file_operations can_rcvlist_eff_proc_fops = {
 	.open		= can_rcvlist_eff_proc_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= single_release_net,
 };
 
 /*
-- 
2.17.0
