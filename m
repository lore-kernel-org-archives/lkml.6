Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D234C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C098321829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 06:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="utZfwDI5";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="utZfwDI5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C098321829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbeHMJjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:39:15 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:50912 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbeHMJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:39:14 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.cmail.yandex.net (Yandex) with ESMTP id 7141A21233;
        Mon, 13 Aug 2018 09:58:17 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EpZ3JuQNfW-wHN8cpY2;
        Mon, 13 Aug 2018 09:58:17 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534143497; bh=g8KK2eY9Qx5mtXYPtyrNv99QbkJY/jwtgDsrn4/1FV0=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=utZfwDI5V7wYbwnn/A+RSPxNxnyD2iS620obLp2CZK3EA/KM+PHruewO6HeEW9qac
         +Qe7/DWhS2MSFVUOwzfIXALFixLVtQOynBF30jLP1/zIw17LVqnGcfWcp9HPqj4B0m
         6ZZsWQPI7xx3bCGXIIs+3BoLG837I0PvIA9hNzgE=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2msfYMj7CI-wH8StnEP;
        Mon, 13 Aug 2018 09:58:17 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1534143497; bh=g8KK2eY9Qx5mtXYPtyrNv99QbkJY/jwtgDsrn4/1FV0=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=utZfwDI5V7wYbwnn/A+RSPxNxnyD2iS620obLp2CZK3EA/KM+PHruewO6HeEW9qac
         +Qe7/DWhS2MSFVUOwzfIXALFixLVtQOynBF30jLP1/zIw17LVqnGcfWcp9HPqj4B0m
         6ZZsWQPI7xx3bCGXIIs+3BoLG837I0PvIA9hNzgE=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH RFC 3/3] tools/vm/page-types: add flag for showing inodes of
 offline cgroups
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Mon, 13 Aug 2018 09:58:14 +0300
Message-ID: <153414349419.737150.8224164787883146532.stgit@buzz>
In-Reply-To: <153414348591.737150.14229960913953276515.stgit@buzz>
References: <153414348591.737150.14229960913953276515.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With flag -R|--real-cgroup page-types will report real owner.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/vm/page-types.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index cce853dca691..453dbbb9fe8b 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -173,6 +173,7 @@ static pid_t		opt_pid;	/* process to walk */
 const char		*opt_file;	/* file or directory path */
 static uint64_t		opt_cgroup;	/* cgroup inode */
 static int		opt_list_cgroup;/* list page cgroup */
+static int		opt_real_cgroup;/* real offline cgroup */
 static const char	*opt_kpageflags;/* kpageflags file to parse */
 
 #define MAX_ADDR_RANGES	1024
@@ -789,6 +790,7 @@ static void usage(void)
 "            -l|--list                  Show page details in ranges\n"
 "            -L|--list-each             Show page details one by one\n"
 "            -C|--list-cgroup           Show cgroup inode for pages\n"
+"            -R|--real-cgroup           Show real offline cgroups\n"
 "            -N|--no-summary            Don't show summary info\n"
 "            -X|--hwpoison              hwpoison pages\n"
 "            -x|--unpoison              unpoison pages\n"
@@ -1193,6 +1195,7 @@ static const struct option opts[] = {
 	{ "list"      , 0, NULL, 'l' },
 	{ "list-each" , 0, NULL, 'L' },
 	{ "list-cgroup", 0, NULL, 'C' },
+	{ "real-cgroup", 0, NULL, 'R' },
 	{ "no-summary", 0, NULL, 'N' },
 	{ "hwpoison"  , 0, NULL, 'X' },
 	{ "unpoison"  , 0, NULL, 'x' },
@@ -1208,7 +1211,7 @@ int main(int argc, char *argv[])
 	page_size = getpagesize();
 
 	while ((c = getopt_long(argc, argv,
-				"rp:f:a:b:d:c:ClLNXxF:h", opts, NULL)) != -1) {
+				"rp:f:a:b:d:c:CRlLNXxF:h", opts, NULL)) != -1) {
 		switch (c) {
 		case 'r':
 			opt_raw = 1;
@@ -1231,6 +1234,9 @@ int main(int argc, char *argv[])
 		case 'C':
 			opt_list_cgroup = 1;
 			break;
+		case 'R':
+			opt_real_cgroup = 1;
+			break;
 		case 'd':
 			describe_flags(optarg);
 			exit(0);
@@ -1266,7 +1272,15 @@ int main(int argc, char *argv[])
 	if (!opt_kpageflags)
 		opt_kpageflags = PROC_KPAGEFLAGS;
 
-	if (opt_cgroup || opt_list_cgroup)
+	if (opt_real_cgroup) {
+		uint64_t flags = 1;
+
+		kpagecgroup_fd = checked_open(PROC_KPAGECGROUP, O_RDWR);
+		if (write(kpagecgroup_fd, &flags, sizeof(flags)) < 0) {
+			perror(PROC_KPAGECGROUP);
+			exit(EXIT_FAILURE);
+		}
+	} else if (opt_cgroup || opt_list_cgroup)
 		kpagecgroup_fd = checked_open(PROC_KPAGECGROUP, O_RDONLY);
 
 	if (opt_list && opt_pid)

