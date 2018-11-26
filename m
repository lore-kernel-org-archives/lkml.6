Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCDEC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345502146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk35OIeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345502146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbeKZVxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbeKZVxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:53:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 227982146F;
        Mon, 26 Nov 2018 10:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229959;
        bh=6cjDADyKlfDQwGbf4ite/PGpd12Utf0Hgg6SblM8DlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zk35OIeb8p3HbCuzDwQTXIG9u8PPuF3LFUv3YoJoAtIqeJ1447XCmNjM4w8AB2llx
         zf9gJLUx/dNIriA8AbEA0HcwkUummYzg0122jWIk8pAEne8z2EtaPD/HGqYqnc7MTn
         wkihpKGa26n9KpnhA7tF8cbq6bXpE/j1Y2foRvxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prasad Sodagudi <psodagud@codeaurora.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dennis Zhou <dennis@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/62] arm64: percpu: Initialize ret in the default case
Date:   Mon, 26 Nov 2018 11:51:00 +0100
Message-Id: <20181126105052.428139949@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105050.592727680@linuxfoundation.org>
References: <20181126105050.592727680@linuxfoundation.org>
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

[ Upstream commit b5bb425871186303e6936fa2581521bdd1964a58 ]

Clang warns that if the default case is taken, ret will be
uninitialized.

./arch/arm64/include/asm/percpu.h:196:2: warning: variable 'ret' is used
uninitialized whenever switch default is taken
[-Wsometimes-uninitialized]
        default:
        ^~~~~~~
./arch/arm64/include/asm/percpu.h:200:9: note: uninitialized use occurs
here
        return ret;
               ^~~
./arch/arm64/include/asm/percpu.h:157:19: note: initialize the variable
'ret' to silence this warning
        unsigned long ret, loop;
                         ^
                          = 0

This warning appears several times while building the erofs filesystem.
While it's not strictly wrong, the BUILD_BUG will prevent this from
becoming a true problem. Initialize ret to 0 in the default case right
before the BUILD_BUG to silence all of these warnings.

Reported-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/percpu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 43393208229e..d79eaa816f29 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -93,6 +93,7 @@ static inline unsigned long __percpu_##op(void *ptr,			\
 		: [val] "Ir" (val));					\
 		break;							\
 	default:							\
+		ret = 0;						\
 		BUILD_BUG();						\
 	}								\
 									\
@@ -122,6 +123,7 @@ static inline unsigned long __percpu_read(void *ptr, int size)
 		ret = READ_ONCE(*(u64 *)ptr);
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
@@ -191,6 +193,7 @@ static inline unsigned long __percpu_xchg(void *ptr, unsigned long val,
 		: [val] "r" (val));
 		break;
 	default:
+		ret = 0;
 		BUILD_BUG();
 	}
 
-- 
2.17.1



