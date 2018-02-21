Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225tXyjztnwMYINN4Hst/SUrUEnStB/KdxzrsHV555ZKH/vQK0rtPWg7Yj6zGsDkIa93/QC3
ARC-Seal: i=1; a=rsa-sha256; t=1519217689; cv=none;
        d=google.com; s=arc-20160816;
        b=ie2lWoD3pg4+gVvfUZsifIf5pgQR2oY3Beod/LyfGd5DZoQppVJzQxkVpAPAXIWDCS
         bWzTasWHCQUfGJU1Hsu2dnseWDWtZXCrUuUysJv9XlwjjHN795vycmPTmUKE5P1wPdre
         LUStiNi99b9h3us50T4BmptWX6rVoBYtJWAWdhcy6SqtJ3V1GbjPZkm4yKV4qFgXu3Qs
         Oz++X/Hbjw8jp5hyoJyaMKeRidvz52rbiIpoqqVf3vB0EXf/DZ9DdCRk7RqKzaPmKliJ
         Mh0xda1W4jcIwYQg2n9f6qvbhpzKWsi42oNbqvqDIJkQLRqficZ6TfX4lIg9KAirCiqa
         2njA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+2wrC7Dc+0EiltFho6sq+CssfYQhm+9TyoqkkHCejy0=;
        b=b32f8nxgdwG5SP8R3sT5Vq8JuDsSJsaXDQLY2BTkmJId2jKyC+c+06Suqe26Ch+aYD
         xEgqkhkIIhoj4Zqi/s1h0JSCdMkpYJnRy4l/rRzzvbCVGpmrdJtVazVZpA78m8OyXJZA
         FOO+MbdqBqG+IZd+GlFsBLxh6Wm4HJSixdvNra5lc3Xva9AFUVZvXO8zphZi9MANBXLt
         IjQSdvtjka7gC5QkzO1zVxa+/9DCcCvV930A3qL6DnHB/ieuR5MLnrgHr2Cnjmo+Ges+
         6dhe+tccymvLS5XdIl7yOvfzlpthFTNfwxnMM4LpkHIZatj9fUrs8ktD+F9eSrf/w0OT
         bHqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 20/77] Btrfs: fix extent state leak from tree log
Date: Wed, 21 Feb 2018 13:48:29 +0100
Message-Id: <20180221124433.029399304@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015207747928649?=
X-GMAIL-MSGID: =?utf-8?q?1593015207747928649?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

commit 55237a5f2431a72435e3ed39e4306e973c0446b7 upstream.

It's possible that btrfs_sync_log() bails out after one of the two
btrfs_write_marked_extents() which convert extent state's state bit into
EXTENT_NEED_WAIT from EXTENT_DIRTY/EXTENT_NEW, however only EXTENT_DIRTY
and EXTENT_NEW are searched by free_log_tree() so that those extent states
with EXTENT_NEED_WAIT lead to memory leak.

cc: <stable@vger.kernel.org>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/tree-log.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3013,13 +3013,14 @@ static void free_log_tree(struct btrfs_t
 
 	while (1) {
 		ret = find_first_extent_bit(&log->dirty_log_pages,
-				0, &start, &end, EXTENT_DIRTY | EXTENT_NEW,
+				0, &start, &end,
+				EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT,
 				NULL);
 		if (ret)
 			break;
 
 		clear_extent_bits(&log->dirty_log_pages, start, end,
-				  EXTENT_DIRTY | EXTENT_NEW);
+				  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 	}
 
 	/*
