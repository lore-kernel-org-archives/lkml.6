Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsrn563knfm6NXb4AURsr6333GjnW1NfFRw6Yc0MzbT1D+YfgHxRuYTvNrqpM0fizYP2ZYv
ARC-Seal: i=1; a=rsa-sha256; t=1521800398; cv=none;
        d=google.com; s=arc-20160816;
        b=e2jdBTrCUIMHpC4Dn3vCDKdvZahNvidjLYuBFmDXi41rvuKygBQGE5To5IUdN7Dc8o
         LVdIk6zC0nkdE1rS1dtkxHzdJaMQPcbTFhy51dwWX/qTM4Ez0hEKIeQXSElPmPESO40R
         YjD+VbunPgNWXAn+nHuQz3brGRroDvlrx1uv/uNpAmBeeZf99qeyDbjsHkHHZ/vq32xX
         0Z/cbFIDZEadIMRBwdBmzNd++U51Honqy+VzkYt7++SzWtJXW7EY8ox0VdxrMp1Ql1E2
         lxafSAy1nU4Zf6M/OmyhfMgDQdXLm2rQWpQBAv76bg/g+5sQXCTyYhpfZSUJ56cqF1Bk
         D2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+wjdX+L1JfxMA6j+CMSiFmsyp0EXSHY8eGnV28IIRvM=;
        b=ns3QMytBLjj3/Dd2IHGzYFwTnNsZoriOEJqrysDFAKerlKUpf+UtugUppNwZC0o56g
         +dZ3YkgYhA7SkerpF5guVwx2gH/665pMFtIvAp0dkeUm36gy0F5UFR9MHMZekN9Lxp07
         tC2goBvsCwX/AsMwgaLwak4rK9FR+lw3en8xi9HwDAH4jwq0fhGTawtDH//dMR4aVwh7
         2edXm45yX78Fm6zs05FzgBz4h+uOU5moKgNOMha3Gmoqu4jQf+qJOdHmUiIC+FUJ6BgY
         f0+bs1e0RkphJEsyaMHqDvx8cLczOu08igLjqgANNdrN37eDTKSKQV3vNbTN0L+j9Vfy
         dcBA==
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
Subject: [PATCH 3.18 40/47] mmc: avoid removing non-removable hosts during suspend
Date: Fri, 23 Mar 2018 10:55:31 +0100
Message-Id: <20180323094249.825988801@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722014093884855?=
X-GMAIL-MSGID: =?utf-8?q?1595723374292371321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2656,6 +2656,14 @@ int mmc_pm_notify(struct notifier_block
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
