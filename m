Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/+TXsIq70xmbZTJpVVhpu2QzdQwuD4+d0HMUZkdBVTCc8MnwwG2HQqDtMSZlw+kdYpWxu
ARC-Seal: i=1; a=rsa-sha256; t=1519676541; cv=none;
        d=google.com; s=arc-20160816;
        b=AMVA1N4Db7asksSKDg9x0nvXCvbfsGIrsOHcMl3IEzwol9r8QUQ79yD7BM3JuyBDlz
         Ez2TG5wGxPihTcRKtwsqD3kroOMcJj2Ybn+2m77hFgGDustccVPkdKmwJQpQ3W2qw/yj
         PT6slDVnNNFhvAJlMyYbM4OyctWZNZ+jTC9N1VEuFruRClYgcZyx5m6qLhzBH3zIPSfh
         lIKnZPVovZPb6lzwhckrx4wsESi6eUErIgiahN2QttePuwA4NrKGf/4Wcw8ngKaBHOPQ
         682bEaXJ1lwl76tS1jNLDN98J/iATGczodO252clk5MwYfgCiEC8S6Z/cduyybFVUivC
         iGiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KubXiy3v81fUhrGUGSfbbFRuAocxrRjCuo+nZKv+4ng=;
        b=adlhzF+b60zLxpQlRI/3db6o0NtPuL1mwMqti4+RZmbvVyx55vbCGxzLtJUuhND0N7
         opgUYRH+hVLnQPagMU19yPBXIQJljdWYuBGltB3w0s+Lwf8Qae1aLIEyCJlJb1CZsiH+
         pEjEY/J5YuX7E529RTgLnrP/V9ZpYFsup4KC608UmaJzTsIab4cynz6zRRZFI002MBa0
         Cq/e/YsQ2p4QJvLPL/9JAq93ny1cTS3r0rPN4EBRjTEHtC4dMSSoF7Qso9cUo2NA7pDl
         dIXEEuiiCiR3RCrOkSUpqpWYDT6AOc/tFZTSZZ9iwmeTexXyqrhZd/ZGrZZRRyWzJuGS
         xsFw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Ross Zwisler <ross.zwisler@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 30/39] fs/dax.c: fix inefficiency in dax_writeback_mapping_range()
Date: Mon, 26 Feb 2018 21:20:51 +0100
Message-Id: <20180226201644.994652037@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496349085817871?=
X-GMAIL-MSGID: =?utf-8?q?1593496349085817871?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Kara <jack@suse.cz>

commit 1eb643d02b21412e603b42cdd96010a2ac31c05f upstream.

dax_writeback_mapping_range() fails to update iteration index when
searching radix tree for entries needing cache flushing.  Thus each
pagevec worth of entries is searched starting from the start which is
inefficient and prone to livelocks.  Update index properly.

Link: http://lkml.kernel.org/r/20170619124531.21491-1-jack@suse.cz
Fixes: 9973c98ecfda3 ("dax: add support for fsync/sync")
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dax.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -785,6 +785,7 @@ int dax_writeback_mapping_range(struct a
 			if (ret < 0)
 				return ret;
 		}
+		start_index = indices[pvec.nr - 1] + 1;
 	}
 	return 0;
 }
