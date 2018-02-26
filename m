Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224LT29bDpDIDzGZ9Dep8zdykXJeS8mS5kAQNnyik5XsdGLGXfxT3YKZKvuimzU0PMEJba5Z
ARC-Seal: i=1; a=rsa-sha256; t=1519676788; cv=none;
        d=google.com; s=arc-20160816;
        b=Bz4znkWB5nRcRufvPPoHcaEE8CZEkDOqmuwHBjWi3h2XH6/CSuSvfCK9v+5jw6DEKz
         jU8HMQMRoCVfF2sd68GvbzVFKvpKzBrk2fv63hpeKAY8gocWHJjALvBOeKgHKC7nXyiC
         doqpW20OWBbqckgtzv0to88gq4DLVduCRrz3yurK8T+AjiQfqlkQvIucjEZw1jrHv1HH
         l9p96sz5lUz3D1zLvBX0XIg8JqLUfQ8+dwt+Ta+Ax5saHysneC8K+lchBuNqBmyFklro
         7ELa6qZGmavNMue4XYSRSjF4Mxj4l7hUVu2RjLnhoND7UFuxye5Qb84Ml4cOc80VMtVr
         eIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5HTJbw1GXF9zWZNfbQ8FzRB327TVgK0HY+ZcwzVIFy0=;
        b=PNiIE8KbORo0hW4ttd/Ra7uiPtOmvBXnMUIeMPbE/uQ4r/rJPPbsSNybW9tc/4SzbW
         LVaLBSURjlo0/d/UdwLY/egpS1MozKvxm7RlOLYGJVAxSAoEvdO9eeeDrb+1Ddc54Dge
         DgPpbGdt8OwBZwX1q3WO/k+x81KVWMcbP6mSJQ59ywgk9xchAEVuv+uve5SMDcG+9Xf1
         T6ULvhZNyqIwlKuhpDwStMLhTe5CwIcvPnvz9JAAbkE/8PCpQquzSeZgPFGMaHNs3oan
         XRj7MdJcRKN1rHteqmHlwa+XmvUBxOU7DSGm5Fr0dAEBMniVbSBeEbBxcoKZwgUcQ7m9
         orFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yuriy Vostrikov <delamonpansie@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4.15 16/64] genirq/matrix: Handle CPU offlining proper
Date: Mon, 26 Feb 2018 21:21:53 +0100
Message-Id: <20180226202154.136078662@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496608255303914?=
X-GMAIL-MSGID: =?utf-8?q?1593496608255303914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 651ca2c00405a2ae3870cc0b4f15a182eb6fbe26 upstream.

At CPU hotunplug the corresponding per cpu matrix allocator is shut down and
the allocated interrupt bits are discarded under the assumption that all
allocated bits have been either migrated away or shut down through the
managed interrupts mechanism.

This is not true because interrupts which are not started up might have a
vector allocated on the outgoing CPU. When the interrupt is started up
later or completely shutdown and freed then the allocated vector is handed
back, triggering warnings or causing accounting issues which result in
suspend failures and other issues.

Change the CPU hotplug mechanism of the matrix allocator so that the
remaining allocations at unplug time are preserved and global accounting at
hotplug is correctly readjusted to take the dormant vectors into account.

Fixes: 2f75d9e1c905 ("genirq: Implement bitmap matrix allocator")
Reported-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Yuriy Vostrikov <delamonpansie@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20180222112316.849980972@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/matrix.c |   23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -16,6 +16,7 @@ struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
 	unsigned int		managed;
+	bool			initialized;
 	bool			online;
 	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
 	unsigned long		managed_map[IRQ_MATRIX_SIZE];
@@ -81,9 +82,11 @@ void irq_matrix_online(struct irq_matrix
 
 	BUG_ON(cm->online);
 
-	bitmap_zero(cm->alloc_map, m->matrix_bits);
-	cm->available = m->alloc_size - (cm->managed + m->systembits_inalloc);
-	cm->allocated = 0;
+	if (!cm->initialized) {
+		cm->available = m->alloc_size;
+		cm->available -= cm->managed + m->systembits_inalloc;
+		cm->initialized = true;
+	}
 	m->global_available += cm->available;
 	cm->online = true;
 	m->online_maps++;
@@ -370,14 +373,16 @@ void irq_matrix_free(struct irq_matrix *
 	if (WARN_ON_ONCE(bit < m->alloc_start || bit >= m->alloc_end))
 		return;
 
-	if (cm->online) {
-		clear_bit(bit, cm->alloc_map);
-		cm->allocated--;
+	clear_bit(bit, cm->alloc_map);
+	cm->allocated--;
+
+	if (cm->online)
 		m->total_allocated--;
-		if (!managed) {
-			cm->available++;
+
+	if (!managed) {
+		cm->available++;
+		if (cm->online)
 			m->global_available++;
-		}
 	}
 	trace_irq_matrix_free(bit, cpu, m, cm);
 }
