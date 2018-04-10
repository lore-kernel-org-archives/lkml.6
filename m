Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/QZSmM7E35qAWTlEqmtKkO5Y9Lcv2S/WwLAbasB3NmJxmcPDL1roVoSRW1YlbdLD/846tn
ARC-Seal: i=1; a=rsa-sha256; t=1523399421; cv=none;
        d=google.com; s=arc-20160816;
        b=AhChLsIb7HqhFXF/UnRp7zAuxhBOWuAIrAvQcRx9pb0qhLaO7fv9WaX2yKhO/LJyJK
         ToYCmWbYujDmP1/zr+ekFmDrjfQDCI0FIBLfARa9FyvWVI7xxAjHEsbeLCKkEiM7fAuo
         QL1e82YW/9GOVHF/EvFgot4Lj/ewFAJDrbL+w0heibcgVQ5aJKSfeXN7nhBOUMTIjoOD
         YX3r1+opsOjtvWBbyU/QB6SdNO0ygw076nyxZU9lIbcqijlpe8mFNP+pI9PpwxViQunz
         qwOKggbJiQfpRTAnfud0U8fShWUsaqh0KRZ+7J7vN9D8x8Yyc1qnIdilrYNQ5D6nWPdL
         zTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l8kDVyzY0/pEJ91LTzp6d5z5iicbEV5ASZhyexPCqZI=;
        b=XwYDvzQNrfn+UJ+d2p6q+0+iMmat2rLjqKszFSKd8VwJY4GkgpC8zhr38SOJ9QCTvo
         SNs6W5eQF4HnpbJ3DgSobj45/la/ZqY9wAc2ubNkP5Y1uRfhDA0Prf1alHv4jWg+XZ/V
         2TBHTN6WDL3UdgO6BBVDz7G0XcBINBAp0zNuUQ7JGdKAFSkxyGS+EI4SWH9MUQBt/RIw
         zSekqKRoaUWvuKud6juB43XdD264TNJhyPFh9KFBx+rlYVNwe61TyylyNyRfVW1Dxt8v
         9xfoQLwfR4SfHR4Q0pYxZ+l44lsiY2IAICqjGkRnA9TKWDpbSuN6t0hoNuS2n6cMYga8
         q/8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hua Rui <huarui.dev@gmail.com>,
	Michael Lyle <mlyle@lyle.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 072/168] bcache: ret IOERR when read meets metadata error
Date: Wed, 11 Apr 2018 00:23:34 +0200
Message-Id: <20180410212803.260884103@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400072268634043?=
X-GMAIL-MSGID: =?utf-8?q?1597400072268634043?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rui Hua <huarui.dev@gmail.com>


[ Upstream commit b221fc130c49c50f4c2250d22e873420765a9fa2 ]

The read request might meet error when searching the btree, but the error
was not handled in cache_lookup(), and this kind of metadata failure will
not go into cached_dev_read_error(), finally, the upper layer will receive
bi_status=0.  In this patch we judge the metadata error by the return
value of bch_btree_map_keys(), there are two potential paths give rise to
the error:

1. Because the btree is not totally cached in memery, we maybe get error
   when read btree node from cache device (see bch_btree_node_get()), the
   likely errno is -EIO, -ENOMEM

2. When read miss happens, bch_btree_insert_check_key() will be called to
   insert a "replace_key" to btree(see cached_dev_cache_miss(), just for
   doing preparatory work before insert the missed data to cache device),
   a failure can also happen in this situation, the likely errno is
   -ENOMEM

bch_btree_map_keys() will return MAP_DONE in normal scenario, but we will
get either -EIO or -ENOMEM in above two cases. if this happened, we should
NOT recover data from backing device (when cache device is dirty) because
we don't know whether bkeys the read request covered are all clean.  And
after that happened, s->iop.status is still its initially value(0) before
we submit s->bio.bio, we set it to BLK_STS_IOERR, so it can go into
cached_dev_read_error(), and finally it can be passed to upper layer, or
recovered by reread from backing device.

[edit by mlyle: patch formatting, word-wrap, comment spelling,
commit log format]

Signed-off-by: Hua Rui <huarui.dev@gmail.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/bcache/request.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -576,6 +576,7 @@ static void cache_lookup(struct closure
 {
 	struct search *s = container_of(cl, struct search, iop.cl);
 	struct bio *bio = &s->bio.bio;
+	struct cached_dev *dc;
 	int ret;
 
 	bch_btree_op_init(&s->op, -1);
@@ -588,6 +589,27 @@ static void cache_lookup(struct closure
 		return;
 	}
 
+	/*
+	 * We might meet err when searching the btree, If that happens, we will
+	 * get negative ret, in this scenario we should not recover data from
+	 * backing device (when cache device is dirty) because we don't know
+	 * whether bkeys the read request covered are all clean.
+	 *
+	 * And after that happened, s->iop.status is still its initial value
+	 * before we submit s->bio.bio
+	 */
+	if (ret < 0) {
+		BUG_ON(ret == -EINTR);
+		if (s->d && s->d->c &&
+				!UUID_FLASH_ONLY(&s->d->c->uuids[s->d->id])) {
+			dc = container_of(s->d, struct cached_dev, disk);
+			if (dc && atomic_read(&dc->has_dirty))
+				s->recoverable = false;
+		}
+		if (!s->iop.status)
+			s->iop.status = BLK_STS_IOERR;
+	}
+
 	closure_return(cl);
 }
 
