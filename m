Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx489mIWgrlUHamkS4R94hZ9X/XaRi92lU5R6X1ai5mTKkyvYE3GYRwz5qYWfsQioWMGEMPjI
ARC-Seal: i=1; a=rsa-sha256; t=1523021356; cv=none;
        d=google.com; s=arc-20160816;
        b=L0/Dm+OySH2yU23H3Ogiqw0zEwwZ/NM9up7gKWbGlVU18Z9ND43K8QDtNEkzsKJSDR
         zZUhOjT/S0LHGmqefVIrafHAnHbHgrY4seDSGdLqPf4n93eHkhxGNpt1oifAeJritDcP
         JlHkEWz0qkSoR0AStY8KotJL6lFWtGyvsdYIAz8tHCSjZndxgbkXC5XInxQlDbV0+90M
         sHY8XwaxzPLkxWJAhBbWz76HARvqy2WyTBTHlPXATDACEQPCMO3+2kydxR7o5gGqsNMG
         SIoqQcDf8fkn5b6Usny4045wvhY4eKKebwpTcus5Vpuprvi1zwk4k7YbqYPc86+7emp1
         2Nig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WnVMHKXufe2wcstGLTuOtIUeDK20DEv3dQ8jt/XiMn0=;
        b=p8yuSbQa2Q1ISwXdQcocj6uzcFIleSv4Ms8G8zB3j4LqM/OCK5GX3BISRZiz/xJzYk
         w4t10By3VZA9gZImCMvL055kUSZGbpRembYocXlbC/OGkdzTn9BOtuomKuFbl4fjUHlZ
         8ze1Hvlgf0MpoOGcEBWsyxiD44hfUcdD6cQbV4nMFAXLSIelStVs318DgN6m+cDsE8a6
         9oNcinJO6Lv30flq0E/PS6aSEfr6GRxzxPMjeCj6bkhv82iSQ6plo87OHIzOw7oke38w
         utFZfRIKHxiwnQeT35RXI3eA2dQicd4KgEhfa+i2ffYeUCSq8OSdW9trXoO/Vd/DHdoC
         cCmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Guoqing Jiang <gqjiang@suse.com>,
	Shaohua Li <shli@fb.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 3.18 90/93] md/raid10: reset the first at the end of loop
Date: Fri,  6 Apr 2018 15:23:59 +0200
Message-Id: <20180406084229.103773273@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003641922069555?=
X-GMAIL-MSGID: =?utf-8?q?1597003641922069555?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <gqjiang@suse.com>

commit 6f287ca6046edd34ed83aafb7f9033c9c2e809e2 upstream.

We need to set "first = 0' at the end of rdev_for_each
loop, so we can get the array's min_offset_diff correctly
otherwise min_offset_diff just means the last rdev's
offset diff.

[only the first chunk, due to b506335e5d2b ("md/raid10: skip spare disk as
'first' disk") being already applied - gregkh]

Suggested-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3717,6 +3717,7 @@ static int run(struct mddev *mddev)
 
 		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
 			discard_supported = true;
+		first = 0;
 	}
 
 	if (mddev->queue) {
