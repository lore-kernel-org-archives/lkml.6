Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6250C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8776A2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dHDtII3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8776A2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbeKML7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36175 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbeKML7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:38 -0500
Received: by mail-pf1-f193.google.com with SMTP id d13-v6so5217467pfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=KwRK/8QusrPt9E60VsZ+F/UZc9LhXH3dVrppBh4GkT0=;
        b=dHDtII3SPhynR8V8WQ6RhY4iIrwmmAHy+ZinjdkXtAm6sTkEaaNuEfub+dqf8SZI3B
         dTR9Mi7Ofc/EDidTtGRZGq2FOn2yrZ5AjhcKGCXlipf7oXVnGNVQ5D9IZlZ8qkS29ZDZ
         vLBb1DTN8fTFH2mUvlsCLTryVkC5RaACkNLhkGdoesX76++l56Rec0ivX5NQwfxlFEEF
         XFylgfi91mBrEPDtddjEdg9ZGYDi8/twxrOKKwpUlSs3OyQLPqnEL1kymjS/P5AK6LGK
         uSPu7xhD6XsiKqEDE2xJmtLfJsmnY0Eqvolu66Rsj3rVTchSqEFlVYLHuRSEju2ldVkY
         Idjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=KwRK/8QusrPt9E60VsZ+F/UZc9LhXH3dVrppBh4GkT0=;
        b=gJywTJLSjAWVT1LUZMuki6ai5DdEkFHQe3FTUf5V5Wdi7QLKXSdSqY361oLgoBKkLb
         jD6+v+ZqDSL6/bi3nVame7qQ8zsJrgOZ2rde7WMYSfUM3UAdiHJM6d8rJILIEn7eWWnd
         CUr6CKRfTC1EpWvZnBBkrsfs3gw92FbjjGle9nEd6cwIc4+2ht23V+uPN6LfugV8Yvfh
         qytGJ97V609eqeLqft/jNCHtzDwzC1xAADACOch6i9HrgxtFnBd3nMC7ue6Lx9k84A7D
         pdx4h64AnMLBHKOpbQcB7V3QRrE+SXBgWynCQal1pL4oPdOhunkKdt7xcF9PWLkm9mfj
         sOng==
X-Gm-Message-State: AGRZ1gJM7oCB/VQOBFlqBJVIkrmMg6ifKKzxLcG/h3pZgfqUK7u+IPP5
        RuM8dCjWOnODNV+0O81BC+irMg==
X-Google-Smtp-Source: AJdET5eNU9kgcQE7rm+1rijBilcpE7dY75n5yG5XoGYN5pAdXkENPvN/pzgS0E8cPu4WG9WX/bx8Aw==
X-Received: by 2002:a63:8043:: with SMTP id j64mr3036868pgd.405.1542074626048;
        Mon, 12 Nov 2018 18:03:46 -0800 (PST)
Received: from localhost ([216.9.110.1])
        by smtp.gmail.com with ESMTPSA id f10-v6sm11693569pfa.188.2018.11.12.18.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:45 -0800 (PST)
Subject: [PATCH 5/7] doc: Indicate that arm64 support queued-spinlocks
Date:   Mon, 12 Nov 2018 18:01:11 -0800
Message-Id: <20181113020113.29640-6-palmer@sifive.com>
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
 .../features/locking/queued-spinlocks/arch-support.txt          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index e3080b82aefd..743aa6691715 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |        csky: | TODO |
     |       h8300: | TODO |
-- 
2.18.1

