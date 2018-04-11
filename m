Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+7AZ4pseM7pFgtn1h33qQMG5WaUIS+FE6WtylsW4dJulGeGKUJBRGcgx5tiSDjbC0flosE
ARC-Seal: i=1; a=rsa-sha256; t=1523473417; cv=none;
        d=google.com; s=arc-20160816;
        b=U06eyKHqj3VZY/toA6FUYzOXpoVSHsP1dDBnMOqRFiL/URH2XMHH5mgSVOfajW7Tt5
         SwzHMlA1qRB1JGiLjahYwr9YlmvxsZJwqmkGH7t7X+jrB3VZqOVzwK0D/k+Fqlqt5vM1
         4KcY55OWdToSK8j+hYmmdRBB1ydwitDcgqeRNOULEZC5vddVLk7RDtPj7MD6GunmW0C2
         ivnC1B8bZrCZbEWW8UU3K1VJS5LsgX4rUqP0wi7I0Mk2LjGnzuVr6b4k+/zuRSwewJP3
         BjgfRbAtYVhwFMJPWu4Koy0AVyXNhNX6vurLqfWRQ6AfXQn62TbwGE3rAGo8I8PIU6nm
         TI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ztwnajaFLBAYbwbc0xWAFZJz3IPrEXDUcIWycZaAOg0=;
        b=eOB86wukiIzRYnRELurw/foMM7Jn6eHZjhX+Bj4N8nH/APrsWR9BKWl7a81hfG3Q0x
         mkg40iN+W9lh2W8J3bAbxlk7p3XwBw8FPzCDavBEGk5ETrv55FAp5+vcz/8UE2wTEseY
         /w5kghQIcSEltAVmdexJ8ZOZxA+hrgzekGo6cfUxE0H1EdhMfn5D3J+6UWibsbyp8Y09
         GV4xqvavM/D27IXgRs/myrQ1ihxFXa4pMEqkxZBtFnuQy/xEv5qPlqXPzZYCkfMfHQV6
         jlI75YCYu6OM/xoVW3GQSk2QwFVmflyaBmekGYhrX3QBb0qy1hvcasitgF7dSJnoElaq
         HvlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rakesh Pandit <rakesh@tuxera.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 213/310] nvme: fix hang in remove path
Date: Wed, 11 Apr 2018 20:35:52 +0200
Message-Id: <20180411183631.723699641@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597477662224806346?=
X-GMAIL-MSGID: =?utf-8?q?1597477662224806346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>


[ Upstream commit 82654b6b8ef8b93ee87a97fc562f87f081fc2f91 ]

We need to start admin queues too in nvme_kill_queues()
for avoiding hang in remove path[1].

This patch is very similar with 806f026f9b901eaf(nvme: use
blk_mq_start_hw_queues() in nvme_kill_queues()).

[1] hang stack trace
[<ffffffff813c9716>] blk_execute_rq+0x56/0x80
[<ffffffff815cb6e9>] __nvme_submit_sync_cmd+0x89/0xf0
[<ffffffff815ce7be>] nvme_set_features+0x5e/0x90
[<ffffffff815ce9f6>] nvme_configure_apst+0x166/0x200
[<ffffffff815cef45>] nvme_set_latency_tolerance+0x35/0x50
[<ffffffff8157bd11>] apply_constraint+0xb1/0xc0
[<ffffffff8157cbb4>] dev_pm_qos_constraints_destroy+0xf4/0x1f0
[<ffffffff8157b44a>] dpm_sysfs_remove+0x2a/0x60
[<ffffffff8156d951>] device_del+0x101/0x320
[<ffffffff8156db8a>] device_unregister+0x1a/0x60
[<ffffffff8156dc4c>] device_destroy+0x3c/0x50
[<ffffffff815cd295>] nvme_uninit_ctrl+0x45/0xa0
[<ffffffff815d4858>] nvme_remove+0x78/0x110
[<ffffffff81452b69>] pci_device_remove+0x39/0xb0
[<ffffffff81572935>] device_release_driver_internal+0x155/0x210
[<ffffffff81572a02>] device_release_driver+0x12/0x20
[<ffffffff815d36fb>] nvme_remove_dead_ctrl_work+0x6b/0x70
[<ffffffff810bf3bc>] process_one_work+0x18c/0x3a0
[<ffffffff810bf61e>] worker_thread+0x4e/0x3b0
[<ffffffff810c5ac9>] kthread+0x109/0x140
[<ffffffff8185800c>] ret_from_fork+0x2c/0x40
[<ffffffffffffffff>] 0xffffffffffffffff

Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")
Reported-by: Rakesh Pandit <rakesh@tuxera.com>
Tested-by: Rakesh Pandit <rakesh@tuxera.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2040,6 +2040,10 @@ void nvme_kill_queues(struct nvme_ctrl *
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
+
+	/* Forcibly start all queues to avoid having stuck requests */
+	blk_mq_start_hw_queues(ctrl->admin_q);
+
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
