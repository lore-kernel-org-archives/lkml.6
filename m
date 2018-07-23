Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED98EECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4DBD20846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 11:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YiKZQSAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DBD20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388059AbeGWMLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 08:11:00 -0400
Received: from m12-16.163.com ([220.181.12.16]:51197 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387970AbeGWMK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 08:10:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=+v29pUSID7u/mFVYhe
        vBsLWOuxfFL367mhA7UaJDGRM=; b=YiKZQSAyV80TUyN2G1+o6kJsDEOo2GwkbO
        0VeHJEQFhYgdSpCvpLK7Wryq0LqLJ55GwhBvSjpPMjNHCeTYXDYU0VGOqJCDA9yK
        Jphs+zcXBE/YzNUUk5yKnbN/0YaLlldqOxCL7+sShDzwUz+doKTt/SnEo3ub8CCm
        nk/toGeZY=
Received: from localhost.localdomain (unknown [106.120.213.116])
        by smtp12 (Coremail) with SMTP id EMCowACniUaCt1VbVMRSIA--.19246S3;
        Mon, 23 Jul 2018 19:10:03 +0800 (CST)
From:   Xidong Wang <wangxidong_97@163.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Nazarewicz <mina86@mina86.com>,
        Vincent Pelletier <plr.vincent@gmail.com>
Cc:     wangxidong_97@163.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb:gadget:function:fix memory leak
Date:   Mon, 23 Jul 2018 19:09:46 +0800
Message-Id: <1532344186-30505-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EMCowACniUaCt1VbVMRSIA--.19246S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3uFy3Ar1UCrWDAF45Awb_yoWfZFX_uw
        1xXr1xXryqq3ZrGrWUG3yfAFWIga1UXF97uF1qgr9aya4S9ws3Ww1vqrs5G3WxZw43Wrn8
        CryrXrnxXw4aqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8I38UUUUUU==
X-Originating-IP: [106.120.213.116]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/xtbBFQuM81XlcX044wAAsG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function f_audio_set_alt(), the memory allocated by
usb_ep_alloc_request() is not released on the error path
that req->buf, which holds the return value of kzalloc(),
is NULL. This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/usb/gadget/function/f_uac1_legacy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
index 24c086b..2fcdade 100644
--- a/drivers/usb/gadget/function/f_uac1_legacy.c
+++ b/drivers/usb/gadget/function/f_uac1_legacy.c
@@ -630,8 +630,11 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
 							ERROR(cdev,
 							"%s queue req: %d\n",
 							out_ep->name, err);
-					} else
+					} else {
+						usb_ep_free_request(
+							out_ep, req);
 						err = -ENOMEM;
+					}
 				} else
 					err = -ENOMEM;
 			}
-- 
2.7.4


