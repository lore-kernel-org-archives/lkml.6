Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A84BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AA0218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 04:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlDyqnPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbfABEQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 23:16:39 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46462 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbfABEQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 23:16:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id w25so25802518otm.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 20:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sGf8qo2Wdx2LK1OhcJgrgfHsKFZtTfQlC5pl8JudtzE=;
        b=TlDyqnPHZSSgvwoclhmoj5ys8xDZm6AlFzh05iWq49a0NRex24EjU20DyAzpNHTUT9
         uRytyqszNnfGIMXVM/NFBwcNXsFtkxYspclXZAz3c2+g15YObn+SUogf8XaTA8DIeE2K
         ocCl0fV6dGBnOPKUF3b97m7ySSCWjVhPDwUhr2YyuSNUkfxZqr+XiZTD+K/u9s10C9Zf
         Le5E3McHGCXl1ohRSkIOtmOyLYHTVM7ChSDXX3bf6Ps5+9Ln/adFK1P4iSr6jK6ZYm76
         fR3gRj5Y1C1QVCMJi4sqEETFCjfuEZMOZApxYz1eqmVGlwetjzwxPK+81yhXcQPCYQoy
         14IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sGf8qo2Wdx2LK1OhcJgrgfHsKFZtTfQlC5pl8JudtzE=;
        b=s8/55fC2fzYAeS6sTGDOhhovhu7Sa/esd4MSaeb9FUvlATaNgQ0ediEYz/EijIpfGf
         ytTPh7x5whbKcJxB3gZSmE6g73ILZkmfSccgfr+lM+FaqVFp9sB8UZiRmnS8CEsVcMA9
         JVw+ADPNck9RTpkyhi6f+zC1yVxJQakh+p41+LfCJiOVYvW/g1KNVrD69S4eeTBQBUww
         //V/1NUXbHoDSDF79W6YuCZCTYtpfnmKMy0Z2h/z2zHMlKPAmmcyxgFzxUg4n72+hInl
         SqJvYR1l2Sp49gmdJZdXrDPuU8Mk0tWeah8yTzghhTVf7/rUhl6zodLgpERy0gHmvkBR
         X8tQ==
X-Gm-Message-State: AJcUukdJZoE7qfOmvlqUkA9k+oYDXGcb9U8leJSnGpG5s7f3ABJzwMwr
        uzH1MR59BUQBOz4AP20tHnHPo5EMD1U=
X-Google-Smtp-Source: ALg8bN45dgSFZYcm+zGi65miW7qopuu4TeQu4nqCYJSidDyIUBobIzzQRL8h0VOde/VcbbUE/YeMUw==
X-Received: by 2002:a9d:1421:: with SMTP id h30mr28318662oth.321.1546402597919;
        Tue, 01 Jan 2019 20:16:37 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 21sm29760692oie.24.2019.01.01.20.16.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Jan 2019 20:16:37 -0800 (PST)
Date:   Tue, 1 Jan 2019 20:16:28 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vineeth Pillai <vpillai@digitalocean.com>
cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kelley Nielsen <kelleynnn@gmail.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v3 2/2] mm: rid swapoff of quadratic complexity
In-Reply-To: <CANaguZAStuiXpk2S0rYwdn3Zzsoakavaps4RzSRVqMs3wZ49qg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1901012010440.13241@eggly.anvils>
References: <20181203170934.16512-1-vpillai@digitalocean.com> <20181203170934.16512-2-vpillai@digitalocean.com> <alpine.LSU.2.11.1812311635590.4106@eggly.anvils> <CANaguZAStuiXpk2S0rYwdn3Zzsoakavaps4RzSRVqMs3wZ49qg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2019, Vineeth Pillai wrote:

> Thanks a lot for the fixes and detailed explanation Hugh! I shall fold all
> the changes from you and Huang in the next iteration.
> 
> Thanks for all the suggestions and comments as well. I am looking into all
> those and will include all the changes in the next version. Will discuss
> over mail in case of any clarifications.

One more fix on top of what I sent yesterday: once I delved into
the retries, I found that the major cause of exceeding MAX_RETRIES
was the way the retry code neatly avoided retrying the last part of
its work.  With this fix in, I have not yet seen retries go above 1:
no doubt it could, but at present I have no actual evidence that
the MAX_RETRIES-or-livelock issue needs to be dealt with urgently.
Fix sent for completeness, but it reinforces the point that the
structure of try_to_unuse() should be reworked, and oldi gone.

Hugh

---

 mm/swapfile.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- mmotm/mm/swapfile.c	2018-12-31 12:30:55.822407154 -0800
+++ linux/mm/swapfile.c	2019-01-01 19:50:34.377277830 -0800
@@ -2107,8 +2107,8 @@ int try_to_unuse(unsigned int type, bool
 	struct swap_info_struct *si = swap_info[type];
 	struct page *page;
 	swp_entry_t entry;
-	unsigned int i = 0;
-	unsigned int oldi = 0;
+	unsigned int i;
+	unsigned int oldi;
 	int retries = 0;
 
 	if (!frontswap)
@@ -2154,6 +2154,7 @@ retry:
 		goto out;
 	}
 
+	i = oldi = 0;
 	while ((i = find_next_to_unuse(si, i, frontswap)) != 0) {
 		/*
 		 * Under global memory pressure, swap entries
