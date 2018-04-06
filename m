Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48OGo6ftimbn3zmriYGseIM/SQl8RrBADI/3BcdeompSRwwe5Bor10YrQ8uI8Dvo7ukB2VU
ARC-Seal: i=1; a=rsa-sha256; t=1523021807; cv=none;
        d=google.com; s=arc-20160816;
        b=P/rElAAdTG1d7H8KY5ZVykzCmRSqlWERfjAaSEvdRDNps2sc+FhObWn8jDQtVCbduA
         S5nkioK5dU9/ArROxVRjQkWWY5E0y1vxmMLJUs+Sn6MV4lMrUSOH9u6/5EsGz+kzlDGS
         o4Fs9BUZLPjRkH6/RR844VavYeoEKeXngsF7PZjkiFNGxqm6VHZqrCWaNHNBGF9H5Oua
         4M+pyDLUAtwXBQwUKwzxYm7/urS1CDuawswfgIkpO0NBbD69yDpwp+UfhHvjLme+SAjs
         lYRTHe7vz4WpzT0nN1GlKVkk28kJTh1z2JYEgUlNvJrWj1XJScPPgGiog7Qkmr5z8Smq
         eEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tAqK9NU8PBHPtf0ahUM6t8gpy/qw2u0ylIzwRyjVjg0=;
        b=RVJzdB3s3eJQklEw1qDMUHjN4f2rB/6rP3brsamXZH+VjokNPK/dKLEykUclM9IApb
         fhw7MBaOxbdr2xwYU3y2yxnn8EXaArBA5qtVfUg84QC3D9VUe3z18d76f5wcTCw1xpjc
         5qMFEtjzghqCQfHpsMqEJFaO3juiLAjfFWKM9KgGEJAGgCUBu+h9pCLP+r25MW7UaMcP
         D23NhXgqyK9ND2nWUTA1xc0x4Q1GTJwzozJUAxtGTeB1t0PgST/i832g+pDS5zRIW19/
         wW2xn6644ZxmbhIv6naaBCOjfIi5XJtwWiaLz732GrjCoyJT9aupchvAoZZmwnXmT6LS
         7C4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	NeilBrown <neilb@suse.com>,
	Guoqing Jiang <gqjiang@suse.com>,
	Shaohua Li <shli@fb.com>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 094/102] md/raid10: reset the first at the end of loop
Date: Fri,  6 Apr 2018 15:24:15 +0200
Message-Id: <20180406084344.705659568@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003641922069555?=
X-GMAIL-MSGID: =?utf-8?q?1597004114015466329?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guoqing Jiang <gqjiang@suse.com>

commit 6f287ca6046edd34ed83aafb7f9033c9c2e809e2 upstream.

We need to set "first = 0' at the end of rdev_for_each
loop, so we can get the array's min_offset_diff correctly
otherwise min_offset_diff just means the last rdev's
offset diff.

[only the first chunk, due to b506335e5d2b ("md/raid10: skip spare disk as
'first' disk") being already applied - gregkh]

Suggested-by: NeilBrown <neilb@suse.com>
Signed-off-by: Guoqing Jiang <gqjiang@suse.com>
Reviewed-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <shli@fb.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/raid10.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -3681,6 +3681,7 @@ static int raid10_run(struct mddev *mdde
 
 		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
 			discard_supported = true;
+		first = 0;
 	}
 
 	if (mddev->queue) {
