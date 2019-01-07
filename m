Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FDBC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0985321736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865334;
	bh=lsja5kgmsApBCXK5+/qRUOLOT9WEVsAd1YMN8VNSXbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XtuhkMTILJqKZq1smpVk3udo1MsXR2GadbEWkpUQ7N5m6A3nNOcFgbDPqhWXo32g+
	 ybsG65M2gnjAkkKfIXGeJiFZZsWAagxZPQdtfn3bHfUgf7oMAX8VqG8FXfxhM2z3Op
	 ZO5cwqAplkISazu9ebQ8kV9es3m5tXU800SiqyUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbfAGMsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729250AbfAGMsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C8B220651;
        Mon,  7 Jan 2019 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865330;
        bh=lsja5kgmsApBCXK5+/qRUOLOT9WEVsAd1YMN8VNSXbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBFNG+mc9Ml0vt8C1jQd/NkzLZLqUZ5MiISuz4VFyvVQh6Fv8J51VAYebLo3y9EDj
         2ermKFk7LXroIC3vb085yEGWSUSJApiC/D1+RhobOdgf18rpKDFw7H7xk27nuTKpJk
         Ya0M9myrPglaoWwzntpYGr4itmhXMug6XnEPBw4Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Timothy Redaelli <tredaelli@redhat.com>,
        "Herton R. Krzesinski" <herton@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 057/170] net: Use __kernel_clockid_t in uapi net_stamp.h
Date:   Mon,  7 Jan 2019 13:31:24 +0100
Message-Id: <20190107104459.819387468@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Davide Caratti <dcaratti@redhat.com>

[ Upstream commit e2c4cf7f98a519eb4d95532bfa06bcaf3562fed5 ]

Herton reports the following error when building a userspace program that
includes net_stamp.h:

 In file included from foo.c:2:
 /usr/include/linux/net_tstamp.h:158:2: error: unknown type name
 ‘clockid_t’
   clockid_t clockid; /* reference clockid */
   ^~~~~~~~~

Fix it by using __kernel_clockid_t in place of clockid_t.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Cc: Timothy Redaelli <tredaelli@redhat.com>
Reported-by: Herton R. Krzesinski <herton@redhat.com>
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
Tested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/net_tstamp.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/uapi/linux/net_tstamp.h
+++ b/include/uapi/linux/net_tstamp.h
@@ -155,8 +155,8 @@ enum txtime_flags {
 };
 
 struct sock_txtime {
-	clockid_t	clockid;	/* reference clockid */
-	__u32		flags;		/* as defined by enum txtime_flags */
+	__kernel_clockid_t	clockid;/* reference clockid */
+	__u32			flags;	/* as defined by enum txtime_flags */
 };
 
 #endif /* _NET_TIMESTAMPING_H */


