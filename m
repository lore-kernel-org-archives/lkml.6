Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2263gY20yGeUlJge6rt3thj4JfAGX3WwItf+T6UKyycTlfszusn/TOsdWzMT9+v9FJFlGErV
ARC-Seal: i=1; a=rsa-sha256; t=1517591426; cv=none;
        d=google.com; s=arc-20160816;
        b=M1gyEleUitI3fV0t+8KYeQduylHFt9GKoRhGOsgouz2qa25fQSDzL4q5h9kMROfWXg
         ac0HKvQAliHtAUGN835zlyPNhvQ69phBgXDcjYOWYp3wYQHn//UwrRv49KQOEAYlZDw2
         Bd6MGm0ycuweUeoKWBcAtp7I5UYfioAZEe36Ak+VrPgye1JZtEuOf9samyzyAIr/3gOb
         4YUvRPR6+ct0sTmovbZzDA+76DEi64qkvlD9me8PPRWORAYp+aUSJi1lpuG2woGZUv68
         D0DQC7aOCuecT0SvOIesb11lX4TMxCTC/YaNMlVC+fdqHf8UAmL+NSXGCkdByt/Trt1g
         AglA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=2mKk0VdWkOf7X2BEWAazmRFu4bhD12KXpk5GZDgjQ50=;
        b=Zf87eRGGQhaAFoAv9K4gKBu25iCnMqvMrJESvX5pTtyisl2BN+rVN4ylZdzhVHgUNR
         t62VTDtoOTM12YC3CraX1oH4qlLBxCw/awfTjsUkyKqke1w1NInzPiqodLqvAYwqZJBh
         3S5SijT4c1AYoZbztCFQZqQEGfKEfXFduGmeEsRrS+mwmOEUAuaGTAwkI1rozdyhJ8dC
         3MW8hf0XFCfJPOXQ3zpAzVsHlKLPZpHtMCHj5NN/fAeWETcH85ABBl8gk7L3KJglE1qR
         01ff49Q2EA6RDesuZlZ3Y7YRMmPefGpp4Lzvr5ZODNYsRAKhNR2zV6ZJHbfBw8Z88pha
         qP2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mirza Krak <mirza.krak@endian.se>,
	Sandy Huang <hjc@rock-chips.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 068/156] drm/rockchip: dw-mipi-dsi: fix possible un-balanced runtime PM enable
Date: Fri,  2 Feb 2018 17:57:29 +0100
Message-Id: <20180202140843.370659851@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309946928354816?=
X-GMAIL-MSGID: =?utf-8?q?1591309946928354816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mirza Krak <mirza.krak@endian.se>


[ Upstream commit 517f56839f581618d24f2e67a35738a5c6cbaecb ]

In the case where the bind gets deferred we would end up with a
un-balanced runtime PM enable call.

Fix this by simply moving the pm_runtime_enable call to the end of
the bind function when all paths have succeeded.

Signed-off-by: Mirza Krak <mirza.krak@endian.se>
Signed-off-by: Sandy Huang <hjc@rock-chips.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1510734286-37434-1-git-send-email-mirza.krak@endian.se
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
@@ -1275,8 +1275,6 @@ static int dw_mipi_dsi_bind(struct devic
 		goto err_pllref;
 	}
 
-	pm_runtime_enable(dev);
-
 	dsi->dsi_host.ops = &dw_mipi_dsi_host_ops;
 	dsi->dsi_host.dev = dev;
 	ret = mipi_dsi_host_register(&dsi->dsi_host);
@@ -1291,6 +1289,7 @@ static int dw_mipi_dsi_bind(struct devic
 	}
 
 	dev_set_drvdata(dev, dsi);
+	pm_runtime_enable(dev);
 	return 0;
 
 err_mipi_dsi_host:
