Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520747781; cv=none;
        d=google.com; s=arc-20160816;
        b=wmjHQEno2Jf6GQSDpfB3YksKpOgNLxorOEs11bq+CI+xpCygFZTzMDAih/V8Vg4w9n
         TmAQX7xOIAN+a48grNu7gKT/BZ6HxdiIzNZCqNT6+z1Kp2dDLYTZUUirH7JELoLsPNPI
         +ojKG4nt5VruvJwBBChTLU9R6LDsWaVkhlNlgQjyn2RjVYZKB78MvQ739eth1Xk+UmOh
         +Q+y2a2BJr8mn9c+uV7YBDHhJxuDV9rHUD1c/sh30ZBUSY8jX3HBdYq9Wc/oSJxIU7Wf
         75RSuot7UJ57kVjGImDfDJQYygX6odQ7da4+ogREOVm84qvMPlrSHKPJ2GQy969Wl6R6
         wgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+jRf4YplOGJsxGXUj4lqthkuLQFZ4fbCe6fmVwdn3PY=;
        b=RD0MvBv6rCOITUnSBLYHAEbFKUg1A/tDolqyIrOk3/5agK+g2QAkrBLVx/4oKIy9j+
         PE36EKtfPCtkUixEy7LlHgIlZ+MaDs5PWXToyx+jnjAr98sahyoXTGcgN9YuNqLNxoPW
         GpxDpdXEwcf7WatiqA0B6TvwcZlwk3ud48mgzFOsKO6nPlk7LMFKc1oFO7xD4TcWnbav
         i+n5slgjCxmFodNM1KnQSfTv6uYc8e7NhoF6y+IAGvpg0g+fdJQZt3SHvxDkB3sSdT/B
         O23Dx0LokIKxVUrlXn6nNF5b2cwCTbOcZHTbtrstCmTfx7RZye5W5i5/DAnaILgYuasC
         N7hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fNWp/Fo1;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=fNWp/Fo1;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsJRba0YWGzR/WpWzKcwSTmTH8wbQyNSrdUzfpquKYmlwI5+exK/KsOOo9G/rF0vQSUeI7Tiw==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] driver core: cpu: use put_device() if device_register fail
Date: Sun, 11 Mar 2018 11:25:51 +0530
Message-Id: <4410a178df7ff0ea8f4b9a3639665c4f0386c3fe.1520747459.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
References: <cover.1520747459.git.arvind.yadav.cs@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594619625453678310?=
X-GMAIL-MSGID: =?utf-8?q?1594619625453678310?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/base/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index d21a2d9..2da998b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -382,8 +382,10 @@ int register_cpu(struct cpu *cpu, int num)
 	if (cpu->hotpluggable)
 		cpu->dev.groups = hotplugable_cpu_attr_groups;
 	error = device_register(&cpu->dev);
-	if (error)
+	if (error) {
+		put_device(&cpu->dev);
 		return error;
+	}
 
 	per_cpu(cpu_sys_devices, num) = &cpu->dev;
 	register_cpu_under_node(num, cpu_to_node(num));
-- 
2.7.4
