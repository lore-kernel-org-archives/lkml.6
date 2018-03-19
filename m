Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsoW0PQa/BJQeR6qlMHDp58GyZHOS5SnTscmOwnJPG2NtbC5W+pUvSS3qbRYqaewGCNBlLR
ARC-Seal: i=1; a=rsa-sha256; t=1521484214; cv=none;
        d=google.com; s=arc-20160816;
        b=oT1Cz2DT4HR00IPDxmU1jXjHqBcnLkswD7u18fOTR69Izq+fxsvP23h1wi2KF3qcvb
         XSidglXIUjq9JEZwagD7lyihelmmMtH4FZn/RnKfDJOWt5cCKQqh4x/+ihUzJic4ZUY+
         RcAJ60j0O1Q4r5E8YuE6pDfuMOx+wZwmwJNitVM88qkPgxoFRY9i38Q9XhZDocQ55hx4
         5od7FUHJVBCKe+6smtHZ/3Vaxm2XU76Ac2mx6p9CsM2PLlI0CUcV2vaJftzWT7T8UBq9
         I1nBe5CkFTGG+LXd7hGvaT2Aa1H72cyHp969tvtZxxQCBbDikQQ69/gYz5hEZxXHGgjd
         R7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8CJN7NTR5WClvbjC8AJL/G5X5ZYkFP9URlxnrZnq9rg=;
        b=FdbXsaAsZ089fgV0I6cbOmKqxFUS0aNryFrZYGK2LO4PeYPr3l+LuHdRy+xau8aIXO
         eWPuKRF9C1bnxqbOomL/MsfAodN09u5I6XIoNk8UrCawzuQ1NFr8ENAQci4L0Hh7Z+wn
         asu0Jl5cnfcRdzdlQBXuS9MVJOgLNVbTEzc3tc7Nvza9StruM5LVn5ThSyE+0DA06P9c
         +MQ7NFYldBr7//hlrkp2cSF6Xtx3BicP/9Qbe1cER8XarHQaZ/yAS+xbOUMqWo/xgAeG
         P2i5LxtY+pfaBaUJL8Z53bfCTLccehKj8+Z0ooi+605OirmSmMHQm1DUsPeM3imtditr
         fIGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Edmund Nadolski <enadolski@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 31/41] btrfs: add missing initialization in btrfs_check_shared
Date: Mon, 19 Mar 2018 19:08:31 +0100
Message-Id: <20180319180734.271249639@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180732.195217948@linuxfoundation.org>
References: <20180319180732.195217948@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391831494126893?=
X-GMAIL-MSGID: =?utf-8?q?1595391831494126893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Edmund Nadolski <enadolski@suse.com>

commit 18bf591ba9753e3e5ba91f38f756a800693408f4 upstream.

This patch addresses an issue that causes fiemap to falsely
report a shared extent.  The test case is as follows:

xfs_io -f -d -c "pwrite -b 16k 0 64k" -c "fiemap -v" /media/scratch/file5
sync
xfs_io  -c "fiemap -v" /media/scratch/file5

which gives the resulting output:

wrote 65536/65536 bytes at offset 0
64 KiB, 4 ops; 0.0000 sec (121.359 MiB/sec and 7766.9903 ops/sec)
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128 0x2001
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1

This is because btrfs_check_shared calls find_parent_nodes
repeatedly in a loop, passing a share_check struct to report
the count of shared extent. But btrfs_check_shared does not
re-initialize the count value to zero for subsequent calls
from the loop, resulting in a false share count value. This
is a regressive behavior from 4.13.

With proper re-initialization the test result is as follows:

wrote 65536/65536 bytes at offset 0
64 KiB, 4 ops; 0.0000 sec (110.035 MiB/sec and 7042.2535 ops/sec)
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1
/media/scratch/file5:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..127]:        24576..24703       128   0x1

which corrects the regression.

Fixes: 3ec4d3238ab ("btrfs: allow backref search checks for shared extents")
Signed-off-by: Edmund Nadolski <enadolski@suse.com>
[ add text from cover letter to changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/backref.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -1496,6 +1496,7 @@ int btrfs_check_shared(struct btrfs_root
 		if (!node)
 			break;
 		bytenr = node->val;
+		shared.share_count = 0;
 		cond_resched();
 	}
 
