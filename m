Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB489C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D36220879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078429;
	bh=/oKx9/TyiYNTJj7zIhrU07tf0xJwOR+KIe+rT0lzsok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SCW+qIPAMYNLPhLEZfkEk5wXiLJZzwpt8VJRvSM7dk77M6R9DxudRpgVwkC/P5sjm
	 VscBbEVhhy2VWK4VPlWHsB5WZ59yCpbfgQeb16oSrzZQNapXoHp/POD2quMrcKahY5
	 Sa6wuZnITBf97I3lQYXgHxP2sTKrPUdc6Riv9Vew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfAUNrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbfAUNrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1961420861;
        Mon, 21 Jan 2019 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078423;
        bh=/oKx9/TyiYNTJj7zIhrU07tf0xJwOR+KIe+rT0lzsok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfHUjP136CZqb/Da0E0d8AvqVrjZVZpBEiCbjz9F6+qx1e9oqfHFafi1okujh2Jr8
         SeOF9TaAIuhCNpkmkjGhb9yVd8fct8snuGJ4L2DJlKDYhDfvmGgn3eGRp2ix4EkjoL
         UliKM+p2g/ySgv4sP3X75kMvcx9Mz2EW9iULnPzs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christopher Ferris <cferris@google.com>,
        Dave Taht <dave.taht@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 026/111] IN_BADCLASS: fix macro to actually work
Date:   Mon, 21 Jan 2019 14:42:20 +0100
Message-Id: <20190121122458.664443610@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

[ Upstream commit f275ee0fa3a06eb87edc229749cf1eb18f0663fa ]

Commit 65cab850f0ee ("net: Allow class-e address assignment via ifconfig
ioctl") modified the IN_BADCLASS macro a bit, but unfortunatly one too
many '(' characters were added to the line, making any code that used
it, not build properly.

Also, the macro now compares an unsigned with a signed value, which
isn't ok, so fix that up by making both types match properly.

Reported-by: Christopher Ferris <cferris@google.com>
Fixes: 65cab850f0ee ("net: Allow class-e address assignment via ifconfig ioctl")
Cc: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/in.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -268,7 +268,7 @@ struct sockaddr_in {
 #define	IN_MULTICAST(a)		IN_CLASSD(a)
 #define	IN_MULTICAST_NET	0xe0000000
 
-#define	IN_BADCLASS(a)		((((long int) (a) ) == 0xffffffff)
+#define	IN_BADCLASS(a)		(((long int) (a) ) == (long int)0xffffffff)
 #define	IN_EXPERIMENTAL(a)	IN_BADCLASS((a))
 
 #define	IN_CLASSE(a)		((((long int) (a)) & 0xf0000000) == 0xf0000000)


