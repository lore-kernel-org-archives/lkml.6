Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E2C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BA02145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 20:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="RutW/IMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBJUkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 15:40:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36646 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJUkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 15:40:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so13030040wmc.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Feb 2019 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRw5jo/1Jkxk5PfUb0MKz0xpR3rEEtzZtLn5tkA43Cg=;
        b=RutW/IMcnrpkxzv4XkPmehQgntelMXEvuVaG/LWmR/x4rmmotu1cmTEP1CBfi+Vhud
         0SH9BUalcP2HQOHOYupjafSZAoQ7O6ABeTdFhTQ1KmtHOVplJAEoB41mcto+grDPlAKE
         7x8QIzy/J4yY4w32jnZb0BbBHHNUaFtaQqPfSY5oAyrfAy6bQMx9tGZ40K1g/XJRY6Jg
         4gJrmi3ip5uK2a1lBK3KxD5Cw3xwSn//PqvySUSGsnNlU1cjiW96jdTvZafyu9VoJsUZ
         nFPoylvI/yKGzNyRwbyxhfLQ0CCSh7KMdFWpf8tvcdSgbgcUe+CGBVOVIPxFO54JkBLh
         Jz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mRw5jo/1Jkxk5PfUb0MKz0xpR3rEEtzZtLn5tkA43Cg=;
        b=SwnD8hgyawLJCuUV4nPWSkQC1BqbqGZCGNPqsJHtTV3o+3ksMdQaLvSnQ37WaDev4k
         8jEFdvo+zoglL4WXIpEX12QBViT2LS+b2tWIyeHiPc0iRKT5eRl/uFTNMPOu+rg10Olf
         YKj7ZQ7nF+zqkanILFQK4RXFljlndRz+OXrWqWQx4BapJohVOx5hpkfb9DQPla3LK/6h
         V8i/TdHWVkEiNP0/c3qDGtOom0lz7nfqvaeZMsuuuqJxsFB2lMSL8hnaDXoPzdjT9Bge
         8Vw6eJ9q7HP5iMG7B6AriP1m+IGXDOz/2mv7UWb5o4zjDa1yek9f04achrEhikfnaW0N
         0COQ==
X-Gm-Message-State: AHQUAubpDU/oj64v5iNGEbuJYYpIuDNNXMTqpq9GOy2b+zBiCqOXr8os
        VmSY/olTYShTES99wY0y3Cc00w==
X-Google-Smtp-Source: AHgI3IYkeowaoRVRyhwubPm3zMMIm46wl67ovxokYuyZQulWXgdk7RC0gUGikiNU51YBhjIbxLXFOw==
X-Received: by 2002:a1c:ed17:: with SMTP id l23mr6930729wmh.51.1549831198962;
        Sun, 10 Feb 2019 12:39:58 -0800 (PST)
Received: from localhost.localdomain (p200300EA6F14665209EDE1AF663E9C0B.dip0.t-ipconnect.de. [2003:ea:6f14:6652:9ed:e1af:663e:9c0b])
        by smtp.gmail.com with ESMTPSA id l20sm16469784wrb.93.2019.02.10.12.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 12:39:58 -0800 (PST)
From:   Christian Brauner <christian@brauner.io>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: [PATCH v4 0/3]  sysctl: handle overflow for file-max
Date:   Sun, 10 Feb 2019 21:39:40 +0100
Message-Id: <20190210203943.8227-1-christian@brauner.io>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andrew,

You currently carry 
* sysctl-handle-overflow-in-proc_get_long.patch
* sysctl-handle-overflow-for-file-max.patch
in your http://www.ozlabs.org/~akpm/mmotm/ tree.

I recently pointed out that the current change can potentially lead to a
userspace facing change and asked you to please drop the second patch
(cf. [3]).
I think you might have missed that mail. This is the same patchset just
that the userspace facing change is split out into a separate commit.
Please take the first two commits as they fix the issue without any
userspace facing change. The third one is marked as RFC and we can
either take it now or punt on it until later.

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
[3]: https://lore.kernel.org/lkml/20190111145140.lbmiz3w2f255uf65@brauner.io/ 

Christian Brauner (3):
  sysctl: handle overflow in proc_get_long
  sysctl: handle overflow for file-max
  sysctl: return -EINVAL if val violates minmax

 kernel/sysctl.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

-- 
2.20.1

