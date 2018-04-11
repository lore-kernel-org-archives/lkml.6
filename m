Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Y2oGdOUcrUMsUpckaG3+rhD0rFyxTBsTRVjGIjwPtDpEits403xO2j5kCSlC15YeyluAC
ARC-Seal: i=1; a=rsa-sha256; t=1523473135; cv=none;
        d=google.com; s=arc-20160816;
        b=qRdSeb9NfUGWS9hl1Rtn2BvZpw9v352tEqPcxdKL4XkCQpz5yiTmYwEkV5sJN71aAa
         P2V0WvUoVBx+rmUTgyxLbImrceHQsHVt0UCnDk1LaOLcLsTheB+n4IlFm7Yplzah0v1l
         CLyVvpowVFSoQVpXJ2cduggWEfKfNP9/FKUODbganlkh+LNfqS0mnAhb9gHceezzDwIK
         kGY56g77tvwDLK5q/MPyCx8QZe3MtOhUeFFEv4R0Eq8EMvPeE5u6RjvAE/dxWAfy4n8b
         ydVGGzSkN2xEhgyjq0kq2WILp+ri5fKoUdr8/uA0bZgtFOYaGFrc0TAEgmtkidaBOQwM
         oNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oKgNAqVgSgeQs8vlMoShhgSoji1fqdqJqULA/+ffijw=;
        b=P2nbhFoqPMYDvqzzuwnvCPAk/+4C5OJwzbeStst8STrmTFczOsujtXfQ7Si9TP0fmV
         23E4m7k/k8Rrj+7MPDgfZJsKO9BciTnMG7SIlY87NoPdzq2KAkTKNxtohpma4adpz7uc
         CboeCu7cSi88ko45yebps0WLizIx7lE1UGknlUdpngujiNDTREA9Ij0CE4Td1aJB/HmM
         bxaA0ynklbG7utbn0TGeiHEmRjbxbvLnk7tKG7tSph2MW/qNMMu3ElERyUjLRlQ+8/ZS
         NxdNKkCyhLcUkRH2BZpUlL2xWJRcKCAxFOJyQzPap8T0q5HEE7I6UeyUIim7xayaCABN
         lvNg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Eryu Guan <eguan@redhat.com>,
	Theodore Tso <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 107/310] ext4: fix off-by-one on max nr_pages in ext4_find_unwritten_pgoff()
Date: Wed, 11 Apr 2018 20:34:06 +0200
Message-Id: <20180411183626.810637061@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476154165929900?=
X-GMAIL-MSGID: =?utf-8?q?1597477366268068007?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eryu Guan <eguan@redhat.com>


[ Upstream commit 624327f8794704c5066b11a52f9da6a09dce7f9a ]

ext4_find_unwritten_pgoff() is used to search for offset of hole or
data in page range [index, end] (both inclusive), and the max number
of pages to search should be at least one, if end == index.
Otherwise the only page is missed and no hole or data is found,
which is not correct.

When block size is smaller than page size, this can be demonstrated
by preallocating a file with size smaller than page size and writing
data to the last block. E.g. run this xfs_io command on a 1k block
size ext4 on x86_64 host.

  # xfs_io -fc "falloc 0 3k" -c "pwrite 2k 1k" \
  	    -c "seek -d 0" /mnt/ext4/testfile
  wrote 1024/1024 bytes at offset 2048
  1 KiB, 1 ops; 0.0000 sec (42.459 MiB/sec and 43478.2609 ops/sec)
  Whence  Result
  DATA    EOF

Data at offset 2k was missed, and lseek(2) returned ENXIO.

This is unconvered by generic/285 subtest 07 and 08 on ppc64 host,
where pagesize is 64k. Because a recent change to generic/285
reduced the preallocated file size to smaller than 64k.

Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -429,7 +429,7 @@ static int ext4_find_unwritten_pgoff(str
 		int i, num;
 		unsigned long nr_pages;
 
-		num = min_t(pgoff_t, end - index, PAGEVEC_SIZE);
+		num = min_t(pgoff_t, end - index, PAGEVEC_SIZE - 1) + 1;
 		nr_pages = pagevec_lookup(&pvec, inode->i_mapping, index,
 					  (pgoff_t)num);
 		if (nr_pages == 0)
