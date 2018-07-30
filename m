Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538E2FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3D820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3D820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731994AbeG3QNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 12:13:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34276 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731927AbeG3QNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 12:13:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id l2-v6so8564154wme.1;
        Mon, 30 Jul 2018 07:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXyu/uXHanDF8qSWkwavLjCObdKKHdrqjDJFGsNHsiY=;
        b=NxP3e5eEO/gln92fP1mu22iIuKOvsk6wTK6gGrJZnnBsgSuwu+hICkAlNQZ6nTF3V9
         OW8gDkMEcoUy4t0nBnEIK3PTwF8pPRXfgXBxfpZZbt1JCjFNds91yS9vZv7H/L8fvOus
         rJ/cNlhueDe2dHardsvZB0c3bhzjdukWT4B0vxZ+nEPtVlR1ZS+hxO8XY+p9cG4vSE1E
         BH/qFrcyj6AWKPaUIClF50NTkcTN4dUk1I3GUPy6yF3pOjHEE0rLsm4ULzbszq85OoDP
         b8R0/mR1YbTZ+UdyzZXbcX9GZaWk2gtQzd/NZC7QQRKRcHjhKe0SR1yvPNDd92UAMjdT
         2l6g==
X-Gm-Message-State: AOUpUlHUin5B9n0Dbf8qWPvyCKavDwyny5CikQnHwSyNacOcTwrJcFC9
        kd40Jy2bXCFoW28HEdWrK0FRvOSVoUQ=
X-Google-Smtp-Source: AAOMgpdb1fNHlzJ/rLu9S4BocnyDD7DLMFl1fAmbCffEPmEV1p7TevaGhrIEzRaR4inFECiU8IfoFg==
X-Received: by 2002:a1c:b80c:: with SMTP id i12-v6mr6552501wmf.30.1532961473893;
        Mon, 30 Jul 2018 07:37:53 -0700 (PDT)
Received: from localhost.localdomain (u-084-c050.eap.uni-tuebingen.de. [134.2.84.50])
        by smtp.gmail.com with ESMTPSA id 71-v6sm16599753wmq.17.2018.07.30.07.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 07:37:53 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        rlove@google.com, ben@decadent.org.uk,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 3/4] file: export get_files_struct()
Date:   Mon, 30 Jul 2018 16:37:09 +0200
Message-Id: <20180730143710.14413-4-christian@brauner.io>
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
get_files_struct() we need to export this function.

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
index b1ffa7acff69..430d74642e00 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -409,6 +409,7 @@ struct files_struct *get_files_struct(struct task_struct *task)
 
 	return files;
 }
+EXPORT_SYMBOL(get_files_struct);
 
 void put_files_struct(struct files_struct *files)
 {
-- 
2.17.1

