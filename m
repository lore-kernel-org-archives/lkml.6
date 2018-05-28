Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932988AbeE1QCE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966327AbeE1KPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:15:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 034/268] mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()
Date: Mon, 28 May 2018 12:00:08 +0200
Message-Id: <20180528100205.943769387@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "weiyongjun (A)" <weiyongjun1@huawei.com>

[ Upstream commit 0ddcff49b672239dda94d70d0fcf50317a9f4b51 ]

'hwname' is malloced in hwsim_new_radio_nl() and should be freed
before leaving from the error handling cases, otherwise it will cause
memory leak.

Fixes: ff4dd73dd2b4 ("mac80211_hwsim: check HWSIM_ATTR_RADIO_NAME length")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2925,8 +2925,10 @@ static int hwsim_new_radio_nl(struct sk_
 	if (info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]) {
 		u32 idx = nla_get_u32(info->attrs[HWSIM_ATTR_REG_CUSTOM_REG]);
 
-		if (idx >= ARRAY_SIZE(hwsim_world_regdom_custom))
+		if (idx >= ARRAY_SIZE(hwsim_world_regdom_custom)) {
+			kfree(hwname);
 			return -EINVAL;
+		}
 		param.regd = hwsim_world_regdom_custom[idx];
 	}
 
