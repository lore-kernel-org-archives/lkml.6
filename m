Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr0JSljlt3/3NyIIXp9xG4QnjsdHccUPxdSeYfsmNrZVHNIOgJ176TqINkkeTYSyp9C/0eo
ARC-Seal: i=1; a=rsa-sha256; t=1527156166; cv=none;
        d=google.com; s=arc-20160816;
        b=HFwIR6AFnoZIxlhXjLgvyYjkqNliIr3JlriswTOR0BP0XOBkXzMzR1uYIzCg5Hh8ns
         JbuVjjeDUHC8QShSifoftWXYaxqKsy5EjQWafuRcvjhZQlps5qNLGRvNHa2XKNn3Wq6Q
         57bGTbGHm19zPNTMsWFdqqqXhYsNu/WihVP6fP6IPGS5psF33I1wTBm3xYIrAps0GxK7
         tKb1GXNnYH3SNjw+pyFKtBPNIHEHzr+52MAQ4h9r0ewrGvsX595+cHnCC+Fj3B3oiBU2
         FcLwDS+AqinPzby6I/fXpfvrY4K3Db4t2btr8r/+sTNutRaJr6//9mmTgcj1NhDIPeJw
         6hUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Y9cJAADyzhHXITBzM+Jts3OUezyd7Ifbysb90sYaOgY=;
        b=X6WIBTcI2yAHq6oPsR9S+BSZvLFIbC63+OYFc5ZUnd4CPA44HOInILcfezHXPwEVFx
         fa79Wy/To0yGkLZSBHS83buPt+bzIf/ZjzQSbWa97grqbg3tUrvELWOrEFLIn9En0rMc
         Aht5TLIz0ITIgtVmETQ/208EF1HN/1O+QO5KZb1d9FRDGAefH/zWXQwzU38NWsYcxnk4
         OK9OUoPhqhx+pr9gSgZ6oz4tQQpfxwFs+CAx+5kDAsitKkQzG+pWoZaUvQsiIUoOv6RV
         tjurJOfJqZzaYQqWdiVyj4z3FVKYnXJYR4EG8HlH+6vT5h3jNPp42lvvDAYmFU84g4XT
         Lvlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nis+Oo83;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Nis+Oo83;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.16 087/161] cfg80211: limit wiphy names to 128 bytes
Date: Thu, 24 May 2018 11:38:32 +0200
Message-Id: <20180524093028.878554842@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338022330318261?=
X-GMAIL-MSGID: =?utf-8?q?1601339304472752060?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

commit a7cfebcb7594a24609268f91299ab85ba064bf82 upstream.

There's currently no limit on wiphy names, other than netlink
message size and memory limitations, but that causes issues when,
for example, the wiphy name is used in a uevent, e.g. in rfkill
where we use the same name for the rfkill instance, and then the
buffer there is "only" 2k for the environment variables.

This was reported by syzkaller, which used a 4k name.

Limit the name to something reasonable, I randomly picked 128.

Reported-by: syzbot+230d9e642a85d3fec29c@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/uapi/linux/nl80211.h |    2 ++
 net/wireless/core.c          |    3 +++
 2 files changed, 5 insertions(+)

--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2618,6 +2618,8 @@ enum nl80211_attrs {
 #define NL80211_ATTR_KEYS NL80211_ATTR_KEYS
 #define NL80211_ATTR_FEATURE_FLAGS NL80211_ATTR_FEATURE_FLAGS
 
+#define NL80211_WIPHY_NAME_MAXLEN		128
+
 #define NL80211_MAX_SUPP_RATES			32
 #define NL80211_MAX_SUPP_HT_RATES		77
 #define NL80211_MAX_SUPP_REG_RULES		64
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -95,6 +95,9 @@ static int cfg80211_dev_check_name(struc
 
 	ASSERT_RTNL();
 
+	if (strlen(newname) > NL80211_WIPHY_NAME_MAXLEN)
+		return -EINVAL;
+
 	/* prohibit calling the thing phy%d when %d is not its number */
 	sscanf(newname, PHY_NAME "%d%n", &wiphy_idx, &taken);
 	if (taken == strlen(newname) && wiphy_idx != rdev->wiphy_idx) {
