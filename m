Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045EFECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B659D208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B659D208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeGMPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:22:11 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbeGMPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:22:10 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MarjW-1fKgeh47kg-00KNwG; Fri, 13 Jul 2018 17:07:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Simon Que <sque@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gasket remove current_kernel_time usage
Date:   Fri, 13 Jul 2018 17:06:37 +0200
Message-Id: <20180713150703.3156256-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:G6aoTFHleRaNKcwQWEDvwO22CVEaxZ5qNc1H3XM69Gdpkih8ho6
 QQUTd7KcgsV/gEvtcLaeJThIdj3UkD+/A5jnTJ1oHqb7Op2MZICkBWZjPyz4E38VLys3uDr
 waQf++4J+XIRdmUk69BUl/etQRViLMGaAiCbC4kJmQzFtIw4VE6paJytFz97f9+eXB0iQ0u
 QzLiEN95Ga1C/TaetiaPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZqKHunGeb54=:Yb3dO8hAcyOPkV0I6Woyl/
 WctPkZC0njZYoc/WwoMOeI21Qj5JvAgA9dSZd+rfxWrNQPAwdYntmaUETC6oV4PCrKjlmg2uQ
 w6V0CKy0JxHMCVKrkGELwNXC3CJ2Q6aUVHHf7nuN0nXFx8bAMys+W2FvtddItrSjfUFGBJvOo
 SVUWdE6/iPeRBATmqx/yhXnkPdj4itwwjnHq/+T68zMWnEQxZX0tJUkdjFJGj4ff63rYglnm4
 8OG/pN32Xf5IbJXb7P+556CxIipDQ69X6s1zVznfQZy814q2IvndkAfCWAX9ZJWS3dju5SUZO
 OyaCFzB4PypG1G0WChz8l1AGNNlVAKfqDAsJKg9QnlpMUVpqqSNFjl+bG7Kf9Ewv+mbtJz7/T
 pBLIqBj7xYJ+vfQdV1cIDfELsQogcHXkmMUwMhGI4X2tf2GdmqVcsH3BJ6im5vEeeDkGCtZY2
 gMM4pStZ+EJwVzKbmF4ABIyp9BAjSUUgNjMppSPrUWuLFaQITuVyQpw+gVdYgxnDnB7M1eFNP
 CBKlRneUbss3/R/N6RMhce4YY5tdqMdLf6gDdM2FwdWnvXI19s6RG0gcMwDm3Hk69qxD/T4ve
 C/OsZMaOJpr005vxMJJrln3yCoewF5GTjdjfOnIk3hqAiROaKUoG5HL/vCVRtxOegjzmfr45D
 YaXzk298/ZNuWMKxbu9gb2Gp3XhDg6UpCxkTDjCluEkywgixSZtk4YuNFPrCZFPpFHDY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new user of the deprecated current_kernel_time() function has appeared
here. This code won't work correct during leap seconds or a concurrent
settimeofday() call, and it probably doesn't do what the author intended
even for the normal case, as it passes a timeout in nanoseconds but
reads the time using a jiffies-granularity accessor.

I'm changing it to ktime_get_ns() here, which simplifies the logic,
and uses a high-res clocksource. This is a bit slower, but that
probably doesn't matter in a busy-wait loop.

Note: it also doesn't matter in the current version, as there are no
callers of this function.

Fixes: 9a69f5087ccc ("drivers/staging: Gasket driver framework + Apex driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gasket/gasket_core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 45914ebc8f44..248c99a841a9 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -2090,19 +2090,14 @@ int gasket_wait_sync(
 	u64 timeout_ns)
 {
 	u64 reg;
-	struct timespec start_time, cur_time;
-	u64 diff_nanosec;
+	u64 start_time, diff_nanosec;
 	int count = 0;
 
 	reg = gasket_dev_read_64(gasket_dev, bar, offset);
-	start_time = current_kernel_time();
+	start_time = ktime_get_ns();
 	while ((reg & mask) != val) {
 		count++;
-		cur_time = current_kernel_time();
-		diff_nanosec = (u64)(cur_time.tv_sec - start_time.tv_sec) *
-				       1000000000LL +
-			       (u64)(cur_time.tv_nsec) -
-			       (u64)(start_time.tv_nsec);
+		diff_nanosec = ktime_get_ns() - start_time;
 		if (diff_nanosec > timeout_ns) {
 			gasket_log_error(
 				gasket_dev,
-- 
2.9.0

