Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDC4C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 957AE20652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MfhUptbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 957AE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbeJOSk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:40:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46607 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOSkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:40:55 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so20668578wru.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 03:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=58QXr0x2Lx+3XU5gGU63UorfWKmPJJyb27d/xXFwcJM=;
        b=MfhUptbASzjUKecBsOF3qXjEGyl4MgL1vKGbVrg7mpUawEseRKkC9vmyEUItW2vOS9
         8zmBe35S9fwkep0a/GT/mObmQBAODFR/Km0Qjz2psqSJZhxIN6w+JVA73PoAHu7I6lYB
         DzJPMlwSxT9oefFtKkH/W40rnbg0XMCba9ul7B54K3qEWQt22ePjC74UdeaOxh6IA/aY
         Kp7dASXF03MSQSW2V8hXtDwRBiX4vFtwbSlY17Z9rkF9YFHr35aL4e9dJoLDU3eBbTit
         ws4go9VqblFFZWeAUZQExpUJuCRcVMGWDMUdRjyrg9xLeKLP+kxaYt12nZdMejgqrwkY
         JKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=58QXr0x2Lx+3XU5gGU63UorfWKmPJJyb27d/xXFwcJM=;
        b=cYtccbQfyNa40RATBY9PduK2YaJOsQOV0qpiZYJ0p/5dV96pITL25BQeztKjxhWCcF
         LFA+khxi+SvuowjY07vXc3+mJPId2dZcYkiJMAvqva3vVrVxqilZ6xUmxAmD5YjY/n3+
         u3TGncGJbJnBrINY338ZAtxsI9TzASUT771Aye6YS5+D6tgI/LvEk29/2Mm+Q+HcChkh
         tGqLaCpx0hcjOm+lbgZB7JJBOY/e+6uWo85fRILvFj7tUh8nNuXT4VjDGNcvedndNv0H
         Cv+DvUTB6oTUx8cngp6EpaLQj+n9ZD6+DCfpi5D+1RtwFy8hl9Mnp/SfGDzOtNyz4Op6
         OUig==
X-Gm-Message-State: ABuFfoiJEeyZyJxQoMU470tVh4IGVl/0dmbqp1Myitky4HziFD6h7qBy
        pt9HhqliCWt0hMC0jEyMlz/fIw==
X-Google-Smtp-Source: ACcGV60F7Ek+XyZMikpcKveXj30V9BHTmCDNoMi2YfLR54iXPHFNhxBg9fb8zozTUVOfltKkiqolBw==
X-Received: by 2002:adf:db45:: with SMTP id f5-v6mr14252318wrj.237.1539600970484;
        Mon, 15 Oct 2018 03:56:10 -0700 (PDT)
Received: from localhost.localdomain (u-086-c100.eap.uni-tuebingen.de. [134.2.86.100])
        by smtp.gmail.com with ESMTPSA id a11-v6sm14236484wrp.3.2018.10.15.03.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:56:09 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, Christian Brauner <christian@brauner.io>
Subject: [PATCH v1 0/2] sysctl: cap file-max value at ULONG_MAX
Date:   Mon, 15 Oct 2018 12:55:42 +0200
Message-Id: <20181015105544.4395-1-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Here is v1 of this patchset. Changelogs are in the individual commits.

Currently, when writing

echo 18446744073709551616 > /proc/sys/fs/file-max

/proc/sys/fs/file-max will overflow and be set to 0. That quickly
crashes the system. Let's detect the overflow and set to ULONG_MAX in
this case effectively capping the value.

The patch tries to ensure that there is no other user visible change in
behavior for other values. Only when a maximum value is set for a
specific sysctl will it be capped on overflow. The details are outlined
in the commit message of the first commit.

(This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)

Thanks!
Christian


Christian Brauner (2):
  sysctl: cap to ULONG_MAX in proc_get_long()
  sysctl: handle overflow for file-max

 kernel/sysctl.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

-- 
2.17.1

