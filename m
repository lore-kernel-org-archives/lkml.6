Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226IDq7IK/HZDeEV205z2RsxunyDuB3Az73p3GjZB7DLnml2vGr/HrgnotCM/+CMlzhY+DEM
ARC-Seal: i=1; a=rsa-sha256; t=1519218242; cv=none;
        d=google.com; s=arc-20160816;
        b=Nn2QVgD5XU7NasSPeD6ruFMNlTSkzLa5AGHaYuEe+9hmhKQmKUNffQI0c/+9whCFfn
         GqACi3eGM4ItTaAnRb7Oycd5EL1sKs3PagWGkwLb/pPacfmSX4ehqVRQrZw5ckyH2heD
         uTQz0fCocNzjIKq5+ZLR3ObI5ntxyvPEVyP9TqZe1tju4UGzeEmkQuHKIrrmzLTukQ85
         kjuRm7Mniy7lVFdyL1XUI22oWAnlE2+kC+MCI2E2+uE3Qhbh05rsFQq08klBm46oS1sv
         jbcmhGRd4Pu1Tb4V/5wpydd7OdZJC9AKBibNTdIeGlhaFn7geGE8LGsl/OgifUOb5Q9/
         /AGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=JhPCBpxQ4BgvlR7aB1vaUkNDOnVwFvzEXawlC+jZMGQ=;
        b=fKkr1Sy7+Ub7If2X+LD3DwTH1PWQqk0rwINspd1KoDgA2xNHoB4qxuqPJQt7SBVR3U
         uQaevT2ZLPc0Mw2dATop0BMh5yY/a4BpKr/9NPNVkMj8WybyWmQFSdLkhDXEehJEs8PT
         8vSL3kjqA+s5K7aXmOQIypjaSPUOHS7Yx6biCL6l8Sy22ijAO7rVlY6ToRdB1SuFL0Ah
         J7Q8HrkdyOFYN/V3NfbWtPdF2Iih8nOwAXpw5ufMUVlXVrBTlyXc6XQLcTWP/ZrHGM3L
         lJXGnKSJzmYiEK9n760OT3WLFcBho041hSrqhJ9Ol/SA9itYGefDfuQ9ovn+dvInyHO5
         1wEA==
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
Subject: [PATCH 4.14 136/167] Btrfs: fix extent state leak from tree log
Date: Wed, 21 Feb 2018 13:49:07 +0100
Message-Id: <20180221124532.067140822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015207747928649?=
X-GMAIL-MSGID: =?utf-8?q?1593015787630676548?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3047,13 +3047,14 @@ static void free_log_tree(struct btrfs_t
 
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
