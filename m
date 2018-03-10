Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtSW7WMtEbdaRCG/uN25EKFGs07juCsuivoAoWBCBBgca8pWnTHQzSoUahIhjDTBPcaFAIQ
ARC-Seal: i=1; a=rsa-sha256; t=1520641373; cv=none;
        d=google.com; s=arc-20160816;
        b=b+wHhw8yFlR7G7eAGiMLU/y0uHgdInUz+e8YfgWFv7JxnuoAoi9OHcz258CwkRG0Wd
         fMwCte4EeE8H+bvp58u+UAclLHb4vwuUFNKCHG7gZKH/seN8GHuhpQ39YAATj6nmEcZT
         2flFIpLU5iKAZhzWIYZf/E5Uqkt2b2BdebjycskALtUXWv3Wk4x+mbsWxWH/2EMhjkB5
         GqGucvzXP9ECVhDWqED3y8cBEzwWyUlflDjFPHTZ2eIj8zBu0LOgscDmOMsPljjWsNTo
         zIJC83ptu6iGjL/i4JUsyEt7U9z6lzEqCsMVhQGiD05SSpfjbQTlLUu/ZawtcutmSobh
         w9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Sy+BIoF1s7n1YtezsJli0XEZsCjPBmnHDP7BexnBqB4=;
        b=wgrEP6wJyObDjAvbq+yvjoXatWRqKrJgMQYvv1lZspS1bG/aonoKw5A+a0GpDv+Gvq
         jYDFCN0gIvopCpVyq0U/CzJCcvG4XB5MeIypaPBYzoGfKwbLIFbM9IjOmZcV2dvM14HR
         pz6RA6BAaQSIrjUnIYAJKp0rkGTtODdKp4/k92pxAWkIHtuT/trEVbDDvzfcJ1SDhev6
         q1LU7VHCkyFiZ98UybxaImKXR1rtTsn8YV5BzyPUy7JFcdI6noANVIAo4Wc3Bvk7mPHQ
         0w/0k4l7G0dTvEZE+g4bENF5O5YJVbHua7UESTxUU3V4Jq2cacwKbRYsmrDPMbIAn7gR
         yxKA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	yuyufen <yuyufen@huawei.com>,
	Tomasz Majchrzak <tomasz.majchrzak@intel.com>,
	stable@ver.kernel.org ("v4.8+"),
	NeilBrown <neilb@suse.com>,
	Shaohua Li <sh.li@alibaba-inc.com>
Subject: [PATCH 4.9 30/65] md: only allow remove_and_add_spares when no sync_thread running.
Date: Fri,  9 Mar 2018 16:18:30 -0800
Message-Id: <20180310001827.315883030@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508049522327490?=
X-GMAIL-MSGID: =?utf-8?q?1594508049522327490?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 39772f0a7be3b3dc26c74ea13fe7847fd1522c8b upstream.

The locking protocols in md assume that a device will
never be removed from an array during resync/recovery/reshape.
When that isn't happening, rcu or reconfig_mutex is needed
to protect an rdev pointer while taking a refcount.  When
it is happening, that protection isn't needed.

Unfortunately there are cases were remove_and_add_spares() is
called when recovery might be happening: is state_store(),
slot_store() and hot_remove_disk().
In each case, this is just an optimization, to try to expedite
removal from the personality so the device can be removed from
the array.  If resync etc is happening, we just have to wait
for md_check_recover to find a suitable time to call
remove_and_add_spares().

This optimization and not essential so it doesn't
matter if it fails.
So change remove_and_add_spares() to abort early if
resync/recovery/reshape is happening, unless it is called
from md_check_recovery() as part of a newly started recovery.
The parameter "this" is only NULL when called from
md_check_recovery() so when it is NULL, there is no need to abort.

As this can result in a NULL dereference, the fix is suitable
for -stable.

cc: yuyufen <yuyufen@huawei.com>
Cc: Tomasz Majchrzak <tomasz.majchrzak@intel.com>
Fixes: 8430e7e0af9a ("md: disconnect device from personality before trying to remove it.")
Cc: stable@ver.kernel.org (v4.8+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Shaohua Li <sh.li@alibaba-inc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/md.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -8224,6 +8224,10 @@ static int remove_and_add_spares(struct
 	int removed = 0;
 	bool remove_some = false;
 
+	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		/* Mustn't remove devices when resync thread is running */
+		return 0;
+
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) &&
 		    rdev->raid_disk >= 0 &&
