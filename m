Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+fZOC4eKeXHdsd7rBx+qhwtJ0dIh/MovNFlDldGffWna6Mc33K5L8X/q4e/+UFaomgQUYb
ARC-Seal: i=1; a=rsa-sha256; t=1522346724; cv=none;
        d=google.com; s=arc-20160816;
        b=V3npS4iEDWHiUsIQfY/AzzBfuY7pkyXN4niDAxK9w4uOGh5DeptwYrk3wa0mMyS8II
         KwUfHBDH6z3FgvDOBm7go/lhHkTvz/7Y/OBFd43o/e/cfIZaySquHVAnw1RX1pK17jpN
         694/nHu0o3xKMkVeuOedu4fWIt4EScK3/9xkPYOCTDBK45lT9hzNzwlmJQjcqnyHFBUt
         eDkOK9i5tfK4kp0rsh3D6bZsb9GQDFlH1rxw36AY0MRTZ0wTu/uko3MwAxCRjPrdOSkR
         i8eKDdKfSRh6ts8KGGIdFvXsU+J9fiQKvRo2JYU3DcJ7bgdRCYl5sUvyB4KxZjRaAio8
         fY4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3tG2ZcZIdJvHIwThMF8z/7flrW5i4tCHwhscY8IQbFI=;
        b=ZJF225jTrqU1/6xOCtnnjSFRaSaQ77YXtsMzZrKv26NVKAiMSkvaxWlSxdaNMj2z8U
         Fzh4AN6qXxSd1TrG9Y7O1XrQOm3f0E0qWS7533EKpZN2ZLvO+WyLCI2ltqGJutRkVysH
         yiIO8BznPzT/80wB3Zc7NV4KnJCXgBM/hstC9wNulVY3D9quMwBE2XrAmVIUc855QWrv
         tFyrlRgXoxxuWDdLn9Lw/DFsaPy04SFA+aYHD3nSa/JVdv1C3Bdj7tcuRu8CetweYzvN
         su7YToUyHT39twu234ziFNbKeWT9k5mvQPcjRSkXZVm4JXJRbok57m4U3qflq9rXsA9O
         WdTw==
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
Subject: [PATCH 4.14 36/43] dpaa_eth: fix error in dpaa_remove()
Date: Thu, 29 Mar 2018 20:00:31 +0200
Message-Id: <20180329175734.073816441@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596296077654525127?=
X-GMAIL-MSGID: =?utf-8?q?1596296239599464404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
