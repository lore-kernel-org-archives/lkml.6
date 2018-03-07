Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4119318-1520452653-2-2263661415007774609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520452653; b=JuJjQpkvMcrKW7rzqTGC2+64f9lvJVfmMmTh9Y0oIJsbqN8
    KOfW9VWRIKbNx6lH8wvMn62B6cOg94KEK3EueZtBWjRaV0JAbHmWkbN0sAsFbhSO
    +ApYviN4u63Wyvsjf73eryUiyON+yIJ2d6U4E/xPXUqqgcXfW7z6toIXH8Q4al53
    grjWWJCSKsKE3itGjK8qjIzXAlY/uo+5jURk7lJut7jEEAYsOJPeRdVftrgudDun
    GzjLPTdEqkV39nmKhAzTXx6nJUoK0xsHmSIZ/1hx4LI8kI3Qc10YYZCzNmuZsMfE
    Ks4qIe8CFoVIYMus6aanl5lu4/ehYxaw2pWivaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520452653; bh=YC0etEWx2NdhYV667cBc0vvaJW
    LIOKK5Oo1F7azyYfE=; b=ODYA8nPrp8FZ2nLyM8averEYwIR7kAJsY+yR7MRmK+
    QqXIrRS+ZZ35U3AodgjNlstFz2rSKWydw0XruHwWzEvAQ9xN1JIaI8c3CrXyDQZz
    Zygnhmz1+gu+kwo2SuxEdt4HrBcugxCpJimem4NebDE6I/Af7jWjP55SB6s5flfu
    mbcP2+fsISJKqm+7aqr8/dZg8onvW4v68gZhJS6Kr8P1jJEnc+C9HqLo5+8y+uCg
    sQoQZk5WyHfQKuUoJyJ2JlKzk8UvE58eNDtgk5+vBYibZ+/vzIxt8bNSNunXs3cf
    jj1sxu8NNsPP1A07tnPWfBJaNZ41Hz4MeEM1Q5P9CotA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965186AbeCGT5U (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 14:57:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44962 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965716AbeCGTrV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 14:47:21 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Valente <paolo.valente@linaro.org>,
        Omar Sandoval <osandov@fb.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 083/110] blk-mq: dont call io scheds .requeue_request when requeueing rq to ->dispatch
Date: Wed,  7 Mar 2018 11:39:06 -0800
Message-Id: <20180307191050.465606623@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 105976f517791aed3b11f8f53b308a2069d42055 upstream.

__blk_mq_requeue_request() covers two cases:

- one is that the requeued request is added to hctx->dispatch, such as
blk_mq_dispatch_rq_list()

- another case is that the request is requeued to io scheduler, such as
blk_mq_requeue_request().

We should call io sched's .requeue_request callback only for the 2nd
case.

Cc: Paolo Valente <paolo.valente@linaro.org>
Cc: Omar Sandoval <osandov@fb.com>
Fixes: bd166ef183c2 ("blk-mq-sched: add framework for MQ capable IO schedulers")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -638,7 +638,6 @@ static void __blk_mq_requeue_request(str
 
 	trace_block_rq_requeue(q, rq);
 	wbt_requeue(q->rq_wb, &rq->issue_stat);
-	blk_mq_sched_requeue_request(rq);
 
 	if (test_and_clear_bit(REQ_ATOM_STARTED, &rq->atomic_flags)) {
 		if (q->dma_drain_size && blk_rq_bytes(rq))
@@ -650,6 +649,9 @@ void blk_mq_requeue_request(struct reque
 {
 	__blk_mq_requeue_request(rq);
 
+	/* this request will be re-inserted to io scheduler queue */
+	blk_mq_sched_requeue_request(rq);
+
 	BUG_ON(blk_queued_rq(rq));
 	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }
