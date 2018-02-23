Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227oPRotflxQcQpn25tQz/N/K4B8cYdo+K6ceSBGW8I7xvbQRP2uI5iuD/DggH5jkrtsUivh
ARC-Seal: i=1; a=rsa-sha256; t=1519412188; cv=none;
        d=google.com; s=arc-20160816;
        b=wByvMhJ/H8W/D1hhuDhbjFWnuDUSVCsZ7S7FQuKDsVYWmJ9PY3UT9NGOtFlhb39ASy
         Aylwl0/rO/dSv38QValTkNPQz1E/b4fBSYSbNJwkoNJpYUI8ljYpmrQmuGn15WazsLCn
         9m7C3F+CALMNVb8Id/Hvf98JLoK2/TeMzHoDY0GcwnYYKbO2+YJS2hXYVSt8PYSmZM2g
         Hy320CCAt/MiIHaM+vURHuWL/rhl4t4p7VXlED65m3WRO3EzpPgBy6dqlKkgf2LZ0FqS
         RwKzOHuPaPmPjAM6mkiUpMO7h/ibPEt5ylCgkh6SKZ9mlqb4FgznMIXZHxitBD9YLb4r
         nh+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=UGQhDI+lIzmSQ4BJtubQH1yjOjK5wZ86vIKXf/y7b7g=;
        b=jcTM8Dvl4XatJ2ilPhfuwqQj8hkLxMbfjndG5G9YyZyqgHgDvYpaNZs/vSDVommt7G
         d+L+ddwCLzFR+Y+7xa2N1swH5a4DSYA3N7dNqYdpIZUPNrPx8yQo+DY9sVhRhgwMI8+L
         y0EnOLYWlYqIPDCXs2tceAY5ANKVaCCpeIGUUn4CbvIPxR8fNNZJ3b1tCHodiMcQ/PiS
         59SzgmxFdyRvy7OBQtoJmru/Y7Vt79jssuufybmlxXzlXNXQPZO+ttI4hAgC0b7wjYBN
         iOJ85DNz+5K+Yb0/lxdi63pV38Kd8fmhOODipLWCHHxZQs0ZM+q2V4+m1r9tpeAQI9uc
         6Ivw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Justin Maggard <jmaggard@netgear.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 118/159] btrfs: Fix quota reservation leak on preallocated files
Date: Fri, 23 Feb 2018 19:27:06 +0100
Message-Id: <20180223170757.587068442@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219155611912676?=
X-GMAIL-MSGID: =?utf-8?q?1593219155611912676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Maggard <jmaggard10@gmail.com>


[ Upstream commit b430b7751286b3acff2d324553c8cec4f1e87764 ]

Commit c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
changed the behavior of __btrfs_buffered_write() so that it first tries
to get a data space reservation, and then skips the relatively expensive
nocow check if the reservation succeeded.

If we have quotas enabled, the data space reservation also includes a
quota reservation.  But in the rewrite case, the space has already been
accounted for in qgroups.  So btrfs_check_data_free_space() increases
the quota reservation, but it never gets decreased when the data
actually gets written and overwrites the pre-existing data.  So we're
left with both the qgroup and qgroup reservation accounting for the same
space.

This commit adds the missing btrfs_qgroup_free_data() call in the case
of BTRFS_ORDERED_PREALLOC extents.

Fixes: c6887cd11149 ("Btrfs: don't do nocow check unless we have to")
Signed-off-by: Justin Maggard <jmaggard@netgear.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3016,6 +3016,8 @@ static int btrfs_finish_ordered_io(struc
 		compress_type = ordered_extent->compress_type;
 	if (test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->flags)) {
 		BUG_ON(compress_type);
+		btrfs_qgroup_free_data(inode, NULL, ordered_extent->file_offset,
+				       ordered_extent->len);
 		ret = btrfs_mark_extent_written(trans, BTRFS_I(inode),
 						ordered_extent->file_offset,
 						ordered_extent->file_offset +
