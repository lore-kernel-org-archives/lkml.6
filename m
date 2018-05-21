Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrZRdwGCc77zMdI+63wb7Ab0nijifM33Tj8sp/I09Nm8E7E0aA+D64sc9Gz/ubjR5iPYlFB
ARC-Seal: i=1; a=rsa-sha256; t=1526937303; cv=none;
        d=google.com; s=arc-20160816;
        b=mmhmoXoD+33V5rdLH6O+F56qPZZbiKS2kMt9DGW5bvMSbzZUbl0/Jzv2FwgQxIoHOS
         2uD9SMXMDKCOXuFVK8S9vJghORN2uFabOouhiiGuURax1iQ32YE+aXgHZh/fNuFiZCvz
         0T+x8D9Y62G77YWZ6RIpkWD47YMRUC50FEyIFukNXgVxA/TdB6nAifaYCn7Qh4Meny6q
         EdrECMHjwcvxDn2i83XVyfc74Mv/vmUKUyRvnTGWzq9mH/oUARu5GsItKDxcFd/ljLdG
         YTBcQutUKr1/Z4nKUlxMsQperX66w2EAzMp41OmTfTv9RuafTP+BJcQD2G1wQYbK4qEW
         LdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=2uCcGQp2D5ZztXn+r8b1Cd7NwDcqKQZjqNCXn2+4vjA=;
        b=edmJd3lBpkLSRIpvET7RwyJZWf+fvXBnBVgahmbz23k+PuWuan8UL/B6cHjH+x/qlj
         2iH6KaRQuLFRYIhEMg5W5dNBQgHaI2sW4j5UP8D751p97Gzg6ysQRM0r9UA6GegW0uI0
         XquHd7T/H+oDQ/x1FpQfjkL2YP23YVALQA3GMGzMHwJ+6BMbNjY+lyMq28BzSxJIuzJj
         hp5d1Llc1c60N26Z0JGZ6EbiIN2pnwyIc7tUV5wbtxIn9YOK6Xg1NsyiH7NzQt6PgygF
         i9aATutQU7G2KTY98mEPmjfIvF+r3yLlm6IifCymxy4Shnb8CywpM+Ky6ekBDPmQHia4
         gimA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bX9Fv9Cb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=bX9Fv9Cb;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 33/87] btrfs: fix crash when trying to resume balance without the resume flag
Date: Mon, 21 May 2018 23:11:09 +0200
Message-Id: <20180521210423.498634150@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109810478273493?=
X-GMAIL-MSGID: =?utf-8?q?1601109810478273493?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 02ee654d3a04563c67bfe658a05384548b9bb105 upstream.

We set the BTRFS_BALANCE_RESUME flag in the btrfs_recover_balance()
only, which isn't called during the remount. So when resuming from
the paused balance we hit the bug:

 kernel: kernel BUG at fs/btrfs/volumes.c:3890!
 ::
 kernel:  balance_kthread+0x51/0x60 [btrfs]
 kernel:  kthread+0x111/0x130
 ::
 kernel: RIP: btrfs_balance+0x12e1/0x1570 [btrfs] RSP: ffffba7d0090bde8

Reproducer:
  On a mounted filesystem:

  btrfs balance start --full-balance /btrfs
  btrfs balance pause /btrfs
  mount -o remount,ro /dev/sdb /btrfs
  mount -o remount,rw /dev/sdb /btrfs

To fix this set the BTRFS_BALANCE_RESUME flag in
btrfs_resume_balance_async().

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3966,6 +3966,15 @@ int btrfs_resume_balance_async(struct bt
 		return 0;
 	}
 
+	/*
+	 * A ro->rw remount sequence should continue with the paused balance
+	 * regardless of who pauses it, system or the user as of now, so set
+	 * the resume flag.
+	 */
+	spin_lock(&fs_info->balance_lock);
+	fs_info->balance_ctl->flags |= BTRFS_BALANCE_RESUME;
+	spin_unlock(&fs_info->balance_lock);
+
 	tsk = kthread_run(balance_kthread, fs_info, "btrfs-balance");
 	return PTR_ERR_OR_ZERO(tsk);
 }
