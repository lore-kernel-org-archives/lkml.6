Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5DC83C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E00208BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAmUAVAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E00208BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754421AbeFLQyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934838AbeFLQyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:32 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F43B208B4;
        Tue, 12 Jun 2018 16:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822471;
        bh=v5GfxsQGiE+bBMmN2OxgMT5z3I9MNKJB4U0/2M8DwkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAmUAVAg/3t9QQBMKfFop2AUjvUNUqEvQH8QFFZxJ7mvyIBA6VlqlNVbeEvh9cB6d
         uqI9BXhT0ysDV0FNlLbUk2qggtJEyYbPHVg8UY24IKXKS5XR+94vaIhIYUMpbbBshy
         YITh6yIhmnhuKSaRyzZXoTwHUnxQcQxT755SN86M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e64565577af34b3768dc@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3.18 03/21] cfg80211: further limit wiphy names to 64 bytes
Date:   Tue, 12 Jun 2018 18:52:00 +0200
Message-Id: <20180612164825.530260391@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 814596495dd2b9d4aab92d8f89cf19060d25d2ea upstream.

wiphy names were recently limited to 128 bytes by commit a7cfebcb7594
("cfg80211: limit wiphy names to 128 bytes").  As it turns out though,
this isn't sufficient because dev_vprintk_emit() needs the syslog header
string "SUBSYSTEM=ieee80211\0DEVICE=+ieee80211:$devname" to fit into 128
bytes.  This triggered the "device/subsystem name too long" WARN when
the device name was >= 90 bytes.  As before, this was reproduced by
syzbot by sending an HWSIM_CMD_NEW_RADIO command to the MAC80211_HWSIM
generic netlink family.

Fix it by further limiting wiphy names to 64 bytes.

Reported-by: syzbot+e64565577af34b3768dc@syzkaller.appspotmail.com
Fixes: a7cfebcb7594 ("cfg80211: limit wiphy names to 128 bytes")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/nl80211.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2026,7 +2026,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
-#define NL80211_WIPHY_NAME_MAXLEN		128
+#define NL80211_WIPHY_NAME_MAXLEN		64
 
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77


