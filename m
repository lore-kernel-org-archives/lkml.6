Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABAEDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB6B218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="DMG0aJ99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbfBNXBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:01:54 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:49923 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727718AbfBNXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=wsTueB5FCF3UVfbxYbcnT/ahi9d1rKHo5AZX0D8g1l8=; b=DMG0aJ99ENaF
        i/yy6ngN73/OoMX2gikO+E8so5bL48p3L7HIw5VyeXGuw9vgF5gnTK13FWf9GWvyNmO5ZmCVL676n
        XBA5dGi1xcuoeivYQyTee4UWIQMTbf5jLYONGZIr2iGBKAOR4MOe6oo9L2FQK2Saf83UfH4ZVHoLA
        aVm2xsLTZncAHJTfI8gFFk518dDUVU+FtM0UrJhzU3OLB51NsHJ0p3cHy0DypqvriYtsoTVE9mnUN
        rDdDjVP6VtqIUFXPeZV651k0tPf8RwsGopWKR9VpqOy69WHq+NszBDoeXp/Y41Rk4BcJIEGaQdvMb
        TF2tQ4JptAMY6VUtRw5AOw==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0N-000DE9-FT; Fri, 15 Feb 2019 00:01:21 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id ABA92C0482;
        Fri, 15 Feb 2019 00:01:13 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 03/23] locking/lockdep: Fix reported required memory size (2/2)
Date:   Thu, 14 Feb 2019 15:00:38 -0800
Message-Id: <20190214230058.196511-4-bvanassche@acm.org>
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
X-SpamExperts-Outgoing-Evidence: Combined (0.06)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5hPAD2Qps+BuB8HiQex1z2t602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN595IiOQJnthabI+GrNxh0H/gwtsdFHwt5Ayx2WeOby5J9y+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0VpXCEqSenvCQusD//B2Ay+BOeDCHiLDCiKxT74NwJRhr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHJAvCeCpJ5f0G2AUcL3y76T0O6Z/tI9joh/MiSveK
 z84hu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lock chains are only tracked with CONFIG_PROVE_LOCKING=y. Do not report
the memory required for the lock chain array if CONFIG_PROVE_LOCKING=n.
See also commit ca58abcb4a6d ("lockdep: sanitise CONFIG_PROVE_LOCKING").

Include the size of the chain_hlocks[] array.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 193fef487a15..b00c6edd6a28 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4282,10 +4282,11 @@ void __init lockdep_init(void)
 	       (sizeof(lock_classes) +
 		sizeof(classhash_table) +
 		sizeof(list_entries) +
-		sizeof(lock_chains) +
 		sizeof(chainhash_table)
 #ifdef CONFIG_PROVE_LOCKING
 		+ sizeof(lock_cq)
+		+ sizeof(lock_chains)
+		+ sizeof(chain_hlocks)
 #endif
 		) / 1024
 		);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

