Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE7EC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0F820661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 21:57:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0F820661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbeLIVzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 16:55:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35342 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbeLIVzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:24 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72n-0002ij-9g; Sun, 09 Dec 2018 21:55:21 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72k-0003e9-F5; Sun, 09 Dec 2018 21:55:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Steve French" <stfrench@microsoft.com>,
        "Paulo Alcantara" <palcantara@suse.deR>,
        "Ronnie Sahlberg" <lsahlber@redhat.com>,
        "Aurelien Aptel" <aaptel@suse.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.952852973@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 291/328] smb2: fix missing files in root share
 directory listing
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

From: Aurelien Aptel <aaptel@suse.com>

commit 0595751f267994c3c7027377058e4185b3a28e75 upstream.

When mounting a Windows share that is the root of a drive (eg. C$)
the server does not return . and .. directory entries. This results in
the smb2 code path erroneously skipping the 2 first entries.

Pseudo-code of the readdir() code path:

cifs_readdir(struct file, struct dir_context)
    initiate_cifs_search            <-- if no reponse cached yet
        server->ops->query_dir_first

    dir_emit_dots
        dir_emit                    <-- adds "." and ".." if we're at pos=0

    find_cifs_entry
        initiate_cifs_search        <-- if pos < start of current response
                                         (restart search)
        server->ops->query_dir_next <-- if pos > end of current response
                                         (fetch next search res)

    for(...)                        <-- loops over cur response entries
                                          starting at pos
        cifs_filldir                <-- skip . and .., emit entry
            cifs_fill_dirent
            dir_emit
	pos++

A) dir_emit_dots() always adds . & ..
   and sets the current dir pos to 2 (0 and 1 are done).

Therefore we always want the index_to_find to be 2 regardless of if
the response has . and ..

B) smb1 code initializes index_of_last_entry with a +2 offset

  in cifssmb.c CIFSFindFirst():
		psrch_inf->index_of_last_entry = 2 /* skip . and .. */ +
			psrch_inf->entries_in_buffer;

Later in find_cifs_entry() we want to find the next dir entry at pos=2
as a result of (A)

	first_entry_in_buffer = cfile->srch_inf.index_of_last_entry -
					cfile->srch_inf.entries_in_buffer;

This var is the dir pos that the first entry in the buffer will
have therefore it must be 2 in the first call.

If we don't offset index_of_last_entry by 2 (like in (B)),
first_entry_in_buffer=0 but we were instructed to get pos=2 so this
code in find_cifs_entry() skips the 2 first which is ok for non-root
shares, as it skips . and .. from the response but is not ok for root
shares where the 2 first are actual files

		pos_in_buf = index_to_find - first_entry_in_buffer;
                // pos_in_buf=2
		// we skip 2 first response entries :(
		for (i = 0; (i < (pos_in_buf)) && (cur_ent != NULL); i++) {
			/* go entry by entry figuring out which is first */
			cur_ent = nxt_dir_entry(cur_ent, end_of_smb,
						cfile->srch_inf.info_level);
		}

C) cifs_filldir() skips . and .. so we can safely ignore them for now.

Sample program:

int main(int argc, char **argv)
{
	const char *path = argc >= 2 ? argv[1] : ".";
	DIR *dh;
	struct dirent *de;

	printf("listing path <%s>\n", path);
	dh = opendir(path);
	if (!dh) {
		printf("opendir error %d\n", errno);
		return 1;
	}

	while (1) {
		de = readdir(dh);
		if (!de) {
			if (errno) {
				printf("readdir error %d\n", errno);
				return 1;
			}
			printf("end of listing\n");
			break;
		}
		printf("off=%lu <%s>\n", de->d_off, de->d_name);
	}

	return 0;
}

Before the fix with SMB1 on root shares:

<.>            off=1
<..>           off=2
<$Recycle.Bin> off=3
<bootmgr>      off=4

and on non-root shares:

<.>    off=1
<..>   off=4  <-- after adding .., the offsets jumps to +2 because
<2536> off=5       we skipped . and .. from response buffer (C)
<411>  off=6       but still incremented pos
<file> off=7
<fsx>  off=8

Therefore the fix for smb2 is to mimic smb1 behaviour and offset the
index_of_last_entry by 2.

Test results comparing smb1 and smb2 before/after the fix on root
share, non-root shares and on large directories (ie. multi-response
dir listing):

PRE FIX
=======
pre-1-root VS pre-2-root:
        ERR pre-2-root is missing [bootmgr, $Recycle.Bin]
pre-1-nonroot VS pre-2-nonroot:
        OK~ same files, same order, different offsets
pre-1-nonroot-large VS pre-2-nonroot-large:
        OK~ same files, same order, different offsets

POST FIX
========
post-1-root VS post-2-root:
        OK same files, same order, same offsets
post-1-nonroot VS post-2-nonroot:
        OK same files, same order, same offsets
post-1-nonroot-large VS post-2-nonroot-large:
        OK same files, same order, same offsets

REGRESSION?
===========
pre-1-root VS post-1-root:
        OK same files, same order, same offsets
pre-1-nonroot VS post-1-nonroot:
        OK same files, same order, same offsets

BugLink: https://bugzilla.samba.org/show_bug.cgi?id=13107
Signed-off-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Paulo Alcantara <palcantara@suse.deR>
Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/cifs/smb2ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -743,7 +743,7 @@ smb2_query_dir_first(const unsigned int
 	}
 
 	srch_inf->entries_in_buffer = 0;
-	srch_inf->index_of_last_entry = 0;
+	srch_inf->index_of_last_entry = 2;
 
 	rc = SMB2_query_directory(xid, tcon, fid->persistent_fid,
 				  fid->volatile_fid, 0, srch_inf);

