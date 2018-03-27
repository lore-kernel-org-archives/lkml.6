Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/TvhPBkSizJBE8ziW0HTiKhs8taCSz4g0B8rx0VvgdBtBTBSy2wVJ3azItC+KbqEGlG51J
ARC-Seal: i=1; a=rsa-sha256; t=1522168598; cv=none;
        d=google.com; s=arc-20160816;
        b=HvL5xekqxIKwwrslejyHsc2jzhTjBTb6rOeHcHjK94aX6Tkz2LJPv2mnAa3ekR0epf
         8y2cT2Vh3pDV9fdvIQ8UskU+2TTvKJTb1LVYjzxoCLRKYWGBdPdQyIlm8Vv+rfOU4n4P
         mIJABeWhHCOlBhHsyBHrm5QLERlwaSA5cGxdZLNBXFIKd2KpIbvgbaup3hfdYENbKT9z
         2wizDOZe4Dy0pmp1dv5hIjIkeJZ1zz9ioXSPoMAFkd0EcaNmtcQVh6JTXF0y8Fjx0C49
         kkzKb5bF6lEd0Miz988VxmSoCpyD2+UAYtJQESaK+BNVKRksfPb7kImAODHs6Qfk76xV
         2SRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hQcciyp1HXLASsADsO/YpffB/Pvc5Ol2QCpVSpdkJp8=;
        b=FcSLS8O84QCTRJ7X9/HlR6o+dmv/6vq1ivAWpimufU8TUdV3FuecbUmP+G23Cs7UAz
         OT9cJguaLfr0W77eoui09K/xf9P213JPLMZM20OTSs2gM0U6GRi5VVJkKL+rF10JhZpY
         KLZl3ayLER1doQ09LXIq5VAyb8ZnlqUa8JD4N/LaTHJPfUT5yVPclgfTgi8LXS3FzZK/
         U6AkxiltWhtOkZxS5VRY1DqzB3JpKvOqP2zSIE0LVir9F4nyILQLAmApRcBF7RXrNy60
         g91zjII6oAPmbR6iHr7sbsjhBpY9f+B2Lqql8t5Qhp/N+Ne91xb9fwvLolFEIDbmUChH
         O3FA==
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
Subject: [PATCH 4.14 020/101] mmc: dw_mmc: exynos: fix the suspend/resume issue for exynos5433
Date: Tue, 27 Mar 2018 18:26:52 +0200
Message-Id: <20180327162751.216426681@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109460522217445?=
X-GMAIL-MSGID: =?utf-8?q?1596109460522217445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
