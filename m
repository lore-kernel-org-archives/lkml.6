Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BAEFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC0B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC0B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732032AbeG3QNP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:13:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39025 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeG3QNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:13:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so13144219wre.6;
        Mon, 30 Jul 2018 07:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g6uA/ItY/jvy50+CLjnIIK3lTFRrbJaUxjf6MtvCKkw=;
        b=n8QVUfuQNhrJhhxGOwjMjVS2Qtu/DIaK3BQ97l5HXSft/PyPP67p5WTqRpV9teJwFt
         tw+QlzQiaVV9exL3g8r0bthNpmgSwZwApms6tL71N9hdkPuwGQ+wXHVKLNs78XMAkt8a
         D3DQPzv0ijTQk+0iCK2PmvHf2m5TOFE19zrC5NwDqWjs7mNdVeHe/G7A0au2BQvH5fsg
         pcJTKgnIGR2mV031/2Y+kzrz+L0mkwBihA2F7Hec45oel8HvrQJjKvElhx9n67EJcEcz
         hqM2s1EhboAMj0GBe6fYoRK5HJspZWbbtH5p3LYC4GnDyMQtO24lsjgLzX8DbunStR8M
         SDdg==
X-Gm-Message-State: AOUpUlGV2Jz2lH+KMc2Ibj3fYdU/MX3L3TBREHxQ/77lOEurHZLTMA1K
        U7VRHdu6nhD8olym9HmPNVY=
X-Google-Smtp-Source: AAOMgpeo6JvDLIlZkQMawe3L7fjIdZ1uwKJ8Hm2rj2/EetrnDmF5YS1Sgp2vpSPrjyBuN0Xw4jaRYQ==
X-Received: by 2002:a5d:44c6:: with SMTP id z6-v6mr17936427wrr.236.1532961474858;
        Mon, 30 Jul 2018 07:37:54 -0700 (PDT)
Received: from localhost.localdomain (u-084-c050.eap.uni-tuebingen.de. [134.2.84.50])
        by smtp.gmail.com with ESMTPSA id 71-v6sm16599753wmq.17.2018.07.30.07.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:37:54 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 4/4] file: export put_files_struct()
Date:   Mon, 30 Jul 2018 16:37:10 +0200
Message-Id: <20180730143710.14413-5-christian@brauner.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730143710.14413-1-christian@brauner.io>
References: <20180730143710.14413-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Android binder driver will be turned into a module. Since it uses
put_files_struct() we need to export this function.

Signed-off-by: Christian Brauner <christian@brauner.io>
Cc: Todd Kjos <tkjos@android.com>
Cc: Robert Love <rlove@google.com>
Cc: Ben Hutching <ben@decadent.org.uk>
Cc: Martijn Coenen <maco@android.com>
Cc: Arve Hjønnevåg <arve@android.com>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index 430d74642e00..89a62165c5a0 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -422,6 +422,7 @@ void put_files_struct(struct files_struct *files)
 		kmem_cache_free(files_cachep, files);
 	}
 }
+EXPORT_SYMBOL(put_files_struct);
 
 void reset_files_struct(struct files_struct *files)
 {
-- 
2.17.1

