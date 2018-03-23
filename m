Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvCJ08g4aqBtBmVQ6FXAmDBp3voZ6mgqvlA9RZGeyZzT3L43jrJ60APqm8Gq6WLi98V0tLn
ARC-Seal: i=1; a=rsa-sha256; t=1521800266; cv=none;
        d=google.com; s=arc-20160816;
        b=W4qEGh2fiFWvuimPQ+Vhx0rMyWchGFjRTRbDNaCPR4fXWsLh1kXrA1M+EuLc9RhJSV
         tgWBHE9xPiKMxtjQQ5v9m5tiVvoAeBfkuIy5To4Fj8+Rr/SOml82kl7KqPDPztBUjd5H
         z8fjCyzHc8BdbGcczwd/1ei7cVopp6nBpKSU/v+5+5HJCb7gpD3Zrzh0GIIw99M2WVsL
         7HiOrI2EBRU6msgWcqxwVAI2mLDaI/ms8ulxPgbfQZSGbn3KuLfo5Phqm/L2/bVh6mN8
         QXtEftIDhaqk5Lxmk1nWxJ+Lb8HkSuNhFJSNoiNVgzBwMPjBao2QAtDBvrO2qUHpFzFn
         ZTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vlzol39d+O9aMF9F8XY03DsiM2Fnsx54KnYLVg22cik=;
        b=ninwV6tLRfwQcwekuYED9WKUP2OEzldHhEjl1vTd9fBLDk8dORJ02hVP9o6vLxNR4c
         1LPRs7NI2tm3Wt/UV0EVtNYq318NPm1phVPJKIDVPCUpVgy/jrQMDfD4uUIp2++2SLWQ
         oKh6alA5Og942PPfW7Yfc9Q+JTQavgk/Y43AHk7ohd5TXoABRlO//v/GcUDEehj79TIy
         A4AOsNA/4w9UpnAUGCqrD/2EDURg3x18KV1s57NapaPVQw/BQRX7HuKCwt/yZKC6Ybnx
         rX+JXsjHW2AKuSLJKfucTgag1oV2gpxL9bj5uTIcDMP0c612GsZ9xAIHpBd1/x/47SQs
         17eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 82/97] mmc: avoid removing non-removable hosts during suspend
Date: Fri, 23 Mar 2018 10:55:09 +0100
Message-Id: <20180323094202.121320977@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722014093884855?=
X-GMAIL-MSGID: =?utf-8?q?1595723236117862291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Drake <drake@endlessm.com>


[ Upstream commit de8dcc3d2c0e08e5068ee1e26fc46415c15e3637 ]

The Weibu F3C MiniPC has an onboard AP6255 module, presenting
two SDIO functions on a single MMC host (Bluetooth/btsdio and
WiFi/brcmfmac), and the mmc layer correctly detects this as
non-removable.

After suspend/resume, the wifi and bluetooth interfaces disappear
and do not get probed again.

The conditions here are:

 1. During suspend, we reach mmc_pm_notify()

 2. mmc_pm_notify() calls mmc_sdio_pre_suspend() to see if we can
    suspend the SDIO host. However, mmc_sdio_pre_suspend() returns
    -ENOSYS because btsdio_driver does not have a suspend method.

 3. mmc_pm_notify() proceeds to remove the card

 4. Upon resume, mmc_rescan() does nothing with this host, because of
    the rescan_entered check which aims to only scan a non-removable
    device a single time (i.e. during boot).

Fix the loss of functionality by detecting that we are unable to
suspend a non-removable host, so avoid the forced removal in that
case. The comment above this function already indicates that this
code was only intended for removable devices.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2791,6 +2791,14 @@ int mmc_pm_notify(struct notifier_block
 		if (!err)
 			break;
 
+		if (!mmc_card_is_removable(host)) {
+			dev_warn(mmc_dev(host),
+				 "pre_suspend failed for non-removable host: "
+				 "%d\n", err);
+			/* Avoid removing non-removable hosts */
+			break;
+		}
+
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
