Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48EGNXZ0TkGKO3+EuDA9ey82HRiRxtFwume+avcwNnaOLApAw6wfGseAfmf9RHBIhhQFU84
ARC-Seal: i=1; a=rsa-sha256; t=1523980872; cv=none;
        d=google.com; s=arc-20160816;
        b=gNESe+Z8Evb34ZQM0TkUEhe47YvuVioL8Jn7bgpk8Mcsix+puHA0lsZzi7bN9X47lU
         QJz7Llu/lhbeqMz4LDaFrWyN/z3dYJhsAe740721tOxPRRO/eAeqGL0QLpNeKbfhvEvy
         V98sDQ4l3f0DRk+6VUl6iNlkBbIRPwnd9/pJuZKlPAXTtL2hO2PKGTWkju+I9FpPlbgW
         c/3XKsUDrhp9Fr7iNMsnUrDrJE45WbD/d5iK2y1cFD2KWlfieec8Jc9XsNNS+I+GxNrp
         Jo/3zp6maxdXWrl1mlBXrD5R1bMkgi/hWiYrNriuX6tD+pK+AoqeF4DWSZegfG4TPgfT
         q/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Oh512x6NyJ2iSjxX+9X8XAqGnIdj/nH4bWApIkfCQNA=;
        b=vP6q5Xs5IX/h1ajZIsIjzBDrvC7BS3xSJ5fZqreWFj/x6XkSxxPVRYjFx5AxU/F/Wa
         7hwCELNYtEEiVFYSVjmbLzgKXIFWbfSqY1k90TrjDG6aZcnwBDKIb/1gFPGGrYo9oD3N
         7NHZz27brDkUI0aZUPeijEAzaJBnOIuk8SC0kgWrdKmH5OFy7pJiM7pht4trGdp9Tmn6
         nPXZd9wH/aPPVWMZH+r0KtpSVqistjudwUYV87Pa4DIzkYrMamRa2wJj/3VMJovOodRc
         zcsuYgZepW6O8oxBulz0cPhSjajzgZ3ZANZh7VuEz/NKFFMlLOF2EMAKYH27QmK/tFvC
         BHZg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yunlong Song <yunlong.song@huawei.com>,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.16 35/68] f2fs: fix heap mode to reset it back
Date: Tue, 17 Apr 2018 17:57:48 +0200
Message-Id: <20180417155750.765830011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009767226616026?=
X-GMAIL-MSGID: =?utf-8?q?1598009767226616026?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yunlong Song <yunlong.song@huawei.com>

commit b94929d975c8423defc9aededb0f499ff936b509 upstream.

Commit 7a20b8a61eff81bdb7097a578752a74860e9d142 ("f2fs: allocate node
and hot data in the beginning of partition") introduces another mount
option, heap, to reset it back. But it does not do anything for heap
mode, so fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/gc.c      |    5 +++--
 fs/f2fs/segment.c |    3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -191,8 +191,9 @@ static void select_policy(struct f2fs_sb
 	if (gc_type != FG_GC && p->max_search > sbi->max_victim_search)
 		p->max_search = sbi->max_victim_search;
 
-	/* let's select beginning hot/small space first */
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	/* let's select beginning hot/small space first in no_heap mode*/
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		p->offset = 0;
 	else
 		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2164,7 +2164,8 @@ static unsigned int __get_next_segno(str
 	if (sbi->segs_per_sec != 1)
 		return CURSEG_I(sbi, type)->segno;
 
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
