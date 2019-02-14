Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472A7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DCE218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="AcVghC4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbfBNXCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:02:53 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:40267 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfBNXBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=Kg05y0DxnXVf1rAGTLAmSg5XgiOY1z3O55rmXiCb5tk=; b=AcVghC4++GJF
        SUDdkoIXPzG8wdBzB9JG2CfnYmUnkQUz3DyyKkEs8Evk4j6i2fm5FfHJt//tw1BG9Tt9GjcZvlHx7
        jchEVU8AxXunBz2OYpYFjnBOT+1RHuTP1ZEMscrMQg58koysBjlP42RglE8R+SwZbsViLl3tESe75
        qEDhDrZBPugMqGhLBSv9V7wxnhTfcH7j8ggQIZmAixhSy92e1j4qks37vQRyVVoVEGXfqQnmLD6ZL
        kq+wSmpcFc+e51uoRLuegIzqvxlRkDiwi2j1a4T2Jcl+CCZPeJdEyKqmHqDY1i/1crQnW3BBtlwxF
        LqzMG/aT6CgSv/7X7rQnDw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0q-0000ms-Ak; Fri, 15 Feb 2019 00:01:48 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E722BC0926;
        Fri, 15 Feb 2019 00:01:45 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 17/23] locking/lockdep: Verify whether lock objects are small enough to be used as class keys
Date:   Thu, 14 Feb 2019 15:00:52 -0800
Message-Id: <20190214230058.196511-18-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.07)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5vyybTBwZFNaNE/CXFITNxF602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59mkGG2u1tfBVga+mxrQwceKido1BuolQ9HBm0o5M3yA5y+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNVA0hlu/NpOnaXNvrIp4mRGgQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0WH0EA9CFU+XZZAji6JOThIzqiNYjiBOuBcW2wqK3yI2r1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHnnujRpkiuNnPi3DrmbeA2Rtj+fVESHz/Odf0H02H
 7xchu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f5df97812dfa..93216e195b4f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -758,6 +758,17 @@ static bool assign_lock_key(struct lockdep_map *lock)
 {
 	unsigned long can_addr, addr = (unsigned long)lock;
 
+#ifdef __KERNEL__
+	/*
+	 * lockdep_free_key_range() assumes that struct lock_class_key
+	 * objects do not overlap. Since we use the address of lock
+	 * objects as class key for static objects, check whether the
+	 * size of lock_class_key objects does not exceed the size of
+	 * the smallest lock object.
+	 */
+	BUILD_BUG_ON(sizeof(struct lock_class_key) > sizeof(raw_spinlock_t));
+#endif
+
 	if (__is_kernel_percpu_address(addr, &can_addr))
 		lock->key = (void *)can_addr;
 	else if (__is_module_percpu_address(addr, &can_addr))
-- 
2.21.0.rc0.258.g878e2cd30e-goog

