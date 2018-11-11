Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B429C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB4920866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRwcpjx9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB4920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbeKLJmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:42:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732817AbeKLIS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:28 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94082175B;
        Sun, 11 Nov 2018 22:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975312;
        bh=uqT9+m7CCWmamkRtOC5T79akFOcjvXOpzUKXKtJwb7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRwcpjx994L/BPgJ15HhxiYvI2/n2HkEdDqumKUIwqfT62C3QutaDL3StbdHmWX4q
         rPB9EiXyoGNH5Yr7I5ubNV+8ZSf4bE9pwR9ISd7ZMXB3e2lHaMQ5NkUgXj2/UoOjql
         MNLQdREq09KKrfKU0bfZpDsSA0P8eg1FljZikgcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 293/361] media: v4l2-tpg: fix kernel oops when enabling HFLIP and OSD
Date:   Sun, 11 Nov 2018 14:20:40 -0800
Message-Id: <20181111221656.858224392@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit 250854eed5d45a73d81e4137dfd85180af6f2ec3 upstream.

When the OSD is on (i.e. vivid displays text on top of the test pattern), and
you enable hflip, then the driver crashes.

The cause turned out to be a division of a negative number by an unsigned value.
You expect that -8 / 2U would be -4, but in reality it is 2147483644 :-(

Fixes: 3e14e7a82c1ef ("vivid-tpg: add hor/vert downsampling support to tpg_gen_text")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reported-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: <stable@vger.kernel.org>      # for v4.1 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
+++ b/drivers/media/common/v4l2-tpg/v4l2-tpg-core.c
@@ -1770,7 +1770,7 @@ typedef struct { u16 __; u8 _; } __packe
 				pos[7] = (chr & (0x01 << 0) ? fg : bg);	\
 			} \
 	\
-			pos += (tpg->hflip ? -8 : 8) / hdiv;	\
+			pos += (tpg->hflip ? -8 : 8) / (int)hdiv;	\
 		}	\
 	}	\
 } while (0)


