Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZrPzk9dG9ZRSro63xJohT0kiLTIi0ryfOrVyAnU5HMMGT2ojsEbM7NvT05V49ZVr5T/7Gzc
ARC-Seal: i=1; a=rsa-sha256; t=1526472329; cv=none;
        d=google.com; s=arc-20160816;
        b=KSDdImaJAutgSb0nXvgiDBDB3kM522QnSKOzCsw2OgoLppfGgFPMEJ4HfdgLJNU+PA
         QP0iv06QvRVe78fsqIgWCJYwB1CbAqPYDQ/tgzdIljXeBVrDeh1tBxoLkVxB4zIk1kws
         2vQoXdo5KjxFuTOF+sxcTaQnLL0e1Cz1/R4HRx7Sqt13/uCebH3GHCu4AmDJgMH3EyRf
         ORznIFTGARvpylilptU6vcVJt1jg+5jaQC0VeVZvXiTSzELSkVIoE0Bh7YIPl6tL02bV
         ejfwoMgcSeXwNi49D1h44KV0BG1itwQQLzUHl+2DwdhaXbxitBOKmYahVHkEY944YaJG
         8Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=k/1kmH/LuSTv/Z293DXOQwLWsrIIn+0dCTChTV7O98I=;
        b=Fwui5J20m4gZ9u37SXqKPXZSENpZYqYcx8eUon7kuv//X5M7DuIX97Qnc6RoBoOqcH
         H7N8XwgXrOAi7rpvpQbkNaBafoZhRhJoEusxKUCTFliBxctCjYLpCRSvQQLPZ+Mxkk3f
         wnF5w1L7El6elg0vO5+RX2O0W1Yec2BeoYRKwdU67qyqCpOK8L9nJ+GxmBpEleT+FuwZ
         ane+54nVfw6P6JnQ1Pf/JjPI4lomY6f0oJ51GwCNXqi+gzEsprlflI0l2ivpmyBe6ALr
         ml+R27JnNLZjxv+QyaGcjndr/07hQcsFNt15Tn1WfUeKRp36JQY1ahSOdy4m9/7QEbCt
         iNxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] return EINVAL error instead of BUG_ON()
Date: Wed, 16 May 2018 14:05:24 +0200
Message-Id: <20180516120527.29403-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538306192171209?=
X-GMAIL-MSGID: =?utf-8?q?1600622249539022912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch series makes driver_register() emit an error message and
return a failure code instead of triggering a BUG_ON().

The first patch will now print out the name of the faulty driver *and*
the name of the involved bus. The second patch records the error code
if bus_register() fails. The third and final patch of the series
extends the first patch so that the recorded error code is also print
out if non-zero. Otherwhise, if drv->bus->p is NULL but the error code
is zero, then probably bus_register() was never called before.

Florian Schmaus (3):
  driver-core: return EINVAL error instead of BUG_ON()
  driver-core: record error on bus registration
  driver-core: print bus registration error value

 drivers/base/bus.c     |  2 ++
 drivers/base/driver.c  | 14 +++++++++++++-
 include/linux/device.h |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.16.1
