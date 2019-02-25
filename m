Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AFE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130764;
	bh=LDhHh8q7rf7tZf3Ss/4ym2NC+6YUnn1uZ7eCBrgWPR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v6WHIM/Kgn+6mHG8gbN4kJRmFzEmpZ0VpjX34hhEqG/y0Uda6rQQFBxV9sIxtd+qs
	 jyqN385SQctDR+xav7EIQWOibu7yksGnTtUQkyz9pM8vsrm2OQ6Rwi0FdCMHV6zB9E
	 L6QiMS/bIUmJ183BnEeW+dmXIYt9sgrx/R7l0OQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733122AbfBYVgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733097AbfBYVgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58FE217F5;
        Mon, 25 Feb 2019 21:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130565;
        bh=LDhHh8q7rf7tZf3Ss/4ym2NC+6YUnn1uZ7eCBrgWPR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OL8lO6QTLxTrBwykpnh9/MrKgXE9TYdDrlVNEz1U/sw/6yfVX8npgGUKM7c58HXDH
         pqpj8lQ9ztVVSXQWfTFHtwH5wnxRVe18sIMFfHT7Vs8K7RHmbU2sHLwpE2Yf15+22j
         tKTuJswK3yigdKjbg4cE8qnpH8lg2fN94DY79mKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.20 161/183] mac80211: Change default tx_sk_pacing_shift to 7
Date:   Mon, 25 Feb 2019 22:12:14 +0100
Message-Id: <20190225195122.158033941@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

commit 5c14a4d05f68415af9e41a4e667d1748d41d1baf upstream.

When we did the original tests for the optimal value of sk_pacing_shift, we
came up with 6 ms of buffering as the default. Sadly, 6 is not a power of
two, so when picking the shift value I erred on the size of less buffering
and picked 4 ms instead of 8. This was probably wrong; those 2 ms of extra
buffering makes a larger difference than I thought.

So, change the default pacing shift to 7, which corresponds to 8 ms of
buffering. The point of diminishing returns really kicks in after 8 ms, and
so having this as a default should cut down on the need for extensive
per-device testing and overrides needed in the drivers.

Cc: stable@vger.kernel.org
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -615,13 +615,13 @@ struct ieee80211_hw *ieee80211_alloc_hw_
 	 * We need a bit of data queued to build aggregates properly, so
 	 * instruct the TCP stack to allow more than a single ms of data
 	 * to be queued in the stack. The value is a bit-shift of 1
-	 * second, so 8 is ~4ms of queued data. Only affects local TCP
+	 * second, so 7 is ~8ms of queued data. Only affects local TCP
 	 * sockets.
 	 * This is the default, anyhow - drivers may need to override it
 	 * for local reasons (longer buffers, longer completion time, or
 	 * similar).
 	 */
-	local->hw.tx_sk_pacing_shift = 8;
+	local->hw.tx_sk_pacing_shift = 7;
 
 	/* set up some defaults */
 	local->hw.queues = 1;


