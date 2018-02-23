Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeBWQMq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:12:46 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:44023 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbeBWQMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:12:45 -0500
X-Google-Smtp-Source: AH8x225ahZ80Sr5HTfED8d1RhO/oQw6Op1HkBMd6wPmbyzT8+lljVnd5XOPiKRJcPS3dwbqDmqBOSg==
Message-ID: <1519402362.55655.70.camel@gmail.com>
Subject: [PATCH] percpu: add a schedule point in pcpu_balance_workfn()
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Date: Fri, 23 Feb 2018 08:12:42 -0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

When a large BPF percpu map is destroyed, I have seen
pcpu_balance_workfn() holding cpu for hundreds of milliseconds.

On KASAN config and 112 hyperthreads, average time to destroy a chunk
is ~4 ms.

[ 2489.841376] destroy chunk 1 in 4148689 ns
...
[ 2490.093428] destroy chunk 32 in 4072718 ns

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 mm/percpu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/percpu.c b/mm/percpu.c
index 50e7fdf84055151d8c7e8bb220f7a73e96b7f3e4..d40dfb597ffce2656220257f0227219ab917135b 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1600,6 +1600,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
 			spin_unlock_irq(&pcpu_lock);
 		}
 		pcpu_destroy_chunk(chunk);
+		cond_resched();
 	}
 
 	/*
