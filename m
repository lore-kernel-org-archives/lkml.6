Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C5C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D394326158
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WkXUhI5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D394326158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeFYVMa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:12:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44212 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbeFYVKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:10:43 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so2643879pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Avxx9PvYtzEZjc921kE7oEpJGokk8Or/8y8tIvzareo=;
        b=WkXUhI5VtfVn0d7vBu7j7imcjQNCjH/Gq9NcGnwiTulsnOQ9EAKUDg8VUaGFVjvvzb
         FqerqSyukonb7dqiSMSfoxMk/prSxcaUn8qoZi/PYFAEzjDWxWZ7GO2eWOz0e5sYpE5Z
         dt+YOdPbdYsVmqJUtMnlSfuFt6U4ozRCoYh1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Avxx9PvYtzEZjc921kE7oEpJGokk8Or/8y8tIvzareo=;
        b=DUah24tbrr47vSEf7YwXB7dKwqfENDtRg6R9qCCxDUiu8/7+NZGkWXkM2GukfKLWda
         4Lrqq24X3Dt0X/4/r0cQ/Mn7vMWbBrySud/MAM1MWDLialzXGDEu9SlHULh/HehBopZk
         Wf1THVhHhYyHvBLkFZfo897aHrUlCWBKkvl0z9YTw5DYnnNqN+FOiSC20NmxLu1Lyp4R
         agiNWLA+B4YlG61cXIMmPC7gYslW3BRCdbJbMMY9R+GOPUEkIkQlSc9Mj9U7yC964uTL
         FL9BHtLV8VjiVHc95duA2tw88e2RaiJokB4o1o8BGON5OuAJwvhdprdrqPZWdogAfExM
         SEwQ==
X-Gm-Message-State: APt69E1/G50fsnEYrdR0K+GRGrWmoem84vz6khuJ0DIr9A6xu9fuDhOy
        gIwBXsjGMKR8HntdzL6tv0O2Pw==
X-Google-Smtp-Source: ADUXVKIzKg7fzPLNVKFRWB5W0uN2BAiDvieV6Shm+2++VAKjHTUsvXkDT19CcjoxiH+MZYZROLbTpw==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr14246902plr.0.1529961042752;
        Mon, 25 Jun 2018 14:10:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y18-v6sm22705040pfl.122.2018.06.25.14.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 14:10:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/11] dm verity fec: Remove VLA usage
Date:   Mon, 25 Jun 2018 14:10:21 -0700
Message-Id: <20180625211026.15819-7-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625211026.15819-1-keescook@chromium.org>
References: <20180625211026.15819-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to remove all stack VLA usage from the kernel[1], this
uses the newly defined max digest size macro. Also adds a sanity-check
at use-time.

[1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/md/dm-verity-fec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index 684af08d0747..fe5cfd1a5fa5 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -212,12 +212,15 @@ static int fec_read_bufs(struct dm_verity *v, struct dm_verity_io *io,
 	struct dm_verity_fec_io *fio = fec_io(io);
 	u64 block, ileaved;
 	u8 *bbuf, *rs_block;
-	u8 want_digest[v->digest_size];
+	u8 want_digest[AHASH_MAX_DIGESTSIZE];
 	unsigned n, k;
 
 	if (neras)
 		*neras = 0;
 
+	if (WARN_ON(v->digest_size > sizeof(want_digest)))
+		return -EINVAL;
+
 	/*
 	 * read each of the rsn data blocks that are part of the RS block, and
 	 * interleave contents to available bufs
-- 
2.17.1

