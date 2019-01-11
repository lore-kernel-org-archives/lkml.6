Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B163C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2B22084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219261;
	bh=OA0f2JQm2xgh5fqsT70Y1ecSJU+jHBDIbWY5b0RdNmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cBmnM6Wj0lqUL/qsLBx8RmYh66pkd2DncLi7ylu+yXZKG3wgcy34Eq6tQcbum1ny/
	 e4Wt8NvxFSJs1Ze/2R7JD8vdy6Mo1a4pLJmrbJcrC7ozDTagGYlFsmCpt17COEU5i+
	 g880Fn4wJPvnW1NYlCnNZXlfwRyqTkV7QLYnasHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391956AbfAKPHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:07:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:47094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388508AbfAKO2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE422133F;
        Fri, 11 Jan 2019 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216904;
        bh=OA0f2JQm2xgh5fqsT70Y1ecSJU+jHBDIbWY5b0RdNmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hExPI9ypcP+vp1mZRlxQWamZS11ePAYOl8po5b4yRVItuy4m0pB+0WEJzvLzaEGC2
         R5qWTJSasgTum/Q78HCyGYHeXJEXnJ693w21g/7RZyMW2C66y5xE9vGcGTxaA6sz2+
         smMAK/7t/k4daA4yzw4oaydvzKgDJtm6a/4f6hO0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.9 34/63] libceph: fix CEPH_FEATURE_CEPHX_V2 check in calc_signature()
Date:   Fri, 11 Jan 2019 15:14:37 +0100
Message-Id: <20190111131051.026277590@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

Upstream commit cc255c76c70f ("libceph: implement CEPHX_V2 calculation
mode") was adjusted incorrectly: CEPH_FEATURE_CEPHX_V2 if condition got
inverted, thus breaking 4.9.144 and later kernels for all setups that
use cephx.

Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/auth_x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -804,7 +804,7 @@ static int calc_signature(struct ceph_x_
 	void *enc_buf = au->enc_buf;
 	int ret;
 
-	if (msg->con->peer_features & CEPH_FEATURE_CEPHX_V2) {
+	if (!(msg->con->peer_features & CEPH_FEATURE_CEPHX_V2)) {
 		struct {
 			__le32 len;
 			__le32 header_crc;


