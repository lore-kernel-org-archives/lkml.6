Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20CD208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20CD208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388326AbeHWMbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:31:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeHWMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:31:23 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DD7D0BBF;
        Thu, 23 Aug 2018 09:02:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jun Piao <piaojun@huawei.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>,
        Greg Kurz <groug@kaod.org>,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 264/324] net/9p/client.c: put refcount of trans_mod in error case in parse_opts()
Date:   Thu, 23 Aug 2018 09:55:30 +0200
Message-Id: <20180823075009.199949399@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: piaojun <piaojun@huawei.com>

[ Upstream commit c290fba8c4ce6530cd941ea14db5a4ac2f77183f ]

In my testing, the second mount will fail after umounting successfully.
The reason is that we put refcount of trans_mod in the correct case
rather than the error case in parse_opts() at last.  That will cause the
refcount decrease to -1, and when we try to get trans_mod again in
try_module_get(), we could only increase refcount to 0 which will cause
failure as follows:

parse_opts
  v9fs_get_trans_by_name
    try_module_get : return NULL to caller which cause error

So we should put refcount of trans_mod in error case.

Link: http://lkml.kernel.org/r/5B3F39A0.2030509@huawei.com
Fixes: 9421c3e64137ec ("net/9p/client.c: fix potential refcnt problem of trans module")
Signed-off-by: Jun Piao <piaojun@huawei.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Dominique Martinet <dominique.martinet@cea.fr>
Tested-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Ron Minnich <rminnich@sandia.gov>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/client.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -228,7 +228,8 @@ static int parse_opts(char *opts, struct
 	}
 
 free_and_return:
-	v9fs_put_trans(clnt->trans_mod);
+	if (ret)
+		v9fs_put_trans(clnt->trans_mod);
 	kfree(tmp_options);
 	return ret;
 }


