Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C43ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315242146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kb7yngL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315242146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbeITDKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:10:55 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41676 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732024AbeITDKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:10:55 -0400
Received: by mail-io1-f68.google.com with SMTP id q4-v6so5726032iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsKsL23WOSe8csELfD1zOIy8AwtJaj2AKKUNBsQ+wwM=;
        b=Kb7yngL2FN0ve2b318HE7dwVIuuGADXXlSoRGdJ91wK097OWzxqvmAWAsLPzAFPGbw
         9DIXjTEdr9sXoAcE48sxZ3l6D7wX33rP8vf3/hH66SqDk01d9O3HcuiKYn7Y4cq7dT+k
         hXxHKwt4s9KVwJrVokbaCGVnJkBic+HqkHBv/sanpUXLJSS+m7OtXIhwGxTkr06C1/yY
         MFeEl7TgcwwyZJm62CYr0JmpnBStgemDQZjn/vo8SMcCVKDUSvHg8oJp0yiCTWULrQF0
         JnuYdSAjEC1ymzvr3hHYfBS7pRdCb6O19vFDU+RVGTfgs4xOOxyOkf99K4B1WQ1Ndd8g
         6cwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IsKsL23WOSe8csELfD1zOIy8AwtJaj2AKKUNBsQ+wwM=;
        b=c6YoreyFi/Ydz1LMOpVGtkpYVk69HiynbYeWqgPbgTf9W5Mskr3/BETbGvysy0RZsy
         tkYe4++KECIGE20dykk2ltqfLvLWNC8od5rXjDQBeQrsk/VV4HPBMVae/qeOnpKntTQ5
         buNa7kb+376vec2sYPzOzFeLWuA8vBr42SaQgdpdn7ffpQ6lxY0xE/oiZsbGIAKeLH8Q
         MqbTuIpBsjOhF+gzIhp7I+tuEfy/uSMntarwPdznFYViRMqVWdxcJZWKfSM2KrThIzdJ
         dJGzD3/s1DNt15n6ifDNAb+dgDijtxuEKu21m5lSeiNwbI+2W25tvg5uYw2LtkDevqxt
         qzGw==
X-Gm-Message-State: APzg51AqXA1TyLRfmFZp3erCFv/GaiWZ6s0okJJZ8S2fSEozQg2tUFvB
        1WhrQAUCMDjJ+ok5URlVbh5RGg==
X-Google-Smtp-Source: ANB0VdbvK9QNHUxgIYofngb9toZNsFv+lyvDmaWJ/qhyez7Tznwc2YYYEiPd6OCEvVeMnWdvCFpgnw==
X-Received: by 2002:a6b:f919:: with SMTP id j25-v6mr15825408iog.280.1537392665610;
        Wed, 19 Sep 2018 14:31:05 -0700 (PDT)
Received: from yuzhao.bld.corp.google.com ([2620:15c:183:0:a0c3:519e:9276:fc96])
        by smtp.gmail.com with ESMTPSA id d198-v6sm4305617ith.5.2018.09.19.14.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 14:31:04 -0700 (PDT)
From:   Yu Zhao <yuzhao@google.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH] regulator: fix crash caused by null driver data
Date:   Wed, 19 Sep 2018 15:30:51 -0600
Message-Id: <20180919213051.199105-1-yuzhao@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_set_drvdata() needs to be called before device_register()
exposes device to userspace. Otherwise kernel crashes after it
gets null pointer from dev_get_drvdata() when userspace tries
to access sysfs entries.

[   25.566073] general protection fault: 0000 [#1] PREEMPT SMP KASAN NOPTI
[   25.621976] gsmi: Log Shutdown Reason 0x03
<snipped>
[   25.747085] Call Trace:
[   25.749532]  name_show+0x51/0x6f
[   25.752760]  dev_attr_show+0x59/0xa0
[   25.756333]  ? device_namespace+0x9e/0x9e
[   25.760339]  sysfs_kf_seq_show+0x228/0x33b
[   25.764434]  seq_read+0x74f/0xd58
[   25.767747]  ? set_track+0x63/0xfa
[   25.771148]  ? kzalloc+0xf/0xf
[   25.774200]  ? _copy_to_user+0x87/0x9a
[   25.777947]  __vfs_read+0x106/0x320
[   25.781433]  ? mandatory_lock+0x94/0x94
[   25.785267]  ? fsnotify_unmount_inodes+0x17d/0x17d
[   25.790053]  ? inode_security+0x17/0x40
[   25.793885]  ? selinux_file_permission+0x176/0x342
[   25.798670]  ? security_file_permission+0x77/0x98
[   25.803369]  vfs_read+0xf3/0x197
[   25.806595]  SyS_read+0xfa/0x19b
[   25.809822]  ? file_end_write+0x91/0x91
[   25.813653]  ? filp_close+0xdb/0x100
[   25.817225]  ? file_end_write+0x91/0x91
[   25.821057]  do_syscall_64+0x184/0x1bb
[   25.824804]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
<snipped>
[   25.895502] RIP: rdev_get_name+0x29/0xa5 RSP: ffff8801d45779f0
[   26.550863] ---[ end trace fb2a7bb4f63aeba5 ]---

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 5f2218c67edf..69565ff65800 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -4404,13 +4404,13 @@ regulator_register(const struct regulator_desc *regulator_desc,
 	    !rdev->desc->fixed_uV)
 		rdev->is_switch = true;
 
+	dev_set_drvdata(&rdev->dev, rdev);
 	ret = device_register(&rdev->dev);
 	if (ret != 0) {
 		put_device(&rdev->dev);
 		goto unset_supplies;
 	}
 
-	dev_set_drvdata(&rdev->dev, rdev);
 	rdev_init_debugfs(rdev);
 
 	/* try to resolve regulators supply since a new one was registered */
-- 
2.19.0.397.gdd90340f6a-goog

