Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKLru+c+NdFNjXnsm2uGd6Wpi8e7CtjT/kx82po/fUbI0Q20rfeDt3kV/9ir3CvXmp3yc5
ARC-Seal: i=1; a=rsa-sha256; t=1521483126; cv=none;
        d=google.com; s=arc-20160816;
        b=TAju/tj3nvYqRPyXW6XA8CUFQ1pbuXAn2llDf1U382LU60L9kw6uaG5iRF0GowBIHU
         689xhqMiEgZkEuyBsjoIyWVOSqJAewZ+i6pcae1S9udCzPt0pRtpGLVpTW8xAe9NrrQz
         xSHLbJe61WObaZbK3Yopu0I+OJdyBwU0BeVIJdywq0jyd7CqZB+0NPfYZ216d6gx4Und
         u+81hvfIMcjj/iwQLXdSQXBpzZCTKWrrhIE28W7THh8ptY2j+Ith9POFiafr4QCpLo+M
         1jfdDocKhY6wXimos3VIaaKcTto8CmrDziofJkAWJAtREUJLeGtMlRhNLt/iuu0Hze/T
         mYXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gCmYEbSrfiyiIt6B4esU6c3Vm+wf0EIfJxag5IhAS9s=;
        b=q77+QTZacmHAMZZg7jNS70783uo4BV0uffWHjUVlBp0cbgoCjF62anKwwP5dYN5cis
         hzXPXrJYWf3ZqHdaBfCCKPHRNxUsAuYb9FLQdHxfEV0wEjo8koT6X5B4CekCB0X3Q8IX
         mOLe35cEtiajJ+8wmAQF/HBJVL8fBNHik/S8Wku6YncwPx+CbwkWS0dO1sX8kCD/Cq5v
         jdUJ2m4c/Rea+nIUuD0GMosygXeABXkHEY+OLCZV2KrxCc3mhKCQ1m+eAcQMROTp/sQj
         VT20203SmSRQD6fj5sW3XzFGhNzju5HvnG4xSUfYx8yO9mGqaxlM7Xcwj49y3opYmoCo
         WRfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hou Tao <houtao1@huawei.com>,
	Jens Axboe <axboe@fb.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.4 001/134] blkcg: fix double free of new_blkg in blkcg_init_queue
Date: Mon, 19 Mar 2018 19:04:44 +0100
Message-Id: <20180319171849.185867012@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595390690637575955?=
X-GMAIL-MSGID: =?utf-8?q?1595390690637575955?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

commit 9b54d816e00425c3a517514e0d677bb3cec49258 upstream.

If blkg_create fails, new_blkg passed as an argument will
be freed by blkg_create, so there is no need to free it again.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-cgroup.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1078,10 +1078,8 @@ int blkcg_init_queue(struct request_queu
 	if (preloaded)
 		radix_tree_preload_end();
 
-	if (IS_ERR(blkg)) {
-		blkg_free(new_blkg);
+	if (IS_ERR(blkg))
 		return PTR_ERR(blkg);
-	}
 
 	q->root_blkg = blkg;
 	q->root_rl.blkg = blkg;
