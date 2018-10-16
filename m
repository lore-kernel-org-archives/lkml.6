Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F827C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52821477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeOW4m+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52821477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbeJQBGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbeJQBGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:06:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 819C42089E;
        Tue, 16 Oct 2018 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710131;
        bh=kSZxGx7/yXedssIiKxUQIX3kGGH2//1v4jWTCT94EAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TeOW4m+h3BcHGyg6X05qUkW2OM42MLljjiIpkGyK4drGYeVv8eF44L0TCw2+sObji
         fLJ5knNHVKmN2MwkCkLJWnyF4/rbZ/v5ykK0QJuMmBoFtMLIiRTXPYiMwfbs9l9rFh
         R2JruhhFOrxWEIQxuz8yF2XQizU4dqxG8tyT5UXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: [PATCH 4.18 111/135] afs: Fix afs_server struct leak
Date:   Tue, 16 Oct 2018 19:05:41 +0200
Message-Id: <20181016170523.002988446@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170515.447235311@linuxfoundation.org>
References: <20181016170515.447235311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f014ffb025c159fd51d19af8af0022a991aaa4f8 upstream.

Fix a leak of afs_server structs.  The routine that installs them in the
various lookup lists and trees gets a ref on leaving the function, whether
it added the server or a server already exists.  It shouldn't increment
the refcount if it added the server.

The effect of this that "rmmod kafs" will hang waiting for the leaked
server to become unused.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/afs/server.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -199,9 +199,11 @@ static struct afs_server *afs_install_se
 
 	write_sequnlock(&net->fs_addr_lock);
 	ret = 0;
+	goto out;
 
 exists:
 	afs_get_server(server);
+out:
 	write_sequnlock(&net->fs_lock);
 	return server;
 }


