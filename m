Return-Path: <kernel-hardening-return-12518-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELudA7mUDUN3fjC+2CK1OjOT8BDTeQko2GVbHu3dg6CdJlGO62lLEUeTB8t1Cd7NbsMHIiRK
ARC-Seal: i=1; a=rsa-sha256; t=1520970741; cv=none;
        d=google.com; s=arc-20160816;
        b=Nuck6AbHAZLH6IX4JKf+kwOVgq92R4PIBeqGfgFiYUv63Gp+2seVSsmglsL2gc00FF
         htcNCtMSgSop9WaCwuIOpH3uaazGbXNqJk2iBZHUws5EVz/np6lRI1kg/O/4XrCkvOv5
         dqVdH4zvWvpCWsxRzeA1bZFiBQGjI4lTRDUL4XyVHX7xZE911stvWKIWjG2JQjCT5v3q
         aQTAemRduP9PIBlKc76d5oSqnd/rz4mPgNXA4KDVFayBI+Ye+Js01WIWzFYTKUoLqjs1
         4xEz651hM/MRXFOBQUQG7MYeXIRqBDFqtMt4KwJl9FIW/SA+Cn07WImz6uMfQHSWZkKt
         bDTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ogX+fjjyfvLqQfI0J/Br2/bnDmIyb3fQ5eOf0W1m+fk=;
        b=zBweH99796lJz001N7KtA7jGxG0X5wmjTLCs6MYi2dUlfBh1PUATgao0XIYjO+7Bjp
         7SpK4yMfLnbjEdDObGC5kBbC33Ew5eeia3YzIFCluMREzFxB8GGhBfZt7N8nJBD+4Yiq
         4TSjX+XVyUdLSq1KOsJopRkdUMLwTPyGRmlHoRxQhG9R6h+h5QjhjaRzxENZud2+s2rq
         1natJpQZfbFV1kfNGgUF4hRCRAcpo7WsZHcmh/0t45OtllrAk7MYlbU6G7+kC9S5n/q2
         hAQcw7Uvzt9yFYJfOhge1VW97LV59c63zBj2coN1AHA0oYRrr42KP4wGmyRRZLbjdsTV
         tIOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rxpwSps4;
       spf=pass (google.com: domain of kernel-hardening-return-12518-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12518-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=rxpwSps4;
       spf=pass (google.com: domain of kernel-hardening-return-12518-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12518-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com,
	Joel Becker <jlbec@evilplan.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Fasheh <mfasheh@versity.com>,
	Salvatore Mesoraca <s.mesoraca16@gmail.com>
Subject: [PATCH] ocfs2: drop a VLA in ocfs2_orphan_del()
Date: Tue, 13 Mar 2018 20:51:50 +0100
Message-Id: <1520970710-19732-1-git-send-email-s.mesoraca16@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594853416162653651?=
X-GMAIL-MSGID: =?utf-8?q?1594853416162653651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Avoid a VLA[1] by using a real constant expression instead of a variable.
The compiler should be able to optimize the original code and avoid using
an actual VLA. Anyway this change is useful because it will avoid a false
positive with -Wvla, it might also help the compiler generating better
code.

[1] https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
---
 fs/ocfs2/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c801edd..41ef356 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2332,8 +2332,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
 		     struct buffer_head *orphan_dir_bh,
 		     bool dio)
 {
-	const int namelen = OCFS2_DIO_ORPHAN_PREFIX_LEN + OCFS2_ORPHAN_NAMELEN;
-	char name[namelen + 1];
+	char name[OCFS2_DIO_ORPHAN_PREFIX_LEN + OCFS2_ORPHAN_NAMELEN + 1];
 	struct ocfs2_dinode *orphan_fe;
 	int status = 0;
 	struct ocfs2_dir_lookup_result lookup = { NULL, };
-- 
1.9.1
