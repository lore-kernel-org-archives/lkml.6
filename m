Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AC62145D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpgWtXu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AC62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbeKTDI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:08:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387555AbeKTDIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:08:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CAAD214C4;
        Mon, 19 Nov 2018 16:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645884;
        bh=BjjHDTUEXSfrn89xwo7khmEH1SGuUrQw0KcXcz1pQyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CpgWtXu1nQXJ5nUfC3f8Ku4KnkPOkNlUOaKhY4AxMJov9TKlL4hmHDsryHR6NQfS5
         QHICDyjROfjWk5YvfjZLhjX5MypXgGh/3GwzFbWwY+1bDB+6+afKhx6nl+gy5oKNZO
         O5Xhi9R8UfowrHt21D0i/b6fmCFf5AWVP57OxNck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH 4.18 126/171] kdb: use correct pointer when btc calls btt
Date:   Mon, 19 Nov 2018 17:28:42 +0100
Message-Id: <20181119162637.610035833@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit dded2e159208a9edc21dd5c5f583afa28d378d39 upstream.

On a powerpc 8xx, 'btc' fails as follows:

Entering kdb (current=0x(ptrval), pid 282) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0x0

when booting the kernel with 'debug_boot_weak_hash', it fails as well

Entering kdb (current=0xba99ad80, pid 284) due to Keyboard Entry
kdb> btc
btc: cpu status: Currently on cpu 0
Available cpus: 0
kdb_getarea: Bad address 0xba99ad80

On other platforms, Oopses have been observed too, see
https://github.com/linuxppc/linux/issues/139

This is due to btc calling 'btt' with %p pointer as an argument.

This patch replaces %p by %px to get the real pointer value as
expected by 'btt'

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/debug/kdb/kdb_bt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -179,14 +179,14 @@ kdb_bt(int argc, const char **argv)
 				kdb_printf("no process for cpu %ld\n", cpu);
 				return 0;
 			}
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			return 0;
 		}
 		kdb_printf("btc: cpu status: ");
 		kdb_parse("cpu\n");
 		for_each_online_cpu(cpu) {
-			sprintf(buf, "btt 0x%p\n", KDB_TSK(cpu));
+			sprintf(buf, "btt 0x%px\n", KDB_TSK(cpu));
 			kdb_parse(buf);
 			touch_nmi_watchdog();
 		}


