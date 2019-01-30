Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3937C282CD
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC27621848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPaw46Tt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbfA3DyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:54:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33712 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3DyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:54:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id d15so12974678qkj.0;
        Tue, 29 Jan 2019 19:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEyOHCwVPYw7HStNlmnz7HDoR38M6hlikqiPdfmFD4w=;
        b=YPaw46TtlJTtAmeAsYUQ+PhjGLht5bhU+xu6nv9LVnd/QvvUXTEGidqhE16pYupEJL
         lURyFrlud4S7ttY1SlKjpXSR9gt46QuOF2402KOurawQkmatQYP3FVfF8RwuuxMgHB/A
         IsvMMYXJV7skZJ2NFzzdG+MKeInePyHg4+2JsY/Zd0EwFForG+gcJ0tL8eaRBwoUE6Sr
         eK0kYjnWSYHFK5HeQPqDbBX8abL2w9X/XM1IGE7G6OfxA55XD05BnHj4jEtiDUlcQe0o
         dQSetSPq9qufWxgFOWurduTU76S9FsNKjSjd47PFb+PhcT3Vkbs216gXBHGuNvGE6ep2
         yYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEyOHCwVPYw7HStNlmnz7HDoR38M6hlikqiPdfmFD4w=;
        b=finU3Mu2/TNVFme3NA3xXVyLHNumlBM2zLBSkPFOAuxu8CNgniYUOtsvirFQ7EDoKn
         7sZkUfYaPif02d76z3362OLfnzFTvIbxF3RVbE1lYhhaHdX0KnNV9rZheQ+ZTUk8Nw7Z
         +EzalcSrV00Z+/v2vntDmgDajQfkm/Oj7Jmp6T8FF6BeoCc6IbNTJ5I0R9BMHKWBvfHS
         zbUvCNfTDZqGY+nymUPdBcqWJtEz7RNKrlG9wyvDZb8DO6VRBwr8cFKL1qRZDK4gokB9
         McmX/xiqBshCxMSve6+5x+eA2IR0aMWjz5V25faJbvyjVWZynVay8TRlN2eaxAdIA3U5
         J3GQ==
X-Gm-Message-State: AJcUuketQf1iwyiFF0n8akDfv6bcc6wmQXXQKmHzrYPMFI66LJo3MdVt
        vSVpbXFvzA0VvcWFgV3toyA=
X-Google-Smtp-Source: ALg8bN7isfnR0LdTHXhEcIuOtq9j2i2zYf+I0jCmt8uYa5dgmsC1UGCX1BMwF84LT8iI6oBKAN4g8w==
X-Received: by 2002:a05:620a:136e:: with SMTP id d14mr24916553qkl.344.1548820438984;
        Tue, 29 Jan 2019 19:53:58 -0800 (PST)
Received: from x3200.lan ([2601:152:4302:ae1f::16e])
        by smtp.gmail.com with ESMTPSA id q5sm1094098qtq.20.2019.01.29.19.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 19:53:58 -0800 (PST)
From:   George Amanakis <gamanakis@gmail.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sdf@google.com,
        netdev@vger.kernel.org, George Amanakis <gamanakis@gmail.com>
Subject: [PATCH] tun: move the call to tun_set_real_num_queues
Date:   Tue, 29 Jan 2019 22:53:55 -0500
Message-Id: <20190130035355.13304-1-gamanakis@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAKH8qBvEintAf5Dmz+8kCTW1V_BRUDxSAZy8WoYSyNoLW+JHfQ@mail.gmail.com>
References: <CAKH8qBvEintAf5Dmz+8kCTW1V_BRUDxSAZy8WoYSyNoLW+JHfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call tun_set_real_num_queues() after the increment of tun->numqueues
since the former depends on it. Otherwise, the number of queues is not
correctly accounted for, which results to warnings similar to:
"vnet0 selects TX queue 11, but real number of TX queues is 11".

Fixes: 0b7959b62573 ("tun: publish tfile after it's fully initialized")
Reported-and-tested-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 18656c4094b3..fed298c0cb39 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -866,8 +866,6 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	if (rtnl_dereference(tun->xdp_prog))
 		sock_set_flag(&tfile->sk, SOCK_XDP);
 
-	tun_set_real_num_queues(tun);
-
 	/* device is allowed to go away first, so no need to hold extra
 	 * refcnt.
 	 */
@@ -879,6 +877,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	tun->numqueues++;
+	tun_set_real_num_queues(tun);
 out:
 	return err;
 }
-- 
2.20.1

