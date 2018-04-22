Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+9zmCLF9BDihYU9iCIExMEaMXwT4CN9535nH5rxMnRuJIj4UK5bXXRgD7RMjuRhbk+ef8Q
ARC-Seal: i=1; a=rsa-sha256; t=1524405960; cv=none;
        d=google.com; s=arc-20160816;
        b=UtSsWOrP8Ob3Mgu52eSBC1E8dKuBtqGq/zkEHrSiRVNr6ao7l999Ar1NCyT4mJWGS8
         qkZDSoQzW7g6Lq7ylm6IwTo0CzFccLFH0XF5KUpo38tcMMqDIoJ4bNRazNw5IASAjlgM
         2PtuzCDoJaCTPgDYOqfVmOc7HN6tRhEomvvDaXbpPgMS4dS3JuaRbA9NUYMoFZOi9KSo
         mjDh7nX82eyScyejiRtvEyuY52Xm/NIOU/oCVBuPpTnwmCdnFcrk/+sE+aCfxhebLByP
         JwMZkC/zamzzHx/mPOED0fRKlIXDk/RQZI6jzkJQfIYD9/05j8mxEo5wziUBPOwikUpn
         INpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xC+Ai9v9sSgKZg4/WW9P/K+m2br8JMxEQXHSmh1kpC0=;
        b=iM6XKCnNP0yqsnYvQpK2Wx/YqLuVX0LYQy3XBaFNN0brzxNpKIlDOh2n8Krm8Q0pRi
         Vy223LzRTsjRIphrQ0UT5yefBrvxaJkoIe1pjyzake5+cBLozWzNRBDVMJO6DOpTWLO3
         Sas5D9sWvVX+GLASfsQC+N9SFHcwFuo6NkjIFCYZ8wgJq8YANlJXb+m1FLrdzvqX4YZz
         2Orf5G1uuQG0F8ed5cRupIsrYm2JFaS3va/okMx/lAZdgfk6tixXjSVwby15GrjYtf39
         dkyrWFUoIzjxN989F1aMdPnwM+gIyQ6L/el3k7sh0JPETjU5MXijjEe3i/txqK/LAJXs
         Omtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Weiyi Lu <weiyi.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4.14 060/164] soc: mediatek: fix the mistaken pointer accessed when subdomains are added
Date: Sun, 22 Apr 2018 15:52:07 +0200
Message-Id: <20180422135137.905383183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454976334056522?=
X-GMAIL-MSGID: =?utf-8?q?1598455504465659258?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Wang <sean.wang@mediatek.com>

commit 73ce2ce129783813e1ebc37d2c757fe5e0fab1ef upstream.

Fix the pointer to struct scp_subdomian not being moved forward
when each sub-domain is expected to be iteratively added through
pm_genpd_add_subdomain call.

Cc: stable@vger.kernel.org
Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/soc/mediatek/mtk-scpsys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -892,7 +892,7 @@ static int scpsys_probe(struct platform_
 
 	pd_data = &scp->pd_data;
 
-	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
+	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
 		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
 					     pd_data->domains[sd->subdomain]);
 		if (ret && IS_ENABLED(CONFIG_PM))
