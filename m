Return-Path: <kernel-hardening-return-12640-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELto9pycRKlwlEM8xEx8iLvLLw0KZJ1IBr7OGqCle7OBElV4gfk7cWXpbQmNdbQKrnVdldpr
ARC-Seal: i=1; a=rsa-sha256; t=1521143310; cv=none;
        d=google.com; s=arc-20160816;
        b=PkTEdwhs+mIPv4jVlXha/k1ChFeM5C5A5sxJnDDf+XPg1x6afUKQXt/fBzGoJ+xTXC
         k+NsnC6vMEI2RCWcY5MYDXYXohl3VLdjwwGrwm9UX1b8SLqdx5Zh6kLBfEKYdDzr4PLe
         ZCZxe9SPNbvldSgm8VZkI9Q9hDU4Ek3mwlbk56pAr2UydFSkuN6q4ATLmudbX/MrTaaH
         GkaQQKiP9gwRJg9seE4V9VBNsgaeoUge6UVhtThAbcB60CJGFAM6J36rWqxEkWseGV0u
         hVVcsLJSjwIDy2+at8khtrophFRonaMag9vWjQG4ZKDAhFDtCy9pKM0+V1DP41GcvH8E
         6u0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=EW+e1W8pvRgjTePfgizezvzi9dI4+U5AdXRYyQsIL90=;
        b=SpziFESk1Sf9r+eMP4kJDGRv+2fUdCxcchV+Ma2lYwdAZACqVXvaDrUHgmf8/t/nEf
         4nMhMHdQQUj8qTFdy+c3LPg6OyihQRL8CWdcbB8AXEFEFqQierw0poZ9IosZkB2ASbK+
         VUjsIk66DnUzHafvgiSb0CKTfR7oJrx1jL+wGIx53y2wVMWkwDOmqVAM3VdLz00syYbH
         CBk06v3dkZCUTcm/pryniKmcz2QmWtAeo1dONPSPncfFY0y28WLgmIfu9QiozRhARi4i
         fJaKdlXTSRgcFex/zcPieQKyIkxhDtwdpo8HkgzIZw7HqVhFXi2JFVFm/JTodRwIpvEm
         80Hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=f+Nba7Y1;
       spf=pass (google.com: domain of kernel-hardening-return-12640-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12640-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=f+Nba7Y1;
       spf=pass (google.com: domain of kernel-hardening-return-12640-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12640-gregkh=linuxfoundation.org@lists.openwall.com;
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
Subject: [PATCH v4 2/2] Remove false-positive VLAs when using max()
Date: Thu, 15 Mar 2018 12:47:46 -0700
Message-Id: <1521143266-31350-3-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521143266-31350-1-git-send-email-keescook@chromium.org>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595034368078500739?=
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
 lib/vsprintf.c                           |  4 ++--
 net/ipv4/proc.c                          |  8 ++++----
 net/ipv6/proc.c                          | 10 ++++------
 5 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp4_core.c b/drivers/input/touchscreen/cyttsp4_core.c
index 727c3232517c..f89497940051 100644
--- a/drivers/input/touchscreen/cyttsp4_core.c
+++ b/drivers/input/touchscreen/cyttsp4_core.c
@@ -868,7 +868,7 @@ static void cyttsp4_get_mt_touches(struct cyttsp4_mt_data *md, int num_cur_tch)
 	struct cyttsp4_touch tch;
 	int sig;
 	int i, j, t = 0;
-	int ids[max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
+	int ids[const_max(CY_TMA1036_MAX_TCH, CY_TMA4XX_MAX_TCH)];
 
 	memset(ids, 0, si->si_ofs.tch_abs[CY_TCH_T].max * sizeof(int));
 	for (i = 0; i < num_cur_tch; i++) {
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index c3c8d48f6618..1ddd6cc3c4fc 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -341,7 +341,8 @@ static int check_dir_item(struct btrfs_root *root,
 		 */
 		if (key->type == BTRFS_DIR_ITEM_KEY ||
 		    key->type == BTRFS_XATTR_ITEM_KEY) {
-			char namebuf[max(BTRFS_NAME_LEN, XATTR_NAME_MAX)];
+			char namebuf[const_max(BTRFS_NAME_LEN,
+					       XATTR_NAME_MAX)];
 
 			read_extent_buffer(leaf, namebuf,
 					(unsigned long)(di + 1), name_len);
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7a708f82559..9d5610b643ce 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -744,8 +744,8 @@ char *resource_string(char *buf, char *end, struct resource *res,
 #define FLAG_BUF_SIZE		(2 * sizeof(res->flags))
 #define DECODED_BUF_SIZE	sizeof("[mem - 64bit pref window disabled]")
 #define RAW_BUF_SIZE		sizeof("[mem - flags 0x]")
-	char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
-		     2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
+	char sym[const_max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
+			   2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
 
 	char *p = sym, *pend = sym + sizeof(sym);
 	int decode = (fmt[0] == 'R') ? 1 : 0;
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index dc5edc8f7564..fad6f989004e 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -46,7 +46,7 @@
 #include <net/sock.h>
 #include <net/raw.h>
 
-#define TCPUDP_MIB_MAX max_t(u32, UDP_MIB_MAX, TCP_MIB_MAX)
+#define TCPUDP_MIB_MAX const_max(UDP_MIB_MAX, TCP_MIB_MAX)
 
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
index b67814242f78..58bbfc4fa7fa 100644
--- a/net/ipv6/proc.c
+++ b/net/ipv6/proc.c
@@ -30,10 +30,8 @@
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 
-#define MAX4(a, b, c, d) \
-	max_t(u32, max_t(u32, a, b), max_t(u32, c, d))
-#define SNMP_MIB_MAX MAX4(UDP_MIB_MAX, TCP_MIB_MAX, \
-			IPSTATS_MIB_MAX, ICMP_MIB_MAX)
+#define SNMP_MIB_MAX const_max(const_max(UDP_MIB_MAX, TCP_MIB_MAX), \
+			       const_max(IPSTATS_MIB_MAX, ICMP_MIB_MAX))
 
 static int sockstat6_seq_show(struct seq_file *seq, void *v)
 {
@@ -199,7 +197,7 @@ static void snmp6_seq_show_item(struct seq_file *seq, void __percpu *pcpumib,
 	int i;
 
 	if (pcpumib) {
-		memset(buff, 0, sizeof(unsigned long) * SNMP_MIB_MAX);
+		memset(buff, 0, sizeof(buff));
 
 		snmp_get_cpu_field_batch(buff, itemlist, pcpumib);
 		for (i = 0; itemlist[i].name; i++)
@@ -218,7 +216,7 @@ static void snmp6_seq_show_item64(struct seq_file *seq, void __percpu *mib,
 	u64 buff64[SNMP_MIB_MAX];
 	int i;
 
-	memset(buff64, 0, sizeof(u64) * SNMP_MIB_MAX);
+	memset(buff64, 0, sizeof(buff64));
 
 	snmp_get_cpu_field64_batch(buff64, itemlist, mib, syncpoff);
 	for (i = 0; itemlist[i].name; i++)
-- 
2.7.4
