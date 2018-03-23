Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvm4M3dsi+2eQV4H7xE1UEcuHjiUBxEJSLoY6KQ3G5fAHXw/w2sVvLtVxP7BhxgV/Qq68Yb
ARC-Seal: i=1; a=rsa-sha256; t=1521800417; cv=none;
        d=google.com; s=arc-20160816;
        b=SSYoz3g53XQ57Fn5Y41LQRmlrDW+uVS64ATW/QrgYLsCOb/YTBPyUKUE1jieWKHbqW
         57rVH2J0mfsdwivL3tkUkVNyp17/+5cLEDhxPkg2AFgbtJx15eN4Or2c2xCo200tZ24Z
         za84F1Ujvt5QdbWchvcjKv6fsj6EP0JR9ni08rT17N2iGV0DgaKqraCPRsnBNRBolTuM
         /N/RHCn/e1atXditc3FZikxemC2Htp2oyBTEISp1nfj3+rXMFMNBxe998EwENkItW7BF
         BttYZSw0Ro5OQ5Uh6q5d9t1fWXraRVsR7sNPG+eQ6PR4oclipbU/i+mzGiqv/FwCD0ab
         Awjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dZtfNHA3axgD657l1anmBemyfWGuWlyhNX1POjUA5XM=;
        b=ec1n0WIHzoGKPysGg2tp/szoq0zpTzNSZzLoeaLO4PCUGcfheSZBfFiDDfX8FV1a8T
         0QCzXRuMJ82xvBIKJGqlBcXlqm8OWK0029pzeU1lyhUixTFvp7fOaxZXOwfUa09DdeuS
         Zg6pqxNiuedkGYisJsHZLM6TFFznMSVQ+v/MySBrGB5pxRUb6XNM1QMdx9cJbkqKBUj2
         oxLw/kzuz24ShvDD/KxhZCHxWdhCMbJeQfi8o5kyclDiyruy9m2MEMhg49+Kg04IsGgE
         42/x5IPfuHVVdGVctgwMiKTp6iG3ShfA9MuumKVH7T0vbxb9aPGIU13ucttkV0j8pIwA
         /CJQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 35/47] sm501fb: dont return zero on failure path in sm501fb_start()
Date: Fri, 23 Mar 2018 10:55:26 +0100
Message-Id: <20180323094249.616033361@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722758223854090?=
X-GMAIL-MSGID: =?utf-8?q?1595723393960601810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>


[ Upstream commit dc85e9a87420613b3129d5cc5ecd79c58351c546 ]

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/sm501fb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_
 	info->fbmem = ioremap(res->start, resource_size(res));
 	if (info->fbmem == NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret = -ENXIO;
 		goto err_mem_res;
 	}
 
