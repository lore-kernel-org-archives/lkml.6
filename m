Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754890AbeDCWh3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 18:37:29 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42607 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754925AbeDCWhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 18:37:25 -0400
X-Google-Smtp-Source: AIpwx4/OEINoc/rQEU6cIxpkwSuxb0hY9R6OMLe2oFZEwS9N/xVOzZAxv2LV/hod2V33Qnelk6scQA==
Date: Wed, 4 Apr 2018 01:37:22 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [RFC] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180403223722.GA15783@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An ability to manipulate mm_struct fields was introduced in
sake of CRIU in first place. Later we provide more suitable
and safe operation PR_SET_MM_MAP where all fields to be modifed
are passed in one structure which allows us to make more detailed
verification.

Still old interface remains present for compatibility reason
though CRIU itself already switched to PR_SET_MM_MAP on its
own long ago.

Googling didn't reveal some other users of this operation
so I think it should be safe to issue deprecation warning
first time and get rid of this interface after a couple
of releases.

CC: Andrey Vagin <avagin@openvz.org>
CC: Andrew Morton <akpm@linuxfoundation.org>
CC: Pavel Emelyanov <xemul@virtuozzo.com>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Yang Shi <yang.shi@linux.alibaba.com>
CC: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Or we can simply drop it off because PR_SET_MM_MAP covers all needs,
and I would rather prefer to do that asap.

 kernel/sys.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-ml.git/kernel/sys.c
===================================================================
--- linux-ml.git.orig/kernel/sys.c
+++ linux-ml.git/kernel/sys.c
@@ -2052,6 +2052,8 @@ static int prctl_set_mm(int opt, unsigne
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
 
+	pr_warn_once("Non PR_SET_MM_MAP operations are deprecated\n");
+
 	if (opt == PR_SET_MM_EXE_FILE)
 		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
 
