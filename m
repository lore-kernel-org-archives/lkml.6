Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D617C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86F3213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogEZNYdf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86F3213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390260AbeKTDPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388976AbeKTDPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:15:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B382621104;
        Mon, 19 Nov 2018 16:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646277;
        bh=9GqKqCOHazWxrmMcK+0oUNrbsIoB3L1fIeVTSQrgRxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogEZNYdfydZDNpgk4/FbwMK2AbiKSq5X5zHCMi11N1FxtKsDAhK/8PIRQM7GVd4mN
         SCydzuRVXy4TBE3jTvrvheFcOoCWzrNu96WNaeBc+NPu+8LrJNkeuOO/v+NCy05h98
         KSOuK8tl2DNdfTbi4sX6z14PUzsI30cr8nDVSFMI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 103/124] lib/ubsan.c: dont mark __ubsan_handle_builtin_unreachable as noreturn
Date:   Mon, 19 Nov 2018 17:29:17 +0100
Message-Id: <20181119162631.708771513@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 1c23b4108d716cc848b38532063a8aca4f86add8 upstream.

gcc-8 complains about the prototype for this function:

  lib/ubsan.c:432:1: error: ignoring attribute 'noreturn' in declaration of a built-in function '__ubsan_handle_builtin_unreachable' because it conflicts with attribute 'const' [-Werror=attributes]

This is actually a GCC's bug. In GCC internals
__ubsan_handle_builtin_unreachable() declared with both 'noreturn' and
'const' attributes instead of only 'noreturn':

   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84210

Workaround this by removing the noreturn attribute.

[aryabinin: add information about GCC bug in changelog]
Link: http://lkml.kernel.org/r/20181107144516.4587-1-aryabinin@virtuozzo.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Acked-by: Olof Johansson <olof@lixom.net>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/ubsan.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -451,8 +451,7 @@ void __ubsan_handle_shift_out_of_bounds(
 EXPORT_SYMBOL(__ubsan_handle_shift_out_of_bounds);
 
 
-void __noreturn
-__ubsan_handle_builtin_unreachable(struct unreachable_data *data)
+void __ubsan_handle_builtin_unreachable(struct unreachable_data *data)
 {
 	unsigned long flags;
 


