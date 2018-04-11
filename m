Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeDKNML (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752901AbeDKNMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:12:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF732178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Wed, 11 Apr 2018 09:12:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "John 'Warthog9' Hawley" <warthog9@kernel.org>,
        Satoru Takeuchi <satoru.takeuchi@gmail.com>
Subject: [for-next][PATCH] ktest: Take submenu into account for grub2 menus
Message-ID: <20180411091207.2a84493a@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Another old patch from my INBOX.

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
for-next

Head SHA1: 6cd110a91f52197e3392809cd43466bfe2c524d0


Satoru Takeuchi (1):
      ktest: Take submenu into account for grub2 menus

----
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---------------------------
commit 6cd110a91f52197e3392809cd43466bfe2c524d0
Author: Satoru Takeuchi <satoru.takeuchi@gmail.com>
Date:   Fri Sep 22 13:38:19 2017 +0900

    ktest: Take submenu into account for grub2 menus
    
    grub-reboot selects the submenu's first menuentry (title is "1>0") rather than ktest's
    menuentry (title is "2") by mistake.
    
    ===
    $ sudo cat /boot/grub/grub.cfg  | grep -E "^menuentry|^submenu"
    ...
    menuentry 'Ubuntu' --class ubuntu --class gnu-linux --class gnu --class os $menuentry_id_option '...' {
    ...
    submenu 'Advanced options for Ubuntu' $menuentry_id_option '...' {
    ...
    menuentry 'ktest' {
    ...
    ===
    
    Correct it by taking submenu entries into account in get_grub2_index().
    
    Link: http://lkml.kernel.org/r/87poaje4as.wl-satoru.takeuchi@gmail.com
    
    Signed-off-by: Satoru Takeuchi <satoru.takeuchi@gmail.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a14fc309d140..777388cc8221 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1872,7 +1872,7 @@ sub get_grub2_index {
 	    $grub_number++;
 	    $found = 1;
 	    last;
-	} elsif (/^menuentry\s/) {
+	} elsif (/^menuentry\s|^submenu\s/) {
 	    $grub_number++;
 	}
     }
