Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpC+5F1rrP4VCqtukhSx7Ma+hZSrAUowi5dx/FGmZ90d3+o3CqUcqKpnn+DJH/QVpAwx65x
ARC-Seal: i=1; a=rsa-sha256; t=1526280747; cv=none;
        d=google.com; s=arc-20160816;
        b=pZGpLkY0cr7yGGO4tmiFozU6wok7JT9FwJ1PebPth93iUGbX4edHVri0HZlNE1ES7N
         bigqOtFcTavSuypgbvkaiuidShEhiLm4ewi5RW9VFB8cIZ3drmN3Q02GsHuzGlOhsXDY
         ocmg5R6Mpe5PoHKQ0zMtC8sc9bbbaP9ON8JkSi1xLeKloMzRdFRIHNSL7inbkzox4TtF
         yPKW23UwLR1Ab4LjyFRoZ1sH4PbY7BCRU7Sw2fSNR1RRs7wNPkbc9WJhlDaA7V2tkkXB
         6RCCefEnUJETqrLqWdvvrOon+MUEaEoGfEzj4RokHgIg8DljvcUOVbGkEQVcpoDrVx4n
         F7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0xS1G9Z+cSJqol/Pxrb1BX4IP7/gH3yGa6chOtF3IFM=;
        b=N1MWoTMudcuQYZuUSNG4ycVFxMXQzSIJ10tUEyipXuBQpDgRl8t+1RFTqTTPphJ7Lj
         FA2EWKdg6AWWRmw0JT92TsqQF86Iyw7kZmBks2qVmb5I/lpEapZLb9Cf+xQYj/Mf/Hkw
         M8EmjhUYrTYWcSQ8VX42RAPNjfYQUs/Ub7vYvY0UJGbsLDpoAMa82oAlQnkMZ90v4CCN
         fO3AsAc6wWIIKkEn1VRedB1490MELZC9A0/xmkEsLU35iwlJTA+kmTqxGja8y0uVNe7/
         TiQ8XOi8Q2l/4Kz0UxyTliWKdfncIvUcrBfP5rUAbcC/WjQzasA4xAYYzXafsxCitm6r
         JnXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rLjPoB1Q;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=rLjPoB1Q;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Wei Fang <fangwei1@huawei.com>,
	Chao Yu <yuchao0@huawei.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 42/56] f2fs: fix a dead loop in f2fs_fiemap()
Date: Mon, 14 May 2018 08:48:47 +0200
Message-Id: <20180514064758.657859681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421360895982780?=
X-GMAIL-MSGID: =?utf-8?q?1600421360895982780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -721,7 +721,7 @@ static int __get_data_block(struct inode
 	if (!ret) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = map.m_len << inode->i_blkbits;
+		bh->b_size = (u64)map.m_len << inode->i_blkbits;
 	}
 	return ret;
 }
