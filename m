Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48bEsTplyESKCUYABPyolUzcV4ecCdft1G+4GVbPmpMX2HJI9oc9vttuyeOE89kAmNS6Cth
ARC-Seal: i=1; a=rsa-sha256; t=1522168755; cv=none;
        d=google.com; s=arc-20160816;
        b=yhYrx+cfCQvBz5hIM/Z6h16PZPVetYs9GFnEly+7LU5GqK4ATO4xkjRhxlW6AgfNVP
         RqQoB23BEwNgN452QeJ0hjiF1oRGHdfeseq27+dOvKutWLCVJLicnbnAhxPXuOkKeQjf
         6IQuNCrW1X551Br1zjIgsB/nPvWuwc6J3+s+SdjyoxMvi74rrsWp5r0LLPt/akxCPyX2
         tSMzzSVNkn6LsSvRynYrLW+gVfLatZFPs6smO2q9t+cIfQGJW85aASgI5TQrSWDf79Ov
         Y8/ffCKXejBw63jjxzG/u5dEK+ePiO1bPU8nDvc1dkzX11QrK241ufo5XgLQm8ZByApw
         YSlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=wtrbOzXzt9wxnf8OHlfPoi9Idcg4lLD8yNb/rdrSkK4=;
        b=RgwGVQN6UOGNiwAY9B2eSCVOFAdHEhiDfqW+eWFNbqZ0E17cZTW6hJ1YhtO3zm5c1x
         Qv1qrqAkOo38Qwydzxh3HQ4bX/o8heWsHUtucgM1dlX7pWT3a5rSFoKrxKmoNjPPuB/n
         OOLCFy+v0CK+0BRetAnWWwD4EMN+jtJFOsV2ONa64bLwGEJ3YluNYLuvEPeqXNNKa3Lw
         ldvMfz6cD01OGKto8/9wZSg+UnHF05auDKroRN9RURM6B990IixVcif/Xkpox6XF3CeW
         BQ7vYIZGUJwTzD6lxJpm+QoYJycgfAYx2V6hsVxCS+Uneu+6cJBx2Qxg6+0IHY+e10gm
         P4YQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.15 020/105] mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433
Date: Tue, 27 Mar 2018 18:27:00 +0200
Message-Id: <20180327162758.695430167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109460522217445?=
X-GMAIL-MSGID: =?utf-8?q?1596109624808388753?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaehoon Chung <jh80.chung@samsung.com>

commit e22842dd64bf86753d3f2b6ea474d73fc1e6ca24 upstream.

Before enabling the clock, dwmmc exynos driver is trying to access the
register. Then the kernel panic can be occurred.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/dw_mmc-exynos.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -165,9 +165,15 @@ static void dw_mci_exynos_set_clksel_tim
 static int dw_mci_exynos_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
+	int ret;
+
+	ret = dw_mci_runtime_resume(dev);
+	if (ret)
+		return ret;
 
 	dw_mci_exynos_config_smu(host);
-	return dw_mci_runtime_resume(dev);
+
+	return ret;
 }
 
 /**
