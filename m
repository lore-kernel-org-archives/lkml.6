Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJPbbp6ULfgPrjojQiG1AHdqWRYMUWKVwO2O+wSXHr03HLfzv4rNps3gp+6iAKxpK+L9hu
ARC-Seal: i=1; a=rsa-sha256; t=1521484023; cv=none;
        d=google.com; s=arc-20160816;
        b=ymnUND6Zyo2aseH8FzHhm/SF2/hyLNuqechzeTNZNFc6ewg3ddzw4a9/YYjyWR9mCY
         hKbkgSaThMmrC2HFt7D2MVJXqlHd1oHneNK7iGCR2Ilq9DupT8yKu+RjO5cadO8cJeKz
         fcH0V81hicSg740NXP6/r3uWuuGNzCHQz9wnib/OhCFg/g9rFsDYfJ90CoQgSjFi7w+2
         MKKvQD2HDaCzZy6e6Tp4bm0JffsI6T44ivx7vMOW2q2u38gtuuEhDwryD+bhfritGjKi
         LuoQKxyENtPLlRAYeP3I12QhI9fzVXkUmh7m12lTbxjF0c1ZyUzqNoY8qOpTClRkfAaq
         UwXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=DHh0gyOsvzpGPKWhUjk9ipeDVOpT1bNZRQUDYM+zrzw=;
        b=k7YtXrrJR5xSMwQvB3cXzv2FUnF1BF2Xv0fUGYJMqHvC6Y7bQtNpYdplVgfyitiJJ3
         kRRuYkJWIrmtbUUwCUoVjn/pYBfrL7H4tbZxxs6IrNgu7tAAhUj26tvijJ2wutCaNYQg
         dWegNC0Ipv94trwzca9hwSQV2Sr4DSsdtOBvIVthMj9RZJIX+LevBdvLq45mCPILuz2P
         u4+kHBFQaLiDowh3D3rb0l+ymc2Bw9XHz84J5FFLY2RLb+Pd08CxNEx1F0LuSLo3zA1S
         Iz5Bn8C43D468In9zEZPwgH8wkkI+46IBcsuRcpaAUDmM1dnDUl8u8Wd0DdYKnmNRwlL
         ytsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Adiel Aloni <adiel.aloni@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 203/241] mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
Date: Mon, 19 Mar 2018 19:07:48 +0100
Message-Id: <20180319180759.586466536@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390965209243785?=
X-GMAIL-MSGID: =?utf-8?q?1595391631592844714?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adiel Aloni <adiel.aloni@intel.com>


[ Upstream commit e16ea4bb516bc21ea2202f2107718b29218bea59 ]

Enforce using PS_MANUAL_POLL in ps hwsim debugfs to trigger a poll,
only if PS_ENABLED was set before.
This is required due to commit c9491367b759 ("mac80211: always update the
PM state of a peer on MGMT / DATA frames") that enforces the ap to
check only mgmt/data frames ps bit, and then update station's power save
accordingly.
When sending only ps-poll (control frame) the ap will not be aware that
the station entered power save.
Setting ps enable before triggering ps_poll, will send NDP with PM bit
enabled first.

Signed-off-by: Adiel Aloni <adiel.aloni@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -728,16 +728,21 @@ static int hwsim_fops_ps_write(void *dat
 	    val != PS_MANUAL_POLL)
 		return -EINVAL;
 
-	old_ps = data->ps;
-	data->ps = val;
-
-	local_bh_disable();
 	if (val == PS_MANUAL_POLL) {
+		if (data->ps != PS_ENABLED)
+			return -EINVAL;
+		local_bh_disable();
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_ps_poll, data);
-		data->ps_poll_pending = true;
-	} else if (old_ps == PS_DISABLED && val != PS_DISABLED) {
+		local_bh_enable();
+		return 0;
+	}
+	old_ps = data->ps;
+	data->ps = val;
+
+	local_bh_disable();
+	if (old_ps == PS_DISABLED && val != PS_DISABLED) {
 		ieee80211_iterate_active_interfaces_atomic(
 			data->hw, IEEE80211_IFACE_ITER_NORMAL,
 			hwsim_send_nullfunc_ps, data);
