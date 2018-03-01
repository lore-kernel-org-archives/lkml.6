Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AG47ELuRzkXvXtuJjzLE8tOXjKB/ARPe7BVBUju1ekEesLiLRsnDoBDYcr8SctuhyzKnpWcCXocu
ARC-Seal: i=1; a=rsa-sha256; t=1519947154; cv=none;
        d=google.com; s=arc-20160816;
        b=ylclNVQfjil1UrPEoodDfCvQO3hKy0r2HMPakrv0N8UuVb4/pBverG4H+4TtdGNVbd
         iTnHaq3M+0Dr7JPzz8VdqDng/z7bdCCeaxYjQwnJl9e1Ge3AUXdw/5qo6awTVphKfq2C
         UOrt13OxS47wBVdKMaYgVR6EcqXNLBHFs2ZrA8CHEpKFDuIa+7hsF6fjWmFoUj3kOuX6
         QHq/4g6Iyn9KnSXhSKP2yTuZ1h/ryBr1rzjEHJ9WP2xQZZq9sbz6mbAPLPFO3/z+Ac8H
         GD53SfZ6gXqty1GnB5fS/xb9gmDEoojiC3hucEGU1jHHSqGzlP2n/DRkvqlj44OuyXxg
         RUdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=gauJiWygrG/6gr8IumLvJLQJ1wgjCv81Cf0pdz8wGuE=;
        b=yQboHzV6WEwAz3rU3pzjApTgWoZcfJ8OnNFJvqggZjOdeoGmbqh+P9XrxYZpMHVGCE
         Ez1eHeGG0ijBVPbwe3yDRyneEzMefasbmXJZ84vCkSo5BU6dqocxzxH3MCH3oVYytZym
         WH5zxtyoUbRh+7yr0VGnz9soLyHJnP9jT91LuCeFuXQGVeU7VOXsMa6sKqOO8yu/2RqG
         LqF8yW4RH6M4GCDQvRauyiNwrpVMA8Rc1AgurQ118sXMpTTqzQ1Nikcbn7J7ju9+6Nv5
         xg8xl7rUlg6WLk5E/RbBFzjcVb7FKqpm2rH4VYxog3Ybaoizr1hdckoALwMGxaDHQtT1
         jyxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 02 Mar 2018 10:31:25 +1100
Subject: [PATCH 03/17] staging: lustre: statahead: remove incorrect test on
 agl_list_empty()
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <151994708514.7628.7094184804431206060.stgit@noble>
In-Reply-To: <151994679573.7628.1024109499321778846.stgit@noble>
References: <151994679573.7628.1024109499321778846.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593780107647480528?=
X-GMAIL-MSGID: =?utf-8?q?1593780107647480528?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Including agl_list_empty() in the wait_event_idle() condition
is pointless as the body of the loop doesn't do anything
about the agl list.
So if the list wasn't empty, the while loop would spin
indefinitely.

The test was removed in the lustre-release commit
672ab0e00d61 ("LU-3270 statahead: small fixes and cleanup"),
but not in the Linux commit 5231f7651c55 ("staging: lustre:
statahead: small fixes and cleanup").

Fixes: 5231f7651c55 ("staging: lustre: statahead: small fixes and cleanup")
Signed-off-by: NeilBrown <neilb@suse.com>
---
 drivers/staging/lustre/lustre/llite/statahead.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/llite/statahead.c b/drivers/staging/lustre/lustre/llite/statahead.c
index 6052bfd7ff05..ba00881a5745 100644
--- a/drivers/staging/lustre/lustre/llite/statahead.c
+++ b/drivers/staging/lustre/lustre/llite/statahead.c
@@ -1124,7 +1124,6 @@ static int ll_statahead_thread(void *arg)
 	while (thread_is_running(sa_thread)) {
 		wait_event_idle(sa_thread->t_ctl_waitq,
 				sa_has_callback(sai) ||
-				!agl_list_empty(sai) ||
 				!thread_is_running(sa_thread));
 
 		sa_handle_callback(sai);
