Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B85C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1791B2070C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICweIGJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfAHDKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:10:42 -0500
Received: from mail-ed1-f53.google.com ([209.85.208.53]:44260 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfAHDKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:10:42 -0500
Received: by mail-ed1-f53.google.com with SMTP id y56so2767016edd.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ebYjQj3w9N6BeKLRbMxmWtzuFXlLsdYBCJKOXxZa3Dk=;
        b=ICweIGJ8cYdGcvU740Bs2F/wj7p07U4i4Jg1/hIiFulGwb+jAdPshhJ6y54WIfu/+e
         wu6keTuXWuHOoz1JUcK6I6tlguulihCGYvNG10VjzSxtXp8StivJXkXvJr7Ce88KPg9Z
         cVnAtVz0UpNQ7mfklov9p4+0RbdlQqyRkSIG/2XJP7YVEb09qypp0KhP0o5BzO/8ecn7
         xgiZkQrt+QppBr5w0q42al9JKS8/X1g6yZNXAaL50Mix1ZnIj2AMCGpr8XbOChX9G9A2
         /6bMFw36emCKfow3tFjIOoKbD+r+kkSP5kbMrg9bYcllmzXdusf5+tgUf9V0PbTy5Syn
         kiuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ebYjQj3w9N6BeKLRbMxmWtzuFXlLsdYBCJKOXxZa3Dk=;
        b=CFFPcIho0G9mWRI6IgmjJiuQcy9mro27DFH01qnlX5NbMovw0XdqUBIQf103izBisX
         I0aeUst93U4Zfhv9T44mns4T5g4lOD6fafqmBbFg09WDbJ3tZKISVVbDlCjWbdm7fTNH
         PE2HMsaquZeIKdaotgO3/Am2He/ttgsVO/l0WkubfT5NjK3d0MM4NeH+6BCxUYi/DIl8
         y9QUFSDdP8qWCpmyJR3cXvM5ASmvQsrrz33C8G4I6LLRSZVRRM9eHDsoeVx4vfKs2mPT
         lZrfPVbLCm51JxqQE6RKDfG5r/T5lfZy3Z/uOYMy2wKE+nu3PAtLVgf/W0jVFXeWKX8B
         +1eA==
X-Gm-Message-State: AJcUuke/46gxqBK92rBU6Q9LeEevowdQSqqcMmW6snr7Ym8eFGWBKZiN
        sdq1/29A9BhmHQRMn8YdBDk=
X-Google-Smtp-Source: ALg8bN5ASl4nrl1lQAAND3PraZ+Osp+zs3BYwS+d4VRWNhxxtgmjAi71Q5U2n908F34Ksu9CWixLnQ==
X-Received: by 2002:a17:906:4e82:: with SMTP id v2-v6mr291790eju.149.1546917040834;
        Mon, 07 Jan 2019 19:10:40 -0800 (PST)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id a27sm37037195eda.65.2019.01.07.19.10.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 19:10:40 -0800 (PST)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Bo YU <tsu.yubo@gmail.com>, linux-kernel@vger.kernel.org,
        joe@perches.com, yuzibode@126.com
Subject: [PATCH v4 0/2] kobject: trival fix
Date:   Mon,  7 Jan 2019 22:10:24 -0500
Message-Id: <cover.1546915794.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is trival fix for lib/kobject_uevent.c file.

Bo YU (2):
  kobject: use pr_warn to replace printk
  kobject: drop newline from msg string

 lib/kobject_uevent.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--
2.11.0

