Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49nMZyGznRZGz/AG3rD+F67IGTgCIrXrRO4uEsqC8pbfSnZgjzFz5LrE233pgXHGsDRC2Ll
ARC-Seal: i=1; a=rsa-sha256; t=1524406924; cv=none;
        d=google.com; s=arc-20160816;
        b=tahyhmiG9kj/0KyOSimIum/vIST/YvNdfPOECHQtCv5T5HGQilV0KosPDds+0OR9E4
         vEL5VHI+GnilLTiroiTCMkRI5JJLAxHlM5zD6t+I0XTUUdL8FGeQYic1CMYbQIsrgPh9
         h6prNR9K5DSpMdX4cx5RUj+k40zFsjx0ElIJZ6pHHAmLGN2l4BbxoAhIPOvAf6oyOv2j
         RNXKaE/vjqgoEfliY0S0Dx/C9hTSncXiIeSn6NZ0l7WpW5KhPF6IIMBCa6bMjhL77apn
         7rTmb3W0PsBxB8BuXjnryyQTiYxRx9Q8dUmXANfT321BlaoMleLdyRWmhNMmGpa76Tvx
         pbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aKgWC1y/0YQbGlUNmOMUAJp2pI6WfR7eWNMSt9UuPRk=;
        b=MjPgmoRWUAa6QJBoIzeiOmR5J5eE1Do3WsbJqNnzDOGY1ZAPdXGzoJjr+me1xUea2v
         QaTRgMrS/dLE5mFckhSKUxckPRFegzWO38Cu286Vkh9jiWXC8Xs1WOhy8U8AETWl1+g+
         B2zjEmuhEnB1wpcFNZOHhXMC/TrDwf1zL/Ro1GA9t8X/XqGNX+/KW+pBPDjqIQz15X30
         o9gvO8exSlZv3Q4XFDmnjbxhY+cTVckbD+mW49HdsVRI76+jK3g+mJdWuNjBz2iQHf7n
         9qgg7QOEdGoOmU6aTXqFmwxDN+h8X1wh2Eh4DXvu4J/A7QLJ7pVKY4u+Jtw+xM0dGwGq
         Bu/w==
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
Subject: [PATCH 3.18 23/52] thunderbolt: Resume control channel after hibernation image is created
Date: Sun, 22 Apr 2018 15:53:56 +0200
Message-Id: <20180422135316.364136514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454990022490536?=
X-GMAIL-MSGID: =?utf-8?q?1598456515398081237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -627,6 +627,7 @@ static const struct dev_pm_ops nhi_pm_op
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 };
 
