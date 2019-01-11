Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA919C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF74F20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218731;
	bh=cNXo8HBfQ9mItkIfL/+LuZHg/GQjJbayUmhanOPBls0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXkhZwhSgeRAoOl3hK7uJdM4Ioo3a/c3Oi6hdn6kU+9bNkcbhDdgXeBQabqRxxT8D
	 0LVQ7bsMf2bsvZoagU6o7hPreYdTjUxc9/YqD5NbQuBKpBBXBt536KB+/BjIXd0Yqv
	 K59+vFyig9TNjF1Nfar75+WNnO+xSb5Nzx1iYzLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391751AbfAKO6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389849AbfAKOeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:34:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921D32133F;
        Fri, 11 Jan 2019 14:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217258;
        bh=cNXo8HBfQ9mItkIfL/+LuZHg/GQjJbayUmhanOPBls0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0bVPrDmMzbOw7SymnyWx1sz6AvfsIA4i6lIUgM2AdTMtjEXzxefIwWghhvdNcrzE
         GI2DoSqduOT5N1QSTSHqwIX+sOUeBpPRy6AaEnBLQ5EHd/R2Pk3xD0nDG4tTpwWMks
         5pjg4lwacPPT1xU1bf7ohS7U/R1wUL97f2j7l9ko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.14 100/105] ceph: dont update importing caps mseq when handing cap export
Date:   Fri, 11 Jan 2019 15:15:11 +0100
Message-Id: <20190111131111.159827011@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yan, Zheng <zyan@redhat.com>

commit 3c1392d4c49962a31874af14ae9ff289cb2b3851 upstream.

Updating mseq makes client think importer mds has accepted all prior
cap messages and importer mds knows what caps client wants. Actually
some cap messages may have been dropped because of mseq mismatch.

If mseq is left untouched, importing cap's mds_wanted later will get
reset by cap import message.

Cc: stable@vger.kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/caps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3438,7 +3438,6 @@ retry:
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_seq - 1;
 			tcap->issue_seq = t_seq - 1;
-			tcap->mseq = t_mseq;
 			tcap->issued |= issued;
 			tcap->implemented |= issued;
 			if (cap == ci->i_auth_cap)


