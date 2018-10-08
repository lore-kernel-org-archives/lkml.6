Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCE4C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CDF214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoGSS4gT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CDF214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbeJIBvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:32 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA0F22089D;
        Mon,  8 Oct 2018 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023908;
        bh=ydWyHCkpSdzTuNs7fTLcHNtR7tLdfqdTx5cek0BRh8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoGSS4gTf2L/OC9QO6ZLp2pgG1JdgFiadV/bOVoDjzdFsAxanSXNVp0E+LiOJP2vD
         ozBfhkBpjCRC7NEwpMohq12vdXqmqqkH45sQ8eXc+czL1q5PvbMgGiHVSTyNvW5NXZ
         wms61OV1rEk6LgsnuG91wKzbKta+Fq1NTykYYhIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Ivan Delalande <colona@arista.com>
Subject: [PATCH 4.9 02/59] time: Introduce jiffies64_to_nsecs()
Date:   Mon,  8 Oct 2018 20:31:09 +0200
Message-Id: <20181008175547.105276805@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
References: <20181008175546.620836256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frederic Weisbecker <fweisbec@gmail.com>

commit 07e5f5e353aaa61696c8353d87050994a0c4648a upstream.

This will be needed for the cputime_t to nsec conversion.

Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Cc: Wanpeng Li <wanpeng.li@hotmail.com>
Link: http://lkml.kernel.org/r/1485832191-26889-2-git-send-email-fweisbec@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ivan Delalande <colona@arista.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/jiffies.h  |    2 ++
 kernel/time/time.c       |   10 ++++++++++
 kernel/time/timeconst.bc |    6 ++++++
 3 files changed, 18 insertions(+)

--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -292,6 +292,8 @@ static inline u64 jiffies_to_nsecs(const
 	return (u64)jiffies_to_usecs(j) * NSEC_PER_USEC;
 }
 
+extern u64 jiffies64_to_nsecs(u64 j);
+
 extern unsigned long __msecs_to_jiffies(const unsigned int m);
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
 /*
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -704,6 +704,16 @@ u64 nsec_to_clock_t(u64 x)
 #endif
 }
 
+u64 jiffies64_to_nsecs(u64 j)
+{
+#if !(NSEC_PER_SEC % HZ)
+	return (NSEC_PER_SEC / HZ) * j;
+# else
+	return div_u64(j * HZ_TO_NSEC_NUM, HZ_TO_NSEC_DEN);
+#endif
+}
+EXPORT_SYMBOL(jiffies64_to_nsecs);
+
 /**
  * nsecs_to_jiffies64 - Convert nsecs in u64 to jiffies64
  *
--- a/kernel/time/timeconst.bc
+++ b/kernel/time/timeconst.bc
@@ -98,6 +98,12 @@ define timeconst(hz) {
 		print "#define HZ_TO_USEC_DEN\t\t", hz/cd, "\n"
 		print "#define USEC_TO_HZ_NUM\t\t", hz/cd, "\n"
 		print "#define USEC_TO_HZ_DEN\t\t", 1000000/cd, "\n"
+
+		cd=gcd(hz,1000000000)
+		print "#define HZ_TO_NSEC_NUM\t\t", 1000000000/cd, "\n"
+		print "#define HZ_TO_NSEC_DEN\t\t", hz/cd, "\n"
+		print "#define NSEC_TO_HZ_NUM\t\t", hz/cd, "\n"
+		print "#define NSEC_TO_HZ_DEN\t\t", 1000000000/cd, "\n"
 		print "\n"
 
 		print "#endif /* KERNEL_TIMECONST_H */\n"


