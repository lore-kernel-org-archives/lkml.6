Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0A5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644AD206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="fgcKx0If"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfBEBWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:22:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44320 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBEBWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:22:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id n32so2155553qte.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 17:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/vDaxBVASW6iBtYKKCds6dLngrOLTNYFBovgl2XcSN8=;
        b=fgcKx0IfCGlfbxb4mk2vOLKuRBUo18bqf+XVKJ4FDJl5hF/rZQY+jf07fH2fGi8nZe
         oC9KhjsJd+C1k8zKkkiLqvvHRMK+Ei3k4/RPWmW2H6OKk73yKulD8VIitWASaK1RQSzF
         Yfr3tWa5JCTamf0IK2nQm07cN/79/PFaKaBwRQsrKA0OqXAGJlG0O8JOm+mABUnJ21bp
         CHUI/l8Pi5syh4GMw+U2CVHZ2U9x8n89onx3Hi2KF6cNFKZkya+u9CiJ8Q0jkIy+8N2w
         BnrNBougZBlGz5Z8JscyPSOamn2Q9awbT7aTndrJm0sjNJzenvYnu5POfM6egtjQuLGz
         MrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/vDaxBVASW6iBtYKKCds6dLngrOLTNYFBovgl2XcSN8=;
        b=rceDzsX1AfK9u0RrQ37/rTLOEJGG6oUvkK3fJPKfzE3ziitTLzQyzj4hiWhlZBfi5X
         /e5tIsK5qqIVWB1B/nfT0YFQz/VrlX0QppVXdqENq9jWsCZp7DgEmJc9N0dBkG3arpFz
         ngwwt3d6cHzpm2d5aJUvKpNu3fv9uIITJqbtCedNiOb7kPogZghtfLVHL1fw2/oyA064
         Z+IWjaSI7NodgDS9diRe8t8sx0cONZ0H5kgMkm3AEcj71M3vMnkegmbQz9reyWIJvyDB
         In7lw3WOpriJl2X9qHxy6vC17eUSVx1M8GOX5YD3LA1d7mXSzQoQZzK6MpzUAA5A6wXB
         2zzw==
X-Gm-Message-State: AHQUAuYRekdJIhx6aOF5Hzh4QFN21h0Cj9O3xaNuuVLJS5vZlm0otjBy
        gJEqLQXzRB0F0mr4NXp5gtcMnw==
X-Google-Smtp-Source: AHgI3IYIJQfQ0lRcRNH2GuySKqa7VlZE+jw/33RiTr2diDYvcv6jKOoXazv6IbLRcLheJh+VKiak+g==
X-Received: by 2002:ac8:6990:: with SMTP id o16mr1729486qtq.185.1549329754031;
        Mon, 04 Feb 2019 17:22:34 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d7sm12466946qkk.71.2019.02.04.17.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 17:22:33 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mike.kravetz@oracle.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] hugetlbfs: a terminator for hugetlb_param_specs[]
Date:   Mon,  4 Feb 2019 20:22:24 -0500
Message-Id: <20190205012224.65672-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting up an arm64 server with CONFIG_VALIDATE_FS_PARSER=n triggers a
out-of-bounds error below, due to the commit 2284cf59cbce ("hugetlbfs:
Convert to fs_context") missed a terminator for hugetlb_param_specs[],
and causes this loop in fs_lookup_key(),

for (p = desc->specs; p->name; p++)

could not exit properly due to p->name is never be NULL.

[   91.575203] BUG: KASAN: global-out-of-bounds in fs_lookup_key+0x60/0x94
[   91.581810] Read of size 8 at addr ffff200010deeb10 by task mount/2461
[   91.597350] Call trace:
[   91.597357]  dump_backtrace+0x0/0x2b0
[   91.597361]  show_stack+0x24/0x30
[   91.597373]  dump_stack+0xc0/0xf8
[   91.623263]  print_address_description+0x64/0x2b0
[   91.627965]  kasan_report+0x150/0x1a4
[   91.627970]  __asan_report_load8_noabort+0x30/0x3c
[   91.627974]  fs_lookup_key+0x60/0x94
[   91.627977]  fs_parse+0x104/0x990
[   91.627986]  hugetlbfs_parse_param+0xc4/0x5e8
[   91.651081]  vfs_parse_fs_param+0x2e4/0x378
[   91.658118]  vfs_parse_fs_string+0xbc/0x12c
[   91.658122]  do_mount+0x11f0/0x1640
[   91.658125]  ksys_mount+0xc0/0xd0
[   91.658129]  __arm64_sys_mount+0xcc/0xe4
[   91.658137]  el0_svc_handler+0x28c/0x338
[   91.681740]  el0_svc+0x8/0xc

Fixes: 2284cf59cbce ("hugetlbfs: Convert to fs_context")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 fs/hugetlbfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index abf0c2eb834e..4f352743930f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -81,6 +81,7 @@ static const struct fs_parameter_spec hugetlb_param_specs[] = {
 	fsparam_string("pagesize",	Opt_pagesize),
 	fsparam_string("size",		Opt_size),
 	fsparam_u32   ("uid",		Opt_uid),
+	{}
 };
 
 static const struct fs_parameter_description hugetlb_fs_parameters = {
-- 
2.17.2 (Apple Git-113)

