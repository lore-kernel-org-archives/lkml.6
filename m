Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18193C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE19521855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864919;
	bh=EywqWChuzjwCdUh39Rtcjdvs3wLU/gItA6w90EIpH2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NCmJ4BsSrXFDdjh+lqK3NjUkc0c5XaTdiS8G2fUiy9vF79ImFcKwc2vwleiXNobFi
	 cYW/eirOKw9+3HkqgwRL8dKLN0dm1GZmQMhCysLtLQgQ6/UnptFhu7nOLxMlPNjp0P
	 dJ9FmispYxATemZvh2MW9SNHcfNz39QBd+uxhne8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAGMl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:41:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727347AbfAGMl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:41:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5BBA2183F;
        Mon,  7 Jan 2019 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864916;
        bh=EywqWChuzjwCdUh39Rtcjdvs3wLU/gItA6w90EIpH2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bIjEm7ciX/+chSGr9auoiOpm/+eyKKSldckNTWMJVlOX6lXGJfqKRalwDSYWQrYqH
         Qn6pTWRkFxXZYC4Gm77+S7Bg8uU7TPJXVtIoHi4dhkrUK+wPuZElO23cKAn3w3H2NZ
         iFW3cYtUfyC0i8VKZJ70CvcvxVnfex19hnQXajqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@kernel.org
Subject: [PATCH 4.20 101/145] KEYS: fix parsing invalid pkey info string
Date:   Mon,  7 Jan 2019 13:32:18 +0100
Message-Id: <20190107104450.449235421@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

From: Eric Biggers <ebiggers@google.com>

commit 57b0e31453209d746c99e513d80b3d0c44a80891 upstream.

We need to check the return value of match_token() for Opt_err before
doing anything with it.

[ Not only did the old "-1" value for Opt_err cause problems for the
  __test_and_set_bit(), as fixed in commit 94c13f66e13c ("security:
  don't use a negative Opt_err token index"), but accessing
  "args[0].from" is invalid for the Opt_err case, as pointed out by Eric
  later.  - Linus ]

Reported-by: syzbot+a22e0dc07567662c50bc@syzkaller.appspotmail.com
Fixes: 00d60fd3b932 ("KEYS: Provide keyctls to drive the new key type ops for asymmetric keys [ver #2]")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Cc: stable@kernel.org # 4.20
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/keys/keyctl_pkey.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -50,6 +50,8 @@ static int keyctl_pkey_params_parse(stru
 		if (*p == '\0' || *p == ' ' || *p == '\t')
 			continue;
 		token = match_token(p, param_keys, args);
+		if (token == Opt_err)
+			return -EINVAL;
 		if (__test_and_set_bit(token, &token_mask))
 			return -EINVAL;
 		q = args[0].from;


