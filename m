Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49NaHRUsOfpGw9yJktfc/vh0wVRidb1nXG0Mt8eR3eK0Xgfqi6bMyGz7uQ5vLoOuHmWke8q
ARC-Seal: i=1; a=rsa-sha256; t=1524406765; cv=none;
        d=google.com; s=arc-20160816;
        b=1JyALIXCtTz00s5xfmXIuPzD1ytFIBZIF3+te+Rs+zQl0wXeDn1Ir2R+obhn+BZJEP
         nfNGL1fcPgevsiRs/4toJUyK4eDXYWnejFLDEWtQt0CMYR+soNFr0I0/z425GASBkU56
         2hTbCSdJJe21O7iYMm/OY3JFMh+VtQIje0iWF6dZPL3IwJFg2gSxoEkW86a9EHHznEE6
         hriYcdwcruhOs2JCNTaF9efHlHKDpU0rstor+3oY60fUiodeBTB5WvHPObvfL4e28M52
         bO/U3AXv/GESXatrBQw4tNiPssCfshk3stPlVU3SXnaThTJdZtmHrGIdLmlwJ4P36Dp7
         ULug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0bHJMxHrOdfJJHUQq5ppWSbgyqtfDOqCS/mtQz0wB3Y=;
        b=gwPHyUeYQM0uG1cP08a2wGEhQUkCUW2qzQ5Z4yVO+l9S0uB9lhvcQ153PIA/i8TssO
         vZeBqiHxO7FHH7ptXGQC+wrc/udX2h2kW5WVIer0sa4MAHBIgeLzRVk6bJWE81uaag/6
         BB3JeOVC2LOUr0675BxUs8jwUlBVJJUyA2/Qbnheh8FZaf7fG9l1fFKxj/+Jf6gYUVjb
         mhaa66E7Q7lcPnehF1cz5SRoaheUOBMx+50F3n9XKnmRRrd5haAHINz7SHNIIS3fqRcY
         RBL+3nB7IjbCeSvei0AQ+SrV5JAWgOTuMKWla4qseQgIzuwtCRBXNarr8W6Lv5niA68U
         Jf0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	wangguang <wangguang03@zte.com>,
	Theodore Tso <tytso@mit.edu>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.4 95/97] ext4: bugfix for mmaped pages in mpage_release_unused_pages()
Date: Sun, 22 Apr 2018 15:54:13 +0200
Message-Id: <20180422135310.354979867@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135304.577223025@linuxfoundation.org>
References: <20180422135304.577223025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598456348546351551?=
X-GMAIL-MSGID: =?utf-8?q?1598456348546351551?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[@nathanchance: Resolved conflict from lack of 09cbfeaf1a5a6]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1515,6 +1515,8 @@ static void mpage_release_unused_pages(s
 			BUG_ON(!PageLocked(page));
 			BUG_ON(PageWriteback(page));
 			if (invalidate) {
+				if (page_mapped(page))
+					clear_page_dirty_for_io(page);
 				block_invalidatepage(page, 0, PAGE_CACHE_SIZE);
 				ClearPageUptodate(page);
 			}
