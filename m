Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvP8IwKtJ+jvqPtBicVqeS48c0hFaqLIbci7GQ3ikGkdeWWG40X74i5TO0mzOuxcOhOIQYq
ARC-Seal: i=1; a=rsa-sha256; t=1521800100; cv=none;
        d=google.com; s=arc-20160816;
        b=tACIu/ewID9YQQXaI+J+d62sQ+DbN3/xaVHGt7GtW86WWesQY1FMs2UC824RW9LbcD
         kxDzAdp6/wYC8596e5b6EXIqF75SMNEDgsAmHU8zrX795PfmWKQwD9e7aHkSQtruP8dy
         HRjPjo/vfTfbJVe1MvMFXSN18BPl+EO0tFNsKv8wtsGqPCKhB6F4hZsrS6ijjaBIPoOa
         DBj8MrdtFoH7AvwBCDgOhQsz2m0p/UDiGzffu3uS8tjLRfObS/Pg0joeLyXIIYCsPkPZ
         MObxXTa6cOfUH9XOXZ46dEQILOmng7sQ4RoecvmkPRwgA2zuqhDXv4Z+lIChux4uDfoe
         SecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hX/RHJxR7KJlHlNFcoDMZbfrpPsxpM8Lqz8e2AiE3as=;
        b=xDBsHMq+/8msXssDeIHU+9yr/QjyTj/wboL5iVJayDo76zRWuimLTFT6CBp5XbmlpZ
         gOZ4ITSL9ide+/4wKa1VFM00iPcGacQyLMZxvIZuRg5y3btLvvR3IOXOCE+aJLHS5GOA
         UCzAI0UPAB/9OvJqSvpmkDpjP2alJZtMgmUkC7n9+mJl1VO5kUrX1+a/6KKafPrccqZn
         /qIQJopLbvUM6kqDm1SMI9iRy9THmJ+8Hv+BxzcPtJ4TuYwIRnKvp8Z2EkaMK5U776YO
         GN38Qxf2kHZ0LML1yd2W0tBdMQDnPjxYeE6vw3zkPis9iUgLFoODpKNZqFOmz9kGqfFh
         cWbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maor Gottlieb <maorg@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Doug Ledford <dledford@redhat.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 34/97] IB/mlx4: Take write semaphore when changing the vma struct
Date: Fri, 23 Mar 2018 10:54:21 +0100
Message-Id: <20180323094159.597716749@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722537979467705?=
X-GMAIL-MSGID: =?utf-8?q?1595723062516579607?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maor Gottlieb <maorg@mellanox.com>


[ Upstream commit 22c3653d04bd0c67b75e99d85e0c0bdf83947df5 ]

When the driver disassociate user context, it changes the vma to
anonymous by setting the vm_ops to null and zap the vma ptes.

In order to avoid race in the kernel, we need to take write lock
before we change the vma entries.

Fixes: ae184ddeca5db ('IB/mlx4_ib: Disassociate support')
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/main.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx4/main.c
+++ b/drivers/infiniband/hw/mlx4/main.c
@@ -1041,7 +1041,7 @@ static void mlx4_ib_disassociate_ucontex
 	/* need to protect from a race on closing the vma as part of
 	 * mlx4_ib_vma_close().
 	 */
-	down_read(&owning_mm->mmap_sem);
+	down_write(&owning_mm->mmap_sem);
 	for (i = 0; i < HW_BAR_COUNT; i++) {
 		vma = context->hw_bar_info[i].vma;
 		if (!vma)
@@ -1059,7 +1059,7 @@ static void mlx4_ib_disassociate_ucontex
 		context->hw_bar_info[i].vma->vm_ops = NULL;
 	}
 
-	up_read(&owning_mm->mmap_sem);
+	up_write(&owning_mm->mmap_sem);
 	mmput(owning_mm);
 	put_task_struct(owning_process);
 }
