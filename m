Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030473AbeEYVeQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 17:34:16 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59679 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030403AbeEYVeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 17:34:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
        Chenbo Feng <fengc@google.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH, net-next 2/2] bpf: avoid -Wmaybe-uninitialized warning
Date: Fri, 25 May 2018 23:33:20 +0200
Message-Id: <20180525213331.2115471-2-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525213331.2115471-1-arnd@arndb.de>
References: <20180525213331.2115471-1-arnd@arndb.de>
X-Provags-ID: V03:K1:nvXbhged/p74c8JC1ib2clyM8v/J6YsPl6k6IyrPD+Duvhz8WOR
 6awQqZmeaSODxy6tlL43jRTO5Eh9y0afNgjY8EbgOsvqXBHqYyzmTo5kVaO1hiohzH+e8x5
 XwlSIejxV9KmxILz2UGGPPb+YWVO8PlEWVwV2olVLCbNpMJQUBG+VS6nSgIAjQ3obiKMnxl
 cld+nxmlIiQgWq45LIzIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EDWTd9JPXcI=:BI+G/XXennjVWjg8kX6A77
 IjCNbXqDayborfR+tU/59uEVtZDaGtEQY5n/NNk6vyKrlk5sCQyAOl7RW0OXZ2ubmkq7LfOEn
 /4fBLZ6yf+KL7r3tvDWdkyay03NKgBcoB1GzENxiWSxG5xo9CoFfwJgS0RLedzXXCqnjuk+m4
 gMnibZerCaf1s6HkFFo+VtxC7WuC3M/8Nx2girMpNZhI7CWEyeZC6DkiOl5XyiW9SSOvIookA
 kX1IMClHVLULCgu5vzVNwyjKfSf094SNAgM3gsPy/bjHrk+rWTQBeXiPmW2eCHoy4kJZzRjxy
 z9cgnN4KC/cZ7jjZEh2WCc37g0awsonFVV5nt8rD1/wjMQ4GXKzDpYssvwb64q0YDlc2d8UJB
 nNIRYKNwGQWPmLUgy8pTZvKDCe/q9Z/pfyDMAMBLqyyQIjBjvUD6+9iFcfTkBdQCfF2GyHiVo
 9kNl5hV+kDV+8SHHtnTw+Pr/CXsNxe0cZNQTdw0HDdP7GX0jWtjT073fjcIgX/2zVuXZY8yJW
 fTgYzez2DbjEKRe06iVX3jH0QNvoV5vEZItlksIImvhpQmdUuU578wtaIxj6fz2qWgQXYgyNk
 KZgtTKuyzS7bUrWC2v5epf+pH3aGKr39NsHD7TeWw+ec3TtxLbvl461tg+XGEkYmdNLdGt7NP
 3p61rtyp1psOX5BYYOWFscFzn/pMNx0Wqk1apwDGzSGbF4bVLI5nYr+c8A4aXHdoYcY8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stack_map_get_build_id_offset() function is too long for gcc to track
whether 'work' may or may not be initialized at the end of it, leading
to a false-positive warning:

kernel/bpf/stackmap.c: In function 'stack_map_get_build_id_offset':
kernel/bpf/stackmap.c:334:13: error: 'work' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This removes the 'in_nmi_ctx' flag and uses the state of that variable
itself to see if it got initialized.

Fixes: bae77c5eb5b2 ("bpf: enable stackmap with build_id in nmi context")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/bpf/stackmap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index b59ace0f0f09..b675a3f3d141 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -285,11 +285,10 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 {
 	int i;
 	struct vm_area_struct *vma;
-	bool in_nmi_ctx = in_nmi();
 	bool irq_work_busy = false;
-	struct stack_map_irq_work *work;
+	struct stack_map_irq_work *work = NULL;
 
-	if (in_nmi_ctx) {
+	if (in_nmi()) {
 		work = this_cpu_ptr(&up_read_work);
 		if (work->irq_work.flags & IRQ_WORK_BUSY)
 			/* cannot queue more up_read, fallback */
@@ -328,7 +327,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 		id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
 	}
 
-	if (!in_nmi_ctx) {
+	if (!work) {
 		up_read(&current->mm->mmap_sem);
 	} else {
 		work->sem = &current->mm->mmap_sem;
-- 
2.9.0
