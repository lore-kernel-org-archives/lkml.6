Return-Path: <kernel-hardening-return-11989-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuyc2YkHuEPU6MszPha5AZjb/dMOOddqEbeAxEAjahEY1h08rEnZneaLVVHXnnlCiFlwkUu
ARC-Seal: i=1; a=rsa-sha256; t=1519706751; cv=none;
        d=google.com; s=arc-20160816;
        b=pxLSXDGIz7r0eie/OjIwTD/rUkydyya1M7xr70CVKCsy53n3hfl86018SZKnJ2BY67
         7s4IqAMfyli3+N3hj3ZfOdtAXSiYr2B/Xp/rp1sjcfgaCWj3lC0if5Pz9Wi5f7ilEQFU
         9Yw5D4S2OLtT5NPocb7h5NuY36/rpOzXHwELoMquYeXq9TfwcFhPu5kFgDEPBRnV+t1l
         aJTy/DUoAHyjuW9zRYrLNJ0TObX4VytMUbDQBkeGGZDWmev5UIgFM87PiGRDu4q4HWkY
         K3pOwscdNMiaoGL3e4Kv8wQDST7wP8HzcA1ZGlZtiAySOtXvsD5sovFiaeGOFHr/V2jr
         xhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=sXjBP4a8D9Z/IdtHkvecjg5IkuRFM6EfJVv9dB6qmgY=;
        b=L5ORFy7lg7bRwoKjGaKyZ3luNDd0k5BrJ0lWVwzqWmaMYcU/BaUWP5XytiWTENWU4A
         hVQW4l62nHhDBJheesvRnkJEEkaPkOFwbXTXAQitv/jE0R2860TK9Uyjz3gXwfreBa4G
         K/7PktFH2D4KU8gxdH1g5QyDryCNSaiTGGZFMN1KCGiKcWDvxLjy/0ly3Lv4eIl4jADB
         Gss7DBKnSgeC8mEoUmybBR1PKeQVqHr9fz8mAnsRyMpuhbawtcSr7zGi4rM1YzNj0mVr
         ngRQrA4pj96710DAwlN+onac1EqZ4LXJJlQNwTd016acUj6pkzb2F6nIEAx1xHk+FBO4
         OEQg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=b8h+e2xS;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=UkmoseHj;
       spf=pass (google.com: domain of kernel-hardening-return-11989-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11989-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=b8h+e2xS;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=UkmoseHj;
       spf=pass (google.com: domain of kernel-hardening-return-11989-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11989-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:ZeKUWht1GfC5Jo-SmGdb-zlwTpoMnCTCl1GS-DKt6PdzeLnrOiKobg>
From: "Tobin C. Harding" <me@tobin.cc>
To: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	Tycho Andersen <tycho@tycho.ws>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] leaking_addresses: skip all /proc/PID except /proc/1
Date: Tue, 27 Feb 2018 15:45:09 +1100
Message-Id: <1519706711-18580-2-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519706711-18580-1-git-send-email-me@tobin.cc>
References: <1519706711-18580-1-git-send-email-me@tobin.cc>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593528026509077926?=
X-GMAIL-MSGID: =?utf-8?q?1593528026509077926?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the system is idle it is likely that most files under /proc/PID
will be identical for various processes.  Scanning _all_ the PIDs under
/proc is unnecessary and implies that we are thoroughly scanning /proc.
This is _not_ the case because there may be ways userspace can trigger
creation of /proc files that leak addresses but were not present during
a scan.  For these two reasons we should exclude all PID directories
under /proc except '1/'

Exclude all /proc/PID except /proc/1.

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 scripts/leaking_addresses.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 6e5bc57caeaa..fb40e2828f43 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -10,6 +10,14 @@
 # Use --debug to output path before parsing, this is useful to find files that
 # cause the script to choke.
 
+#
+# When the system is idle it is likely that most files under /proc/PID will be
+# identical for various processes.  Scanning _all_ the PIDs under /proc is
+# unnecessary and implies that we are thoroughly scanning /proc.  This is _not_
+# the case because there may be ways userspace can trigger creation of /proc
+# files that leak addresses but were not present during a scan.  For these two
+# reasons we exclude all PID directories under /proc except '1/'
+
 use warnings;
 use strict;
 use POSIX;
@@ -472,6 +480,9 @@ sub walk
 			my $path = "$pwd/$file";
 			next if (-l $path);
 
+			# skip /proc/PID except /proc/1
+			next if ($path =~ /\/proc\/(?:[2-9][0-9]*|1[0-9]+)/);
+
 			next if (skip($path));
 
 			if (-d $path) {
-- 
2.7.4
