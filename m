Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv0YGEVPgZMqjNglerZAr2JP6QbzS3JLHn0J6QtUAyHdvnetnfyD11DtN7kuw7KVNmKp97V
ARC-Seal: i=1; a=rsa-sha256; t=1521215102; cv=none;
        d=google.com; s=arc-20160816;
        b=M7R2tbbqJMV0gBaG+r3M0AYd5UGkj+pFfHUEgmJMZXvkl7SpAzu4fgs2UbK35S8W7a
         qJJYJFYWD7ymcaTk9BoNe827NdlDePSQkqRNhvNke+KJ96CIoWnChqxZYzYobduDSKLx
         Yx7/Ii7zNT921X0BO3AFffdqTs6H45YZsSHMl/V7gBw6ebc+nbiHL5DYytLvj1XGu5vY
         4r/TqGNj8rvyomgjMPZlI8smg/uiLs6IiEKl+8Wc6EjHaUXWvi0MFxboJ4OTI2se0Gpm
         CNvYEDrLdh/4y7A2lcF8mpLbNpSl5SMlePSBevUX+q4Y880XvL/u5QxfgVqFjJAy8IQo
         15/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=++qFeA2L7El+2wOcWzla3jzupk28U+f1UNNU+Xf+a58=;
        b=KT42BkcXY7UAOuDve8sCGe6IP0330MVxj3+YLUYEVOY+K1spnBL3clt4kWrHGdqtXN
         x3tObqGebwxGGVzZphIMPfb/gAXKkBYVtsg3awGg4usGE8UBiP2AVQjxoryE+rp8Nikd
         dREQMHZGEtkqu/zYOvF1PClQzKVR2CCF7S183hvdVLXGzsoSNcn0pccVEB0b+/g8Qs5f
         9FSaWnwXEv4nZLyksLyMCmYAtdLCAmrPgieeKIFMp5fbz/jx/YZoVtTZZos9V2Q0eZss
         AnK+FejSBUPsjiB4coZ49kWlIpOm3Jp0cEPQdPad38d5tenOuc0nCizCTPzu8RHtL5A/
         zsAA==
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
Subject: [PATCH 4.15 116/128] mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
Date: Fri, 16 Mar 2018 16:24:17 +0100
Message-Id: <20180316152342.264923312@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109226193268055?=
X-GMAIL-MSGID: =?utf-8?q?1595109647261398697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -729,16 +729,21 @@ static int hwsim_fops_ps_write(void *dat
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
