Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51F0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FC02083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FC02083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIGVYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:24:47 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:34479 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeIGVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:24:46 -0400
Received: from fsav105.sakura.ne.jp (fsav105.sakura.ne.jp [27.133.134.232])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w87Gh1DT018302;
        Sat, 8 Sep 2018 01:43:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav105.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp);
 Sat, 08 Sep 2018 01:43:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav105.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w87Gh0FI018298
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 8 Sep 2018 01:43:01 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] selinux: Add __GFP_NOWARN to allocation at str_read()
To:     selinux@tycho.nsa.gov
References: <000000000000038dab0575476b73@google.com>
Cc:     syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>,
        eparis@parisplace.org, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, peter.enderborg@sony.com, sds@tycho.nsa.gov,
        syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <f3bcebc6-47a7-518e-70f7-c7e167621841@I-love.SAKURA.ne.jp>
Date:   Sat, 8 Sep 2018 01:42:58 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000038dab0575476b73@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is hitting warning at str_read() [1] because len parameter can
become larger than KMALLOC_MAX_SIZE. We don't need to emit warning for
this case.

[1] https://syzkaller.appspot.com/bug?id=7f2f5aad79ea8663c296a2eedb81978401a908f0

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ac488b9811036cea7ea0@syzkaller.appspotmail.com>
---
 security/selinux/ss/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e9394e7..f4eadd3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1101,7 +1101,7 @@ static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 	if ((len == 0) || (len == (u32)-1))
 		return -EINVAL;
 
-	str = kmalloc(len + 1, flags);
+	str = kmalloc(len + 1, flags | __GFP_NOWARN);
 	if (!str)
 		return -ENOMEM;
 
-- 
1.8.3.1

