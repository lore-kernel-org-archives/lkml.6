Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELstQglpY9aUYB0u2QumWxLfHzX/4dkE508r6pOK9OTqBKZSLmclh27/Agqm0MpmEI7ISDCl
ARC-Seal: i=1; a=rsa-sha256; t=1520452097; cv=none;
        d=google.com; s=arc-20160816;
        b=FyV1WmHoL/KFD/dp1rcwW2ZbqrM2kt93jRuC1UVSq/KqsVnKSw7s6bcsKLjnK2Yrej
         EGvCXcmEV8rQkS+rcBGMp0eClh3DZ9kkdVzO5juGgCq9DtQoxencnuFlp7heclh5TgH9
         iVZoTtXEvGTRY72afJIGaq/QoEO6KIP7QM6TcsyCfLaxB907UiuCdhswcqgSZh3aUWUY
         dzqQIuAz84KVTXOluQZTxzmPFX/Cbavl9M5jtA7Rep5YCQZ6sFjCtsu+NHlbO9HL0Z1C
         V/MEMifP56FBQ/03AISBzACViqUB0xtyW8wK/mBx/nnmvOcVlNqLIjTvUy9+kXHKjBBH
         6JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=QIjiD+NZCpUbvK/kScf7A5kwHFLeVZK3etxiSC7wX9E=;
        b=Zhyea5ullpcpc4CgK3QX6Pyu8uKOmr3WedkVYZq/VSukgh/qmSBWp0HD+LLhrz/Qtt
         5aBBYAfW4cZKUMto06xWO4hmhNn1ukxpBlP5Pv8FiwmFpdjElW0+ulrINDQTXBHtja2z
         1uEB+q3W10esTD5CBnCC3zABpQDRcPRvrgpT3Cm4c/zPZmfpanHJ03DkEKoA55oPzvyJ
         OHy3TmspukZt10B/HCLAoduh1nNlWj+1EXQ4QsriA3MF4nw9PIjguQNdFQ7XoYvIcCWE
         m+gFZZCGQoymfrK8Fd9wW13wAK7i4wbTt/K3eIBVMTHIiR9JSkcNiVj0kXWE1/9TTB8j
         kphg==
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
Subject: [PATCH 4.14 109/110] md: only allow remove_and_add_spares when no sync_thread running.
Date: Wed,  7 Mar 2018 11:39:32 -0800
Message-Id: <20180307191053.934934129@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309318369465472?=
X-GMAIL-MSGID: =?utf-8?q?1594309578219431286?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8522,6 +8522,10 @@ static int remove_and_add_spares(struct
 	int removed = 0;
 	bool remove_some = false;
 
+	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		/* Mustn't remove devices when resync thread is running */
+		return 0;
+
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) &&
 		    rdev->raid_disk >= 0 &&
