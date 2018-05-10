Return-Path: <dougso@me.com>
X-Google-Smtp-Source: AB8JxZox4WAdiwKQayvXxcToxk3gjihUgLRuReQbiIkWg7bTXMcC8RWk+cPX1r6Q5oiRdsVtM1QS
ARC-Seal: i=1; a=rsa-sha256; t=1525975638; cv=none;
        d=google.com; s=arc-20160816;
        b=gDxuXD34VXlqgmCF0TTyb7uwZiRcIAAUM5ROe7fSP+qm7jAjEjJaKlGknsWms2EzZ3
         O6fKp6vIyjEMRQtf40s/NyGgQ/h8vXKtnSEdLpEy3Qjzrk2svHtNldnr8wh353tgTKCW
         vGUWy7YnbNl+3zjXZ4WD1Mabs4JhgZcdNLve24KL/n63T96xygtPgt5nRWZlWtbSmHIH
         3zgzD65wh6ka7dc+jnQkWzME9P4Xrs00yv2dgnrZJBaUxTWrNY9F8HQFlknohc4w8DPf
         GBQxAAHPwVjY46ASyH62kS+hXkiOTdG7XrwRn5uM5Jv1p5f7nLEeBseBKBJf5pgoopDw
         9Haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=A9s7VzC9lTDDiddYsa5pKhZCZ88tSKei62dibdnOSgI=;
        b=Aymk+hvgf84t5ua+OI/KRv9TtmTT+SZqWsW+qMrehN/DFMVKS+wXMfwz2gcFYpLSj4
         OM9+FShHJ2Pe8aR/DR8edb73b6dcyg3uKGQghJwlihVF7iVxxQ3yLiqc9omY1xAcJKCB
         H8d0BH4K/Wj6EWx+2tuZhtsHaquXYGXNQD/vEcuXcipo18z4CSc4K0Qp3ZRmHtn3/nmD
         mqwGpAC0VIkN5aNDti0VbxdEZbbnxFo7ho1ZfHTXqLOUaQNE8YJn4ATjc+mApUyfMTj5
         Dk+oOeBIiGbbxqOHCUL5F3ByIjN62mbw9eyHHXZ5aV7Nofm+xLHlxORTa7CbvVFGLGSx
         dlfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=UZCg5Ke2;
       spf=pass (google.com: domain of dougso@me.com designates 17.172.80.96 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@me.com header.s=04042017 header.b=UZCg5Ke2;
       spf=pass (google.com: domain of dougso@me.com designates 17.172.80.96 as permitted sender) smtp.mailfrom=dougso@me.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=me.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-10_06:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805100169
From: Doug Oucharek <dougso@me.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>,
 Doug Oucharek <dougso@me.com>
Subject: [PATCH v2] staging: lustre: o2iblnd: Fix crash in
 kiblnd_handle_early_rxs()
Date: Thu, 10 May 2018 11:07:01 -0700
Message-id: <1525975621-4978-1-git-send-email-dougso@me.com>
X-Mailer: git-send-email 1.8.3.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600101431301672185?=
X-GMAIL-MSGID: =?utf-8?q?1600101431301672185?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Under upstream staging commit 5a2ca43fa54f561c252c2, the list handling
code in kiblnd_handle_early_rxs() got changed to list_for_each_safe().
That protects against the current thread from deleting the current entry
it is looking at. It does not protect against another thread from deleting
the next item in the list (which the tmp variable points to). The way this
routine holds then releases a lock opens the door to other threads doing
just that.

This patch reverts this commit on this routine.

Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9886
Fixes: 5a2ca43fa54f ("Staging: lustre: Iterate list using list_for_each_entry")
Signed-off-by: Doug Oucharek <dougso@me.com>
---
Change v2: Fixed list_entry parameter to be proper struct
Change v1: Initial Patch

 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
index 32fa8ca..47eb8b4 100644
--- a/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
+++ b/drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c
@@ -1965,13 +1965,14 @@ static int kiblnd_resolve_addr(struct rdma_cm_id *cmid,
 {
 	unsigned long flags;
 	struct kib_rx *rx;
-	struct kib_rx *tmp;
 
 	LASSERT(!in_interrupt());
 	LASSERT(conn->ibc_state >= IBLND_CONN_ESTABLISHED);
 
 	write_lock_irqsave(&kiblnd_data.kib_global_lock, flags);
-	list_for_each_entry_safe(rx, tmp, &conn->ibc_early_rxs, rx_list) {
+	while (!list_empty(&conn->ibc_early_rxs)) {
+		rx = list_entry(conn->ibc_early_rxs.next,
+				struct kib_rx, rx_list);
 		list_del(&rx->rx_list);
 		write_unlock_irqrestore(&kiblnd_data.kib_global_lock, flags);
 
-- 
1.8.3.1
