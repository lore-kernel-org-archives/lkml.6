Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZp3D2Y2txDg6EWQ4eLYa9prgcOFy+LNFhbtvTSS0LLj9fIwYw4qPppESox4EoNaYBF8WwTi
ARC-Seal: i=1; a=rsa-sha256; t=1524837620; cv=none;
        d=google.com; s=arc-20160816;
        b=n7pThMQ6UodP2B/VRiVOOoRCxNs9JCkSZpHer6aRKZCJFu1Xcwu2xnZQlg6p54Rpzm
         Ls5oGQe1aWabLAcmchVkzSsRDf1bP/lk+ZD4vTU9mvNge4jvRpNOWYnDa7gXCml5B5LD
         eZz7W1S/ktfpSRCH1TjY6+5e+LgyfCiEmrQQalVRgPTI/x7vjLkTDxJ+7Smh80zNVsD4
         O4oBJyXd5PeD+2k2dngpr/XM2G1Ca6jfiE3jozTH3ABzbtuOFL5bgAlsC9JNEtVCPELZ
         FRUmhuvVxjF2zBTF1zy4ky1IyBhjSUtxq+H7L1bCfbF84suw/DEC3wYBXCaret1L1ew5
         dYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/hBdTwQFFq92tpDTBR59Kh6LVMX5yCRpSOtI7ZWzqpg=;
        b=Heb0oa+FhHzPKrRPJ/koVGsiAxciOUicZMfw02BTrZ9zv6RVSoDFDGR6wTEAHbtemX
         zXihU3NQurJGdTt1iVYB5FVVn9GYSqv5lBJv8DjxhtlqAiFczyFpPYksIujxPtzZNB35
         T2UmaEMdxHAdfmBnu5KnYjAcGbGiWVII1wYd/GK8qWbowqs9gCd5T/TP5jtMt3ltKlII
         U4hrWNWgi0lwXs+3ZMv3C4XFyLTPxo0NfQOqUgswniBUfk1Qi0BDdgpmnyzDehYSq3a3
         oC2Q57urQMQ+SxxOSzdIicHwVmnwArTKHHYzDIeck9AP0Cj1AwCSvWrToGslvXkS2b8U
         P+ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFCE21894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	wangguang <wangguang03@zte.com>,
	Theodore Tso <tytso@mit.edu>,
	Nathan Chancellor <natechancellor@gmail.com>,
	Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 3.18 04/24] ext4: bugfix for mmaped pages in mpage_release_unused_pages()
Date: Fri, 27 Apr 2018 15:57:39 +0200
Message-Id: <20180427135631.764487030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
References: <20180427135631.584839868@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908132982127189?=
X-GMAIL-MSGID: =?utf-8?q?1598908132982127189?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: wangguang <wang.guang55@zte.com.cn>

commit 4e800c0359d9a53e6bf0ab216954971b2515247f upstream.

Pages clear buffers after ext4 delayed block allocation failed,
However, it does not clean its pte_dirty flag.
if the pages unmap ,in cording to the pte_dirty ,
unmap_page_range may try to call __set_page_dirty,

which may lead to the bugon at
mpage_prepare_extent_to_map:head = page_buffers(page);.

This patch just call clear_page_dirty_for_io to clean pte_dirty
at mpage_release_unused_pages for pages mmaped.

Steps to reproduce the bug:

（1） mmap a file in ext4
	addr = (char *)mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED,
	       	            fd, 0);
	memset(addr, 'i', 4096);

（2） return EIO at

	ext4_writepages->mpage_map_and_submit_extent->mpage_map_one_extent

which causes this log message to be print:

                ext4_msg(sb, KERN_CRIT,
                        "Delayed block allocation failed for "
                        "inode %lu at logical offset %llu with"
                        " max blocks %u with error %d",
                        inode->i_ino,
                        (unsigned long long)map->m_lblk,
                        (unsigned)map->m_len, -err);

(3）Unmap the addr cause warning at

	__set_page_dirty:WARN_ON_ONCE(warn && !PageUptodate(page));

(4) wait for a minute,then bugon happen.

Cc: stable@vger.kernel.org
Signed-off-by: wangguang <wangguang03@zte.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[nathanchance: Resolved conflict from lack of 09cbfeaf1a5a6]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1338,6 +1338,8 @@ static void mpage_release_unused_pages(s
 			BUG_ON(!PageLocked(page));
 			BUG_ON(PageWriteback(page));
 			if (invalidate) {
+				if (page_mapped(page))
+					clear_page_dirty_for_io(page);
 				block_invalidatepage(page, 0, PAGE_CACHE_SIZE);
 				ClearPageUptodate(page);
 			}
