Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F32C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAC121479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAqNfDPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAAC121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeJIB4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeJIB4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:56:34 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C555E2064A;
        Mon,  8 Oct 2018 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024209;
        bh=voHzoXPbmGA9CeZO9NTxHKsHINxDxF9YdjKd3NvEYXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAqNfDPy3zXURZQzApdtMgR2S42KmQruVzmWIAfbk9/VzKeQOeUj7fJmRh2VX3Rp4
         MafkxE725xrr/m7L1mUtp1LL6ugNKFxKK1090E8YnUj87FLLajgI1pK64SDHDfhrxp
         gXjMMoj2A6gtpJIFUkJG+qpGv6fCp0MHz2ZswpoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugeniy Paltsev <paltsev@synopsys.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 25/94] ARC: atomics: unbork atomic_fetch_##op()
Date:   Mon,  8 Oct 2018 20:31:06 +0200
Message-Id: <20181008175606.232440390@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

[ Upstream commit 3fcbb8260a87efb691d837e8cd24e81f65b3eb70 ]

In 4.19-rc1, Eugeniy reported weird boot and IO errors on ARC HSDK

| INFO: task syslogd:77 blocked for more than 10 seconds.
|       Not tainted 4.19.0-rc1-00007-gf213acea4e88 #40
| "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
| message.
| syslogd         D    0    77     76 0x00000000
|
| Stack Trace:
|  __switch_to+0x0/0xac
|  __schedule+0x1b2/0x730
|  io_schedule+0x5c/0xc0
|  __lock_page+0x98/0xdc
|  find_lock_entry+0x38/0x100
|  shmem_getpage_gfp.isra.3+0x82/0xbfc
|  shmem_fault+0x46/0x138
|  handle_mm_fault+0x5bc/0x924
|  do_page_fault+0x100/0x2b8
|  ret_from_exception+0x0/0x8

He bisected to 84c6591103db ("locking/atomics,
asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*()")

This commit however only unmasked the real issue introduced by commit
4aef66c8ae9 ("locking/atomic, arch/arc: Fix build") which missed the
retry-if-scond-failed branch in atomic_fetch_##op() macros.

The bisected commit started using atomic_fetch_##op() macros for building
the rest of atomics.

Fixes: 4aef66c8ae9 ("locking/atomic, arch/arc: Fix build")
Reported-by: Eugeniy Paltsev <paltsev@synopsys.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
[vgupta: wrote changelog]
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/include/asm/atomic.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int
 	"1:	llock   %[orig], [%[ctr]]		\n"		\
 	"	" #asm_op " %[val], %[orig], %[i]	\n"		\
 	"	scond   %[val], [%[ctr]]		\n"		\
-	"						\n"		\
+	"	bnz     1b				\n"		\
 	: [val]	"=&r"	(val),						\
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\


