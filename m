Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A33C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E5620851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfAQJ2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:28:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:46025 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfAQJ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:28:18 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx003 [212.227.17.184]) with ESMTPSA (Nemesis) id
 0LztHH-1hFnxT2Fmd-0152af; Thu, 17 Jan 2019 10:28:17 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] uio: fix potential memory leak in error case
Date:   Thu, 17 Jan 2019 17:27:46 +0800
Message-Id: <20190117092746.17500-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.2
X-Provags-ID: V03:K1:bLr+NofRoXat+M0ErJcpcBvvooMYSbwif0o235QX67rtTJ+apKi
 7rzkcoGFfzqWa5CDYBF57FXJSs+Xv9253PrUpTaSDw5z0EBS0PIOU4QTsQuscfOYYKaWwVv
 8TGZPiS+5jsE9JdaXIMe+iDc1mWhTeUXUTXygpbcWZXqe6Z737JUbegJU4piOn0aI+GWbx7
 LoYmR0501cmNaGOI2B7bA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w4exFh2ZcXc=:zIF3yMuYuR9WkHxgIUxnJw
 +bTFqfV5kD+Lhto4Nko6BU3BeWsje5DZXrBvsaoZmVOotkAL8C5KH+6fRLX1AcQW6gc1QhLzZ
 ogizZja6ILeEJP9/nDBuBF9bpaLLG75TI5YLtsVDjY0+NidK8MDNEGDpLe/nvZ/o+KZtcQkxT
 8/V+i+YX/8o15w2wMMbB851tJYGQxOoPxCaTs55NAAbcMayUoJMXgDz3MK3Q0Lktc5zv0EvRi
 kfgjdXhm7e+eoMwC5+aF+VpS6lXq9WrG1tS+sNTw/q9fZziMaYDatf0IQUKG/rWqpL3ejIHhz
 6hw02933uxDNB6DLCeZYyApmoX5OVAvQVVYelkM+9NbJ9Ta/Kc9+GUrV32Y3KMIMGt1IKqjgx
 ahrUVjNtZqNs/inZcwz3ZNLoQVwh2RNHj3iZ8MktPlPN0oAYUqqd88v9bCYmU6sHRZmQYmKi9
 hLFFZGft6xjEDDgxZBzj3zzyWG7YCkjpjxkBGUF3/nbuiUfri3o+DOuUsDGBgkqodqR1OBxzT
 Wq/HwxBGgrVBYRzXaPW3/3C7sWYJqO6QKq9e1nsrr3w2565ZK2LRKavGMb4Q1f4eu9U0QWlpG
 S+RdoAhvA5gPIB6ovruMzlx9NauyM4Hj5nt/c7KRzY5ETDkPtJbhQB0oL97U9prSIoYkqShJy
 bwkvqeR8dWKLvrHzyVVE4tzIlGmxgXaYpFuwHX53yp9CFxGv3ZkhJ4mdiUze8n3gS8n8nsjdK
 oFaZM9cb0nuc1TuWKq6MWpn/6Z76xii8M4FHWukEWQKy5EJHMa+JA822Lbhz2pfdQYwllcAoy
 BGd68nNe9mJHbXXN9gXOI3/tc4RWj6T+aIwcV+foMUyX0d97Y6cyqva3lnYomwUkbz0PFsPbX
 k1QCTSdhZmXVhPFvf18geVDRVaoJPv++PyviAjpmALgbLgGvLRzMc45JwURHAbUpxAT3pgswN
 4M9sTHS6ytA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should jump to lable err_infoopen when idev->info is NULL
in uio_open().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 drivers/uio/uio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 131342280b46..46e5c1c31ebe 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -491,7 +491,7 @@ static int uio_open(struct inode *inode, struct file *filep)
 	if (!idev->info) {
 		mutex_unlock(&idev->info_lock);
 		ret = -EINVAL;
-		goto err_alloc_listener;
+		goto err_infoopen;
 	}
 
 	if (idev->info && idev->info->open)
-- 
2.17.2

