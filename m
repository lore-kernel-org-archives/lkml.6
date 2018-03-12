Return-Path: <kernel-hardening-return-12409-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt3qmtND94V3sW9TWHtMyIKkaIYMZUSB/ZjsjgdmlQiDn4HWfTmiw1+036R/UnWXSUx/psk
ARC-Seal: i=1; a=rsa-sha256; t=1520830207; cv=none;
        d=google.com; s=arc-20160816;
        b=ZyXU1hKs4wFrYyQ9XP4G5BMm3PZaC6Xry1eZK3zIuRoQ1GrC0jCWI+wtARnhvJLUUt
         CmA3l0VKlop5Yk4jCjhUdPpjrIZfpl20Uthsyqxx6YfO9xVJT2pch9iXMPPiCbIZt0DD
         Ky7Auh1T+YeKVzfgFVKzPK7Sdp3gtJ6KyjgFzxBLPrTMH5TOvfjNtxEgrj/kzhV46Vla
         fUlvGThpcgd3CMbzJ3NS7ijmxZXD2W+iDiiZVReK+iQrpah7ZwzEB4jfcZ5c5sAkK3yq
         8egSp3NVReZmDZ8KC4Mbneez36fki3oELOuuyS527MFdWYP6tvcoWiH5DRJsyvvdgarn
         rwcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=fY71O/oZVqj7ORjPmj1+SBUiM0AiqJV/d2FT6UTP1mg=;
        b=NJcdfYpvoO6YjGytt1xvQRrlkwLoByBAQUfa6Dq1C/zk1Qx2Y807s5ZuSp5ighu5z9
         +CEXyUTS+mwxZSgJa1AKu0x1uuQ60v3hB2/ZDtdHPY1xugmGbslrO5WYBicFqUhv/GM4
         TYKRh4rmTuyTGpXKRUSSjyZFXrnZiPC6XW0Y3YAUjQbP4mKKaCoqAZgb/jvVUBTkafzi
         iuoegwFP/05YLEokxaBzVG2hBFrVbf9NuwLzxfz9oBjizDFsa2oAB+Nn0hExro5XmSXn
         6DbK7LrmKkFNBCJ8Sb9HvlV9YbMycSKOWIN3SCrGGBLDjjaw9/R1W0rF39aZmrNsRDMU
         rQZw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=qs/AWPpP;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Rl4VIvQZ;
       spf=pass (google.com: domain of kernel-hardening-return-12409-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12409-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=qs/AWPpP;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Rl4VIvQZ;
       spf=pass (google.com: domain of kernel-hardening-return-12409-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12409-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:7AamWi2Tv6nlUTRHDJFZ-aGnG7NEPrSltu0EDq4kqlapDLG7ObEM4Q>
From: "Tobin C. Harding" <me@tobin.cc>
To: Ilya Dryomov <idryomov@gmail.com>,
	Sage Weil <sage@redhat.com>,
	Alex Elder <elder@kernel.org>
Cc: "Tobin C. Harding" <me@tobin.cc>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Tycho Andersen <tycho@tycho.ws>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] rbd: Remove VLA stack usage
Date: Mon, 12 Mar 2018 15:49:40 +1100
Message-Id: <1520830180-25452-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594706055475539474?=
X-GMAIL-MSGID: =?utf-8?q?1594706055475539474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  Here the
array is declared using a variable that is declared using a constant
statement but the compiler still emits a warning.  We can clear the
warning bu using the constant statement directly.  In place of later
usage of the size variable we can use the ARRAY_SIZE() macro.

Use constant statement to declare array.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---
 drivers/block/rbd.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 0016170cde0a..927ecd9a2511 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3100,20 +3100,19 @@ static int __rbd_notify_op_lock(struct rbd_device *rbd_dev,
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
 	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
-	int buf_size = 4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + 8 + 8 + CEPH_ENCODING_START_BLK_LEN];
 	void *p = buf;
 
 	dout("%s rbd_dev %p notify_op %d\n", __func__, rbd_dev, notify_op);
 
 	/* encode *LockPayload NotifyMessage (op + ClientId) */
-	ceph_start_encoding(&p, 2, 1, buf_size - CEPH_ENCODING_START_BLK_LEN);
+	ceph_start_encoding(&p, 2, 1, ARRAY_SIZE(buf) - CEPH_ENCODING_START_BLK_LEN);
 	ceph_encode_32(&p, notify_op);
 	ceph_encode_64(&p, cid.gid);
 	ceph_encode_64(&p, cid.handle);
 
 	return ceph_osdc_notify(osdc, &rbd_dev->header_oid,
-				&rbd_dev->header_oloc, buf, buf_size,
+				&rbd_dev->header_oloc, buf, ARRAY_SIZE(buf),
 				RBD_NOTIFY_TIMEOUT, preply_pages, preply_len);
 }
 
-- 
2.7.4
