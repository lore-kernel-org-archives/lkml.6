Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CCEC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24E020857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 22:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24E020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389087AbeG1AIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:08:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42470 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388994AbeG1AIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:08:11 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so6681848qto.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 15:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pd6ZmRSgLE92x+1U96PwNyZnjb7+K9HaXjCFa/rvXf0=;
        b=XxjcHDvdJvLfXbxAC+IrCbPRd82fKI+03hoT8i3UjjFF1WqJ7u7p0+0jQTTgja4gDh
         1SmaWlTERHdu7WDgWLQUpSQDqm1WQupqVwbLEq6Oc2Eu37RYsOWjKXD0EJAwWEAJU91G
         tWsY7/y1P0A/FipOeS38yI36/sxooIV0WUgWSPKuVclhZBqMgGt90dIyhalQ1GfLFrLV
         TIbTqkaenTYbJ0Ku9/gqaYOT8bVEsfW6OdzO85ahYG4twL5wISvvY7ju+qzdZtYcghpd
         nVf33Stl1JfEUNHGfyklc1sqEz/um0woyqR4gOtpmLFoKyNdiv2Q/iUHrO6IqMugcfsX
         HJ5Q==
X-Gm-Message-State: AOUpUlEj3dPcavTaMjUaNrg4Aw6/3YnbFYSWBoKY/sUMGfYvFM9P4dMC
        RSVmemgO8CX3HsqNiw9Fq8UFEL0661E=
X-Google-Smtp-Source: AAOMgpfwaDz5XSMK1NppFkikxN9fx0GT7fq6C3aQJ5HUpeVz4SYzhGwaNKGI9O0DvZNqiPFm2EhCng==
X-Received: by 2002:ac8:3a6:: with SMTP id t38-v6mr8096769qtg.68.1532731451904;
        Fri, 27 Jul 2018 15:44:11 -0700 (PDT)
Received: from builder.jcline.org.com ([2605:a601:80ce:4700:77a5:8983:ea8b:82ec])
        by smtp.gmail.com with ESMTPSA id g39-v6sm4145984qtb.47.2018.07.27.15.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:44:11 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jeremy Cline <jcline@redhat.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] net: socket: fix potential spectre v1 gadget in socketcall
Date:   Fri, 27 Jul 2018 22:43:01 +0000
Message-Id: <20180727224302.5503-2-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727224302.5503-1-jcline@redhat.com>
References: <20180727224302.5503-1-jcline@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'call' is a user-controlled value, so sanitize the array index after the
bounds check to avoid speculating past the bounds of the 'nargs' array.

Found with the help of Smatch:

net/socket.c:2508 __do_sys_socketcall() warn: potential spectre issue
'nargs' [r] (local cap)

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 net/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 3015ddace71e..f15d5cbb3ba4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -89,6 +89,7 @@
 #include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/xattr.h>
+#include <linux/nospec.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -2504,6 +2505,7 @@ SYSCALL_DEFINE2(socketcall, int, call, unsigned long __user *, args)
 
 	if (call < 1 || call > SYS_SENDMMSG)
 		return -EINVAL;
+	call = array_index_nospec(call, SYS_SENDMMSG + 1);
 
 	len = nargs[call];
 	if (len > sizeof(a))
-- 
2.17.1

