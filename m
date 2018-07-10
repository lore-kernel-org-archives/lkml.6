Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184ADC5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB8D2083B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEB8D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933425AbeGJAq2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:46:28 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42019 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933349AbeGJAqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:46:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id z8-v6so8486404qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=raVTaAOmegLYYUImTxrUngb8fkvcUzBZxc/lOqQSVxI=;
        b=CwbvB7KVmdoYqb1GPTQJL57jiquzkAdoOlvZxh/xiDK8PCooZklSv90cjSqc4MprlF
         CQI883JXJ/tW8GTkM/qRUbnEp9WMQAMu9PwVQPcU3q7q6el4EErXotRlkPmEm+t1o2rg
         fp2ZC+DLxob8/hFRXwn8yoPLBelng7fhBvd3xmU2VYR9x9rRIqTbyL3tI+D3PQH+k2tG
         lyogIxaa76aSWYG0yz5ZDgTpGl+QMsRC13bYLqQXSzOVhWWpoNkX6iFLkXAV7Q81e2LH
         DdX5LaJwe3b6ZmUbv/GnjXJYy9KrO47WsZazT0o5lA11Z4cuujW0ezi2oY2q/6eQahrO
         tLug==
X-Gm-Message-State: APt69E3td0pwSetXlof+/iPaKR8MX3ApjODN6OysbCAvX/wwpOWErjGW
        Z3iyA1EpM/3xtN72lxJTkzMDwg==
X-Google-Smtp-Source: AAOMgpfAsRW3ioozCgLb/HjGuebvQED0sH9p9iETyFhikaimJg1OO5sg0kv6ekri27/HuVuWbUp3VQ==
X-Received: by 2002:ac8:242b:: with SMTP id c40-v6mr21266784qtc.209.1531183576855;
        Mon, 09 Jul 2018 17:46:16 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::1941])
        by smtp.gmail.com with ESMTPSA id l36-v6sm1816792qtk.12.2018.07.09.17.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 17:46:15 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: [PATCHv2 2/7] tools: build: Use HOSTLDFLAGS with fixdep
Date:   Mon,  9 Jul 2018 17:45:57 -0700
Message-Id: <20180710004602.21599-3-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180710004602.21599-1-labbott@redhat.com>
References: <20180710004602.21599-1-labbott@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final link of fixdep uses LDFLAGS but not the existing HOSTLDFLAGS.
Fix this.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v2: Switch to just using HOSTLDFLAGS instead of both LDFLAGS and
HOSTLDFLAGS.
---
 tools/build/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 5eb4b5ad79cb..5edf65e684ab 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
 	$(Q)$(MAKE) $(build)=fixdep
 
 $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
+	$(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) -o $@ $<
 
 FORCE:
 
-- 
2.17.1

