Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227Vak2mKs83sFzdQPVzn7xk9QHw5s7kNJw4c5DDEj+mljLtZl3sWpgAv7uKe2fy9g0Srq/F
ARC-Seal: i=1; a=rsa-sha256; t=1517591384; cv=none;
        d=google.com; s=arc-20160816;
        b=ju0Zqsl4NrEUlca1JzutplfL86mqNRb+7Hp7KJoCLcphBVa7wAT11mlGQ2r23rz9xc
         D8opRKXuHzN5RXCNGsJIvwMxrkl/pv8zXXuJUon16pIpB/tDdVRv7X4igX3BnV8OtMZn
         +kMJI4uC5bHMSNX0lm/FqoOqBibSd2kcJfZu/5JB4rTP7EAIdwSjGh4zbd2QR+ifPTcD
         OcW+xWlE/YFZuYL6Sqfz642I5OpErIaPXe+R4L37kD1zHrvZ3Uf4Wh0U9AGrstKNnz/I
         x/Jt9AYi4vToiF7hnq+wSWHKxZmKpUyVbUE/ipQdlFfon8wrU8YU6cVAJdK1sLBq8Qhx
         f1Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Ynhb9djjyOF1A+Bd7L5lCYAF+iF3NM+4bNKZf1hpnpw=;
        b=nlyszrTjchmkarWUV7dLFwcY6qm0W5HOY+ZMs5kB9CvbG573Rbp3IwNUx9fplu9MLJ
         WGswETRtDwXc/+WuDp6C9Iti7etDGKssrLuQAdRNnWS86w73J+eRNH57uztj04i3ScRM
         meYih/kvC6GseIHZw4uZZ30aCd66XwDPnmIK8ujN5MSoQ91S3EpfW3rV49mn58OvaIf/
         Fg4nA20J+MPG+E5cJW6AjNf+W56jIixaGN8VGK25kTJdkjXPfdMwuO2TRaRE9IvAWVgq
         eGsCIB1oIZiZNLZZF6bzkvxt7TiZx2s1pa36ATh1Spvge5LNstf2jc6awTzt5RabauIs
         jhQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Liu Bo <bo.li.liu@oracle.com>,
	Guillaume Bouchard <bouchard@mercs-eng.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 033/156] Btrfs: bail out gracefully rather than BUG_ON
Date: Fri,  2 Feb 2018 17:56:54 +0100
Message-Id: <20180202140841.821186650@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309902845141119?=
X-GMAIL-MSGID: =?utf-8?q?1591309902845141119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>


[ Upstream commit 56a0e706fcf870270878d6d72b71092ae42d229c ]

If a file's DIR_ITEM key is invalid (due to memory errors) and gets
written to disk, a future lookup_path can end up with kernel panic due
to BUG_ON().

This gets rid of the BUG_ON(), meanwhile output the corrupted key and
return ENOENT if it's invalid.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reported-by: Guillaume Bouchard <bouchard@mercs-eng.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5500,6 +5500,14 @@ static int btrfs_inode_by_name(struct in
 		goto out_err;
 
 	btrfs_dir_item_key_to_cpu(path->nodes[0], di, location);
+	if (location->type != BTRFS_INODE_ITEM_KEY &&
+	    location->type != BTRFS_ROOT_ITEM_KEY) {
+		btrfs_warn(root->fs_info,
+"%s gets something invalid in DIR_ITEM (name %s, directory ino %llu, location(%llu %u %llu))",
+			   __func__, name, btrfs_ino(BTRFS_I(dir)),
+			   location->objectid, location->type, location->offset);
+		goto out_err;
+	}
 out:
 	btrfs_free_path(path);
 	return ret;
@@ -5816,8 +5824,6 @@ struct inode *btrfs_lookup_dentry(struct
 		return inode;
 	}
 
-	BUG_ON(location.type != BTRFS_ROOT_ITEM_KEY);
-
 	index = srcu_read_lock(&fs_info->subvol_srcu);
 	ret = fixup_tree_root_location(fs_info, dir, dentry,
 				       &location, &sub_root);
