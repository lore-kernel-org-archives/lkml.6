Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48d1+Z9G0yjiH5z044vR+Bnk3Jjt/saI38L65XnGshfnTC5QWraNWSuofbTA+CnrBU8ABKB
ARC-Seal: i=1; a=rsa-sha256; t=1524653052; cv=none;
        d=google.com; s=arc-20160816;
        b=KWJN9LUx0ODChfibwlOdALU9SXTSv7uG3BzNvlX9lZJTOk9Q4CX+IXG9HmvPyiu41q
         joB20EjeGdmsxOuEK3CU795a9zSEFOxBfBwgEKjfy30kd3iqybwQBtnX5v4IdwGrEFyq
         VDyG1X2D8Bx4NyM8VQuf5ambzJmW3QlANt+nvDoMjikS/lFQ4/WavesXQtQPbeg1Jf5f
         wGo2J24vElvCn5bYDl9TkVyVsbm4oq/CVxEgS+8Xc35qfe0NtrcTeNboqEy0SXJhWUJS
         fohomZxfhpkUfyd+HKgM8XVHf0PZzz1NIglcZyw6KHsK3Je1eTW3tPHvPMhMKEUk56eG
         UdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6g8ShGALBI6pXTnb+RhCWhlrCnAdB5RnX5ofIIGTpIA=;
        b=Mcg4eJtm2rix8m0eOgMZYfS3N1KjLaavplxuPHH1NGIQAxgPe2nxZ5eCHZYQj1eYfl
         jLwrgjEZh+WdVGHgRcE7K47xrZLVPdEY9+jmGFYJ1EzF+TlcG/X4BVMAQwWp+Z8ZeDy5
         dE9FebPqfbLtRsVfuKbj5EkJnOg2VHmC7dM0ryY5sa1OmDyO7ckSB/ii0LLDtySwfDec
         tiEDupJvk4EMMAXH2Zm4zj06RgKp4yWyotd1gBw1rI9WHFuOAJB5XH2QfHa3UjPm7zx6
         tNJAplyFrYXg+q/LgZe/me1JS/QGfTDSy+D8/FR4wZBVVCAEc7FdUktDNRdynf7TItnJ
         0BHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Will Deacon <will.deacon@arm.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 166/183] locking/qspinlock: Ensure node->count is updated before initialising node
Date: Wed, 25 Apr 2018 12:36:26 +0200
Message-Id: <20180425103249.190249869@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598714598684753909?=
X-GMAIL-MSGID: =?utf-8?q?1598714598684753909?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>


[ Upstream commit 11dc13224c975efcec96647a4768a6f1bb7a19a8 ]

When queuing on the qspinlock, the count field for the current CPU's head
node is incremented. This needn't be atomic because locking in e.g. IRQ
context is balanced and so an IRQ will return with node->count as it
found it.

However, the compiler could in theory reorder the initialisation of
node[idx] before the increment of the head node->count, causing an
IRQ to overwrite the initialised node and potentially corrupt the lock
state.

Avoid the potential for this harmful compiler reordering by placing a
barrier() between the increment of the head node->count and the subsequent
node initialisation.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1518528177-19169-3-git-send-email-will.deacon@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/locking/qspinlock.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -379,6 +379,14 @@ queue:
 	tail = encode_tail(smp_processor_id(), idx);
 
 	node += idx;
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
 	node->locked = 0;
 	node->next = NULL;
 	pv_init_node(node);
