Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DCF20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DCF20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730894AbeICVww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:52:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeICVwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:52:51 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DF6CED18;
        Mon,  3 Sep 2018 17:31:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <stfrench@gmail.com>,
        Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 4.18 014/123] smb3: fill in statfs fsid and correct namelen
Date:   Mon,  3 Sep 2018 18:55:58 +0200
Message-Id: <20180903165720.091480695@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 21ba3845b59c733a79ed4fe1c4f3732e7ece9df7 upstream.

Fil in the correct namelen (typically 255 not 4096) in the
statfs response and also fill in a reasonably unique fsid
(in this case taken from the volume id, and the creation time
of the volume).

In the case of the POSIX statfs all fields are now filled in,
and in the case of non-POSIX mounts, all fields are filled
in which can be.

Signed-off-by: Steve French <stfrench@gmail.com>
CC: Stable <stable@vger.kernel.org>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsfs.c  |   18 ++++++++++--------
 fs/cifs/smb2ops.c |    2 ++
 fs/cifs/smb2pdu.c |    8 ++++++++
 fs/cifs/smb2pdu.h |   11 +++++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -209,14 +209,16 @@ cifs_statfs(struct dentry *dentry, struc
 
 	xid = get_xid();
 
-	/*
-	 * PATH_MAX may be too long - it would presumably be total path,
-	 * but note that some servers (includinng Samba 3) have a shorter
-	 * maximum path.
-	 *
-	 * Instead could get the real value via SMB_QUERY_FS_ATTRIBUTE_INFO.
-	 */
-	buf->f_namelen = PATH_MAX;
+	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) > 0)
+		buf->f_namelen =
+		       le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength);
+	else
+		buf->f_namelen = PATH_MAX;
+
+	buf->f_fsid.val[0] = tcon->vol_serial_number;
+	/* are using part of create time for more randomness, see man statfs */
+	buf->f_fsid.val[1] =  (int)le64_to_cpu(tcon->vol_create_time);
+
 	buf->f_files = 0;	/* undefined */
 	buf->f_ffree = 0;	/* unlimited */
 
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -567,6 +567,8 @@ smb3_qfs_tcon(const unsigned int xid, st
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_DEVICE_INFORMATION);
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
+			FS_VOLUME_INFORMATION);
+	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_SECTOR_SIZE_INFORMATION); /* SMB3 specific */
 	if (no_cached_open)
 		SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4046,6 +4046,9 @@ SMB2_QFS_attr(const unsigned int xid, st
 	} else if (level == FS_SECTOR_SIZE_INFORMATION) {
 		max_len = sizeof(struct smb3_fs_ss_info);
 		min_len = sizeof(struct smb3_fs_ss_info);
+	} else if (level == FS_VOLUME_INFORMATION) {
+		max_len = sizeof(struct smb3_fs_vol_info) + MAX_VOL_LABEL_LEN;
+		min_len = sizeof(struct smb3_fs_vol_info);
 	} else {
 		cifs_dbg(FYI, "Invalid qfsinfo level %d\n", level);
 		return -EINVAL;
@@ -4090,6 +4093,11 @@ SMB2_QFS_attr(const unsigned int xid, st
 		tcon->ss_flags = le32_to_cpu(ss_info->Flags);
 		tcon->perf_sector_size =
 			le32_to_cpu(ss_info->PhysicalBytesPerSectorForPerf);
+	} else if (level == FS_VOLUME_INFORMATION) {
+		struct smb3_fs_vol_info *vol_info = (struct smb3_fs_vol_info *)
+			(offset + (char *)rsp);
+		tcon->vol_serial_number = vol_info->VolumeSerialNumber;
+		tcon->vol_create_time = vol_info->VolumeCreationTime;
 	}
 
 qfsattr_exit:
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -1248,6 +1248,17 @@ struct smb3_fs_ss_info {
 	__le32 ByteOffsetForPartitionAlignment;
 } __packed;
 
+/* volume info struct - see MS-FSCC 2.5.9 */
+#define MAX_VOL_LABEL_LEN	32
+struct smb3_fs_vol_info {
+	__le64	VolumeCreationTime;
+	__u32	VolumeSerialNumber;
+	__le32	VolumeLabelLength; /* includes trailing null */
+	__u8	SupportsObjects; /* True if eg like NTFS, supports objects */
+	__u8	Reserved;
+	__u8	VolumeLabel[0]; /* variable len */
+} __packed;
+
 /* partial list of QUERY INFO levels */
 #define FILE_DIRECTORY_INFORMATION	1
 #define FILE_FULL_DIRECTORY_INFORMATION 2


