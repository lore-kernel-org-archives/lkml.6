Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrka8YE3DoQYyPWJp8ZmQIXVypbRAT8jZnYJ5gQ/EugqpB0ksUeB7sy3cyWc9kGMtm3TZ77
ARC-Seal: i=1; a=rsa-sha256; t=1526281111; cv=none;
        d=google.com; s=arc-20160816;
        b=Cwj5ByhOet8XIVZrsruAnX0Jpc6BO8gZmh0KWat77HCbsE2JJdxMGTYtj/EaLKY/WI
         N/oTrsxSQvey7Kgyp2ABCQgv2+lzspPpPcjuhNjqKisZyPE06+gQ97cNvM6tD9qpbdxr
         ll6+YT92f6M8BaqT0DvBGuGk8AbClOyJCsZMEMuE4WpqxzJut+fdmbYhuxzuEjNrFz+Z
         IU6ZT0jliKucycR1ZZzPC1oMtFBnE90mgQKZfd1HvSLIvflzVihXXG/lxMiIbS8JSjhg
         zC/nLmWtxVC6jHl8QUMcTC3MM6c4e/m3siJRHRxEqKw2N/V6FCHdlsn2B/xx/PMwlM5R
         arkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3N1rGQKONjK1LmoAyVX+7xootynBrKYG6WmdjI+qE90=;
        b=n4jfnttwXzm87fIBr0w5kDXRTlIeeX/lCGVpQf79KvmdqAEgbiDkPt5IKq0zltWcrd
         1kd/oxhEqoVrFDqFYCFUGGTyhFwQLN3eMRvCRZUaP3owmT8V4aFn7qlJx4T2Itg8caG3
         DNF95jHxJI8rD2GTHS0gQQbsxLr5wwZoB1wvVDNdK1BUulAPo2xP/DGi6NnScXOCq2Pv
         YkcYL+tyW1OTUoNg7hmEiCP8ZouiVMRZ4r957cAFVRXpLKENErLFtivTZGbDvh9zjnAq
         vO54dwdXmRYY2JOk+jzhu8/86ba3dfkUZrxhGM4gIq9Mms3GFwpTHfYVNwrVqVBNwWgO
         G1zA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FX5Xv7+y;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=FX5Xv7+y;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+049cb4ae097049dac137@syzkaller.appspotmail.com>,
	weiping zhang <zhangweiping@didichuxing.com>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.16 21/72] bdi: Fix use after free bug in debugfs_remove()
Date: Mon, 14 May 2018 08:48:38 +0200
Message-Id: <20180514064823.933801155@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064823.033169170@linuxfoundation.org>
References: <20180514064823.033169170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421743359332116?=
X-GMAIL-MSGID: =?utf-8?q?1600421743359332116?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit f53823c18131e755905b4f654196fd2cc3953f6e upstream.

syzbot is reporting use after free bug in debugfs_remove() [1].

This is because fault injection made memory allocation for
debugfs_create_file() from bdi_debug_register() from bdi_register_va()
fail and continued with setting WB_registered. But when debugfs_remove()
is called from debugfs_remove(bdi->debug_dir) from bdi_debug_unregister()
 from bdi_unregister() from release_bdi() because WB_registered was set
by bdi_register_va(), IS_ERR_OR_NULL(bdi->debug_dir) == false despite
debugfs_remove(bdi->debug_dir) was already called from bdi_register_va().

Fix this by making IS_ERR_OR_NULL(bdi->debug_dir) == true.

[1] https://syzkaller.appspot.com/bug?id=5ab4efd91a96dcea9b68104f159adf4af2a6dfc1

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+049cb4ae097049dac137@syzkaller.appspotmail.com>
Fixes: 97f07697932e6faf ("bdi: convert bdi_debug_register to int")
Cc: weiping zhang <zhangweiping@didichuxing.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/backing-dev.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -126,6 +126,7 @@ static int bdi_debug_register(struct bac
 					       bdi, &bdi_debug_stats_fops);
 	if (!bdi->debug_stats) {
 		debugfs_remove(bdi->debug_dir);
+		bdi->debug_dir = NULL;
 		return -ENOMEM;
 	}
 
