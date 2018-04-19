Return-Path: <BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AIpwx49ZRBcPdLU1DQhfyEDpHAYOe2+JIBNZBf4VJCZRnnOlyuoNqNFHa86gbs7PbIDSjmBVIOV8
ARC-Seal: i=1; a=rsa-sha256; t=1524141817; cv=none;
        d=google.com; s=arc-20160816;
        b=thC2sodpvICXUS2oADgQqTHjDcUtf0uFy5hmB1IH2ReV5CWg/rXuwT4uyylpKIzBWb
         4FQxYfCMA6KWj/vUZvT9Fo30dXF0tQ7NWYu1mCX6uH7P5eqMlrrqKJ1dIBzySo2TAwwQ
         apTQ9YLGsmMJPYZbIEieeASlHX24ryl58Huiny6PlthF7FoRPMUmIGKKpl339XZu4wf/
         9hRUXzOd7/3O2NQSLcr54B+sPtPaKHHoi7DcKs9frc6hLWUtjKPPPELdvNQIua2bv1dm
         /8UjR4fdfE6M2KnxCP96JKRAr1+d7FHtqE/f5WgdBw3AWoIK9yMqOMel579Zf1K9VWkl
         2Yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=SNrHWn9W2FuYRWu3VqtGPQFh08ahxN+WgYaSaDAmjZA=;
        b=lSroquQjdR7S4hgHYLDDuLVSqw58OnGl/lerKtKX5MUaNyq3a4fR0xYrcIZe1r+PF3
         DP0G8tsUcerJCnCEPNU9x0DdxuCkV7drfcvG7rOQSBfZ8qPkMZWiIjq0UmqZnixeJwGU
         H8gU2oK82wJSXdz7eg49+g8zr6ZmZgvbtBAlm0igPpyy6v238aAti0zNPhnSVzP+X5lY
         6kf+X7kg62TVwa19hBvRBU0XrJ+k1cyqMDztjp0wuHGpgiS/mBFtTNZgMyiVh4LEZEqM
         VIx/UuSKp0y3chGixa2ykwBqJmIn7P3l7+ArxUywL64XwapRXbdpB/xjusVQz1ECdAEz
         Qb3A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Di9hvuFT;
       spf=pass (google.com: best guess record for domain of batv+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org designates 198.137.202.133 as permitted sender) smtp.mailfrom=BATV+e1a5265bff2368ff7229+5352+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Di9hvuFT;
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
Subject: [PATCH 31/39] netfilter/x_tables: switch to proc_create_seq_private
Date: Thu, 19 Apr 2018 14:41:32 +0200
Message-Id: <20180419124140.9309-32-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180419124140.9309-1-hch@lst.de>
References: <20180419124140.9309-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598178530383455519?=
X-GMAIL-MSGID: =?utf-8?q?1598178530383455519?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

And remove proc boilerplate code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/netfilter/x_tables.c | 42 ++++++----------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 344dd01a5027..0e314f95a4a3 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -1648,22 +1648,6 @@ static const struct seq_operations xt_match_seq_ops = {
 	.show	= xt_match_seq_show,
 };
 
-static int xt_match_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_match_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_match_ops = {
-	.open	 = xt_match_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 static void *xt_target_seq_start(struct seq_file *seq, loff_t *pos)
 {
 	return xt_mttg_seq_start(seq, pos, true);
@@ -1698,22 +1682,6 @@ static const struct seq_operations xt_target_seq_ops = {
 	.show	= xt_target_seq_show,
 };
 
-static int xt_target_open(struct inode *inode, struct file *file)
-{
-	struct nf_mttg_trav *trav;
-	trav = __seq_open_private(file, &xt_target_seq_ops, sizeof(*trav));
-	if (!trav)
-		return -ENOMEM;
-	return 0;
-}
-
-static const struct file_operations xt_target_ops = {
-	.open	 = xt_target_open,
-	.read	 = seq_read,
-	.llseek	 = seq_lseek,
-	.release = seq_release_private,
-};
-
 #define FORMAT_TABLES	"_tables_names"
 #define	FORMAT_MATCHES	"_tables_matches"
 #define FORMAT_TARGETS 	"_tables_targets"
@@ -1787,8 +1755,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_MATCHES, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_match_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			&xt_match_seq_ops, sizeof(struct nf_mttg_trav),
+			(void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_tables;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
@@ -1796,8 +1765,9 @@ int xt_proto_init(struct net *net, u_int8_t af)
 
 	strlcpy(buf, xt_prefix[af], sizeof(buf));
 	strlcat(buf, FORMAT_TARGETS, sizeof(buf));
-	proc = proc_create_data(buf, 0440, net->proc_net, &xt_target_ops,
-				(void *)(unsigned long)af);
+	proc = proc_create_seq_private(buf, 0440, net->proc_net,
+			 &xt_target_seq_ops, sizeof(struct nf_mttg_trav),
+			 (void *)(unsigned long)af);
 	if (!proc)
 		goto out_remove_matches;
 	if (uid_valid(root_uid) && gid_valid(root_gid))
-- 
2.17.0
