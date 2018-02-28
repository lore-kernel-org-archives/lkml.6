Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbeB1JUF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:20:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:5684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751894AbeB1JUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:20:03 -0500
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <apw@canonical.com>, <joe@perches.com>, <akpm@linux-foundation.org>
CC: <linux-kernel@vger.kernel.org>, Yisheng Xie <xieyisheng1@huawei.com>
Subject: [PATCH] checkpatch: avoid error report caused by syzbot
Date: Wed, 28 Feb 2018 17:10:18 +0800
Message-ID: <1519809018-1736-1-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot request to add his reported-by when fix the bug find by syzbot.
However, it will trigger a error when use checkpatch:

  ERROR: Unrecognized email address: 'syzbot+d7a918a7a8e1c952bc36@syzkaller.appspotmail.com'

For it include '+' in email and make regular expression works abnomal. Fix
it by adding check for syzbot.

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 scripts/checkpatch.pl | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d40403..19f3e26 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1075,7 +1075,11 @@ sub parse_email {
 	} elsif ($formatted_email =~ /(\S+\@\S+)(.*)$/) {
 		$address = $1;
 		$comment = $2 if defined $2;
-		$formatted_email =~ s/$address.*$//;
+		if ($address =~ /^syzbot.*\@syzkaller\.appspotmail\.com$/) {
+			$formatted_email = "";
+		} else {
+			$formatted_email =~ s/^($address).*$//;
+		}
 		$name = $formatted_email;
 		$name = trim($name);
 		$name =~ s/^\"|\"$//g;
-- 
1.7.12.4
