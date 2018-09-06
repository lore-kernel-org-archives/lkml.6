Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927EC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A9C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p3m6VZSz";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p3m6VZSz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A9C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIFMkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:40:05 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:34529 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbeIFMkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:40:04 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 5F57B20F6E;
        Thu,  6 Sep 2018 11:05:48 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id HPtLJuXnAE-5mcSkKYD;
        Thu, 06 Sep 2018 11:05:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1536221148; bh=wesgbHGvb8z/mVqlP4nJEKXvVpfLEYIyDwVg1Hd8XBA=;
        h=Subject:From:To:Date:Message-ID;
        b=p3m6VZSzMHJxnqOrKhx/ER+vWXmVFor1rViZqdUTkOaK1IHyfB6LoYAZ1zBJY+sQH
         8PS/bOdM8ihXb0JxTeY2BXiIcAlRddu6lVuOE9HNHOFKZOIM79/ZRl5nALjxfRw5RI
         YRGsCrwwtwwyzc8uwtiCFnXL3t1IcmaEEPo3neQY=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:ac1b:4357:f84c:a04a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id NJ0ediWL8L-5lOq0lcm;
        Thu, 06 Sep 2018 11:05:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1536221148; bh=wesgbHGvb8z/mVqlP4nJEKXvVpfLEYIyDwVg1Hd8XBA=;
        h=Subject:From:To:Date:Message-ID;
        b=p3m6VZSzMHJxnqOrKhx/ER+vWXmVFor1rViZqdUTkOaK1IHyfB6LoYAZ1zBJY+sQH
         8PS/bOdM8ihXb0JxTeY2BXiIcAlRddu6lVuOE9HNHOFKZOIM79/ZRl5nALjxfRw5RI
         YRGsCrwwtwwyzc8uwtiCFnXL3t1IcmaEEPo3neQY=
Authentication-Results: smtpcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] block: bfq: swap puts in bfqg_and_blkg_put
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Sep 2018 11:05:44 +0300
Message-ID: <153622114435.533797.15694137158197822778.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix trivial use-after-free. This could be last reference to bfqg.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: 8f9bebc33dd7 ("block, bfq: access and cache blkg data only when safe")
---
 block/bfq-cgroup.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 58c6efa9f9a9..9fe5952d117d 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -275,9 +275,9 @@ static void bfqg_and_blkg_get(struct bfq_group *bfqg)
 
 void bfqg_and_blkg_put(struct bfq_group *bfqg)
 {
-	bfqg_put(bfqg);
-
 	blkg_put(bfqg_to_blkg(bfqg));
+
+	bfqg_put(bfqg);
 }
 
 /* @stats = 0 */

