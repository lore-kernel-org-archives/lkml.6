Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELunoGQxwmfH/FQM61pQ3j0lPuwUUlDQL6+f7yGIKjNggcbg9LRUIRfKD1uHJr3SZmadyQ1D
ARC-Seal: i=1; a=rsa-sha256; t=1521800207; cv=none;
        d=google.com; s=arc-20160816;
        b=01SAvSUturI4BN7i8cTJGW7NlDcEZLrjXWZHqwleV+RvWp36iV5SWOJicogvL+YlZQ
         HgOa27yggPIxbXs0oCzK+4hxF2WBoZcrLNji/h4Y2IVS04UAQu/vo99Y/UsLGaRkrV4z
         h8XG8Zs6dTwj1/WP38OFD5/vlNy9ozNp616FCKDBKOl7W7tCMsZzk/K66VDnVgv1EEQ2
         Qg06XAiZwZJrI3cdRgQtfGvELNGXMbPyUI3xD3sO92QgsM0hnDg8MqCVq4/GGcCMwJX3
         9Gq0vHUAZIdZNK1fPleo+2dohYvflSw0ofu1ZJMe7qcyWpspCQZNLsx02y7kHVqPmTWb
         8X/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PYVUaXfsa+E8NqnxzTygsbni5fIU2YvIMkWQu9vFUYg=;
        b=tUSk1lspZrObIwYC0hagYiACDZRtciQ5DFvjBvlHAtfUhB+RQiIsi2eDF386cHlFE9
         estFa+CVzfA7+fzOhG0AmKdz/+EiEU1eJnqWykIFJvQ6EqxOVqXsiQBI788OYhEWjQNS
         G9GKcNgS6O7obqOwI5UCa2vMEEUU4DxQu9Ti/CxGui4RGh32n8r6BrMYmF0iu6QVLL2x
         zuiYgaPCRpKdUAPk8vXwswvY2H3mM8PDlmWfwbBltY3zlTfhFRkgmpcIposo9aD4tgsu
         I2kPhqu9kWtW0VAlpGXL4xpZB0/fgKJJ5yVL1f+vx9CyE5as/X//jiHE7Nu0P3wJsGyH
         JCiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 70/97] rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt ticks
Date: Fri, 23 Mar 2018 10:54:57 +0100
Message-Id: <20180323094201.536829633@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722795226459449?=
X-GMAIL-MSGID: =?utf-8?q?1595723174541196142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Moritz Fischer <mdf@kernel.org>


[ Upstream commit 453d0744f6c6ca3f9749b8c57c2e85b5b9f52514 ]

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Fixes: 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")
Signed-off-by: Moritz Fischer <mdf@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-ds1374.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -527,6 +527,10 @@ static long ds1374_wdt_ioctl(struct file
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<= 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
 
@@ -535,7 +539,8 @@ static long ds1374_wdt_ioctl(struct file
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
