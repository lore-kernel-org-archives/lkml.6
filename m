Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrBCroOsDTWQjjFsYP60khlN+w5EHIE+VGLn0HJNUa/iCgFzjVEqbCf3sZRU9daNhkWQa2O
ARC-Seal: i=1; a=rsa-sha256; t=1526280886; cv=none;
        d=google.com; s=arc-20160816;
        b=ShEaxYZEeDoQOzHRuuIw5W8KfKRQ4W00Zb2Uwk9p/JV/nlsJamZ7qdQa/DPTCvJ5We
         Y68InsyAS6cXVzCVD8gAMlSAJn4VA7OUewjhsSeWLXsqn9ZZjOZ7hbIwzIQ+vwq3Bwsl
         Fmnc4z4Z5jil8fUkNoyQbM5nRZHH7bMRFIuhFPpT5dvvyYiY5Nsxnq5/HeEPI6IwjEQg
         0sw2TQsR91JKYC4BdX50MhUPH6o+TSh74+UtQoRTj8l1K9gU46rID8A399DyPLVZGS8p
         PWIKzyQQz1uo2ls4xhIqRHX8Dq5GI/xUoGI3PldVE6A/qwEXCa9e6M9/KLyKONPOTEO7
         NW7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2rcgYRJj3e/rbwPQtJTUl/XMYV/LOvWMC5aty3oH9tU=;
        b=AzMhvxT7aHpePvjps6XUhQBFHTnAnfo0j+0LE8cPfNLKbebRlXT56CZCuByJqI++u6
         KK9wlPzScPw0D73obOeD5Dg7dmMVsFY3gFrUlJNXZRKUeI7hgrk1uqQXhAKeBRrTq93q
         cHhIwLrUT0XkBrXUCkV7cxMyM5+nC5zbrBhLJ0NaxSPZwM7gUx4uUJXpMNVf1JvrqItC
         Owq2It29hukoUyJnua66zMyi7zuvBt+0vUq6CLRl2DTEd8Ufz63eziBdobbP/KbRkWDy
         +yZCCf1azLvkSRGbKbapB7gggQtkFWkg8328ToT2ECK0clam3R0AQp/k/8MsBImAwocN
         VMuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=f3hdSNP3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=f3hdSNP3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Fang <fangwei1@huawei.com>,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.9 15/36] f2fs: fix a dead loop in f2fs_fiemap()
Date: Mon, 14 May 2018 08:48:49 +0200
Message-Id: <20180514064805.465108725@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421360895982780?=
X-GMAIL-MSGID: =?utf-8?q?1600421507104178818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <fangwei1@huawei.com>

commit b86e33075ed1909d8002745b56ecf73b833db143 upstream.

A dead loop can be triggered in f2fs_fiemap() using the test case
as below:

	...
	fd = open();
	fallocate(fd, 0, 0, 4294967296);
	ioctl(fd, FS_IOC_FIEMAP, fiemap_buf);
	...

It's caused by an overflow in __get_data_block():
	...
	bh->b_size = map.m_len << inode->i_blkbits;
	...
map.m_len is an unsigned int, and bh->b_size is a size_t which is 64 bits
on 64 bits archtecture, type conversion from an unsigned int to a size_t
will result in an overflow.

In the above-mentioned case, bh->b_size will be zero, and f2fs_fiemap()
will call get_data_block() at block 0 again an again.

Fix this by adding a force conversion before left shift.

Signed-off-by: Wei Fang <fangwei1@huawei.com>
Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -844,7 +844,7 @@ static int __get_data_block(struct inode
 	if (!ret) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = map.m_len << inode->i_blkbits;
+		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
 	return ret;
 }
