Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70066C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAE020852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAE020852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934808AbeFROSm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:18:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33971 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934470AbeFROSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:18:40 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue006 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Ma987-1fmqRT04Pn-00Ln1s; Mon, 18 Jun 2018 16:18:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gengdongjiu <gengdongjiu@huawei.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi: cper: avoid using get_seconds()
Date:   Mon, 18 Jun 2018 16:17:59 +0200
Message-Id: <20180618141811.3353245-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:x/kopYaU6xZQ1BGqruRHbgEPeilTEVHQKqoSVv1+vPMkwxMVmyq
 PXDKqgAEgydWN0DgXlb6vroY3+DZbS5pNs+Q8GTObGeGNJloIV7tkd5Zrktm6LfsBa3PPrk
 tYhXISgXROZh0Okl5UDhLAfD5Dt+4BfBBL/rphWmIoA02RwojQDDIozeBLUpqj3TKCaBjBA
 5PqtYwg5NDwD3EAfpwfwg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GmecSOGqaZs=:+AgQaKmuclsQIYcTsnUi1i
 FR+jxMZoTZAP23cfq6XhFEunhJveLxmKc2Nvf2wKVTiyCKk2HWmxDoFl0+QyQ4vAcxp0FuLnl
 j27yb/I0fsg+sd/DoLvqqtyiU2r1hB+I5+UZgOCb7stOvneRjyxHTognXm27KF+vrz34Lc4QC
 NpTJymM8VfPLGu6VWKP5DeJsfU7s6o0ky8KltcIx/vVBi922meWlLBeihYcjjqrv/mljYmM3L
 Pvc53J/DfqlB3foLBQ/S8u+QPPW/z33bEHdSClhb1yZ7YiPH3rM5EYqMb18EX0T74Eroqjxif
 Ofs5yYc7w1LG3nlmgVHsJMD3N0pF2D1ZEnac9Hu9NRibvnWRRfssuzV3+wYHY/6EDR4WdKjBG
 8wOtv07aeqa4WNVBjcY95Eu5hlBhNsjQJqGLpllTy7tEcOTANI1L7sVyz3VKa/R874HeRYljG
 7DKlFYiGqKwcEFy/2iJB1D70uueEyXCselFWJ1AkHyj93eqOs+Zq4weAj7EB0hoddGZQw1fIj
 rI4fciQYekMywF3/6E4FL7TiWErTytAqQgSw72EA9Nqat57qtVaAvjJ5sAbLYWGNmBceOhSBp
 CgJ/qtKTGmKuQgcx5wivTFEx8RDQQn0lSlzuCBjo+Le5FqvJkkTfh/2G1uYZXtu1Xmxpk5ICF
 kphRIWfPWDrdEkmljtDNpdQJngAxqG67nATE1GM27uL8aK0KB95FAHPqUHho/HqmeF6k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_seconds() is deprecated because of the 32-bit time overflow
in y2038/y2106 on 32-bit architectures. The way it is used in
cper_next_record_id() causes an overflow in 2106 when unsigned UTC
seconds overflow, even on 64-bit architectures.

This starts using ktime_get_real_seconds() to give us more than 32 bits
of timestamp on all architectures, and then changes the algorithm to use
39 bits for the timestamp after the y2038 wrap date, plus an always-1
bit at the top. This gives us another 127 epochs of 136 years, with
strictly monotonically increasing sequence numbers across boots.

This is almost certainly overkill, but seems better than just extending
the deadline from 2038 to 2106.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/efi/cper.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index 3bf0dca378a6..b73fc4cab083 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -48,8 +48,21 @@ u64 cper_next_record_id(void)
 {
 	static atomic64_t seq;
 
-	if (!atomic64_read(&seq))
-		atomic64_set(&seq, ((u64)get_seconds()) << 32);
+	if (!atomic64_read(&seq)) {
+		time64_t time = ktime_get_real_seconds();
+
+		/*
+		 * This code is unlikely to still be needed in year 2106,
+		 * but just in case, let's use a few more bits for timestamps
+		 * after y2038 to be sure they keep increasing monotonically
+		 * for the next few hundred years...
+		 */
+		if (time < 0x80000000)
+			atomic64_set(&seq, (ktime_get_real_seconds()) << 32);
+		else
+			atomic64_set(&seq, 0x8000000000000000ull |
+					   ktime_get_real_seconds() << 24);
+	}
 
 	return atomic64_inc_return(&seq);
 }
-- 
2.9.0

