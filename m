Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpA6tD6GuRxZhEHVCUNlviv0V27r/az0ezqx0Y4Yd/8SsqbnPxP+fW0H9Un5oKSWszH7vo0
ARC-Seal: i=1; a=rsa-sha256; t=1526937880; cv=none;
        d=google.com; s=arc-20160816;
        b=sl+UTmubsHbvbRxPHuszkejUJuyfAM9v8WFZ7PFjDvtNY+QJuXA+qRO8bzBA3Ou1Wk
         eHv0taS6ASctXAzefWfWJGWQLE7eLF+JaP/LQbiaahCL71eaX6C4hHFzlZux65vO3Dm0
         MgMNyyo48MpD1v15q5f3FDFVwACe3w0Hfjd/eRJ4wvmtijxIRmsk3xaKQ/4wWQJnlC1e
         IPlF4ZN4kAosPLeH3xpP40oLVSntmjhpwFXZxjVRVjEyEYFQ7hHOwF3xjRKrOFmdFB1/
         Cr1y2//dY73zIXwDs9xQsY2jxM+03Y9AiyCRn7aPgygDzKIdVvvlIeKeV+DEaREcdtkx
         qYiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=5Ro5Gx4+v9TTNOg+s4HK23QgmT+ZnUEFhnuqlQUU+lg=;
        b=HQS40Svqip9dZp507tAFAKYhCgiaGW4zoZTxRXcRwmeFjuvgY3Klz7omwNb92EYPCL
         o3ynu+AzTNfqSbdy2OxzC+YpSKG0PBhqItpH/1Xw2+dVkrSMS/1WWmbpcXjJveRp0OUm
         2Gy90jV50x516RCm5KTP7FDbtcLa6aNRnJAZEuNX4HNKf0wfBPybBXTsUsJf/j/W4pmk
         vFuWbnmh7Z0AdhfORYAgFZ8uzUgik/O5vR5FZummlU1xq5yKzkJL+um0sBUPBWZHzmkl
         5xTZQoin0KsgVSAuZENB0/OiyS0NAa0jcOXiyfUlB9UppTBJWNT6FT1EuIC/XgU4BKv8
         Ro+A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QLHzAcTx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QLHzAcTx;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.16 058/110] btrfs: fix crash when trying to resume balance without the resume flag
Date: Mon, 21 May 2018 23:11:55 +0200
Message-Id: <20180521210511.031885735@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109810478273493?=
X-GMAIL-MSGID: =?utf-8?q?1601110415452205396?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4046,6 +4046,15 @@ int btrfs_resume_balance_async(struct bt
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
