Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpofvO6z6gHt9PxXKmHTGyyd7d1qPChJLPbExiXlzBpfLS4SdSxp1pYd55B3hfOVfj+ehs9
ARC-Seal: i=1; a=rsa-sha256; t=1524837804; cv=none;
        d=google.com; s=arc-20160816;
        b=ArfJbNUyKYxDr+08De5D/biHdq+aFE5vpyxm1EwQlqEPJYgg08oW2OvvAlRwghVe4r
         3kk1/SeGuasLmQIh9tpXuiYVCS0Jow1RnkfMgs9OAo83dp10zJrgJlYujmfn4SMtaFuB
         spxfVu8AfibqhsANhH7EnUQEUUlfOg3LQRhFWK3pB3vx31pL6ehizNX7QMxPNnvGFZQ5
         Ss3bBkKG8sTXycNpoGVr29DldJE7z43CD4M92J+AjX8h1v+Y1AjCHMT0JO8JOVIAhA8M
         u0sVdKfyd7UcoM7R2NXKR4n6CSRZYuPrsNU+tMaxCH49S5mERbS5hPoxISZ6LLj7yhC/
         36NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=EFf20u+oJLp7fhIzgy77S/b6Vu2PP9ki365FnlyfW/s=;
        b=zjjuyyIk1F1BjIBpyp21kOzsi9MLtsMkizWXPiECx20a5K2Q+FmOhPke1NN/+ILWdB
         WF8Xim75PI7LIt6M5+UuNv1HMy877DWa1pJBP8cO6xplgBRKh/7gzDjcyKWCSzGIj9zB
         izgfiJVKlHLqR+YE8Ly143laB7RIRWC81neZOrUzkhOPYH2V1NTt6RosbediE/Ix6Ifs
         m1oDAIB6rs34HbeqVo/shlF0pr6caqNTUKofLeZ86qJ17dPSByMTMx7/7ZIbChqFLH5d
         qorg+pLmFyWNipMyZtxJWXj8cvzDFGryEJ/tliyjq4FLgNQfR83KgDwNN0oOobMr9jJR
         TGvg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32451218A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+70ce058e01259de7bb1d@syzkaller.appspotmail.com,
	Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.9 23/74] mac80211_hwsim: fix use-after-free bug in hwsim_exit_net
Date: Fri, 27 Apr 2018 15:58:13 +0200
Message-Id: <20180427135710.854308792@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908325584981965?=
X-GMAIL-MSGID: =?utf-8?q?1598908325584981965?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>

commit 8cfd36a0b53aeb4ec21d81eb79706697b84dfc3d upstream.

When destroying a net namespace, all hwsim interfaces, which are not
created in default namespace are deleted. But the async deletion of the
interfaces could last longer than the actual destruction of the
namespace, which results to an use after free bug. Therefore use
synchronous deletion in this case.

Fixes: 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial namespaces")
Reported-by: syzbot+70ce058e01259de7bb1d@syzkaller.appspotmail.com
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3346,8 +3346,11 @@ static void __net_exit hwsim_exit_net(st
 			continue;
 
 		list_del(&data->list);
-		INIT_WORK(&data->destroy_work, destroy_radio);
-		schedule_work(&data->destroy_work);
+		spin_unlock_bh(&hwsim_radio_lock);
+		mac80211_hwsim_del_radio(data, wiphy_name(data->hw->wiphy),
+					 NULL);
+		spin_lock_bh(&hwsim_radio_lock);
+
 	}
 	spin_unlock_bh(&hwsim_radio_lock);
 }
