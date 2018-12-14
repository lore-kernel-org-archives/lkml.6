Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22616C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD969214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789847;
	bh=jpizETr2XFATKkxFtJvQcQfCAbR0VKmDVH42n8T2AKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fcR1nsBIgM72SZqF/F//bKELxqobkPx8Fn7iAp/ww3g0bgm6E4WgdiWQ+XhQ5riO8
	 87SmVuArX1ljnLdKfZuZ6fQSP/mi9ej/TZPz6x0YYBkUroVQHcv8JkVl3ZHzSH0MFv
	 9qxqTemazs4/c8f6yfyejgCqzQ3MeiRG6ibzlNXk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD969214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbeLNMRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732894AbeLNMRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 809D62133F;
        Fri, 14 Dec 2018 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789835;
        bh=jpizETr2XFATKkxFtJvQcQfCAbR0VKmDVH42n8T2AKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xcNupi1YXzwMew5+qK8YcMFak9UdnAMV0ERTLyWXe4Jb6FKl5P0cc9Ty+QGKaxdLg
         0DEcZPqFRY7rhLXTm2Ti95xTqXmKgDIESdzJnKnr++l52Hw867QtAuGxKVfwCswtxS
         hQ6hKs/2GH/o1gL6z6EhU5avpc/VQLSCskvi7by8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 87/88] rocker: fix rocker_tlv_put_* functions for KASAN
Date:   Fri, 14 Dec 2018 13:01:01 +0100
Message-Id: <20181214115709.471581903@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 6098d7ddd62f532f80ee2a4b01aca500a8e4e9e4 upstream.

Inlining these functions creates lots of stack variables that each take
64 bytes when KASAN is enabled, leading to this warning about potential
stack overflow:

drivers/net/ethernet/rocker/rocker_ofdpa.c: In function 'ofdpa_cmd_flow_tbl_add':
drivers/net/ethernet/rocker/rocker_ofdpa.c:621:1: error: the frame size of 2752 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

gcc-8 can now consolidate the stack slots itself, but on older versions
we get the same behavior by using a temporary variable that holds a
copy of the inline function argument.

Cc: stable@vger.kernel.org
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/rocker/rocker.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/rocker/rocker.c
+++ b/drivers/net/ethernet/rocker/rocker.c
@@ -821,37 +821,49 @@ static int rocker_tlv_put(struct rocker_
 static int rocker_tlv_put_u8(struct rocker_desc_info *desc_info,
 			     int attrtype, u8 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(u8), &value);
+	u8 tmp = value; /* work around GCC PR81715 */
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(u8), &tmp);
 }
 
 static int rocker_tlv_put_u16(struct rocker_desc_info *desc_info,
 			      int attrtype, u16 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(u16), &value);
+	u16 tmp = value;
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(u16), &tmp);
 }
 
 static int rocker_tlv_put_be16(struct rocker_desc_info *desc_info,
 			       int attrtype, __be16 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(__be16), &value);
+	__be16 tmp = value;
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(__be16), &tmp);
 }
 
 static int rocker_tlv_put_u32(struct rocker_desc_info *desc_info,
 			      int attrtype, u32 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(u32), &value);
+	u32 tmp = value;
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(u32), &tmp);
 }
 
 static int rocker_tlv_put_be32(struct rocker_desc_info *desc_info,
 			       int attrtype, __be32 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(__be32), &value);
+	__be32 tmp = value;
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(__be32), &tmp);
 }
 
 static int rocker_tlv_put_u64(struct rocker_desc_info *desc_info,
 			      int attrtype, u64 value)
 {
-	return rocker_tlv_put(desc_info, attrtype, sizeof(u64), &value);
+	u64 tmp = value;
+
+	return rocker_tlv_put(desc_info, attrtype, sizeof(u64), &tmp);
 }
 
 static struct rocker_tlv *


