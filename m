Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224tBn84kGEKJ9lRES/ulTGgXI5UJChLDWqtR8sJCbhB9nWY6Iye2zskH5ON4i+L2IebL8Bk
ARC-Seal: i=1; a=rsa-sha256; t=1519217123; cv=none;
        d=google.com; s=arc-20160816;
        b=n93ISIykq3WhdkC9vg2ta5At+JdhLR+swAfdyjcn59lxzIHKpXBRrpNyD7YiSXOvDF
         V0ODSOqrHzshKRt3t9vD3Y8iiuotXZt0t2cDiGUrrwYjJyri4n3UaqbLUHe3BpVoPdnR
         fdL2cC2YlKeJziP8A0JRPlrBRebanJreUSQRnul6bBWDh0/7Wyn0hDRB8OZvRwsr3wK7
         /yHsy45xEPEoasAjN4TkBMKWCm3/5BxpLQ2kXOd07w+D35aFNgnO6lvNInDA7RkXOQJJ
         PxXFpOwAyOjvHfJg8mvTs3m1QbzGzNssXTgM0o6B9OttMY3E5N1neQ/cI8DuWg1pCULj
         jT1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fwmtKc6Jjnxb5p8Qn46hZOZUJEYXDL4i5W+sqTJzjhs=;
        b=KtvjzihH85EHAmdpOtW+faTDWkwc8OqJLSp2GCsAjVfpqggyim+/PeGnuY+cdqMg66
         kuhOWJmqaThpg3SWSuggRtjmyiIToOgXwtqzkt1iDcZuiOz8rG+e1kX8nVTh6Igy863F
         HmXw3v33LHJQbJmYF1pkSDy+RUrqFPNQZZ7tJ5U5sWC3/T+L9oohpQU7a77NjBgA5/ge
         NEO5xyVFsRWFH1LGBGdMSbFZPoZBaFuSemVcqnD/eUrJXsLzC1TM/t2KZeLkYyg2w6IC
         lwaJg2kSqPIhI00kjBFBMA2/UtQzYrX6dAvjtJfqoE9anlq+ppQwWVWi2Bq/MJHiRETj
         0SIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: [PATCH 4.4 02/33] PM / devfreq: Propagate error from devfreq_add_device()
Date: Wed, 21 Feb 2018 13:44:45 +0100
Message-Id: <20180221124409.695872290@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014614609921492?=
X-GMAIL-MSGID: =?utf-8?q?1593014614609921492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Andersson <bjorn.andersson@linaro.org>

commit d1bf2d30728f310f72296b54f0651ecdb09cbb12 upstream.

Propagate the error of devfreq_add_device() in devm_devfreq_add_device()
rather than statically returning ENOMEM. This makes it slightly faster
to pinpoint the cause of a returned error.

Fixes: 8cd84092d35e ("PM / devfreq: Add resource-managed function for devfreq device")
Cc: stable@vger.kernel.org
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -583,7 +583,7 @@ struct devfreq *devm_devfreq_add_device(
 	devfreq = devfreq_add_device(dev, profile, governor_name, data);
 	if (IS_ERR(devfreq)) {
 		devres_free(ptr);
-		return ERR_PTR(-ENOMEM);
+		return devfreq;
 	}
 
 	*ptr = devfreq;
