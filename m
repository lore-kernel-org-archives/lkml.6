Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeEVEZH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 00:25:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:51017 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVEZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 00:25:06 -0400
From: Chengguang Xu <cgxu519@gmx.com>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, dhowells@redhat.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] fs/affs: fix potential memory leak in option parsing
Date: Tue, 22 May 2018 12:24:25 +0800
Message-Id: <1526963065-21134-1-git-send-email-cgxu519@gmx.com>
X-Mailer: git-send-email 1.8.3.1
X-Provags-ID: V03:K1:NYtj1vKjUjRHqVWL/ibx/z3Fs3xQ3UMPAfdvATUUhMILJ/cszpW
 9F0USEbR+3E46I1ln5eGYIIas2paapj0b7Mc1KDBxrMv6ooNLp/4yQ6EnIgUfKIFcgUWnhV
 7WoaW59QI1bEq2QiRmPSkejfCsxuBSQx7r3GQQe8hIkO69RiSV7ic8NnA22l4IWEGlKtYnp
 +jGDW6Ge1yJAeEDY9ooaA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PTq92YDhiz8=:QgxHL5b8DVHK0Pf0OgzIqW
 pufYyHB/qilb2g2F1Mk8s44uXbqaZmL2GUTKQbrb7dcLoAAGaTzjmOhKyfnxKB/45A5qSZbU4
 OXTWZHEZA7OA2uNiqB/m9QPYF7A445kzUCLtNm63YMv9AG8LDy9FVwjGlmUwy2ih/YsR5U6t/
 lWJdVv8qIQ4UvbmJAL+2Co6Ax8KNBy4PVXV9zuLUs3HvMDvV9GiRkxW3ItZOCf170HMUUJnlJ
 t9kcV3nrH+y7VrNNf53qfsUwtpV+QjIVaROC0bMd06j8m0dqtnhFfqQiz5QZccVobuyB5YcTZ
 0dmyCluS+8MTT73wnqVlfIHF8dskfyIquwMpBGNLE/hbI1PCzNTiyBK38rZ2zCN3dlE+G7l5C
 5zBhAUPDJiYWKWPlcrUGy/l2/NzKw76ZXp8nQ4ByXwCWzErUXdLadzzAP1c9thVc9StFExxgG
 uXNTuK4z/F444EJMiKU9pcqdiMrZnpRjaBkZb7SR3hWUnlKTYZXZObDpbJdHf2wuVlDm95r3L
 j3vcue5Jvf7A9vT0jQcjdxjavG32D75S+q5tSXuENHm6mDSZkXnWor7oz5gfYyrDDTRjZZA18
 niTM9mNazNyu0xNnnqHSCHGhdxQCCxQy5KB1H65jPXNlw76/7E6f6+OmHKEVGjFLuy+AA/ZA0
 OItYEVze3K42stCq8RZh2eEbTRubORmTqQ+fKtktYf69TNIzkB9soLxsUcvMmfCg9JskYWowd
 D/XqGAlYPc//we3UcrPTg6uoF39E2TMbwsUdhoea20f1PD97MGDQQqlXorA=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When specifying option 'prefix' multiple times,
current option parsing will cause memory leak.
Hence, call kfree for previous one in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/affs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index e602619..d1ad11a 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -241,6 +241,7 @@ enum {
 			affs_set_opt(*mount_opts, SF_NO_TRUNCATE);
 			break;
 		case Opt_prefix:
+			kfree(*prefix);
 			*prefix = match_strdup(&args[0]);
 			if (!*prefix)
 				return 0;
-- 
1.8.3.1
