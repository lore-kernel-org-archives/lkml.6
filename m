Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu2bfNl8rlY/jPJ3RJDud5OOkXpH9WXIJv/EfAxZG6UIcfSazpj6rHdrTL2k7pK9h/AfhDe
ARC-Seal: i=1; a=rsa-sha256; t=1521800210; cv=none;
        d=google.com; s=arc-20160816;
        b=CZcy9a2mK8PSuo2ceiHeatBeJD4dFzhAjc5kOF4ZG+5jW6aan1QjMIJRz9nP1c/Go4
         xpxVX1EUEICp4OKFJRljjQDwfcvVw9xy02tTRBM6e+GVovy+wSq1jJa/OYt1P04WeUAE
         FGDxDonlMMjpFmS5QI8eAtaYMts0gh06mpvj88YOx+1bpDSirTTiAGSdjq+oGsm3jRqT
         le25+CseVCbgqlesh40eQajp5NvMwne9jC6FbV/VPYxNZgFMVS+eH0MbZ2ekCAOWPfuo
         1zyrRjLc39SaUykgb1MmGPN1hHMmVnbuJBCr517em3wPoq8nL2lXlaYOg/JLTwPyJk2K
         262A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6UPT6eIEWN0bKaBaqnp41y7dr4r+bzFzsNtRnTLiXBQ=;
        b=Dd17U0r5RtkRzLyCWAdNRVqeMt3apevXUXI9u9teTSnc31HpnibEhT+9jJ0oObVds4
         MJIPTVT406JxFR/jNSFx4KuU3+9DjnJ25JYk/1r/ZFLPMfzNoqGrDuL8/3eanNIMyuP2
         KWvdbrjaNqWZs5O1FqN5qH2TQA1ArNaU9ZxBktybpOixJh2U1U6UNETEQHa+fcfDjqlV
         eN5DqPrmzyISbIGuIU51PFcfJ6QoGCUT/Y3gCy0nC6KLmcCYbzjsAqBlmrUS+zmwInvt
         jRE8WV6V06i/Ymjl7sGjD3544EKtpLX6t8oYSWa/V3NluRhY32qfsSL+ZODhVztojnPX
         bY8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 71/97] rtc: ds1374: wdt: Fix stop/start ioctl always returning -EINVAL
Date: Fri, 23 Mar 2018 10:54:58 +0100
Message-Id: <20180323094201.588834484@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722797718344874?=
X-GMAIL-MSGID: =?utf-8?q?1595723177733703984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moritz Fischer <mdf@kernel.org>


[ Upstream commit 538c08f4c89580fc644e2bc64e0a4b86c925da4e ]

The WDIOC_SETOPTIONS case in the watchdog ioctl would alwayss falls
through to the -EINVAL case. This is wrong since thew watchdog does
actually get stopped or started correctly.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1374.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -548,14 +548,15 @@ static long ds1374_wdt_ioctl(struct file
 		if (options & WDIOS_DISABLECARD) {
 			pr_info("disable watchdog\n");
 			ds1374_wdt_disable();
+			return 0;
 		}
 
 		if (options & WDIOS_ENABLECARD) {
 			pr_info("enable watchdog\n");
 			ds1374_wdt_settimeout(wdt_margin);
 			ds1374_wdt_ping();
+			return 0;
 		}
-
 		return -EINVAL;
 	}
 	return -ENOTTY;
