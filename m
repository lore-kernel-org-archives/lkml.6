Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70503C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4096320661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4096320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeLIWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37260 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727929AbeLIWHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:07:49 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73G-0002ib-VG; Sun, 09 Dec 2018 21:55:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72c-0003MV-Kz; Sun, 09 Dec 2018 21:55:10 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@gmail.com>,
        "Steve French" <stfrench@microsoft.com>,
        "Aurelien Aptel" <aaptel@suse.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.428764261@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 116/328] smb3: fill in statfs fsid and correct namelen
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

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
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
[bwh: Backported to 3.16: Only use cifs_tcon::vol_{serial_number,create_time}
 if CONFIG_CIFS_SMB2 is enabled]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/cifsfs.c  | 18 ++++++++++--------
 fs/cifs/smb2ops.c |  2 ++
 fs/cifs/smb2pdu.c |  8 ++++++++
 fs/cifs/smb2pdu.h | 11 +++++++++++
 4 files changed, 31 insertions(+), 8 deletions(-)

--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -190,14 +190,18 @@ cifs_statfs(struct dentry *dentry, struc
 
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
+#ifdef CONFIG_CIFS_SMB2
+	buf->f_fsid.val[0] = tcon->vol_serial_number;
+	/* are using part of create time for more randomness, see man statfs */
+	buf->f_fsid.val[1] =  (int)le64_to_cpu(tcon->vol_create_time);
+#endif
+
 	buf->f_files = 0;	/* undefined */
 	buf->f_ffree = 0;	/* unlimited */
 
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -263,6 +263,8 @@ smb3_qfs_tcon(const unsigned int xid, st
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_DEVICE_INFORMATION);
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
+			FS_VOLUME_INFORMATION);
+	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_SECTOR_SIZE_INFORMATION); /* SMB3 specific */
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
 	return;
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2614,6 +2614,9 @@ SMB2_QFS_attr(const unsigned int xid, st
 	} else if (level == FS_SECTOR_SIZE_INFORMATION) {
 		max_len = sizeof(struct smb3_fs_ss_info);
 		min_len = sizeof(struct smb3_fs_ss_info);
+	} else if (level == FS_VOLUME_INFORMATION) {
+		max_len = sizeof(struct smb3_fs_vol_info) + MAX_VOL_LABEL_LEN;
+		min_len = sizeof(struct smb3_fs_vol_info);
 	} else {
 		cifs_dbg(FYI, "Invalid qfsinfo level %d\n", level);
 		return -EINVAL;
@@ -2650,6 +2653,11 @@ SMB2_QFS_attr(const unsigned int xid, st
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
@@ -946,6 +946,17 @@ struct smb3_fs_ss_info {
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

