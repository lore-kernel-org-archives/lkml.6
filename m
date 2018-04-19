Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx4/zR3sS6Rqr/GIx6HhT+tCgaEIoWoi8612nZfG+3QgTFllCKLaAd8NnqGL/4rEpRTczlmWV
ARC-Seal: i=1; a=rsa-sha256; t=1524141793; cv=none;
        d=google.com; s=arc-20160816;
        b=jpiahO0b+S49F//FRIaErSu1voTTJkGTAdonwUj1iTWUvru6vNPWGF8fuaMdnAa5n/
         Y1skJSgtLmEc8tFSsklE6MpINp1n4lndzQCdLXePZMN4o2EQ6Vzeu2VC9FZRMNR8GC0s
         5wZ+DDlOAjzJ/LGc4yQ5yMCOGa2Qp7oaqBPML19BbovVX3f5REgJpmxVA1v+DQvcPhoC
         +vuupGooax6u07bmx5CSQQxjCcWEAlJozlkIZCkdWeT1TSHsxcQ/xMF7PpZ/NdJW2b2y
         KQkg4G39cKT8OnwH2DZWSdGomEysq3cEQSjisEZxLJgdgfl43uQbaKNGEKl1b0NCZ5Tt
         NwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RWGKGj9U1FaZ95dkodI1qde1IXf4jl54VYOy76x0G00=;
        b=sw2cj/eZ4E7TBpKDVib+Y1ERyMzkteIIaXjylbjte/Ub7/8TFGHK/L2RK4oUtVmU9C
         LgL6u82cooElQHNDuzCPH2ld0SmapeTtgecOO/aSQfpRLHpF4Gyj4TEEHY9tdNPv76jQ
         CUv5aDxO3COFZaEjZIYlKDuDG3u5ASFgS1SSDXrlp9X5adreecG0h+waXSWVQ8AY73Ck
         axGlqT6bLiuhqfV0/cJNoqE4nH0DVOT1JSPj69TRMwltYFNtIIiVnGoVMbDvFuQfQEuT
         4dI+FuIgL/ehNTCCl3rEKvKwRwZtOP05+gr2iP8SEijYv/KUMsTQyCILGMbK/6zx9heG
         U0mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sVf6n5XQ;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=sVf6n5XQ;
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
Subject: [PATCH 26/39] rtc/proc: switch to proc_create_single_data
Date: Thu, 19 Apr 2018 14:41:27 +0200
Message-Id: <20180419124140.9309-27-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178505716638463?=
X-GMAIL-MSGID: =?utf-8?q?1598178505716638463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And stop trying to get a reference on the submodule, procfs code deals
with release after and unloaded module and thus removed proc entry.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/rtc/rtc-proc.c | 33 ++-------------------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
index 31e7e23cc5be..a9dd9218fae2 100644
--- a/drivers/rtc/rtc-proc.c
+++ b/drivers/rtc/rtc-proc.c
@@ -107,40 +107,11 @@ static int rtc_proc_show(struct seq_file *seq, void *offset)
 	return 0;
 }
 
-static int rtc_proc_open(struct inode *inode, struct file *file)
-{
-	int ret;
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	if (!try_module_get(rtc->owner))
-		return -ENODEV;
-
-	ret = single_open(file, rtc_proc_show, rtc);
-	if (ret)
-		module_put(rtc->owner);
-	return ret;
-}
-
-static int rtc_proc_release(struct inode *inode, struct file *file)
-{
-	int res = single_release(inode, file);
-	struct rtc_device *rtc = PDE_DATA(inode);
-
-	module_put(rtc->owner);
-	return res;
-}
-
-static const struct file_operations rtc_proc_fops = {
-	.open		= rtc_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= rtc_proc_release,
-};
-
 void rtc_proc_add_device(struct rtc_device *rtc)
 {
 	if (is_rtc_hctosys(rtc))
-		proc_create_data("driver/rtc", 0, NULL, &rtc_proc_fops, rtc);
+		proc_create_single_data("driver/rtc", 0, NULL, rtc_proc_show,
+				rtc);
 }
 
 void rtc_proc_del_device(struct rtc_device *rtc)
-- 
2.17.0
