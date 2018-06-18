Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19298C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CBC20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CBC20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934933AbeFROZT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:25:19 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934285AbeFROZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:25:18 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M0HAz-1gMLem04Rp-00uWs9; Mon, 18 Jun 2018 16:25:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Joakim Bech <joakim.bech@linaro.org>,
        Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        tiger-yu99 <tigeryu99@hotmail.com>,
        David Wang <david.wang@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: replace getnstimeofday64() with ktime_get_real_ts64()
Date:   Mon, 18 Jun 2018 16:24:56 +0200
Message-Id: <20180618142511.3598193-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:3pB1mVaS/YhPiyUjsf91i2nYDIRsnsIUiA1ExRrYsiozXUo+bl7
 QJW+D/1wsNIwQJ+IWtffgBPt1eNKu+PNIjFWVWYYY1JN0Zx3MHHnKzJqp7NcgnmMYqXgxBF
 ziOPJw/q+MRF8HULBhGsBTJVDGUpF9zLFtv5HtUNRjZcYDzTmVyFQVq+xIctTKdBwIoIEuN
 EqONts4oXlruyprRxlJXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M/i2gwA1krU=:hpm1LXGiAr/TXIh2HpcVCG
 4PJL76d77ieu4L/KlchOKA569kLgebK5iGameiOmOv6+cKxw5m6RsmaBXg6PPjPtjWFaVZySr
 I9Jxit35OJLMXJgT+DQudTL3drmVDck5RmGB1hyCsLv1LYuIlNkS3CkoDDGG3ZsBG3AKRDg5t
 4XxmNCHH8Y9vI950B0z6w6Am9E0oWKA5yiQ/RGVvSBoRsRAEMrrBCQM6mJwnVK5dEsuuY62L7
 f1hS6Io5yMkSDDMeClSYbd2eyLWltlQVrXhT/bWpGGIbRQEuYoEqDTp07vENO5K9u6ZnqfS9q
 7+hOLEwRTN3ZAwrxfwUf/4Ghdh8dOijIg5dFuLoPHWGA950HxdrPUc8v5hpB2l7EiepMQvE/X
 SGf1zoRwrPNaYXUn6Vm8YeRNxEIz5QE5aYuFHcxs3ebEaiuBEaY7hQb+0DgXSCqY0o7AyQRZG
 3UtmUgGfbpslYem/PUDjyoLB5RoKhfdo5nOP3wPPP2USUwl0NLPr5Q3oLJLTj/u06zSV4l2jw
 hYr+jkzpuzUyz7fTfaNoLc4EBD4PHLQyVyAmnmkD9q91S80F5TmSoRDYNVDzAg67+ihDsRuYt
 RmpMsW+PwDjtrTMFWtroLUKqGv8zyk9lggQ+5TZ78VaGPW9c+yQXZcUQofK09m7zvk+Iq+DmJ
 npKZfeRWT/o7F19DswyqEbsTa4nVeNETFHn4aEKuaYm/kM/pv0geT8taXYjgGCTcrb8k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two do the same thing, but we want to have a consistent
naming in the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tee/optee/rpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
index 41aea12e2bcc..b45c73dd37a5 100644
--- a/drivers/tee/optee/rpc.c
+++ b/drivers/tee/optee/rpc.c
@@ -48,7 +48,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
 			OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT)
 		goto bad;
 
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 	arg->params[0].u.value.a = ts.tv_sec;
 	arg->params[0].u.value.b = ts.tv_nsec;
 
-- 
2.9.0

