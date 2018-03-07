Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuijRqTz0gzzh85nLJqOtxxMDvxjbDntkNIer11+HwlwJjxLPDpI3XQeAkGAckLZRQoNM/r
ARC-Seal: i=1; a=rsa-sha256; t=1520451746; cv=none;
        d=google.com; s=arc-20160816;
        b=q64BCTdYVaQFt4V26ICTeX4k9lOJ5CLVAuM4aFBfLJHQpSPaB+c4s4JeDLeRscheQN
         a2dpMN1TMWXnIb7cx9ENkCXDVxx/J8Y3sKGfh44byICndygyuaZB9/CXUWlMH/fYbLug
         KremJF30UIXSIvwytkzYFJVUreSP+4i2g94eR6jLTJENXRZ/mn2fs6jztucetNaA18hk
         LwcKnvLp5KZEL6SRrLouV4v8nmjq0hoL95xffrc4Pj0UTy+AhDo0AGjM82u/jn3Qd81h
         5CamOhxQI3Oyk904QbDju3BuzkEIcXpHLE4L+aXYU0nzf7UPpDNdtr6dcAlZLv3MnDg3
         Nexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=qSmODZiNXCQIDIzkivIqxV1AOxrH3CRUv1t9zpR3j4A=;
        b=nMpRlEInPFqsHFm7b9w5WBZhemC1oJeKVuoNblkh7e6mgqRaMFMb/9NlHO4oPHa/41
         sYyO2IsYThyweEcYEYuFJnoELxpeT5y4Zn9v0/J2RL6gORlx9TLDa3k2+qfLH/FI6YBD
         YY7uisCfS93q98O0isUExKMrxxuCzEItE0cGOXU7EQNrp01ywRWi07e0zk8XDuuYC+NF
         7QBmJctbt/zp6Qh1BKrzFy1XFo+De63dpUJSR3GvSJRdaQmtl3bh8JsQ0EGbD/pU0vH5
         mEqRWTXHkzCzdrC3LhapsfqrecYFKgD//RLqTrdoMnLhGEYIuzidNjGh4jASMNtYOa2S
         YkNQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dmitry Monakhov <dmonakhov@openvz.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.15 031/122] block: pass inclusive lend parameter to truncate_inode_pages_range
Date: Wed,  7 Mar 2018 11:37:23 -0800
Message-Id: <20180307191733.748254637@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309211053475507?=
X-GMAIL-MSGID: =?utf-8?q?1594309211053475507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 0bd1ed4860d0f5f836aa8371797689a3779d1bf5 upstream.

The 'lend' parameter of truncate_inode_pages_range is required to be
inclusive, so follow the rule.

This patch fixes one memory corruption triggered by discard.

Cc: <stable@vger.kernel.org>
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/ioctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -225,7 +225,7 @@ static int blk_ioctl_discard(struct bloc
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
-	truncate_inode_pages_range(mapping, start, start + len);
+	truncate_inode_pages_range(mapping, start, start + len - 1);
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
 }
