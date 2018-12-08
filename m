Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC9C07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E71F20837
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oFnVNw0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E71F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbeLHCwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:52:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34072 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeLHCwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:52:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id r14so6762632qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 18:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Bk6sYsPvSUt2Ewp3VXg+xHASakTFI/7rol3b5kTfvTM=;
        b=oFnVNw0OgWSK8s0k0bu81eE2bGsMieiV0US36LGfdYzJvfyQ+MGIvI7MxY838PrRD3
         FBLUs0DmecYqzUAfuq82yVA+nqnZuXEa4q3ISYWDHnkE4XG1cawEPDVZvkv7P+DiNlQF
         2Jq7ofFptn12JoaQ7gPWflseZDeW1+Mwg+Q3na5dpTYvDruW9f8thZVdRUhE/fh/L/Li
         SR/5fg+NlOf0+FK0shiHvrkg3qVCt6/PQntPEISLFQSMf+WbR6SFAMy21qxrGQlFPdwu
         V5ESinOvVZuwYSY0gAd9tgzMFGTVV92mT4uzDk+6rwlargsf9paKgJqaYd9NDQNmm188
         HywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bk6sYsPvSUt2Ewp3VXg+xHASakTFI/7rol3b5kTfvTM=;
        b=RK+hRSLnABdsxIyK09FFrgdQZB2Kc6g3i8YZ4Tu1nsxI5OoHmnzszkQgkjE3Oe2wb8
         uRM0GQXxI9KH7S3ZMDD/knfXSsE79eGnAiGfLtNxHM+Y0IvIzZI0WWH5MM5BzNU1XYyV
         ibu1x/Hmum6dFkzzgUaAPmdhScOU0xGl/S/gIo7ynudD6Ayfvr7jpoU31p2a4RhS6kkr
         LrUGY8aKrwW8q1YZjIZcsPOVQJ4ZzqFTaDGO7yqXbNJWpZn0X/XdgDq4DW2URNLkAl6u
         BU/mZrF8lh6IR17H9PUr1+Hg2SEAZbLHH31+4bjI9vIK0gk8m/pg/sIo2HheIw3kOuT8
         m2Jg==
X-Gm-Message-State: AA+aEWZzfXa+HlF4Y6AmIERPWekUwDViwThEbzh6QNqg3mQNfXmiSsvb
        6w91cLaY6C7NIBlUtT66oQB4sA==
X-Google-Smtp-Source: AFSGD/V+If+rciT6HZ0/X+rcXQmyx9VZ2C2qij5z4CxpwwlrrbEOMkXod9tWjDcb2z9heBGbMAffVw==
X-Received: by 2002:ac8:2ca9:: with SMTP id 38mr4454792qtw.338.1544237525527;
        Fri, 07 Dec 2018 18:52:05 -0800 (PST)
Received: from ovpn-121-90.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m20sm2339776qkk.66.2018.12.07.18.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 18:52:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] checkstack.pl: dynamic stack growth for aarch64
Date:   Fri,  7 Dec 2018 21:51:43 -0500
Message-Id: <20181208025143.39363-1-cai@lca.pw>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to track dynamic amount of stack growth for aarch64, so it is
possible to print out offensive functions that may consume too much
stack. For example,

0xffff2000084d1270 try_to_unmap_one [vmlinux]:		Dynamic (0xcf0)
0xffff200008538358 migrate_page_move_mapping [vmlinux]:	Dynamic (0xc60)
0xffff2000081276c8 copy_process.isra.2 [vmlinux]:	Dynamic (0xb20)
0xffff200008424958 show_free_areas [vmlinux]:		Dynamic (0xb40)
0xffff200008545178 __split_huge_pmd_locked [vmlinux]:	Dynamic (0xb30)
0xffff200008555120 collapse_shmem [vmlinux]:		Dynamic (0xbc0)
0xffff20000862e0d0 do_direct_IO [vmlinux]:		Dynamic (0xb70)
0xffff200008cc0aa0 md_do_sync [vmlinux]:		Dynamic (0xb90)

Signed-off-by: Qian Cai <cai@lca.pw>
---
 scripts/checkstack.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
index 34414c6efad6..122aef5e4e14 100755
--- a/scripts/checkstack.pl
+++ b/scripts/checkstack.pl
@@ -48,7 +48,9 @@ my (@stack, $re, $dre, $x, $xs, $funcre);
 	$funcre = qr/^$x* <(.*)>:$/;
 	if ($arch eq 'aarch64') {
 		#ffffffc0006325cc:       a9bb7bfd        stp     x29, x30, [sp, #-80]!
+		#a110:       d11643ff        sub     sp, sp, #0x590
 		$re = qr/^.*stp.*sp, \#-([0-9]{1,8})\]\!/o;
+		$dre = qr/^.*sub.*sp, sp, #(0x$x{1,8})/o;
 	} elsif ($arch eq 'arm') {
 		#c0008ffc:	e24dd064	sub	sp, sp, #100	; 0x64
 		$re = qr/.*sub.*sp, sp, #(([0-9]{2}|[3-9])[0-9]{2})/o;
-- 
2.17.2 (Apple Git-113)

