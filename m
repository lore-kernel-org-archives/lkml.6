Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED052250E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C4qmaTA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED052250E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbeKML7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:35 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39218 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730769AbeKML7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so4910512pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=NUwhYXSJlOLk4MgqEvu2/18kJmm1v5aePUdHVkXphZY=;
        b=C4qmaTA3oAHjZRvcymkthP9RKZi0HUpubM/34AurR79c6Oo9E+sZI7nrlW3eZjwKTg
         qYnHiHtcZ/Qhn6T4LjcpAJBkrK/kKfZIF5ZNVRZzFvJj6i287V4UJhrI6SZXsofpXxLC
         4qlCoHmNcdRSjDFqsmWgi1ATJQBoqylYTDP+5G1lYC1LOqvPvlkxA4fhthLM7osfVJQg
         PtpTja3/B67xIg3UJUGv7INSApBE3Z0+ADyvIkYbM0pXIJpYE83XRcoEsDo9X0jc/sGE
         Xu8jSLN/Sldc+YWfB1VMUiFDdhcCbmUPmVIh+VsOVt4qs5lRBZwri9j/oV8n1Hq57jtl
         z6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=NUwhYXSJlOLk4MgqEvu2/18kJmm1v5aePUdHVkXphZY=;
        b=BsarzD8uFtNvM4pM6pn/59BwYSRMLF34x+8VpWLdzxb2+Yvpe6dD0oeFGOE94FCdNh
         ZD43kMv00Do/mZo37FqhASrpIofyRjepJ6CYsI3I4YtcVFaMJvpMmGWcZX99ow8CJ5nm
         6958Qpf6BcNRDNzwEDnghdTMUnt1hyfrkdXnUEFzDrRvaz4X2uNFfrdejgEZEpwmuxfO
         HqojEkhND0u1Rty6ZbwSBSzTOW+pEepOWDHtbjTVFnHfTpA7E/NZfn1yT1XtEqzpGoFr
         nVgIeuSG7ArSDNfvqRUsNEwGSJr9A1Rw2SL2R8eZI9Weq+JH0U6YRbdbXahUct/RNyMQ
         5ynA==
X-Gm-Message-State: AGRZ1gIxtCC1rShOkpA6Xf2rYXuXz1XyW+OpJmk1jJKGihbO7uT75kc9
        D0bA/xBfcK+8OdLjfxejyywVyg==
X-Google-Smtp-Source: AJdET5dyv9OG35uZqV0PsX2J7Sakl0QOMWxpv9ayxV0HozTuG5WYHxf795aoMsccEk0v0MBvGE2aNA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr2890710pge.93.1542074622218;
        Mon, 12 Nov 2018 18:03:42 -0800 (PST)
Received: from localhost ([216.9.110.13])
        by smtp.gmail.com with ESMTPSA id v12-v6sm22272715pfa.167.2018.11.12.18.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:41 -0800 (PST)
Subject: [PATCH 3/7] doc: Indicate that powerpc supports stackprotector
Date:   Mon, 12 Nov 2018 18:01:09 -0800
Message-Id: <20181113020113.29640-4-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181113020113.29640-1-palmer@sifive.com>
References: <20181113020113.29640-1-palmer@sifive.com>
Cc:     corbet@lwn.net, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, ren_guo@c-sky.com,
        andrea.parri@amarulasolutions.com, Arnd Bergmann <arnd@arndb.de>,
        jhogan@kernel.org, dhowells@redhat.com, jcmvbkbc@gmail.com,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        rmk+kernel@armlinux.org.uk, Will Deacon <will.deacon@arm.com>,
        jglisse@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was suggested by features-refresh.sh

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/features/debug/stackprotector/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 9999ea521f3e..32bbdfc64c32 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -22,7 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
-- 
2.18.1

