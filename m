Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+JD4fGlL7VREi/CXoEz8kQY0TEONNBb1H2s+D18saJJ2YjMjppTbT49NKGFJlAdwab9+IV
ARC-Seal: i=1; a=rsa-sha256; t=1523021504; cv=none;
        d=google.com; s=arc-20160816;
        b=MUoQxlvzp/3Xjhh1zbgWbFx9Nx16suT8E6pO5/5WHL7iuApgfHUo/CgCmNqtsY+QK6
         42GxWtP7YUm/vi99AlLfwzD2wQL3xg07apA5v5sfR9/NEN5cuo+kRQAd7pdRPQ9f2EOx
         pmNvRra1eypR2vYglrAdYdky+2mQdlTXPaJ379/OY0/UNZ971qcFX9TPEKPxPNhiBXvG
         TyweRqBBx8zko+3X/5mLsb1FkIoXO4eU8cZUk5nhXaMWjuld8COcHdRS6+8kXmvXOwei
         R1dCJT2NbRoxsdPm+bYBmt45MeX68+bt/0vOSK5SNwrvmk06h2GdJ37xnLarahcm+ggY
         d9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hGhmw2f4cq2k3WkLeSMWlWVQhnMjqTSIv02CThAUzFA=;
        b=haMo2XTyJsewlLX9lSADtOrYy8481ZShFGEWy7HDeSZ5VY8g2KDifpiXvyHaiVKmUV
         /parb4t6RlavwWYbv9ezQ0KMqz4gSG9YoddefhA/1e7NZpmkaDW7AXw5906kd96oe+3W
         kkvZJTVm486TKp4UOWvaE58CPxWFrdESocIZqnsnVNE0bsxHGqM4K/8crzWa5g1XFfmC
         OIaRC1ugLZnKf5TvAi4w81TLd1oxiVvZIEMpu4yCt4j49HoZ/lcsDZGnlcP53B0VApd5
         hylZ/nMRjlJ1E9nsaboaHNbj5lY2M00STx6f9DFUxS2qaDcTkUKJWG1v2cFc/8ujbQ46
         4+mQ==
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
Subject: [PATCH 4.4 61/72] md/raid10: reset the first at the end of loop
Date: Fri,  6 Apr 2018 15:24:02 +0200
Message-Id: <20180406084310.517381733@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597003641922069555?=
X-GMAIL-MSGID: =?utf-8?q?1597003796698401656?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3638,6 +3638,7 @@ static int run(struct mddev *mddev)
 
 		if (blk_queue_discard(bdev_get_queue(rdev->bdev)))
 			discard_supported = true;
+		first = 0;
 	}
 
 	if (mddev->queue) {
