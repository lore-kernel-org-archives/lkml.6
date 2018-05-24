Return-Path: <SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqvRJxd3R3XtiydGCmTcRdtRg37NHWyC8b7Dv54DQrhK7AdeeRk6ge4F9ebaNPK2YGOhonm
ARC-Seal: i=1; a=rsa-sha256; t=1527156297; cv=none;
        d=google.com; s=arc-20160816;
        b=j3cerRgeEt7QMxoKozpW6SY9dP3X6jYXT8F8oEjZUVcv/tv897AVn1/MYCjeyHznBc
         wJzsTFqZ1lyJ72HkZLIgPDg9SzI6H6u6FpraLnIVRz8jwfVXfz8sez7rxtn1+TXPZ8Ej
         pL+3P4yXIf9dEA8fqcjuP5UENhsz7d5kwrLH4eGNkn/NYoVjjJ0RhQna2GRcPGw5wVDf
         1yo8yPz1WepOSTK8wNRdosPcz/SCFOB0/Sd17bynTsPj0Wqzs2SjVgO4u1V+1mmKMpMe
         8Edmcg6Ce5asjNiU/8MQee98gszO7cUw3UhbS/AsA0JDG9U7+x724YKbkkavElJCiUZ6
         qKsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=CBWB/rqVhWjTJMIkFc/6SFsi8RZhNmupujmCiLqbkv8=;
        b=veP0G6ybVWdSwpRl8luR2/gGexRRWDv9jeuDwRa4lqXR2Xi6oI27n+ELCDWFn0nLGd
         rbPzxgR1uWAI3O0sykR4ynxvOenFnUmmeLid9WBAsg+AXwx4kBT3p8aUW51B/e/WVyBs
         sQ9kH7FH6yNXv7Pm951daowjOf9ZAQktvIMDE1SlHoLjQjaeo6goHe49F5M59/fMxHSv
         UXzXDSyNaPp6S44nuiWz68gqNZ3l+Il2bxWtlaQDx08ZrtAfwlQ7VlWcHEcB/5p5b2/A
         x3R5KW1jhnCkE1DPmp834Ukq+ykPIdrwm9ESU4PmbG48F30cp70Mow311YEUBukuWmLs
         9TMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E0T7Ja1f;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=E0T7Ja1f;
       spf=pass (google.com: domain of srs0=we5z=il=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=We5Z=IL=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gary R Hook <gary.hook@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 100/161] crypto: ccp - dont disable interrupts while setting up debugfs
Date: Thu, 24 May 2018 11:38:45 +0200
Message-Id: <20180524093030.391952472@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601338837902762497?=
X-GMAIL-MSGID: =?utf-8?q?1601339441509772512?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 79eb382b5e06a6dca5806465d7195d686a463ab0 ]

I don't why we need take a single write lock and disable interrupts
while setting up debugfs. This is what what happens when we try anyway:

|ccp 0000:03:00.2: enabling device (0000 -> 0002)
|BUG: sleeping function called from invalid context at kernel/locking/rwsem.c:69
|in_atomic(): 1, irqs_disabled(): 1, pid: 3, name: kworker/0:0
|irq event stamp: 17150
|hardirqs last  enabled at (17149): [<0000000097a18c49>] restore_regs_and_return_to_kernel+0x0/0x23
|hardirqs last disabled at (17150): [<000000000773b3a9>] _raw_write_lock_irqsave+0x1b/0x50
|softirqs last  enabled at (17148): [<0000000064d56155>] __do_softirq+0x3b8/0x4c1
|softirqs last disabled at (17125): [<0000000092633c18>] irq_exit+0xb1/0xc0
|CPU: 0 PID: 3 Comm: kworker/0:0 Not tainted 4.16.0-rc2+ #30
|Workqueue: events work_for_cpu_fn
|Call Trace:
| dump_stack+0x7d/0xb6
| ___might_sleep+0x1eb/0x250
| down_write+0x17/0x60
| start_creating+0x4c/0xe0
| debugfs_create_dir+0x9/0x100
| ccp5_debugfs_setup+0x191/0x1b0
| ccp5_init+0x8a7/0x8c0
| ccp_dev_init+0xb8/0xe0
| sp_init+0x6c/0x90
| sp_pci_probe+0x26e/0x590
| local_pci_probe+0x3f/0x90
| work_for_cpu_fn+0x11/0x20
| process_one_work+0x1ff/0x650
| worker_thread+0x1d4/0x3a0
| kthread+0xfe/0x130
| ret_from_fork+0x27/0x50

If any locking is required, a simple mutex will do it.

Cc: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/ccp-debugfs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/crypto/ccp/ccp-debugfs.c
+++ b/drivers/crypto/ccp/ccp-debugfs.c
@@ -278,7 +278,7 @@ static const struct file_operations ccp_
 };
 
 static struct dentry *ccp_debugfs_dir;
-static DEFINE_RWLOCK(ccp_debugfs_lock);
+static DEFINE_MUTEX(ccp_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
@@ -290,16 +290,15 @@ void ccp5_debugfs_setup(struct ccp_devic
 	struct dentry *debugfs_stats;
 	struct dentry *debugfs_q_instance;
 	struct dentry *debugfs_q_stats;
-	unsigned long flags;
 	int i;
 
 	if (!debugfs_initialized())
 		return;
 
-	write_lock_irqsave(&ccp_debugfs_lock, flags);
+	mutex_lock(&ccp_debugfs_lock);
 	if (!ccp_debugfs_dir)
 		ccp_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
-	write_unlock_irqrestore(&ccp_debugfs_lock, flags);
+	mutex_unlock(&ccp_debugfs_lock);
 	if (!ccp_debugfs_dir)
 		return;
 
