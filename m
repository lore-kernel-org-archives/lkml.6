Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELs1wo40aFxO/GnZhbNQLHm4uSiVU5hboGG0hL3CLPQ0ViyoQZ0LulnFLD+4G25hof8Dckoj
ARC-Seal: i=1; a=rsa-sha256; t=1519981106; cv=none;
        d=google.com; s=arc-20160816;
        b=owauNtageHmiWa6+JFSf7oBYcpzOFnor5QyCQWRsoThVAgT2xjeTluO0/nM9NFrftl
         Of0yElNzohQWPjj0JwX5aX60QTwc/geQehfnPKuYqFUWx9JygE+yO77ZeHQEmw/uaEzJ
         haDbYsLQehR9jqqL7lgpKZpHeBPPvSAkLFEspncudx9i/m3uF8h2lg2xg+jBxXA80h3S
         yizYGM+3puMeoG6QgHs/zp0TUx4f/8NTQO0pkmhkke5D8t8Yo+6x0x31leVjmKiXx/7p
         OvvSd+F6NZdLohfaQluS6hrl2my+aDqX7C5LD/ZF9nfOMLSxge1yL0rH9HIwtWAYbgwO
         Gc2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1XNVHapPfMzngFvUqctDyPJ59SZSssczuso0ZGr+CZk=;
        b=rGqu5veh29HUiw6+AN5bmzNvUQnwfBnSd9kvaHJkDaxiFbZc4/KLEy6XeF26UsCHO4
         NoCWlkTvPy2iUjOvenRFm77Bw0FP8kianMG1Vs0AcXJ34q51q0eF6O/sSNO0FI8Tr8Yp
         zULKWkFMwunFZkSOdzPG9JnTBqkDWWwiHItsptWu3FQplWm9h2KixKHEPDTPtAM6T0uO
         LACgsoH4JXgzqmrDnFwvpNE8n+B5A2pLKoNOHZSmKXePNBtQUde3Y+ryqHuplEeNaZXn
         hLGbFj593b4dhM66XNGH6L6w1+FrUYjIzWv6yUUNNsf/2sDQT0IWCE05AZdwlM05zWa3
         1onw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@163.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 15/56] mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio_nl
Date: Fri,  2 Mar 2018 09:51:01 +0100
Message-Id: <20180302084450.390739129@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084449.568562222@linuxfoundation.org>
References: <20180302084449.568562222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593815708130009466?=
X-GMAIL-MSGID: =?utf-8?q?1593815708130009466?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 162bd5e5fd921785077b5862d8f2ffabe2fe11e5 ]

The driver may sleep under a spinlock.
The function call path is:
hwsim_get_radio_nl (acquire the spinlock)
  nlmsg_new(GFP_KERNEL) --> may sleep

To fix it, GFP_KERNEL is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3154,7 +3154,7 @@ static int hwsim_get_radio_nl(struct sk_
 		if (!net_eq(wiphy_net(data->hw->wiphy), genl_info_net(info)))
 			continue;
 
-		skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+		skb = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
 		if (!skb) {
 			res = -ENOMEM;
 			goto out_err;
