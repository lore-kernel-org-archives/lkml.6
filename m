Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Pb4UtGohNAA7F3JDw05NJUywxi9TD0GMJTQHE/27CsEHqa7WMcULt8vUxRVWONk8U10wR
ARC-Seal: i=1; a=rsa-sha256; t=1524406327; cv=none;
        d=google.com; s=arc-20160816;
        b=xAwnK0CufGol3lXKBLix9nRO1xTdw5OFx2e/P+d3IZ8jRruttp4Tyi/fqF1Pgs61Qo
         PIdGn3SPUY+w7HNup6xxuB2uETHKSnUn0ZYJhF3v4faqKqGiH651UjGUQ2UClPk32vFJ
         nARIsZTk4dEYH8MqGuR7iIlDUoZ6S2XMIdvO5SuMqJ9aezoOQjVkqTPzBGO3p1cXgZ8y
         TfwLiCWz2L6CUolwt0fRs9scHG1iB6TZPkidBGBuWDAMzJzX//SqOSNfEVaZ6XZ826eP
         tZOZLWxry0QeQECPt/0PmzFo52//gKqLI1Eyi2h7COZA5m9w8Iyem+TKPCFjUXscaDMP
         a3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cKcTuIKzN3qJVomKliD/+eDGkd5RqxCo/ZmmIrixbLw=;
        b=eDnQIZvrTHxtIcK6IilSadcv9WThKWHnBZTByKr8tXzaz85WKiEZY0J1qEcjMd02+B
         meX9RonCMNUMmdjUa40R3STvqSuJxVKpj58xBVt7Qt6qPaU3li5+NRi+dNZhcssdcOzV
         gUcY/IPnOqa4cZueYMZ3NjVGOVYqM71heaB8VfIgeH6cTtADTuAsBqjkT9u7VC797mXm
         wxkZDXzk7Utju1KZkk8+XKi/P4p+vmyTc0cTtismatLlla2i6rWqCOvMfnxtUxi4hNFt
         JE4zt5X+qBqNRpmdd1zP4uYJY8lVU7UhIsh8Sgv14z7eblgA51/VRJT+gJZryvtU80h4
         3P9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 4.9 31/95] thunderbolt: Resume control channel after hibernation image is created
Date: Sun, 22 Apr 2018 15:53:00 +0200
Message-Id: <20180422135211.714405675@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454990022490536?=
X-GMAIL-MSGID: =?utf-8?q?1598455889318256078?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit f2a659f7d8d5da803836583aa16df06bdf324252 upstream.

The driver misses implementation of PM hook that undoes what
->freeze_noirq() does after the hibernation image is created. This means
the control channel is not resumed properly and the Thunderbolt bus
becomes useless in later stages of hibernation (when the image is stored
or if the operation fails).

Fix this by pointing ->thaw_noirq to driver nhi_resume_noirq(). This
makes sure the control channel is resumed properly.

Fixes: 23dd5bb49d98 ("thunderbolt: Add suspend/hibernate support")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thunderbolt/nhi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -628,6 +628,7 @@ static const struct dev_pm_ops nhi_pm_op
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 };
 
