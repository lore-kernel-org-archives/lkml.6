Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/i3lT/WC4MXfHYCqod9HaOeb/Wibx8mWsXnh0BQbTJIs+vwkNtkbj3ZuO+jLZ7rZmSU5ZJ
ARC-Seal: i=1; a=rsa-sha256; t=1524405974; cv=none;
        d=google.com; s=arc-20160816;
        b=G7x6PgMqm+Ek5bfsVBLmT6da5TKd0zAK6lw9Uw/3Jap58VBPwN28iXH2tHC8EnbAho
         Mwgb/fJNB18Uda6UOqpS76SI47aj8NMBSXZfqQWlWy5VngdpFT+j9B/eFwusDd6V6GNr
         EWJ5Fk+BLNKniccjhuoT/JWCjC2BmuadZd90t/6F9CrD95Mq1ncjaqrO9iXwKMPg8FbS
         57aC/SJJJtFDzN/hE8FtVcMg866MPT8nOOTtC0CFFhysJZHkzYfADW+8cuL7h+Mth+sI
         vxUcDhAQSb9WCbeMO15EQOk6sccLMf4Cna7Jc2n5qEtsvzXyCWNYmL7ncg5gIXE8NsWk
         QVpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lUSF1Xc0wZRkwd4ophFmLlrYqIep4RoqTZM1o7nY7Eg=;
        b=0YseYOzwk/j+59nuJjpq5IdAoj/nGTnEPbfHr4xP5aZ0fDl4UzMNxDTLAeQj6DnhYZ
         L6vh8AZ0KamQOQKJUiwNusq0wyywigSSgHwTSdqzvbO8xTrRwR55Fr3NMCitO+PBkwKK
         Y7hReehD8IBDdLkX81n1+Bly1TTW5RTPBHOwSGUeT1vKpWHbX9VYUUE4lHjI/XYxwB0a
         3XPQhJYfMd0TfirK8nS1Y/LQ8shVOeFiePnWF39KA2dKFITDuMG4Y8OcKD84dHT2xI+e
         4RHkBpOuqmNznsx+fYL1YyGH3GYqSu1DfMzGCHAStb8NNEd/EaI2u+fp/j2dYqHADJ6U
         MFPA==
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
Subject: [PATCH 4.14 065/164] thunderbolt: Resume control channel after hibernation image is created
Date: Sun, 22 Apr 2018 15:52:12 +0200
Message-Id: <20180422135138.108090826@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454990022490536?=
X-GMAIL-MSGID: =?utf-8?q?1598455519525512603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -846,6 +846,7 @@ static const struct dev_pm_ops nhi_pm_op
 					    * we just disable hotplug, the
 					    * pci-tunnels stay alive.
 					    */
+	.thaw_noirq = nhi_resume_noirq,
 	.restore_noirq = nhi_resume_noirq,
 	.suspend = nhi_suspend,
 	.freeze = nhi_suspend,
