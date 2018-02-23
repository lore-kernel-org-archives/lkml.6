Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3684173-1519413782-2-7335308929132892370
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413781; b=daj5WxhQjTiD8kGbDChPnhDT3lLUTrvO99RaGQlBQsOQ2II
    xRNrTHWRSciX2eB4ufgxZg9LkJZZyxEbAuOr/bsbwkYPLhlE9xCls8DThk003Eja
    kPqvEJyT+v0MMos2vzU4SCV+EtJfpFya+7tPqQT6IlYKv5Rs2uS24NJXHOQBe3Wi
    zrZXa0ps1idvpvEM6iZBStMEJtjZllEV9jtfsCB8BbaFBFtaG4mqatdIw+fEtuw7
    9thr9fFacMCzxBfXGzo4WNRB7tqM+y/1qscvQackqFWNNp+XfKZKeKowaJBkN9hV
    Q3xed19mDY6By0MumRihywqANlKGH1bVVvQfuPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413781; bh=4mNpK5f21JMXghs6Za2Ozn3kSu
    oeIaZsuUpcOoiJs2U=; b=lUjzZm/REpQlVsvOMqeZ/B1RKD6qyVoIAfd+WCZyZz
    DHUMUlDWIaGsvPYrrl3xHK8ZpUQI8I7ssyfOGC6bh7yfM5zux3Ci14OsNIoxxsrz
    qqWipRXtCvpuQ9Q6aJyUB80rxu4VUi5Dm8HYwqJdryI/ICR4XGD83ZhB+xWHOX0f
    MW+s8xbPIyuejc9cZXLXSYaZfBk0QuvmLa9/WTMurKf7j1wrsydqOrQtnFI+Lhgm
    /CKNmwqw5Q49nh8Kg9z/JbTU8MwzQuY3Eu9FCiuJHGGSuAtPwfmRLkJZ8+cgfn8j
    41PSMJM/ziaH1Yoql9Hh1LkpW3Tqgt4TrYQijpDysz7A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935345AbeBWSxd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:53:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47392 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935421AbeBWSxc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:53:32 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roy Chung <roychung@synology.com>,
        Alex Wu <alexwu@synology.com>,
        BingJing Chang <bingjingc@synology.com>,
        Shaohua Li <shli@fb.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 094/159] md/raid5: correct degraded calculation in raid5_error
Date: Fri, 23 Feb 2018 19:26:42 +0100
Message-Id: <20180223170754.905649117@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: bingjingc <bingjingc@synology.com>


[ Upstream commit aff69d89bdebc39235cddb4445371eb979b49685 ]

When disk failure occurs on new disks for reshape, mddev->degraded
is not calculated correctly. Faulty bit of the failure device is not
set before raid5_calc_degraded(conf).

mdadm --create /dev/md0 --level=5 --raid-devices=3 /dev/loop[012]
mdadm /dev/md0 -a /dev/loop3
mdadm /dev/md0 --grow -n4
mdadm /dev/md0 -f /dev/loop3 # simulating disk failure

cat /sys/block/md0/md/degraded # it outputs 0, but it should be 1.

However, mdadm -D /dev/md0 will show that it is degraded. It's a bug.
It can be fixed by moving the resources raid5_calc_degraded() depends
on before it.

Reported-by: Roy Chung <roychung@synology.com>
Reviewed-by: Alex Wu <alexwu@synology.com>
Signed-off-by: BingJing Chang <bingjingc@synology.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/raid5.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2678,13 +2678,13 @@ static void raid5_error(struct mddev *md
 	pr_debug("raid456: error called\n");
 
 	spin_lock_irqsave(&conf->device_lock, flags);
+	set_bit(Faulty, &rdev->flags);
 	clear_bit(In_sync, &rdev->flags);
 	mddev->degraded = raid5_calc_degraded(conf);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 
 	set_bit(Blocked, &rdev->flags);
-	set_bit(Faulty, &rdev->flags);
 	set_mask_bits(&mddev->sb_flags, 0,
 		      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
 	pr_crit("md/raid:%s: Disk failure on %s, disabling device.\n"
