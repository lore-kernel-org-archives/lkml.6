Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59B3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B1B217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691019;
	bh=fMY4GZNKsagDYDKlCbu25KvJ/aQt/jgMGzkEgozac28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EMHFrk45X3GTdzcvZLP/C0quWdQY5HxczH8iySzjqp3xikByuZSrO+muoLIE7va3D
	 LrkJ1ins/v08z3b6TxLNw8areJTjuHtMYTLroXFBUAdl+g4l+3IFmPnHju7yc1Y11n
	 TjIyy5ek/SmjEm2Syc2PMfMskiSREV/PRG+HYPTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbfA1P46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:56:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfA1P4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:56:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79AA82175B;
        Mon, 28 Jan 2019 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691012;
        bh=fMY4GZNKsagDYDKlCbu25KvJ/aQt/jgMGzkEgozac28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERu9cgU/U+bKAGQWSwIEwFE1gBprvnf97yIb25kt5mY8kHjTY5fYADeHiH+eMdBMq
         jZ2VniKaB1sYsPTXjaMww43SJ4aB4FKVog5WN5RD4YJWkUAGfL1RaZ+nSfhKG1HKpy
         DaDhioQTFij7A9jJB6ly5YfLYWucNo3DZhGg9xF8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Perl <cperl@janestreet.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 261/304] NFS: nfs_compare_mount_options always compare auth flavors.
Date:   Mon, 28 Jan 2019 10:42:58 -0500
Message-Id: <20190128154341.47195-261-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Perl <cperl@janestreet.com>

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
index ac4b2f005778..5ef2c71348bd 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2409,8 +2409,7 @@ static int nfs_compare_mount_options(const struct super_block *s, const struct n
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

