Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C4FC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB0F22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bBYkVoYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB0F22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbeKML7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:40 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40857 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbeKML7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id q19-v6so5187531pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=j6C7eYKMwxezR19YXqvK92VNNRr0E9JdHBvUwbh35IA=;
        b=bBYkVoYUDtAp6Y66U4BYhcgc+83bly87dtKJMmfVJYGLAB8LMUZSvjOhPhvlF2u8La
         uzPM40fBm5mj22GE1Mjc/s8aEnaGulJmN5I642GTsYcrusQHq71nMqjPewR5WBWusTyO
         +bGAWDyje/cgkuIvnOmiCYV6ivM9/mcKDwYdN/vuVruk6MouzfRcosCRFCDd93SaoFx6
         TBNaF8RfLpbR1KacAGTSTsAM3jfPeLrgOwkWmw9AnXPtaKWK822lLCFN0wgau9hrE6Ev
         geNwE6jQdYNuRm73ibv2w8mK+U73eUs4Oz/bh0QCEdYy0yIJVcQ9KJNG5Oy43wHey+1D
         xoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=j6C7eYKMwxezR19YXqvK92VNNRr0E9JdHBvUwbh35IA=;
        b=eDHE+cq6MAFsAH3tfhzm3HRG3DKltI7Yy4XNbdQr0J78+Ww3CG2x8rC1x2Mjia34Lv
         9yMSKHjBroizPrea25F/nr38B39CEuf7h9AuT8WaS0OPoxE8FAnPweuPV2hCWYHJtPHC
         breKZT4ZYjOD14rUooTwMBAWAA9ySgJThljFgnTtygQ+JBK4oQ5nU9J+iFjWAONZaf5r
         SGwooWDkfS75VrjZJoMCkaEKEYdBhBX+PDQkvaqWNBCpev2PSutc+15fyrXQ2Utxach0
         g1b76BYQL9Llsb6tYpuEMn0t5tM5rUN134a9W4lWmtlRdZfmh0y88snW8aCLZVl1PoYi
         RXjg==
X-Gm-Message-State: AGRZ1gKUKpZCxIsAkz00Rf5YWFJHDXrepcxX3raOeXQQ/pw7/KRy6VIm
        BAS9ss8zxFvbA8gMrR/cav0rXw==
X-Google-Smtp-Source: AJdET5f+IeCOUgwYtlZJXefJNCayYufuSc+tWahuDcPnWC0vkagfmB4Zozi4VPBeLuKRXlIHmdsRlw==
X-Received: by 2002:a17:902:9886:: with SMTP id s6-v6mr3233545plp.55.1542074627796;
        Mon, 12 Nov 2018 18:03:47 -0800 (PST)
Received: from localhost ([216.9.110.2])
        by smtp.gmail.com with ESMTPSA id m17-v6sm20195855pfi.102.2018.11.12.18.03.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:47 -0800 (PST)
Subject: [PATCH 6/7] doc: Indicate that parisc supports kprobes-events
Date:   Mon, 12 Nov 2018 18:01:12 -0800
Message-Id: <20181113020113.29640-7-palmer@sifive.com>
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
 Documentation/features/perf/kprobes-event/arch-support.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index d8278bf62b85..86ae33c70475 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -21,7 +21,7 @@
     |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: |  ok  |
-- 
2.18.1

