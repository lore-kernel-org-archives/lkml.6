Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KNRVlmW+g/wl6QBV5bncr5upH/8ccwpr1zrFyfjVe+QogulT+EbuJZkEmWOFsWT4HyXn6
ARC-Seal: i=1; a=rsa-sha256; t=1522346570; cv=none;
        d=google.com; s=arc-20160816;
        b=bi0vAKm7TPe211BE30l15jvU4rXMfc3lGArf9VzxytTfvqgi4oi9TSDjlESaNnr8JN
         MMxBgNqxkzU17Mu3u13HzNMi9QCexZWUwy+hSTIOH1nS87iACzuPQCnvt18E9iOSP+o6
         xKowBQZzVJ+armvC5jUvlVF6E2oQs5STS+fkv9/xLP99hD/IVbNrKlLr++CFkxfBAlPT
         wuQGodZCDyhBdU3DdPo/wb3Pre5mW/wcaxnGMoFG0R7BalxpNvG174vwG3VkxBZyExEh
         Uwgcq+XgKjBDwPeXXaSBjcNPFsNB7gTFFqhdU0r5/m81iDkIXclN5w4cA6MCfsVaVLcM
         /LTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/u4Rho4CY4mbpwUrTzSnpTMGwe5x3CimSryVdQIY/Mc=;
        b=JSFBX7tt1sBdv9KJLzQiSDTZTZIGMdOUtm+C1pNcVq4PcMRYjjTkx+yagUEc6SEqL0
         qhxDu2+1dJ1udbqJNDdXvy+1t6MBDcpV1hJlZa1jhA+d86uNMe9Mr0KeKoZfMYGqCrYS
         tbh/punnzgDC5XdrVupmTq+JzRhgsfBvt3C8+jzyJwMGMhAv1iUeYPRfyEdGNZZtGgqG
         YZQtKBQ5iq4X7j53uErN5iEoGJpfppe0XWg8FwaSZ6GzcFn8Ee9sK/QNVAMTSZnBRt0j
         D2lULf9JnU/KmypS/uJ7Ntp/Md9dYw68r9RkmZfX6ENDnvtivQBUEcr9a6z4vm21vZ0o
         Jc7g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 31/47] dpaa_eth: fix error in dpaa_remove()
Date: Thu, 29 Mar 2018 20:00:12 +0200
Message-Id: <20180329175731.766761610@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175729.225211114@linuxfoundation.org>
References: <20180329175729.225211114@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296077654525127?=
X-GMAIL-MSGID: =?utf-8?q?1596296077654525127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Madalin Bucur <madalin.bucur@nxp.com>


[ Upstream commit 88075256ee817041d68c2387f29065b5cb2b342a ]

The recent changes that make the driver probing compatible with DSA
were not propagated in the dpa_remove() function, breaking the
module unload function. Using the proper device to address the issue.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2860,7 +2860,7 @@ static int dpaa_remove(struct platform_d
 	struct device *dev;
 	int err;
 
-	dev = &pdev->dev;
+	dev = pdev->dev.parent;
 	net_dev = dev_get_drvdata(dev);
 
 	priv = netdev_priv(net_dev);
