Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28090C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2344207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 03:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="owyCWe4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfBVDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 22:24:30 -0500
Received: from conuserg-12.nifty.com ([210.131.2.79]:33342 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfBVDYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 22:24:30 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x1M3NPc0015648;
        Fri, 22 Feb 2019 12:23:25 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x1M3NPc0015648
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550805805;
        bh=u4g9dlhB0DTvUHWHwr1e6a95y6E4VpHF+IesgzKDpNk=;
        h=From:To:Cc:Subject:Date:From;
        b=owyCWe4/a7yBe5mcQ7XGld9CGrFfiz5Nv3alJNs7jxiY7k8T7N4SnTW/xgYafMFIv
         XYgyO6NcgyHgC1t3O2CBbImUNcQH/er/fkRHyRSnYXKsDLGtTYUL/Pv/DxXgimyinJ
         kaokzAjQE6Lh1p9N5bgCipY/L0FVGNKv7fCFNNMB6knrLDNNVQN8FAqF/6VnvShi0P
         oAWIFz6D/9xnVbhl9K0i/OU5bt7v39dCrSy26o0Zm6BlomO2b6dVlERDTHkPcuRw8L
         8ccZZ0GP0zCWRPdMphjt8c6By/wEGqMTDiAOBjL1CQBlMn+OdMyk9L9nm95DnGPo/d
         kAo0waNANHk4Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH] bpfilter: re-add header search paths to tools include to fix build error
Date:   Fri, 22 Feb 2019 12:23:19 +0900
Message-Id: <1550805799-24572-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I thought header search paths to tools/include(/uapi) were unneeded,
but it looks like a build error occurs depending on the compiler.

Commit 303a339f30a9 ("bpfilter: remove extra header search paths for
bpfilter_umh") reintroduced the build error fixed by commit ae40832e53c3
("bpfilter: fix a build err").

Apology for the breakage, and thanks to Guenter for reporting this.

Fixes: 303a339f30a9 ("bpfilter: remove extra header search paths for bpfilter_umh")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Guenter,

Sorry for bothering you, but
could you please test this with your compiler?

I am also using GCC 7.3, but my compiler cannot
reproduce the build error.


 net/bpfilter/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 5d6c776..854395f 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -5,6 +5,7 @@
 
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
+KBUILD_HOSTCFLAGS += -Itools/include/ -Itools/include/uapi
 HOSTCC := $(CC)
 
 ifeq ($(CONFIG_BPFILTER_UMH), y)
-- 
2.7.4

