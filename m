Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49cA9xVEcySmXfuT9vXjMy60elWLbYErZ7G1JYhe15BZGS/Vee9/jwF0ba79GTWhI3aipAD
ARC-Seal: i=1; a=rsa-sha256; t=1523981045; cv=none;
        d=google.com; s=arc-20160816;
        b=g/WlsXeGHx/72q9vnzn4NWwK0U8yEpFBHc87Z7pY408YMEOODX1aMUeUuB+Sy2zUDQ
         jRCK+fmIUw0eMr1tCZ1UxQcDIGpN8LkGJRr06dmuD5+SkfdM7jnuiapfGTti7Mh/zXLi
         BvQhcfApp48deycFqxvLfw8jkm64O9Bt7dz8Cqkv7vl3RzDYB/VVBW1jg5rSgKDCXJjU
         ZEwho22csNbP2SOspfjEQvirlvApQut4Cfqb7/LJSyCYhsyYkoRrurQPueNLP9uWPPA5
         BAwryPt7olHgRhVKHSPQCOOEnqM2A7HBT1Jdi4jXOEJMzbveIRbncRKIXTV7LPfEdPbe
         AiDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6ByJdTLNipgIbcuBNYEvOUl0h4nY4YIByPRjefCN1oo=;
        b=oxhyA3OFRkoHk03sWmnhI8P2xKas1v0imKDusa9p6T4X/FzHvyW53HYp/EMO70Y0wB
         e/Ty/9HejgARzBzrXZn3XCi3dFO64FQiDLIXvW/KHlZgFnShacGC/yl+A2UZ8J9gztaN
         4seL2f56AL/xyM1btPJHa8p4ui+j9cvw/DzzfgDKalhzkMazlcxXImZfmZbyl1a2HgY+
         VZNztRlPGpP54RvfxOV3irZ1z+fRZumlTFYnEryDD27pMlhepwO+Rkmmr/IdqDYQqFmU
         7syMjUvgcGtgCg9RhZMttJZ0wiEUnDAqPaYioGNawU7ZhCHyPLcT+RQQ6AsNoThIsTSw
         xsgw==
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
Subject: [PATCH 4.15 27/53] f2fs: fix heap mode to reset it back
Date: Tue, 17 Apr 2018 17:58:52 +0200
Message-Id: <20180417155724.487207079@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009767226616026?=
X-GMAIL-MSGID: =?utf-8?q?1598009948735957975?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2155,7 +2155,8 @@ static unsigned int __get_next_segno(str
 	if (sbi->segs_per_sec != 1)
 		return CURSEG_I(sbi, type)->segno;
 
-	if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
+	if (test_opt(sbi, NOHEAP) &&
+		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
 		return 0;
 
 	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
