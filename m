Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA8DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A621905
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498588;
	bh=Bsauk4pMfW5JfsJEH9FDMZ60u3co9laXstouwgXFJEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ck6RptbjQ1bbJk8JHZTRf7yJKIXYFhy8vQ+fZaBG2U/KqTjuh06QXibKNj5c/y2er
	 MFu0nFB2tZrgay6x30Wgyi6VDkWJrnqI3G9wS3WzEMR9EU1JCrdSYLj6PSw4ZJgUkp
	 l09FrNBAf2PHEq2FL01kQ+dQ6G4v30HjSqYBBSj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388975AbfBRODG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbfBRODC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FCBC20842;
        Mon, 18 Feb 2019 14:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498581;
        bh=Bsauk4pMfW5JfsJEH9FDMZ60u3co9laXstouwgXFJEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C13DE7POi9DobivKv8SmcgKNxTFyxExcgvnKZCfRweetGUFOYp5PNfP9oUSlqRL6j
         cM0BGb8cbahBYjS/Wr1tZws0ck5sbS8MOlDabKi/dsgPgi9Fk0sd+hl3sa3vIOosi6
         Qu2bhaf6Nbaqq+AWaiG2+1FY6s0NlPRmuAyqxbdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Perl <cperl@janestreet.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 055/143] NFS: nfs_compare_mount_options always compare auth flavors.
Date:   Mon, 18 Feb 2019 14:43:03 +0100
Message-Id: <20190218133531.128170461@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 594d1644cd59447f4fceb592448d5cd09eb09b5e ]

This patch removes the check from nfs_compare_mount_options to see if a
`sec' option was passed for the current mount before comparing auth
flavors and instead just always compares auth flavors.

Consider the following scenario:

You have a server with the address 192.168.1.1 and two exports /export/a
and /export/b.  The first export supports `sys' and `krb5' security, the
second just `sys'.

Assume you start with no mounts from the server.

The following results in EIOs being returned as the kernel nfs client
incorrectly thinks it can share the underlying `struct nfs_server's:

$ mkdir /tmp/{a,b}
$ sudo mount -t nfs -o vers=3,sec=krb5 192.168.1.1:/export/a /tmp/a
$ sudo mount -t nfs -o vers=3          192.168.1.1:/export/b /tmp/b
$ df >/dev/null
df: ‘/tmp/b’: Input/output error

Signed-off-by: Chris Perl <cperl@janestreet.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 62f358f67764..412fcfbc50e2 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2376,8 +2376,7 @@ static int nfs_compare_mount_options(const struct super_block *s, const struct n
 		goto Ebusy;
 	if (a->acdirmax != b->acdirmax)
 		goto Ebusy;
-	if (b->auth_info.flavor_len > 0 &&
-	   clnt_a->cl_auth->au_flavor != clnt_b->cl_auth->au_flavor)
+	if (clnt_a->cl_auth->au_flavor != clnt_b->cl_auth->au_flavor)
 		goto Ebusy;
 	return 1;
 Ebusy:
-- 
2.19.1



