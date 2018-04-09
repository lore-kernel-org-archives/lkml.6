Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbeDIOZW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 10:25:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49870 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751862AbeDIOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 10:25:20 -0400
Date: Mon, 9 Apr 2018 16:25:17 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        syzkaller-bugs@googlegroups.com,
        syzbot+6bd77b88c1977c03f584@syzkaller.appspotmail.com
Subject: Re: [PATCH?] reiserfs: prevent panic: don't allow %-char in journal
 dev. name
Message-ID: <20180409142517.qrorcyng6puk4qed@quack2.suse.cz>
References: <d9b518a5-287a-72b3-05f1-ea89e25563ba@infradead.org>
 <20180404184517.9f2b91b856a56f71464f5f7f@linux-foundation.org>
 <5e9ea36a-6a6a-921c-81b3-bc623a9e125a@suse.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3boyrbnt6apoxgr5"
Content-Disposition: inline
In-Reply-To: <5e9ea36a-6a6a-921c-81b3-bc623a9e125a@suse.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3boyrbnt6apoxgr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed 04-04-18 21:48:53, Jeff Mahoney wrote:
> On 4/4/18 9:45 PM, Andrew Morton wrote:
> > On Wed, 4 Apr 2018 18:25:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> If the reiserfs mount option's journal name contains a '%' character,
> >> it can lead to a WARN_ONCE() in lib/vsprintf.c::format_decode(),
> >> saying: "Please remove unsupported %/ in format string."
> >> That's OK until panic_on_warn is set, at which point it's dead, Jim.
> >>
> >> To placate this situation, check the journal name string for a '%'
> >> character and return an error if one is found. Also print a warning
> >> (one that won't panic the kernel) about the invalid journal name (e.g.):
> >>
> >>   reiserfs: journal device name is invalid: %/file0
> >>
> >> (In this example, the caller app specified the journal device name as
> >> "%/file0".)
> >>
> > 
> > Well, that is a valid filename and we should support it...
> > 
> > Isn't the bug in journal_init_dev()?
> 
> Yep.  That's exactly it.
> 
> Acked-by: Jeff Mahoney <jeffm@suse.com>

Thanks. I've picked up the patch from Andrew, added his Signed-off-by (OK,
Andrew?), wrote a proper changelog and pushed it to my tree. The result is
attached.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--3boyrbnt6apoxgr5
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-reiserfs-Fix-warning-for-non-existing-journal-device.patch"

>From 121724c8bb9d5c07ee12718520f6f99b0da0a275 Mon Sep 17 00:00:00 2001
From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 9 Apr 2018 16:17:44 +0200
Subject: [PATCH] reiserfs: Fix warning for non-existing journal devices

When a journal device specified as part of mount options does not exist,
reiserfs issues a warking like:

	reiserfs_warning(super,
			 "journal_init_dev: Cannot open '%s': %i",
			 jdev_name, result);

Now this misses a parameter 'id' of reiserfs_warning() which comes
second. As such, the format string is interpreted as an ID and jdev_name as
a format string resulting in funny issues.

Fix the problem by adding missing 'id' argument.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Jeff Mahoney <jeffm@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 70057359fbaf..23148c3ed675 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -2643,7 +2643,7 @@ static int journal_init_dev(struct super_block *super,
 	if (IS_ERR(journal->j_dev_bd)) {
 		result = PTR_ERR(journal->j_dev_bd);
 		journal->j_dev_bd = NULL;
-		reiserfs_warning(super,
+		reiserfs_warning(super, "sh-457",
 				 "journal_init_dev: Cannot open '%s': %i",
 				 jdev_name, result);
 		return result;
-- 
2.13.6


--3boyrbnt6apoxgr5--
