Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtbwL+PW3y+YtgH3xp3vymHE5QcC2shUOk4diJ4XmnnrcOLY5uWxgox6Vg5vmxlypAf4tlv
ARC-Seal: i=1; a=rsa-sha256; t=1521800228; cv=none;
        d=google.com; s=arc-20160816;
        b=v55HyKxcmlp6/hm+2QZrcqPBTQDfeFygRLnYC+XCz+RU4DEQzRpfK3t84p2AqDJlpE
         1LRQzI41cZ5lTqTTWkyTgfUSlta0mUKeL76NVG0jLfIO18f9fqFUKDhjkR7Y8vzr0oKU
         //9pkeoyM8A2J9hs0eqksOg2F5Lc2hH5PiFl3uV/NqRfzthn/AV7NyTRreDlAeMyt/rC
         GmLfe3pCyqrQJegtoU2MWvBuqGk9ua0BzA5TKy+BtuMsqTO6r7XnMNiFLRTBWzuOEj22
         y+y4+oa4mK5vTNzQL3ksANCBd1Zf7OXpba+uSk2MEaKaNARZupMzBzOZ9N7sMUZvCeid
         brgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rm8aRQ3B0l5wriZ3QBLTlYRD5lzchp7S7Fj8OAhXFxA=;
        b=JgMuHErw3oYLAUJr4zqVZczAfI4hW7c2+r0cmvFA3cyCJF6zKLQreZI9A7Jo5TU608
         jQlGitbeNlQbyNbm7XudTC/PCLK/oTO1dgrHdiMLl+/+HHdwG8ykfAcYES+sD6CuHG1o
         mjYhq9W6pWfs5XO9gAQMpv4mYLNaDmas/NDhJiVzO4Obht1EpeHl5LmFgYa73E56G6/Y
         Ouisi46ixrihQe0wZiX/RDfPUo9wNiEubnPgMZfwoM/OiZWLJA40vfpml72vIqF71eOZ
         bKq5XgBv/vmCpthUFkluk5+e4c8pAyFot/x1TJGZAqO2xskE91OGIROr3MvddxhvmIbl
         9Kow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anton Vasilyev <vasilyev@ispras.ru>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 93/97] RDMA/ocrdma: Fix permissions for OCRDMA_RESET_STATS
Date: Fri, 23 Mar 2018 10:55:20 +0100
Message-Id: <20180323094202.680504261@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595722096549947834?=
X-GMAIL-MSGID: =?utf-8?q?1595723196733957889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>


[ Upstream commit 744820869166c8c78be891240cf5f66e8a333694 ]

Debugfs file reset_stats is created with S_IRUSR permissions,
but ocrdma_dbgfs_ops_read() doesn't support OCRDMA_RESET_STATS,
whereas ocrdma_dbgfs_ops_write() supports only OCRDMA_RESET_STATS.

The patch fixes misstype with permissions.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/ocrdma/ocrdma_stats.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
+++ b/drivers/infiniband/hw/ocrdma/ocrdma_stats.c
@@ -834,7 +834,7 @@ void ocrdma_add_port_stats(struct ocrdma
 
 	dev->reset_stats.type = OCRDMA_RESET_STATS;
 	dev->reset_stats.dev = dev;
-	if (!debugfs_create_file("reset_stats", S_IRUSR, dev->dir,
+	if (!debugfs_create_file("reset_stats", 0200, dev->dir,
 				&dev->reset_stats, &ocrdma_dbg_ops))
 		goto err;
 
