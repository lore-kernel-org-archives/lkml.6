Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt6nG/bPNfzmVDVdb5vBg1waJN3nr+4mg2QGoLHzL2EcvY1pZqtBYVtesVBHXMHyF57ZLYi
ARC-Seal: i=1; a=rsa-sha256; t=1521483388; cv=none;
        d=google.com; s=arc-20160816;
        b=LOHtaVDyPxMZ4b3apYUxkdKDDrbs1yefUlqATBVYc7QChvMoCbC3ms8JaZZ6uFQHbi
         CO9qAioS/uZ9qZDS3NZBr4d93uJab9RVGei71QyJG0C6NVNrfs2j1nwP+CYCFQCc6iCo
         pmiRSf7nS7DWXioXQIjfhHOU0Hg5aO3PDoPfRiBoZaB5ArB7YfUhhYMQIEcqtpUdy7Pk
         SlFfjq8Lq1ZHm21V3FSsoPntn5ci2yr15/Q/1SQ0ehSIi2n1U1X4PqDkgc1Bd2iB0GWm
         mzlUsJl4kQyvu+7n6t/MXJoc6o5gZFeQnWpdAWxOZxSN3RkNBGRWrrAHXW1BU/okPIur
         9NWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Htg3xZeNT617CNgj2VgaB1mdzQ69HbGZ+R357xaEVGk=;
        b=OQ0VYoPdXFZhYBo86RlieXdbfW8WgkKESrCifaVBk6xHLFW8rwjea0lWndhCX982oL
         paxv4eUupqeMfhXF1jzAHPKzyfs3+u+YQdVLx2edZrWZeevt36dBr3KgULGKPtrmct3j
         AQdZSa1f6ccT2jpoBRvB1iJ6dlb+LDv467Aybqc4DFDqZpjFOAsqN9h4J7KoF5Fetm9Y
         fnvk0DrD27/EHJ8pihH6YLp74XfPmJwuEOLGTmiJAuYXcK7oqNgSCUjcUcxGCn5hxqwz
         JcFGNP+SrZ820FHxeImu1xbGrdgdQtnH1+5GDllOewIOr1C3FyrHnafBcFLGMuijJw3H
         tPRw==
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
Subject: [PATCH 4.4 104/134] mac80211_hwsim: enforce PS_MANUAL_POLL to be set after PS_ENABLED
Date: Mon, 19 Mar 2018 19:06:27 +0100
Message-Id: <20180319171904.213005015@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390965209243785?=
X-GMAIL-MSGID: =?utf-8?q?1595390965209243785?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -699,16 +699,21 @@ static int hwsim_fops_ps_write(void *dat
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
