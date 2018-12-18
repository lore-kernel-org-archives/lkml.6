Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E22621873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545151262;
	bh=mYCYuCcda5KxLIqXRABQNhy+DZii6YXieATYavv6/Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hieLbdiexLEWhvQDUSdejXxqiPitYWIQ/MWzSzOH2MbpImpdpSJe1O3WjbpqG5YSC
	 9zG5HS7kTeIo2f9i01rV6obl2USPtkK0/KfOJ72Q9rjV7YXylLG673V3qJ3Ucc90kQ
	 5LnuAgBcDjuCvUEoU/ogiLCXmwFt36p12NXgdtv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeLRQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbeLRQk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:40:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80E8218A3;
        Tue, 18 Dec 2018 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545151258;
        bh=mYCYuCcda5KxLIqXRABQNhy+DZii6YXieATYavv6/Oc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BhFQ6uGUvh3YtaazEEhfZDm/w2TkSr0gnsRrjMIyWe1SxZurqGd4Y3RCMJWbotAEJ
         gvdWXdOUBndswpIxAUhD3srYfAq9KCQTvkqpXloLKy0IRtItKmWD1tIY7JoBoC7+tu
         H564LoV+AjYIvI7ymRP4D+Xz/LfuZKTNdADXAs/c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Todd Aiken <taiken@mvtech.ca>,
        Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 14/44] block/bio: Do not zero user pages
Date:   Tue, 18 Dec 2018 17:39:26 +0100
Message-Id: <20181218163929.193192006@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218163927.119623235@linuxfoundation.org>
References: <20181218163927.119623235@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit f55adad601c6a97c8c9628195453e0fb23b4a0ae upstream.

We don't need to zero fill the bio if not using kernel allocated pages.

Fixes: f3587d76da05 ("block: Clear kernel memory before copying to user") # v4.20-rc2
Reported-by: Todd Aiken <taiken@mvtech.ca>
Cc: Laurence Oberman <loberman@redhat.com>
Cc: stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>
Tested-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/bio.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/bio.c
+++ b/block/bio.c
@@ -1262,7 +1262,8 @@ struct bio *bio_copy_user_iov(struct req
 		if (ret)
 			goto cleanup;
 	} else {
-		zero_fill_bio(bio);
+		if (bmd->is_our_pages)
+			zero_fill_bio(bio);
 		iov_iter_advance(iter, bio->bi_iter.bi_size);
 	}
 


