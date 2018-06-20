Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3E3C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C6C2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q8Ml5Nza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C6C2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754530AbeFTQdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:33:55 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:41362 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbeFTQdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:33:53 -0400
Received: by mail-qt0-f201.google.com with SMTP id 12-v6so126996qtq.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=DqmTyLnVHPCzJLIa+OMwdi01ZbF/3M1QtvmuXjucO80=;
        b=q8Ml5Nzaw1AureZJhKqxa+zwJpJeQ3caHd9B2hp/lwfn3ozKMrKk2YcIyhuSUx5dnK
         OYZ7rJ6iOVM+UBnJ23PuCjgHdPtSdGnkPR4JB465e1d+RIvMpp6xTQ0wyVkpWpcP6/7w
         G809vgADq59TlS9AyV/dxZ7+kuD1qeYK3RVu1upy1XSiwLlaX2UGO2iBvljJVOXaFQE/
         WPo/vuq2l2zDPDhhhsXtFKES4XMCAmliuLCI//kZTSMLcG90MnBCTcWyr/QptPvf4s/W
         b8GhF4uAHXUzkb/v1SR3LdVPofGggJMF5pjADGUZiv41S5cwdZNM/97LECtKeVtl5FyO
         J3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=DqmTyLnVHPCzJLIa+OMwdi01ZbF/3M1QtvmuXjucO80=;
        b=Cly5LU07x0b4+BenlhM5J8KTGAhHGADRtFbxspwwbFopA+V3DrRl6icH7mDDwYcJsQ
         F5t2qzfIMj9Q/4u8I+nXWuprMgCMVhjZn4CXvYE2dMbprf3o4Gsigs7AudVDvpKxwHsE
         NMaPsOwmU4v9BJ1vKb3Z0RhxmqKvo7EsmewLy2Tn7/82MhIP6Vy/8mu1c6fk0s+P3u7n
         4xngUpEtQiyj6NDMHe9UQOE6ZIIga0T+jc0ymo/bp+xf3tCIUjnsEyX7mEXoOxmTussZ
         t3vr1Lm9o1yNCCTvKSrBgSi+ptHMdhr20+qOcfSghI51MC/gx3cjMXYZb0+0OZ0Lb7S0
         cjuA==
X-Gm-Message-State: APt69E0ha1qtY7HZQGVbAvID4Tod1hwdXAjjuT71qUynUsBQfU4oR4l8
        3HtmE1wChZ6UiYFrjFPHTcJMGSSK1Q==
X-Google-Smtp-Source: ADUXVKKDLIwady0setVnjehsCapyU5CA5GaMY9/C2X39C0HldHWGs/dHw254Zc40h7/gnnFj23WZSvdJog==
MIME-Version: 1.0
X-Received: by 2002:a0c:8b4a:: with SMTP id d10-v6mr11890635qvc.14.1529512432757;
 Wed, 20 Jun 2018 09:33:52 -0700 (PDT)
Date:   Wed, 20 Jun 2018 18:33:45 +0200
Message-Id: <20180620163345.212776-1-jannh@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH net] netfilter: nf_log: fix uninit read in nf_log_proc_dostring
From:   Jann Horn <jannh@google.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        jannh@google.com
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When proc_dostring() is called with a non-zero offset in strict mode, it
doesn't just write to the ->data buffer, it also reads. Make sure it
doesn't read uninitialized data.

Fixes: c6ac37d8d884 ("netfilter: nf_log: fix error on write NONE to [...]")
Signed-off-by: Jann Horn <jannh@google.com>
---
 net/netfilter/nf_log.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 426457047578..2c47f9ec3511 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -424,6 +424,10 @@ static int nf_log_proc_dostring(struct ctl_table *table, int write,
 	if (write) {
 		struct ctl_table tmp = *table;
 
+		/* proc_dostring() can append to existing strings, so we need to
+		 * initialize it as an empty string.
+		 */
+		buf[0] = '\0';
 		tmp.data = buf;
 		r = proc_dostring(&tmp, write, buffer, lenp, ppos);
 		if (r)
-- 
2.18.0.rc1.244.gcf134e6275-goog

