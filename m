Return-Path: <kernel-hardening-return-12660-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuM2gUxboWSyEF2ujeYkQIp7xKdgFOka+tCRGNQ/xaH+1WXlUTnWTZDpz3fTiBSWJSs3RFS
ARC-Seal: i=1; a=rsa-sha256; t=1521174407; cv=none;
        d=google.com; s=arc-20160816;
        b=YX+LrPBRM00jDYyhzZdm6bsXL++YGhADpDHsZl61oeafrUKjgNHpcp7iCLKnHDO4Tl
         Z85wJJNveAbFu91UuhOy2nqRvqQ9t764Lo/A/tiBkdELEkdk0P4FmOutFSKt8yfaLaqL
         B4Y11ll4rHcRt9p4AiAn0L4PDgA9J3NFQldGpz7A15Ja4Q6F9q3nK/rd71v+mqG6H6ty
         7ZePu0uYLx41Q+8B3zkeheuNHc2yoV5IHRVH1VzLTBarUahk9n3gC4/2qcImavjItiPS
         ZbUXYrV0czBxkIzsLqCZZ2Cc5Q8YidzQp2kM3RWOFq5JBFCE4xlFY/fJUAs5D67HAj0G
         d+xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=etTirND11sHpnpv8W1hcdvXfYX8gc+sNx8YcPii9hYE=;
        b=IV+y+DRZuGk/BMVxsDsf2ea4AxskqVTBYriLiULXfIIYjiF9a2I5OqhDhssiiJKQjb
         78Iw7P1WVi8ze4JNB0tin1v+dYQhSskLZSWG7eXz/s6nv9gH71nJLFLAXaDR5dDqfpnM
         x/i1mNQc5npzeEU9y31A6qh80UCjPev0NSFHSZcsO1n0q9ZzvupCBURtweFqZjUd9mUs
         +VqJQejclbrxCptqIZkV1pUw1N1kYfTmBXldrYbkPeR2WANP7dc6fLbFAvEYFqtBe+m2
         jG32lUGwnuwdD4Av9cOwM4zNqfFfPHwmph64g8wlvcZSNTAwTML4TxgOcbonV32KvUl1
         ageA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=BoUiD6l6;
       spf=pass (google.com: domain of kernel-hardening-return-12660-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12660-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=BoUiD6l6;
       spf=pass (google.com: domain of kernel-hardening-return-12660-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12660-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>,
	Ian Abbott <abbotti@mev.co.uk>,
	linux-input@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v5 2/2] Remove false-positive VLAs when using max()
Date: Thu, 15 Mar 2018 21:25:59 -0700
Message-Id: <1521174359-46392-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521174359-46392-1-git-send-email-keescook@chromium.org>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595066975555181326?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As part of removing VLAs from the kernel[1], we want to build with -Wvla,
but it is overly pessimistic and only accepts constant expressions for
stack array sizes, instead of also constant values. The max() macro
triggers the warning, so this refactors these uses of max() to use the
new const_max() instead.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/touchscreen/cyttsp4_core.c |  2 +-
 fs/btrfs/tree-checker.c                  |  3 ++-
 lib/vsprintf.c                           |  5 +++--
 net/ipv4/proc.c                          |  8 ++++----
 net/ipv6/proc.c                          | 11 +++++------
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 727c3232517c..7fb9bd48e41c 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -868,7 +868,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[const_max_t(size_t, CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c3c8d48f6618..d83244e3821f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -341,7 +341,8 @@ static int check_dir_item(struct btrfs_root *root,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[const_max_t(size_t, BTRFS_NAME_LEN,
+						 XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..12ff57a36171 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+	char sym[const_max_t(size_t,
+			     2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+			     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	int decode = (fmt[0] == 'R') ? 1 : 0;
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index dc5edc8f7564..7f5c3b40dac9 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -46,7 +46,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX const_max_t(size_t, UDP_MIB_MAX, TCP_MIB_MAX)
 
 /*
  *	Report socket allocation statistics [mea@utu.fi]
@@ -404,7 +404,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	struct net *net = seq->private;
 	int i;
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	seq_puts(seq, "\nTcp:");
 	for (i = 0; snmp4_tcp_list[i].name; i++)
@@ -421,7 +421,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 			seq_printf(seq, " %lu", buff[i]);
 	}
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	snmp_get_cpu_field_batch(buff, snmp4_udp_list,
 				 net->mib.udp_statistics);
@@ -432,7 +432,7 @@ static int snmp_seq_show_tcp_udp(struct seq_file *seq, void *v)
 	for (i = 0; snmp4_udp_list[i].name; i++)
 		seq_printf(seq, " %lu", buff[i]);
 
-	memset(buff, 0, TCPUDP_MIB_MAX * sizeof(unsigned long));
+	memset(buff, 0, sizeof(buff));
 
 	/* the UDP and UDP-Lite MIBs are the same */
 	seq_puts(seq, "\nUdpLite:");
diff --git a/net/ipv6/proc.c b/net/ipv6/proc.c
index b67814242f78..b68c233de296 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -30,10 +30,9 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 
-#define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
-#define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
-			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
+#define SNMP_MIB_MAX const_max_t(u32,					\
+			const_max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX),	\
+			const_max_t(u32, IPSTATS_MIB_MAX, ICMP_MIB_MAX))
 
 static int sockstat6_seq_show(struct seq_file *seq, void *v)
 {
@@ -199,7 +198,7 @@ static void snmp6_seq_show_item(struct seq_file *seq, void __percpu *pcpumib,
 	int i;
 
 	if (pcpumib) {
-		memset(buff, 0, sizeof(unsigned long) * SNMP_MIB_MAX);
+		memset(buff, 0, sizeof(buff));
 
 		snmp_get_cpu_field_batch(buff, itemlist, pcpumib);
 		for (i = 0; itemlist[i].name; i++)
@@ -218,7 +217,7 @@ static void snmp6_seq_show_item64(struct seq_file *seq, void __percpu *mib,
 	u64 buff64[SNMP_MIB_MAX];
 	int i;
 
-	memset(buff64, 0, sizeof(u64) * SNMP_MIB_MAX);
+	memset(buff64, 0, sizeof(buff64));
 
 	snmp_get_cpu_field64_batch(buff64, itemlist, mib, syncpoff);
 	for (i = 0; itemlist[i].name; i++)
-- 
2.7.4
