Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ljoa+mLH7gE3N63rDbKh2i/0WSjIWJZUUAG8RKBB9Yuwt/dj2zcZewObcoluuqVKL6K1W
ARC-Seal: i=1; a=rsa-sha256; t=1518709058; cv=none;
        d=google.com; s=arc-20160816;
        b=LhIBxCu8B+b1ovdCD8PSdNQhJVB/3ke0UJdSYc7nFHiElY1Z/6v3ZdXpoNcZUUf+Tc
         Y9SBEecvh9Pi6PWu0PV4Z1z6BCRwMeNHceVa8vdsMJfUwuEtl/50d5JTviV61PdVi8pE
         g5nNsh8kpu+HvuohnQcHElsPiCk8sPzkEQGLAqHby9yY4NwayriZCPT3LZv3BtdPBK3P
         HcZ/JXseADq62e34dC52o9YE7ZVDn2Q/WkeNn/QxUZUqpiowHjHQPCDgeTMe1OqwrSiB
         lvYpcXci1Q2D2Q3S0sXf9SsimdQ/YValfoMLpgqCpkNyOcuXCvPD3GFls1EV6RfvynBn
         0qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ebWREoD0SfnD144cXBcXXHN35WUGS4CbDILRhEa3FXg=;
        b=cIf2Ob27juBgwLbll/rVyNio36A2gm/kI+NoWlDP96yf2TjYO63B4saAylchUyB4ra
         3LdrxyRTzpYtDrMP+nm1xxX3X47z/daeuEnXpRDMTNYQgmy2ddqhqWIgahOg3aqVB5y9
         UHId6nTYTU2FiklUTvzJpj6I2nPPARK4Duu24iS2HOrJBBGIoFuCNgrmy7ezKLD5U8dl
         wk0qgGdS/z/WTz7VUGPSFCOYPFNQPg5K50Q8QAaIX7gpuoQqRPA04dhOcduHYO/jGWq9
         xW8neauZEGUjjugyvPwCOAidEeUlwzreM1YG4w15coJYkYQG80t7Pf+ERYiCiLIs9ks5
         vbfg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.14 177/195] pktcdvd: Fix a recently introduced NULL pointer dereference
Date: Thu, 15 Feb 2018 16:17:48 +0100
Message-Id: <20180215151714.930054744@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151705.738773577@linuxfoundation.org>
References: <20180215151705.738773577@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592481870261874904?=
X-GMAIL-MSGID: =?utf-8?q?1592481870261874904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 882d4171a8950646413b1a3cbe0e4a6a612fe82e upstream.

Call bdev_get_queue(bdev) after bdev->bd_disk has been initialized
instead of just before that pointer has been initialized. This patch
avoids that the following command

pktsetup 1 /dev/sr0

triggers the following kernel crash:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000548
IP: pkt_setup_dev+0x2db/0x670 [pktcdvd]
CPU: 2 PID: 724 Comm: pktsetup Not tainted 4.15.0-rc4-dbg+ #1
Call Trace:
 pkt_ctl_ioctl+0xce/0x1c0 [pktcdvd]
 do_vfs_ioctl+0x8e/0x670
 SyS_ioctl+0x3c/0x70
 entry_SYSCALL_64_fastpath+0x23/0x9a

Reported-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Fixes: commit ca18d6f769d2 ("block: Make most scsi_req_init() calls implicit")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/pktcdvd.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2579,14 +2579,14 @@ static int pkt_new_dev(struct pktcdvd_de
 	bdev = bdget(dev);
 	if (!bdev)
 		return -ENOMEM;
+	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
+	if (ret)
+		return ret;
 	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
 		WARN_ONCE(true, "Attempt to register a non-SCSI queue\n");
-		bdput(bdev);
+		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
-	ret = blkdev_get(bdev, FMODE_READ | FMODE_NDELAY, NULL);
-	if (ret)
-		return ret;
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
