Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31255C6787E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18622086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 01:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QnyfDdHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJHI2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 04:28:46 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56478 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeJHI2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 04:28:46 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20181008011932epoutp03f54898fba5a142aaeeb47d53061e6c3a~bfWWQgeui0489004890epoutp03n
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 01:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20181008011932epoutp03f54898fba5a142aaeeb47d53061e6c3a~bfWWQgeui0489004890epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538961572;
        bh=COsEB1zrLSX3jgWMZiVdXVxTAaMobehcY1Yp14k4yHU=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=QnyfDdHPBJbuKSxBmpsntvaUuDpi3kvLDbXNKblmqvlK4eXcuS6vZkUBZzx3iKlCK
         jpRBsBBy4OcyRI7HkpxO9z7cVAzozzHDq7Fbt5V6AI4P5AN0bcP8LJWkdX7dczi7Ab
         eDMN/l1y6VkPA/NP+BjFBHRqjWz7lMTdWtYFQL2Y=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008011931epcas1p2eed62871cd0d15744470f4fb45ec6979~bfWU6mwmF2099920999epcas1p2b;
        Mon,  8 Oct 2018 01:19:31 +0000 (GMT)
X-AuditID: b6c32a39-af4179c000000ff1-31-5bbab0a33022
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.D0.04081.3A0BABB5; Mon,  8 Oct 2018 10:19:31 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] mm, oom_adj: avoid meaningless loop to find processes
 sharing mm
Reply-To: ytk.lee@samsung.com
From:   Yong-Taek Lee <ytk.lee@samsung.com>
To:     "mhocko@kernel.org" <mhocko@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>
CC:     Yong-Taek Lee <ytk.lee@samsung.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
Date:   Mon, 08 Oct 2018 10:19:31 +0900
X-CMS-MailID: 20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsWy7bCmnu7iDbuiDSZ3iVtc3jWHzeLemv+s
        Fq+/LWO2uN/nYPF4PbcDq8emVZ1sHps+TWL36NuyitFj/ZarLB6fN8kFsEbl2GSkJqakFimk
        5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYArVZSKEvMKQUKBSQWFyvp
        29kU5ZeWpCpk5BeX2CqlFqTkFBgaFOgVJ+YWl+al6yXn51oZGhgYmQJVJuRk3H7UxVjQK1Rx
        6dEytgbGXzxdjJwcEgImEk+eXmDuYuTiEBLYwSjxa942ti5GDg5eAUGJvzuEQWqEBYIlJv3Z
        ChYWEpCVaO1VgQhrS2zfPYMNxGYT0JS4vu0qWImIQJDEwhUhIBOZBaYySrxp+cYGsYpXYkb7
        UxYIW1pi+/KtjBC2qMTN1W/ZYez3x+ZDxUUkWu+dZYawBSUe/NwNFZeS2NV9mQlkgYTAKkaJ
        /QfXMUM4HYwS96d2M0FU6Utc6Z8JZvMK+Eq0vOwFs1kEVCWuLz8NNclFYuv782AbmAXkJba/
        ncMM8gEz0Dfrd+lDhPkk3n3tYYV5YMe8J1DjFSWaT/RCxcUl7s3rg3rAQ+L98jtgTwoJBEq8
        uPidaQKj3CxEiM5CsmwWwrIFjMyrGMVSC4pz01OLDQtMkSNxEyM4uWlZ7mA8ds7nEKMAB6MS
        D++KgF3RQqyJZcWVuYcYJTiYlUR4PwXtjBbiTUmsrEotyo8vKs1JLT7EaAr080RmKdHkfGDi
        zSuJNzQ1MjY2tjAxMzczNVYS530iNTdaSCA9sSQ1OzW1ILUIpo+Jg1OqgfFc2j0ZZn7+1x6v
        Kort7QWbLT22bDi07/pPDQm7Nmv1M63idbVlOo7Xkq7cdq4vqmfZ9GOy7JfzknOuLTPmnHLu
        k7bfjRunPB+1FrDNVDCblPDH4pjJ7pitdnkLZIN/bqw3X6Yo3n4tbsfhUxmyFb1/Pons73u9
        VS45/FB56Ybjh9dt4pesfqvEUpyRaKjFXFScCACKs+fchAMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a
References: <CGME20181008011931epcms1p82dd01b7e5c067ea99946418bc97de46a@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is introduced by commit 44a70adec910 ("mm, oom_adj: make sure
processes sharing mm have same view of oom_score_adj"). Most of
user process's mm_users is bigger than 1 but only one thread group.
In this case, for_each_process loop meaninglessly try to find processes
which sharing same mm even though there is only one thread group.

My idea is that target task's nr thread is smaller than mm_users if there
are more thread groups sharing the same mm. So we can skip loop
if mm_user and nr_thread are same. 

test result
while true; do count=0; time while [ $count -lt 10000 ]; do echo -1000 > /proc/1457/oom_score_adj; count=$((count+1)); done; done;

before patch
0m00.59s real     0m00.09s user     0m00.51s system
0m00.59s real     0m00.14s user     0m00.45s system
0m00.58s real     0m00.11s user     0m00.47s system
0m00.58s real     0m00.10s user     0m00.48s system
0m00.59s real     0m00.11s user     0m00.48s system

after patch
0m00.15s real     0m00.07s user     0m00.08s system
0m00.14s real     0m00.10s user     0m00.04s system
0m00.14s real     0m00.10s user     0m00.05s system
0m00.14s real     0m00.08s user     0m00.07s system
0m00.14s real     0m00.08s user     0m00.07s system

Signed-off-by: Lee YongTaek <ytk.lee@samsung.com>
---
 fs/proc/base.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f9f72aee6d45..54b2fb5e9c51 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1056,6 +1056,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
        struct mm_struct *mm = NULL;
        struct task_struct *task;
        int err = 0;
+       int mm_users = 0;

        task = get_proc_task(file_inode(file));
        if (!task)
@@ -1092,7 +1093,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
                struct task_struct *p = find_lock_task_mm(task);

                if (p) {
-                       if (atomic_read(&p->mm->mm_users) > 1) {
+                       mm_users = atomic_read(&p->mm->mm_users);
+                       if ((mm_users > 1) && (mm_users != get_nr_threads(p))) {
                                mm = p->mm;
                                atomic_inc(&mm->mm_count);
                        }
--
