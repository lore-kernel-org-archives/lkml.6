Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224XWhG6Lfal1atXVIUwOlcjSA9uZA2R9Go7jiDjOt45A7PTtghLrnrl00/TYaCnN8eJL/Iw
ARC-Seal: i=1; a=rsa-sha256; t=1519412216; cv=none;
        d=google.com; s=arc-20160816;
        b=xHQEJvtu3WJaWOYYAPsBjPvagTqSK7N2+yirb6MjKIeIl9ttNUdSr/18bshQpFN3ZD
         IZQmsumVacakupM2xVzIpGlgMJblG3pYjmQh8Z+radjX1PspOf8jej9GLir7olt8vd+G
         KmHLO4XMxQ6Qm5ATTJXYWhz3t3W/ZD1OtLtS6pkp13bBFiJw3B5LWe+Fbz1VcDVFskcM
         Vr4WyCOcQDMLV6Lwnl2k/0nrpi51fjw72rdijZz4xPAWy/+lPoQX27jncC1zJJTvz1NV
         0p4YZVwsr47oRz/k8gEI3Hm2OkvxvekF4JnSKdSOtJuf057O/AK/EE3VaQXCmvYP6NhN
         bB/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Z7yFbGI5tPSI/o7Ld7wGXEwxGc6HEZF3jZQ2MK+/Re8=;
        b=I8YIaXIBK9sTpu7m8KkaQKb2DU1rlHDnC1y9vvUkX/8g8Y0tm8hVusKatHTK3XgC3S
         CuBkL89u9sYJz+j2/KMIetRk4nTFa9npD19AVz5Pmxh4DKSUhisBUXOJbH38PQR7DBkE
         X3k+TuVCiASK0zQ10jD0FcYsDgsXtXDL9o7022/U1kpDxxD6xHEa8T7vyaE4jyi9vQA+
         ABYurT2YBoZeas7j3tTrHr1KQaTYPendViwJjOjKArZXWVOOUYz2fq5DhDZVbDC9TGKK
         wZVLhhwJIaGudQp/ixzQQoXgPLPmFLP8dq8zi/HW8vSgAqoUV1XlE9PFLRNFBG9FhdIG
         b9SA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@163.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 153/159] hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close
Date: Fri, 23 Feb 2018 19:27:41 +0100
Message-Id: <20180223170801.455391651@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593217634600506830?=
X-GMAIL-MSGID: =?utf-8?q?1593219184528991398?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 6e266610eb6553cfb7e7eb5d11914bd01509c406 ]

The driver may sleep under a spinlock.
The function call path is:
rr_close (acquire the spinlock)
  free_irq --> may sleep

To fix it, free_irq is moved to the place without holding the spinlock.

This bug is found by my static analysis tool(DSAC) and checked by my code review.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hippi/rrunner.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/hippi/rrunner.c
+++ b/drivers/net/hippi/rrunner.c
@@ -1381,8 +1381,8 @@ static int rr_close(struct net_device *d
 			    rrpriv->info_dma);
 	rrpriv->info = NULL;
 
-	free_irq(pdev->irq, dev);
 	spin_unlock_irqrestore(&rrpriv->lock, flags);
+	free_irq(pdev->irq, dev);
 
 	return 0;
 }
