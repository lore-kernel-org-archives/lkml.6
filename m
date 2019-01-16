Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1B5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89ECD20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393047AbfAPNQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:16:12 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:56935 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfAPNQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:16:12 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M9Wqa-1geGri1uc8-005auf; Wed, 16 Jan 2019 14:16:06 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/5] s390: open-code s390_personality syscall
Date:   Wed, 16 Jan 2019 14:15:19 +0100
Message-Id: <20190116131527.2071570-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190116131527.2071570-1-arnd@arndb.de>
References: <20190116131527.2071570-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MP74aNqzY/DIAvcLP1cb/Ch7YTV23eOR8QUFO5fetFd8kirIaOc
 OTgmwLsmuisTqVz6xPRi8FZN/+mTcmFRlKG7k6gYGMYPpEM2gh01gkr04Ig4rXav0Wjvyvm
 DOXs9qhDW32vP2S/J2e622fSIDnr7WnOUGkQI1xYg/uTQ7FipXsr+aae4PPSmO5j0eK3yAv
 1uo1qtaNwnXbXnSkDruhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:roQhEKrpGuM=:1w/GKHBSOzwFSBPIJvy5w8
 faeWCxzQBncBCm0wuA6cCfUjq4arHSE0iWTOgz1QnIoiV1QPPPoG12cpMTNfawdjs/WuU05k5
 a+tCNfYC6cz+N3JrljYKXoWIxqLIEuHRfv8598jGeHsHlLAn6nn8Aqb4IcUx2csXWXy5MvKYY
 GNo6u+OD6qA+AVQ74mC90ocbwGGDhf/30zANtB6S3S8xYY3xYgriLAORNdogcgiaZlVQd2IxH
 AVm/79q/6lridx4cIl8twOlqe0XOw31/Q6Tt/3EvY/sgeC9nrx5AjwMTzp0YgBpliBzAxhNKC
 QbwCG2KkWK67boPAYe/8fBViwEagbh3hGu2PlPUdUQlB0bzziVV2MUW813nHbhXczZqtABQA9
 7OGY2QzJFrRi0KP1U8qPz4HspdNLyenYUbCjIMs+pTNpZTUfN6h0bA6gj9r21m9/v65Ibw3Vu
 RUPH7wuaBznK0dgCxp+Iasf3MbsC1HvodhSITbNElgDiW95dGsoWlBUCoQ0Yy2JaWyTGzJDTq
 IkE11qMsAyeY+80fiXXSiYJmh5XVp9Jg+pejKkQgFHwA1sRINurGPW2BmdjI+O+/yZdJCINKs
 nE2kdA32q9//JEHTF7UV/KgGzlBfWRmF/8g6h8nEQ6JY/xvcC+qxWbZyZTZ7KzsAhUthuYbdg
 94uHPqaE1bxor1w1jLdyi8kWGcMVM9Pb74HB5SavqHWHpAax26ZaCqucmaT0TAGn8C90zSEBn
 iOGJX1JEiXDRz52BWxkvYjrs6jSJdNjLmG8eng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sys_personality function is not meant to be called from other system
calls. We could introduce an intermediate ksys_personality function,
but it does almost nothing, so this just moves the implementation into
the caller.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/kernel/sys_s390.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 31cefe0c28c0..560bdaf8a74f 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -79,12 +79,15 @@ SYSCALL_DEFINE5(s390_ipc, uint, call, int, first, unsigned long, second,
 
 SYSCALL_DEFINE1(s390_personality, unsigned int, personality)
 {
-	unsigned int ret;
+	unsigned int ret = current->personality;
 
 	if (personality(current->personality) == PER_LINUX32 &&
 	    personality(personality) == PER_LINUX)
 		personality |= PER_LINUX32;
-	ret = sys_personality(personality);
+
+	if (personality != 0xffffffff)
+		set_personality(personality);
+
 	if (personality(ret) == PER_LINUX32)
 		ret &= ~PER_LINUX32;
 
-- 
2.20.0

