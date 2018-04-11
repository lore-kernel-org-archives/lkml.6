Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+bhk9baspsj2z0VfhsByFvHYcImW8XuNQcotPJ8klB0dRO128KH3yuaRhQtSPFgYjEMBEx
ARC-Seal: i=1; a=rsa-sha256; t=1523473365; cv=none;
        d=google.com; s=arc-20160816;
        b=JD9KCBjzp2GjvPj1gE1y95r53IjEPUDtvkhFXvFTV3WUPummEeWaqAmwi5YBPdehX+
         5IDp0SnCkcG3K+JoJtVDD18FkLHdJciAw0b9YipE4tRM9M1QgWiaAzkwANz67YCy7KTM
         VC0I8kRbh+B/E+Fx3Scs3A2qukV45sC7rs3umhupAWIst2dKizHVEHv1OkBI1/jN8ck9
         05M609q8iZlRzLD1wNGvyGn3NKxWmAuo1JVFe6fIi7zmUWQX7vQUpIpPF/jV+ZpQUTsd
         Ademq0Wh3gzlP+T0H6cpfkyeKxtSG8Tq5LGSRlWDdx1YTTwanrPQ1T703rhaOA9lZ2ZW
         ZCXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=52vMf5XS7twpEQu0zUawMN+AYRelibwr78N4FKOnSYc=;
        b=PdbrqdaUORBpgR7SqA4jeA5ZrInkkkWfiw/EmOidutarB2Y41Rxb/hb43YiKY1EbQ7
         GiGD1k5mk2yVevyo+yPVrS6GXMq9WgS8uJdKS5WMsMyYiAyj0t33FE9x29swsSxBwLQG
         XYkxYSk/zsEAlS//1LkGbAUZVeTS9fgsZIIJWicxJmLSu0sbD4P8BiAnZABnjS1msbdn
         t9jfLhvjzksAmOmAU1zqgNNp2cApycTDCJNjFEfEVjxfm5ep+ovdPZq2HGU+HYi06lfv
         6mP7uNLTe3rNPTcmo/6gEr67ysjj0AIkXC211G5AgcMkx21oY22ZAsQL3mTQ4lpDqzFH
         IAog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>,
	Ming Lei <ming.lei@redhat.com>,
	James Wang <jnwang@suse.com>,
	Jens Axboe <axboe@fb.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 222/310] Fix loop device flush before configure v3
Date: Wed, 11 Apr 2018 20:36:01 +0200
Message-Id: <20180411183632.085674968@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476912619997992?=
X-GMAIL-MSGID: =?utf-8?q?1597477607458919810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Wang <jnwang@suse.com>


[ Upstream commit 6460495709aeb651896bc8e5c134b2e4ca7d34a8 ]

While installing SLES-12 (based on v4.4), I found that the installer
will stall for 60+ seconds during LVM disk scan.  The root cause was
determined to be the removal of a bound device check in loop_flush()
by commit b5dd2f6047ca ("block: loop: improve performance via blk-mq").

Restoring this check, examining ->lo_state as set by loop_set_fd()
eliminates the bad behavior.

Test method:
modprobe loop max_loop=64
dd if=/dev/zero of=disk bs=512 count=200K
for((i=0;i<4;i++))do losetup -f disk; done
mkfs.ext4 -F /dev/loop0
for((i=0;i<4;i++))do mkdir t$i; mount /dev/loop$i t$i;done
for f in `ls /dev/loop[0-9]*|sort`; do \
	echo $f; dd if=$f of=/dev/null  bs=512 count=1; \
	done

Test output:  stock          patched
/dev/loop0    18.1217e-05    8.3842e-05
/dev/loop1     6.1114e-05    0.000147979
/dev/loop10    0.414701      0.000116564
/dev/loop11    0.7474        6.7942e-05
/dev/loop12    0.747986      8.9082e-05
/dev/loop13    0.746532      7.4799e-05
/dev/loop14    0.480041      9.3926e-05
/dev/loop15    1.26453       7.2522e-05

Note that from loop10 onward, the device is not mounted, yet the
stock kernel consumes several orders of magnitude more wall time
than it does for a mounted device.
(Thanks for Mike Galbraith <efault@gmx.de>, give a changelog review.)

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: James Wang <jnwang@suse.com>
Fixes: b5dd2f6047ca ("block: loop: improve performance via blk-mq")
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/loop.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -612,6 +612,9 @@ static int loop_switch(struct loop_devic
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (lo->lo_state != Lo_bound)
+		return 0;
 	return loop_switch(lo, NULL);
 }
 
