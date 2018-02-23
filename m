Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226PQvKea3pnnv72qzo583M9taKzXKVrG+TpZ97otlRTWeg7jdmi1bSBWbYhiHAU4FbzBazm
ARC-Seal: i=1; a=rsa-sha256; t=1519412191; cv=none;
        d=google.com; s=arc-20160816;
        b=N12Wo2mjQAK/Lr7dSlrtSwK3tdynL6KC/HupEr1XPp3qsJqjutjSyGlYf5eXSpAEn/
         sjUacxwrJW6MsUiNrLXiZlGygJvglEhe1PmhhmCmBcYRA3yX/pvvy2OIJi1xAFcHnY42
         RZWSDfbQhJ86Um8TwC7ftY+CsAzy/91pNTENEuOpwaidyq0AwR9/qOOIe1WCvIiaQyrN
         UkNu5OoYb/s2mBwbuXXzHnPfJ0Fv7LJd8BVkknayMVmrqEQEAh4rtz1/IMM7qGxki1Nf
         kh3sePRpaMxvubGoQUeRWCbcCXs2aHATwMJkUwS4IElpdJpDkV7gHtuHHBA7I9kg7tUj
         Y51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NOjZooq6u65QtqBIPzsyPzgUUYrNPVCikGKkBwSMXFI=;
        b=S15UUG9uaf80+Ez0I4G7CVdPncLERs+eyCpHHxRoFE5vSx9Z4PRa5abEhUBUI58YmT
         DqIrsASEwFLbU+NFvr8hy0363ywAYIBQudYlEypOyttqLvwzv3fwfPQj5FQDDFuxebXA
         3Ac3sBt6G2ll0vHAnNFjvJ65iUKR+k2s/e1xxwl6qUePwFYrMjDy9vribzt6BtumHmgL
         vrYmEPbz+TlWgfUiB3Y/2K/rwLXJ51R4yyblHwLysVUlMv8RlXS2UyljYxIq3CjCEsvL
         Rq+lxeAibCbeydXeaib0M/LjsIsRK66R4JAOIMKPg2sUO69QoMlGDER72xR8FZdulzVt
         jFbw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Omar Sandoval <osandov@fb.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 119/159] Btrfs: disable FUA if mounted with nobarrier
Date: Fri, 23 Feb 2018 19:27:07 +0100
Message-Id: <20180223170757.691151421@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219158542441794?=
X-GMAIL-MSGID: =?utf-8?q?1593219158542441794?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Omar Sandoval <osandov@fb.com>


[ Upstream commit 1b9e619c5bc8235cfba3dc4ced2fb0e3554a05d4 ]

I was seeing disk flushes still happening when I mounted a Btrfs
filesystem with nobarrier for testing. This is because we use FUA to
write out the first super block, and on devices without FUA support, the
block layer translates FUA to a flush. Even on devices supporting true
FUA, using FUA when we asked for no barriers is surprising.

Fixes: 387125fc722a8ed ("Btrfs: fix barrier flushes")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/disk-io.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3391,6 +3391,7 @@ static int write_dev_supers(struct btrfs
 	int errors = 0;
 	u32 crc;
 	u64 bytenr;
+	int op_flags;
 
 	if (max_mirrors == 0)
 		max_mirrors = BTRFS_SUPER_MIRROR_MAX;
@@ -3433,13 +3434,10 @@ static int write_dev_supers(struct btrfs
 		 * we fua the first super.  The others we allow
 		 * to go down lazy.
 		 */
-		if (i == 0) {
-			ret = btrfsic_submit_bh(REQ_OP_WRITE,
-				REQ_SYNC | REQ_FUA | REQ_META | REQ_PRIO, bh);
-		} else {
-			ret = btrfsic_submit_bh(REQ_OP_WRITE,
-				REQ_SYNC | REQ_META | REQ_PRIO, bh);
-		}
+		op_flags = REQ_SYNC | REQ_META | REQ_PRIO;
+		if (i == 0 && !btrfs_test_opt(device->fs_info, NOBARRIER))
+			op_flags |= REQ_FUA;
+		ret = btrfsic_submit_bh(REQ_OP_WRITE, op_flags, bh);
 		if (ret)
 			errors++;
 	}
