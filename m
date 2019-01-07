Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41C4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9DE21855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 22:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SHS2sbcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfAGW1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 17:27:13 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34381 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbfAGW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 17:27:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id b3so2425359ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 14:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7VNhaVCYEKTzFbFihRbvWf6+ryMS31k2tE21kf45nk=;
        b=SHS2sbcxNKAmSlK4Y7T+uvMHlw0qsu2AU/DiuHIJPYDga/taVYO2MqlWBX/l7ReTmS
         x3rsZl6OA7sXc63BOhXrC4UX6L89TMdoGfASmxFo3o4YO4D1XkNGzf5wMht+S/JJU1Pg
         IC64PyhL4/ZeVBn/ngVIxR+LiGb1QVJ/WJ7/mOit19yMuWFpcvdqUIZqpFemEXLJUyDC
         jkTdbqNU6maKCYBZUFq6Vri+TZ7gnHR3JIeqt2rJv3tzjnkixP7iiwt3W1Rag7TKa16x
         6uEofzT1RdYfyy9gt2PQU3CQJEmPvIqNYAevZi0zh6XhfV8CQzXIhgcr/FhADjiMDqc8
         mWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F7VNhaVCYEKTzFbFihRbvWf6+ryMS31k2tE21kf45nk=;
        b=d3j1YlT9mOFRXzNBrBApyaBlFMUz5QuDmPXQgW7e/eyZhdfU3QRg0Tfin/jBI02VQi
         0OzAeuAqJZyCoPyhPum2JoJr6GGSXyX9am2DTgXePyCdjRsg/gXoFSeKKFBVjfrM3PJx
         gUPPnqFvL9lKJ6ZbdeAhVwLCXeyzRIYgrLJc/oUwvX7bRC5/A3H9g9pyD1WkaKLu98Yr
         O0j1Pun0l2uguxDRJmWeiMWs4D+/n/IUs2nAk3jhvlf0G+FSoOX5zIEgTDGOx75E3Niu
         p6pcN6Sjt+ELU3qUmqWQEDtw9bH2InqVPARZiEglg51qiFr8X2uy/eCMLyu5Kg0uDC+V
         QWFw==
X-Gm-Message-State: AA+aEWYds9lyZMApr3R/T0aGZOb6E5dfu9U8ECV1gir7bUMRA/dbMaGk
        +nM0wXkSZMCQH5f2ZMKt4pr5zA==
X-Google-Smtp-Source: AFSGD/Xr0pvG4XqCipZlgJPm5KUzc4t7928BvS27WY0J5zSsSRPdVzIbURabao4MYbgcC26LERHN5Q==
X-Received: by 2002:a17:906:11ce:: with SMTP id o14-v6mr49300701eja.136.1546900030650;
        Mon, 07 Jan 2019 14:27:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id e53sm30826227ede.90.2019.01.07.14.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 14:27:09 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [RESEND PATCH v3 0/2] sysctl: handle overflow for file-max
Date:   Mon,  7 Jan 2019 23:26:58 +0100
Message-Id: <20190107222700.15954-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here is v3 of this patchset. Changelogs are in the individual commits.

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system.

The first version of this patch intended to detect the overflow and cap
at ULONG_MAX. However, we should not do this and rather return EINVAL on
overflow. The reasons are:
- this aligns with other sysctl handlers that simply reject overflows
  (cf. [1], [2], and a bunch of others)
- we already do a partial fail on overflow right now
  Namely, when the TMPBUFLEN is exceeded. So we already reject values
  such as 184467440737095516160 (21 chars) but accept values such as
  18446744073709551616 (20 chars) but both are overflows. So we should
  just always reject 64bit overflows and not special-case this based on
  the number of chars.

(This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)

Thanks!
Christian

[1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
[2]: 196851bed522 ("s390/topology: correct topology mode proc handler")

Christian Brauner (2):
  sysctl: handle overflow in proc_get_long
  sysctl: handle overflow for file-max

 kernel/sysctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

-- 
2.19.1

