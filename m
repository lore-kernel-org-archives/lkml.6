Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C59C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3013F215F0
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 06:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYzK2KvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3013F215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751693AbeGGGnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 02:43:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37197 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750816AbeGGGnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 02:43:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id x10-v6so214737pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7TaI+Vqodhb7CKUJe6OR4qWb3hyXJ2f3H9qeszgOD1c=;
        b=XYzK2KvPGdgfcvlIhnwrL6sdMTuBm9h8PkIXp2xCMa0M36Ct7vRXJ0BT3Wf/pzNk0A
         xca5u4wxNQlKhuZYAXBQCoWyXAt5q0ige3I/jUbJGMNgoUWDWbkueaylwK8ROyVMm/eU
         mijx86tuX4uNZW+V/zAdwrZMliXRdMzMg2J6THzZedFx/iyGdn5D6eKR/Sdftnf6W2e3
         DE0AUqO4fkGLys9vAzqlLuo/cELQJeyvsLQKEkohcTeVUf+3gagnYmmVO1NqHVHLV117
         brDDJ46ohLTOINbNjrZgRvfCxhy1kyWamWmeExeV0mdawgK5if+Eyw2LKyhbSRMeXPzX
         +tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7TaI+Vqodhb7CKUJe6OR4qWb3hyXJ2f3H9qeszgOD1c=;
        b=YLMwTCs3+728mQs9hNJS/EczsxZ3pgASQrp7SDxbgxC6nO0j+7J54U2qIyOu4aUET8
         HbbxUKzQprJ9VdfkWr6qsi9Faoc6RCifgnaJzJpx1QIbdgR/uNMtZimk3RJ6aWPg5HGt
         9VPZk1quQTokJMoj7fGz9Rx/iv7O+VAl8pkou2L/oAT2eEk9sq/aeoTZ+QmUzOcQR8+E
         WD+FZd7pLwUgwenAPTkC5s8FaLctRb+MdAsm+jGzXKclH6xDEU1NQFlRu8NA6v1QkwVp
         7GRQhJ1IsaDEBcznmNNjh5OYwLi+UhxTtBgYEEmOecLdCZst8SGBPh/MF8AJiCsG2r+r
         NI2A==
X-Gm-Message-State: APt69E1Py7DUMyQcTRoFpVL/TyWqPa8PbPw7wNYlKCRs61ytvlFfkpwA
        O0bwAb/rodzDbiygNQSB5RI=
X-Google-Smtp-Source: AAOMgpfTG/rQwcehLi60X7ryyzQgMMWzdMXTEFvOloPjTHsls6YkYeTWs8GCZt0z+gfu1bzfNC6LJQ==
X-Received: by 2002:a65:5086:: with SMTP id r6-v6mr11634566pgp.375.1530945810728;
        Fri, 06 Jul 2018 23:43:30 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id h16-v6sm21753168pfd.71.2018.07.06.23.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 23:43:29 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH] drivers/staging/gasket: Use refcount_read()
Date:   Fri,  6 Jul 2018 23:43:10 -0700
Message-Id: <20180707064310.199121-1-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Use the refcount_read accessor function, avoid reaching into refcount
and atomic struct fields.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_sysfs.c b/drivers/staging/gasket/gasket_sysfs.c
index d45098c90b4b..b5cdc180772a 100644
--- a/drivers/staging/gasket/gasket_sysfs.c
+++ b/drivers/staging/gasket/gasket_sysfs.c
@@ -122,7 +122,7 @@ static void put_mapping(struct gasket_sysfs_mapping *mapping)
 	}
 
 	mutex_lock(&mapping->mutex);
-	if (mapping->refcount.refcount.refs.counter == 0)
+	if (refcount_read(&mapping->refcount.refcount) == 0)
 		gasket_nodev_error("Refcount is already 0!");
 	if (kref_put(&mapping->refcount, release_entry)) {
 		gasket_nodev_info("Removing Gasket sysfs mapping, device %s",
-- 
2.18.0.203.gfac676dfb9-goog

