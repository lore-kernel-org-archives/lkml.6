Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938654AbeE1MTV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:19:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422826AbeE1LCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 470/496] audit: return on memory error to avoid null pointer dereference
Date: Mon, 28 May 2018 12:04:15 +0200
Message-Id: <20180528100339.706632423@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Guy Briggs <rgb@redhat.com>

[ Upstream commit 23138ead270045f1b3e912e667967b6094244999 ]

If there is a memory allocation error when trying to change an audit
kernel feature value, the ignored allocation error will trigger a NULL
pointer dereference oops on subsequent use of that pointer.  Return
instead.

Passes audit-testsuite.
See: https://github.com/linux-audit/audit-kernel/issues/76

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
[PM: not necessary (other funcs check for NULL), but a good practice]
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/audit.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1058,6 +1058,8 @@ static void audit_log_feature_change(int
 		return;
 
 	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_FEATURE_CHANGE);
+	if (!ab)
+		return;
 	audit_log_task_info(ab, current);
 	audit_log_format(ab, " feature=%s old=%u new=%u old_lock=%u new_lock=%u res=%d",
 			 audit_feature_names[which], !!old_feature, !!new_feature,
