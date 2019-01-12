Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362C6C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE37820870
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 05:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sR3mXbm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfALFyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 00:54:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47082 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfALFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 00:54:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so17302682wrt.13;
        Fri, 11 Jan 2019 21:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EXdpAxMi+IjCkwtLHAcCwnnONOKeSMkg9N2RbHkuAjo=;
        b=sR3mXbm50Oxnk03Ekn5Y7pbMOqSjRwSdUOwQ0vzASi+buqFi6CULFwjEX/ipTD1iw1
         Iwqh92LSzSE8erL/pj8S8NX0w2Ko84MJ6TNSUCeUhcMxyoaj0M+5EKKx+sLSsO5cuPAV
         3nKef7QCc0POsuYxQYFKSwulnqLBGKfB6N5GMzGo9p1t5eVQEXexNPOAaRfSb7uWXXGr
         /ybR3/nGtvYuPawkKoweifx1ZgvaQrCmwGkmvlwhaF3o7lkdW49kN/ONupsy+/5dU6so
         gPIg/kVzqOhfHfCsE/+hgk8UzRhOeEHqA6GjtAZGleALSWTttOSBH5BL6aFsYNhUaBU0
         3Eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EXdpAxMi+IjCkwtLHAcCwnnONOKeSMkg9N2RbHkuAjo=;
        b=PQ2awEz/i5TcVoWja+IZ+PXS1LaRHT9H6Z1/bSLjIFWfPk2/E5unHkJbCA8rYbNJCL
         b56hx2kkbiZAcd3NUEMWTaKAbWUjDim0+xolGhoI5dDIzE+kVJEQ2ELVujS8bnptwQ8E
         u8hlKOfly7YvZMqlQf79Cch2F150se/n1O7Mlew4eHz5HK8Hx4NYd2wi7FZQyz1Y5vxH
         ESnc4EOLFTLd/Uz5pcaLozgJeTFWGHXMPCwJtVHsuvXqfnJsANxGWYtWzEIxd5mpNnJJ
         RGm8vYBxvMhI3wcdHRUSb4b1k/RAfyeWJXq2zvIS56zjieiPWgENpGT9cTuRyBWBLYAe
         xLRA==
X-Gm-Message-State: AJcUukcKuwijCE6JTPXgeEOLw6Qe+RWeZ2H1Ft2cv5Hda34vWm+zwCJt
        7KpCY/9ILJ+4eDxuhItk7kY=
X-Google-Smtp-Source: ALg8bN5A4BWAl8Q3XXo3GqdH9QoRpSz0hG8rpU2HB7o1ByT8Dt8biREavO5GC9xFg3VN1l8hKf+8Ng==
X-Received: by 2002:adf:f211:: with SMTP id p17mr16041874wro.293.1547272485337;
        Fri, 11 Jan 2019 21:54:45 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d3c:9f00:9d02:40cb:9892:49cb])
        by smtp.gmail.com with ESMTPSA id 124sm22989776wmh.22.2019.01.11.21.54.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 21:54:44 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Krystian Radlak <kradlak@exida.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] fs: drop unused fput_atomic definition
Date:   Sat, 12 Jan 2019 06:54:30 +0100
Message-Id: <20190112055430.5860-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit d7065da03822 ("get rid of the magic around f_count in aio") added
fput_atomic to include/linux/fs.h, motivated by its use in __aio_put_req()
in fs/aio.c.

Later, commit 3ffa3c0e3f6e ("aio: now fput() is OK from interrupt context;
get rid of manual delayed __fput()") removed the only use of fput_atomic
in __aio_put_req(), but did not remove the since then unused fput_atomic
definition in include/linux/fs.h.

We curate this now and finally remove the unused definition.

This issue was identified during a code review due to a coccinelle warning
from the atomic_as_refcounter.cocci rule pointing to the use of atomic_t
in fput_atomic.

Suggested-by: Krystian Radlak <kradlak@exida.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
compile-tested with defconfig & allyesconfig on v4.20

 include/linux/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c77743dad..ddf7de4d522b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -952,7 +952,6 @@ static inline struct file *get_file(struct file *f)
 	return f;
 }
 #define get_file_rcu(x) atomic_long_inc_not_zero(&(x)->f_count)
-#define fput_atomic(x)	atomic_long_add_unless(&(x)->f_count, -1, 1)
 #define file_count(x)	atomic_long_read(&(x)->f_count)
 
 #define	MAX_NON_LFS	((1UL<<31) - 1)
-- 
2.17.1

