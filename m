Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/5KBQpC0P5QAVotMQir8JGU3T0phdAL/AqH1vH9uAHvi9O4Ez++5+/7P883rJBkMYQP8sM
ARC-Seal: i=1; a=rsa-sha256; t=1524405470; cv=none;
        d=google.com; s=arc-20160816;
        b=ULthK4zDBhxuTrnVh9Ie/BvdL/9dYMjbWeNafExs/KLkWpHfWhyYm9wIPqAHLQkUGq
         5+5k1cywjctJjc6VvkFrPGo4vST1X2bM/mUeh6WYOzQJvSKRE2yDjEc4cEaefFdD0lLR
         aiQfCqG4dqfqo4e7dxjlj41hm/a/6AKB8+qHsqpOCdPkLf71gel5j4aXeu0jxOAVVQn5
         yW3FLrqQjk/deTwUdOZOT5C+IeUf11XzgSilkWnLqofXAXB5Dqws/0YHoCQ93+TQoiFJ
         I/IGkGGT5IUIK/Ty9T4/XKYteVb7LLFHXR4C+dLyCPNUnsgYRkbT4HAI0a/hugtTXwpW
         yECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0qPIxFxMAB/cr3SeCdsxBH+bysnBboWJomLFIhARBHw=;
        b=ZiteA6tviXwqu+3iy3oL6371APpHSYiSea5krW7P/ozO47tp9ZfyuIADHHBbaC25Ab
         vFI6tahtWalBr2M8Kx9BCUJXIFnuvk/SvQ4Hx4oP9FXbW6s4JwLQD/nayCp5pOP9wNqf
         RIrheOl8UA+h144L2ZMEvyrkYYCyIZWhJ6EtpcYkGdDEz66PpEsJMUuppoDjFV9+Pqpt
         z+P6fhNxhyFXJiaZVc7lx8e/mj+/kuGidQn7i4Ktp0i/8QOMPLAtUkom0i9KVGAZmsEZ
         UngvsmLaaW/aWaltOoYUie753ngV8IOYPvUWmdIhwVdiySg+2VHwtry3OwmUfM8g28fv
         2Lwg==
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
Subject: [PATCH 4.16 077/196] thunderbolt: Resume control channel after hibernation image is created
Date: Sun, 22 Apr 2018 15:51:37 +0200
Message-Id: <20180422135108.224384580@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454990022490536?=
X-GMAIL-MSGID: =?utf-8?q?1598454990022490536?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1064,6 +1064,7 @@ static const struct dev_pm_ops nhi_pm_op
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
