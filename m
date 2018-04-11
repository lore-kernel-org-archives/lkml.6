Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49AFRm+iV9Z4V1vFPmSe7Diub4j7+zOdFs4EtBLfTvlEdyly5u1FHLOSXJVdQUROsHKoqdE
ARC-Seal: i=1; a=rsa-sha256; t=1523472702; cv=none;
        d=google.com; s=arc-20160816;
        b=e0S843gO+DiEX9cm4u4qm6UNzmZmxjn6ZKvPvgOixkxIFikW8cNxUcTWVhwNM4d9/X
         H+nfSYE2ns92hvodNzGHgHQihnd6oLXOeYRC0GDosS8hthXWdiZOHcZBPk8Lc9jfw+2f
         ZGOCtW7j1DYfQbhfKFlkeIl01iVh9/qnin6HlxPk/S0AbqMojxLJpLukJyyWjpP5t1fx
         tMf7ijkNRLu03EPMzWprPpCVSxc8/lx1z9arX5LVDarlAfR+3Rg8yOiJuNqoY6ELBR7z
         4pKpHF4yttbcM2agdY5Gn4maEbXzFQxNFwCibi14lAHH2JhwRbxRexyRT2R6jZd5bGNm
         BdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l7RTYYwXiDtr1N8xG/QDCQfkiw0X8euwA4ipzIAIBwU=;
        b=R8t1nJabol1lVUPzhuRuO+ZSkJE+cgjeAhMSFGbCfQS9+XwLv9sGHIEOdsKRGksFJZ
         jxGNbuPBjzTnt9m9EGWMA1QZysAjpKhlGZgS7UlP0CGmVSOme906lW8j1SarByD0NLYn
         EpBp2YK12fzx59oR4vAuH3B0XG/ygShFj58Wfv4yDI46PlQcce4REcSgqAafeOnS8l+w
         HiY8xsl+DpQwY+qX1mZcmfEKueXWgaYaYHS3K+QJGY+JtJUQ64Oig0gx9nVbYVLpKgzJ
         uB4TwK2Gs709pKWC/r67wa77dLipFtYy3W8ZujozVAaM5MNqPWj69r+bg2HF4d1syR3a
         oBHQ==
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
Subject: [PATCH 4.4 134/190] Fix loop device flush before configure v3
Date: Wed, 11 Apr 2018 20:36:20 +0200
Message-Id: <20180411183600.326447150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476912619997992?=
X-GMAIL-MSGID: =?utf-8?q?1597476912619997992?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -623,6 +623,9 @@ static int loop_switch(struct loop_devic
  */
 static int loop_flush(struct loop_device *lo)
 {
+	/* loop not yet configured, no running thread, nothing to flush */
+	if (lo->lo_state != Lo_bound)
+		return 0;
 	return loop_switch(lo, NULL);
 }
 
