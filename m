Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225yuF2/C3v79xB5d1IVPc+S8SzLhoWvyN1e+7Qo8W7WcQExPgI/iCTto0NWLEpcblq9FOh5
ARC-Seal: i=1; a=rsa-sha256; t=1519411846; cv=none;
        d=google.com; s=arc-20160816;
        b=LKfz6XUY1P9+TSU+w+ULJTmlLY0dEJrgu/NBa3tzEbC3ypXO0KdHwyqnygDoR++JlJ
         jFUYgMjg54FUCtW70JD96c2lrkQ9EW6f48+AqoWW+fJEwxU54WNkWNpfYZjrHt2RaLhb
         i0zj+JcUu45UCjO9wvjjIwJADjjqvtVZrFN4fB8akLtIJSifBGW0fZAusEeGY5plHWG0
         uil1plNBlPtSO8o+AOo3KLPPvXENV8VMHW0IGQKJ5nppmU+XruDlUIJE2d2aFPVSzjZ0
         N0cpBVcZXmNQRM58G37bIB+z3X/cUKNT3f8DR3UkxTa/kdiMdPohEmqt6Da2SbKKJMty
         o6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0yvk67MmB12wkUc9cyIk689FLtXK32vWvid1TgFXNOI=;
        b=E+iGpJ1MJhP6PGUhKtJFxTfcrB4Xq6ZNxdvzm4O5ak1KUCMI7GK9V6AQDLNxC6Yw4e
         Sx65JJD4/HVyzJzdDDT22Xm5YPLsndYo7inbxaTfAcgOXMc2+ELAwKbT3owRKVbrRlPR
         IjxyIa8r97MUovWbSlF1z/pkhPo8Gasdd3QgqbT2DRkD+kK+C+l1YBiX4spZsCRsorU5
         ShGGlwncOEYT+zcuFy+MAkVqoT//4XMoQnSU4aCduFsvYHnJV9cIKPSLILJhygWNeNCa
         GWUkyn96tt8BwBlqzR5Hb6METOXYdiu2MM8386j56M+9q+0TnlKBmsm8O0/ckATIPgH0
         Oxdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+8dd9051ff19940290931@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 007/159] mac80211_hwsim: validate number of different channels
Date: Fri, 23 Feb 2018 19:25:15 +0100
Message-Id: <20180223170744.022391260@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218795556138485?=
X-GMAIL-MSGID: =?utf-8?q?1593218795556138485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit 51a1aaa631c90223888d8beac4d649dc11d2ca55 upstream.

When creating a new radio on the fly, hwsim allows this
to be done with an arbitrary number of channels, but
cfg80211 only supports a limited number of simultaneous
channels, leading to a warning.

Fix this by validating the number - this requires moving
the define for the maximum out to a visible header file.

Reported-by: syzbot+8dd9051ff19940290931@syzkaller.appspotmail.com
Fixes: b59ec8dd4394 ("mac80211_hwsim: fix number of channels in interface combinations")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |    5 +++++
 include/net/cfg80211.h                |    2 ++
 net/wireless/core.h                   |    2 --
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3119,6 +3119,11 @@ static int hwsim_new_radio_nl(struct sk_
 	if (info->attrs[HWSIM_ATTR_CHANNELS])
 		param.channels = nla_get_u32(info->attrs[HWSIM_ATTR_CHANNELS]);
 
+	if (param.channels > CFG80211_MAX_NUM_DIFFERENT_CHANNELS) {
+		GENL_SET_ERR_MSG(info, "too many channels specified");
+		return -EINVAL;
+	}
+
 	if (info->attrs[HWSIM_ATTR_NO_VIF])
 		param.no_vif = true;
 
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -815,6 +815,8 @@ struct cfg80211_csa_settings {
 	u8 count;
 };
 
+#define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
+
 /**
  * struct iface_combination_params - input parameters for interface combinations
  *
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -502,8 +502,6 @@ void cfg80211_stop_p2p_device(struct cfg
 void cfg80211_stop_nan(struct cfg80211_registered_device *rdev,
 		       struct wireless_dev *wdev);
 
-#define CFG80211_MAX_NUM_DIFFERENT_CHANNELS 10
-
 #ifdef CONFIG_CFG80211_DEVELOPER_WARNINGS
 #define CFG80211_DEV_WARN_ON(cond)	WARN_ON(cond)
 #else
