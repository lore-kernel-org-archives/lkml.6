Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49V+tAm2WkYlhcklF4gALDO8Sh5PFbdMt9MA5tG2T8uBHXukDlMqQhgL5iUCbEQ+fnNktAz
ARC-Seal: i=1; a=rsa-sha256; t=1523981239; cv=none;
        d=google.com; s=arc-20160816;
        b=tjFwFT3N5e4/9OTEq0TC5ZEdHhuloqERAwJV9hP0Xue3pyV2w1k8gj9dbmO5bzeVI+
         ovjE/1Ek7YAtXYLNrekvJ1nL3fw/cIiK4BE63b51LB+7e7RVXuNcLatI2gSIltswc81E
         2zDH2eDrI+4GdxisA5FCWOMRgSwxOAwqZQgM1XzMZOpA1DcqOQVzVloLPWIc3iBV9Cf+
         5xlisP5p/5+4O/qdb6hSdLhLKDL18eVtKsm3z6bqDd58+G9zw0XTKeFg4vKq6NvXVJp5
         PqKQarQlrI1fcxobjJ4ymMotMldcIvNz9i28moY5HGpvlnieia9BQQWDW9z9fOXdHREj
         Gw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Lkq/mOT/QKPw9S2MpRqpt0CNtvcxM8Slp2RaKuUZkaM=;
        b=S6ynmN5H9FSmFvqdQytA2uo26kkLl9HQt4awDX7141fGLthKuSsjKXDuz1Sf7rlF0G
         KBtHNGNZ+rZm+dpjcJr80bPRLv9rv5dANowEr75jichQ4QPolxlYUMY0ZTUHIEWafwhI
         q6uD+RakJi5HHu8JhHRdTw5fy2cY+xniICbET/OsPX1FYcRj6Gf0eZnxzRkTOGq2k5pP
         tw5L0CGCZx17FmuNtbABR8thu06d6E2jDTcKhEZD7ZuTQDEkQVckIQm66Wf1ITiIgfFX
         MlDEdxyQbgKX+8yJSFbxV6WkQkq/rJN3Azl2C6LtI44j+b/6rQ6RG+xifmZqCYHAF9kb
         v0rg==
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
Subject: [PATCH 4.14 43/49] f2fs: fix heap mode to reset it back
Date: Tue, 17 Apr 2018 17:59:22 +0200
Message-Id: <20180417155717.090403971@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009767226616026?=
X-GMAIL-MSGID: =?utf-8?q?1598010151766351440?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1992,7 +1992,8 @@ static unsigned int __get_next_segno(str
 	if (sbi->segs_per_sec != 1)
 		return CURSEG_I(sbi, type)->segno;
 
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
