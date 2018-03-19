Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtB0UEY//1TJL3azW0WmoIxN6FM6vABvXMWnO6Sc64XG4ixk6DYGkZfcL9nc7mo0NAD4v0n
ARC-Seal: i=1; a=rsa-sha256; t=1521483298; cv=none;
        d=google.com; s=arc-20160816;
        b=o3pnaJo8uvgn5RdCJj6goPgUbz/ua0+CspgNZi/r9+eaZqmdNuJzQOsWGpbeuVxgf+
         WRWtZ3W03UA100sxiPQqZLYnZM/HDqbOfRtGxa87zgB4C8/yBuwtH9KFK13rGk4RzNPN
         YTZn7lxF7qtoFcDzp0t929pAQnSz7Mgqmg6h09vXTTOJvb0Pfl2Pm3ECq/90RNOAYm/a
         YVMNG3q0WcqwPIQjUTJzit3wl3Y86Obs0jYn/Ifv6DHDxpqPdb7yWuAWL+v2yKwP5AKj
         dfhtKeQsqkBFWwIYpBBSG6XKsnfj/+F1FDeTZTRhq+y+J5ukY8MYMquOuxIFhiQM5ba5
         Xlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TKVyeHAURhW4yUSIHQCMUTM/yyfhOW94CZKUVdGhL4c=;
        b=PXMIskBgZYGd7I7WzNha5B4HMp4EErm6asQOfGO9IeLtfjnJ7kySP3Ip4sDdTawZhW
         6Gu86NVrprOvxIxakRTX4lVEKMQEwaVGgFhQpkyzVLzknz7wuSTp0buvIuPuPyX+nzLX
         hscJdYOuUfWVrV3j9BbRXBtJhBf43tHjmLDM2KQjkoDTzKvApKy/Oo2HuI9ev8PJnRwD
         ToyHtjVHihCaZeE+BXA5GG5MLXcfvQLxX4YLULUZvW2RYWtenkOSS0QBa3P8VdaxncNX
         hb2Ys5dUbprdMx4UJGHbBy7wIUO/t/hnE8Xblfemw3vzfk54aw2ehiyoE3TMx1GMHiPV
         bJRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yunlei He <heyunlei@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 039/134] f2fs: relax node version check for victim data in gc
Date: Mon, 19 Mar 2018 19:05:22 +0100
Message-Id: <20180319171854.987259946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390871217961883?=
X-GMAIL-MSGID: =?utf-8?q?1595390871217961883?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jaegeuk Kim <jaegeuk@kernel.org>


[ Upstream commit c13ff37e359bb3eacf4e1760dcea8d9760aa7459 ]

- has_not_enough_free_secs
node_secs: 0  dent_secs: 0  freed:0  free_segments:103  reserved:104

          - f2fs_gc
             - get_victim_by_default
alloc_mode 0, gc_mode 1, max_search 2672, offset 4654, ofs_unit 1

                - do_garbage_collect
start_segno 3976, end_segno 3977   type 0

                  - is_alive
nid 22797, blkaddr 2131882, ofs_in_node 0, version 0x8/0x0

                   - gc_data_segment 766, segno 3976, block 512/426 not alive

So, this patch fixes subtle corrupted case where node version does not match
to summary version which results in infinite loop by gc.

Reported-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/gc.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -522,8 +522,10 @@ static bool is_alive(struct f2fs_sb_info
 	get_node_info(sbi, nid, dni);
 
 	if (sum->version != dni->version) {
-		f2fs_put_page(node_page, 1);
-		return false;
+		f2fs_msg(sbi->sb, KERN_WARNING,
+				"%s: valid data with mismatched node version.",
+				__func__);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
 	}
 
 	*nofs = ofs_of_node(node_page);
