Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CDC46471
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED5D21473
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 15:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED5D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeHHSQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:16:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbeHHSQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62F5640216E7;
        Wed,  8 Aug 2018 15:56:23 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CEA621568A3;
        Wed,  8 Aug 2018 15:56:21 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 11/12] KVM: selftests: compile against local uapi headers
Date:   Wed,  8 Aug 2018 17:55:51 +0200
Message-Id: <20180808155552.4836-12-vkuznets@redhat.com>
In-Reply-To: <20180808155552.4836-1-vkuznets@redhat.com>
References: <20180808155552.4836-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 08 Aug 2018 15:56:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently "linux/kvm.h" is included from system headers but these may be
our of sync. Prefer in-tree version.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index dd0e5163f01f..1ab27944520e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -17,7 +17,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
-CFLAGS += -O2 -g -std=gnu99 -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -I..
+CFLAGS += -O2 -g -D__EXPORTED_HEADERS__ -std=gnu99 -I$(top_srcdir)include/uapi -I$(top_srcdir)include -I$(LINUX_HDR_PATH) -Iinclude -I$(<D) -I..
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-- 
2.14.4

