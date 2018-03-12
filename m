Return-Path: <kernel-hardening-return-12410-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsr27hCAQacNhg+5k20ZPInwd8E46J+Kit7ODb9C54Cnh8Z7iUfshpcO2tHWU/IeL28sbl+
ARC-Seal: i=1; a=rsa-sha256; t=1520830834; cv=none;
        d=google.com; s=arc-20160816;
        b=lt3yrpn8MO0fSeUef6PRaOtdGhqOofS2h5EOjnl+6UrviIxmlqnh80aCJ1RPKTu7WY
         /FV/E8sgZGR/xIsDJIMC9d1n47pHkXbzzWn4n9VynNRNoTztfZrGLZFsRiwhHVO73+gp
         POvrRB35rMCeSX7XxRt1gPOwcFmRDgOTsyw39M1LYYJ6847LKQoubrc+Cxt/FjQhNQdr
         EiqpIeykPfJqfJccc7wRVVK0/5X70b6O7neK5QL4rLxthb25Iy+XHIHBUbvO4+6S396+
         E7wAXQ4arj7Pb6UbhToFd6yg7rLrq4+fVMGZv4rNhRVdZv2ntZ/jtiquiBY1M3bkXuj7
         B59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=HI9YNtnL86EqwTdX0gs87n3BCwzk3GslnKYO1Ulr1Qk=;
        b=kG3QHlPs7U6XSaUmM9d/Zrf0gNeCqxWxWVRELw7Fp+TjfdvoeRBpheLnplgCS9cEgC
         Y64hSdyIUYe2re8VANj3FGWvyID9algESzZujXEtXOq1thddbpnrN5Jz144eQScGE6v1
         6JUdeBoi72ATLkruo7cP9FMVKkTrBzZ/1LO6zY/pKT7n0ArPdHzjeIFqGHB+Fq+QcWZY
         7sa4yYqF1eQy82siv1Uq9S+nARja4mvtbHJxN4bLecM7/v+K9f04G/VUu+RXFYMIxRWX
         exIhOouujUma1JxqltwvNf628g9OIPYdowjWecQT6zmTxsGqHfZl3EgahMR+nyp+8ePz
         LJ1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=RXZH0425;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Aiw0vSxt;
       spf=pass (google.com: domain of kernel-hardening-return-12410-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12410-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@tobin.cc header.s=fm2 header.b=RXZH0425;
       dkim=pass header.i=@messagingengine.com header.s=fm2 header.b=Aiw0vSxt;
       spf=pass (google.com: domain of kernel-hardening-return-12410-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12410-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-ME-Sender: <xms:XgmmWq0EXPLCnXJ8Aegv-G5HJ-a5CLRIz4-ClD6UE2xFSpfT8RHi5A>
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
Subject: [PATCH] rbd: Remove VLA saving ack buffer size
Date: Mon, 12 Mar 2018 16:00:08 +1100
Message-Id: <1520830808-26991-1-git-send-email-me@tobin.cc>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594706712333845752?=
X-GMAIL-MSGID: =?utf-8?q?1594706712333845752?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The kernel would like to have all stack VLA usage removed[1].  Here the
array is declared using a variable that is declared using a constant
statement but the compiler still emits a warning.  We can clear the
warning bu using the constant statement directly.  The buffer size
variable is set to zero on the error path; the buffer size variable is
used later in the function, we can maintain this behavior by setting the
variable using the macro ARRAY_SIZE.

Use constant statement to declare array.

[1]: https://lkml.org/lkml/2018/3/7/621

Signed-off-by: Tobin C. Harding <me@tobin.cc>
---

Excuse the lack of threading, I forgot the second patch ;)  Can re-send
threaded correctly if required.

 drivers/block/rbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 927ecd9a2511..7c228753fddd 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3618,13 +3618,14 @@ static void __rbd_acknowledge_notify(struct rbd_device *rbd_dev,
 				     u64 notify_id, u64 cookie, s32 *result)
 {
 	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
-	int buf_size = 4 + CEPH_ENCODING_START_BLK_LEN;
-	char buf[buf_size];
+	char buf[4 + CEPH_ENCODING_START_BLK_LEN];
+	int buf_size;
 	int ret;
 
 	if (result) {
 		void *p = buf;
 
+		buf_size = ARRAY_SIZE(buf);
 		/* encode ResponseMessage */
 		ceph_start_encoding(&p, 1, 1,
 				    buf_size - CEPH_ENCODING_START_BLK_LEN);
-- 
2.7.4
