Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELviE5Dbo+9OSTulqWpWEe3pY63CPbtz78n94Niu3rCOxyIlitbZnx5zU/IyMJnErg6ljqs8
ARC-Seal: i=1; a=rsa-sha256; t=1519410892; cv=none;
        d=google.com; s=arc-20160816;
        b=0CrqM0AVLj+AeR9FM824nIh4xt51daYmIYpWkSTkehMnc7e1m62K+YpvcQLDECGdgP
         e6UMOWp640hiSCCVUCe/tYyvGQAhaG00uZBh8qH91ADlCm9EKAOWJ7x6b/gAhApd+tdm
         l6kvkZOD8TmijaFELAzncbrMiKqAi+NBVLvtqGF3XZtmXPEur+81vhM+zafjezylCGx3
         TBVykOT1fNfFPZ97IBt0af8XKsRdZNGvVOoWC2hQwZpj9oxoiu+6z0g6HQMsNpaBxQGc
         gwniEbGfFh2v/4WGFuRgZzJEtOLfXA6Qa/tAOTtrceH3dyOzAocQ59nKiU0TKGTokA1A
         c5ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yONmBN0PwLawH/44puTRPwySCtZZ9oWD6LkdbP8s8iA=;
        b=bqe3NtaraEfklSfiAQ6zybE+X1aL6QMbtJD9k+cXasmnzsJ/NLN51H7ZeK8LPafzPa
         gNPkt+cO4hdjmE1ilNpefRE91FaYoG6/7308RakVrW80Gv9F/P+gxQ00tNylqX/V2iH2
         MJzf67nE5hRN3Yarf21O/ct9nfa7inJZPTWDFjCB99SS/lbMxz4EWXTXYuqcCggS2SK6
         6ZL9BUJ8p0J/yk+c7Av8e9wZbrfEvOYk86+eiIeF6J2LgyR5hdgBI4mzn/gtGIV3I/8t
         BXWhCS07xyWCfcilOAP2eWM3JKfd3Iuf+LnikyQGrHrbU47jVp6jBbR9UuAyNkw9zW+9
         JQeg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vinod.koul@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 050/193] dmaengine: ioat: Fix error handling path
Date: Fri, 23 Feb 2018 19:24:43 +0100
Message-Id: <20180223170333.848670432@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217795962943006?=
X-GMAIL-MSGID: =?utf-8?q?1593217795962943006?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit 5c9afbda911ce20b3f2181d1e440a0222e1027dd ]

If the last test in 'ioat_dma_self_test()' fails, we must release all
the allocated resources and not just part of them.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ioat/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -395,7 +395,7 @@ static int ioat_dma_self_test(struct ioa
 	if (memcmp(src, dest, IOAT_TEST_SIZE)) {
 		dev_err(dev, "Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
-		goto free_resources;
+		goto unmap_dma;
 	}
 
 unmap_dma:
