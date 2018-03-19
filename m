Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvbWQX0mRG+5O+CCqczqbHJOWyzsdU7Fp209Y3vP7qdJSAvIUO3A9Oo5e15/DwN5+BCNlbj
ARC-Seal: i=1; a=rsa-sha256; t=1521484115; cv=none;
        d=google.com; s=arc-20160816;
        b=iGukc/5HCpkI7nrLuSeS5xbGyBnxPyN5y5pZh53R708yev+u7zISyG7E823Lea5oqt
         /WDbCgmMrQs29Ubp3AjEOlo3Sye9HlcTE5lG0mLIYx/ngXSZ2SYBG5faXYzL3o9Zy7b7
         Yj/q/VzGyb6Cmv2t2qF33C9EmZVkg3WbGV/+HMaF3/jOBVPtaMEyLvnSJe7UramyPd7k
         MwYykC4SeQXyNZfhKhNqQVAqUT3Kh+BS7+L7oIeoESq59p8oMHFcERpVeB6JkUuzM+Sw
         WaiFW1jcxakx3dVikZv/8leHIR3RzXaKhdB36XTRqWMnUdi5k49OkBLt8JydIcOyP5Bw
         JjgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZqYLx8YAAi0N5jFuOaXWmZ0bSGbNAq/ac5a6UXzAEdU=;
        b=ONyJq2xm79c53ZjI0qT+aj1y53KZ1x8sIHmhc4J4vmDf43PKyv9nJeo3B4pSfu8sUb
         BIM1baU/ayNkxn0boZZqfQLP5wbm+YTB4XDkIDq5SahT2PUWwwJCY+D/Ut9OnDG1diM+
         yk7eHRiZJjEyDmcHcS/fXRyIVnLPAJwhz2XIKYrLn0UiVCLJGhZVK7Sw1P55V4wq3fVs
         gXS7imiqpcpoMQQ2J0oB81r2bYnGPRoPr3s9PsgncylpbC3Rbz5E3oEkoiypxKTP+Tlw
         kkHU/vKaNtcjegzgc1c+b4AdAJLAX60XEX2pLCyuXr3rlFBKFENpzGUBnkjFuhA3vMv9
         fWCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.9 237/241] btrfs: Fix use-after-free when cleaning up fs_devs with a single stale device
Date: Mon, 19 Mar 2018 19:08:22 +0100
Message-Id: <20180319180800.989583878@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391039024276652?=
X-GMAIL-MSGID: =?utf-8?q?1595391728233868773?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit fd649f10c3d21ee9d7542c609f29978bdf73ab94 upstream.

Commit 4fde46f0cc71 ("Btrfs: free the stale device") introduced
btrfs_free_stale_device which iterates the device lists for all
registered btrfs filesystems and deletes those devices which aren't
mounted. In a btrfs_devices structure has only 1 device attached to it
and it is unused then btrfs_free_stale_devices will proceed to also free
the btrfs_fs_devices struct itself. Currently this leads to a use after
free since list_for_each_entry will try to perform a check on the
already freed memory to see if it has to terminate the loop.

The fix is to use 'break' when we know we are freeing the current
fs_devs.

Fixes: 4fde46f0cc71 ("Btrfs: free the stale device")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -583,6 +583,7 @@ void btrfs_free_stale_device(struct btrf
 				btrfs_sysfs_remove_fsid(fs_devs);
 				list_del(&fs_devs->list);
 				free_fs_devices(fs_devs);
+				break;
 			} else {
 				fs_devs->num_devices--;
 				list_del(&dev->dev_list);
