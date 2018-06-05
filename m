Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeFERCU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:02:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbeFERCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:02:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e64565577af34b3768dc@syzkaller.appspotmail.com,
        Eric Biggers <ebiggers@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 10/37] cfg80211: further limit wiphy names to 64 bytes
Date: Tue,  5 Jun 2018 19:01:15 +0200
Message-Id: <20180605170109.518600196@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170108.884872354@linuxfoundation.org>
References: <20180605170108.884872354@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2195,7 +2195,7 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
-#define NL80211_WIPHY_NAME_MAXLEN		128
+#define NL80211_WIPHY_NAME_MAXLEN		64
 
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
