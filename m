Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvmIeYrEWPicwPAsbc1eCe2HXIv/ed46F3Bv3V/isIKFvEDb1WhbVVU3/xG5LJe8n7zhYl6
ARC-Seal: i=1; a=rsa-sha256; t=1521800318; cv=none;
        d=google.com; s=arc-20160816;
        b=EVt0XIKmSIQp1xGBL3JE78DXVevBbE2XdLIfzIe9IWkwTvhyxUpihJkBLzOQxnQFVn
         XeX66UeybWEhAC4NTG8nApo6KeXPIYWf3EuKk39saBpi2ELl+/bHznViQpsvVjITfiK0
         ZkAcYKa/yHHp1CzxhPOnmt/IjMLrCJ8TL0siEHB4SbYsRdO+icoudjf07p3e1f9NBlvB
         rF5IbLYqij6ZNdFAaKL/Nvim5y1Ku4xfXbbSs2lF2twWsclY5cSN1iHx5/+usPyRdap+
         aBv2KofHwobHi+t70h1JNxvicPZst3jlgWFKqLvrcacFLlViNqnrxkU6TSKYyYJCT0Pf
         Cr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yV5tbDZaFiqafDeqqGCB/nioDY+3wRT3LN4iP/keS1Q=;
        b=H6rXQ1J+mA59xMquxzD/MF5kZhxNitzgMZ8Ip/B7YMTp+r120KN1t+AkhI9EBedx1U
         tWYO7g6+7k5g61rddnku4DZx//8AbcrZ7OQc0Pvgcz28OeSabNMGIv8Ey70yNLKWm52d
         1tm4aI6LmscgKR77e1eF/ZDZWfNwR3CEc7EzdOr8xBle5vqnj3HNjpoUNa8AYN2DRXbv
         l8qyV3Q2pfcIg3F9kIFSycLEf7wFrxGLmCLMd8h0dD4OitoAnRGU4VqZW3jIQq0mPkXy
         8a3ypjrowZPyUSjKyCyBZYtEfOyh8zsR/WEzcZX3OD9NwkddMfmvrTdKbEQg6oq/MOiN
         pSAw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	rtc-linux@googlegroups.com,
	alexandre.belloni@free-electrons.com,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 02/47] x86: i8259: export legacy_pic symbol
Date: Fri, 23 Mar 2018 10:54:53 +0100
Message-Id: <20180323094248.227501251@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
References: <20180323094248.117679641@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722426879921230?=
X-GMAIL-MSGID: =?utf-8?q?1595723290936633489?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 7ee06cb2f840a96be46233181ed4557901a74385 ]

The classic PC rtc-coms driver has a workaround for broken ACPI device
nodes for it which lack an irq resource. This workaround used to
unconditionally hardcode the irq to 8 in these cases.

This was causing irq conflict problems on systems without a legacy-pic
so a recent patch added an if (nr_legacy_irqs()) guard to the
workaround to avoid this irq conflict.

nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
an undefined symbol error if the rtc-cmos code is build as a module.

This commit exports the legacy_pic symbol to fix this.

Cc: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/i8259.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -405,6 +405,7 @@ struct legacy_pic default_legacy_pic = {
 };
 
 struct legacy_pic *legacy_pic = &default_legacy_pic;
+EXPORT_SYMBOL(legacy_pic);
 
 static int __init i8259A_init_ops(void)
 {
