Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtFk/npb2zzHFW7vQt1wmnCSJiXEJiMzwsZMaB3p/LcDi7+aJ0olGzLLam1n0XgaIWGnQm2
ARC-Seal: i=1; a=rsa-sha256; t=1520451849; cv=none;
        d=google.com; s=arc-20160816;
        b=A6pjaWMMgXR4SAMoCNIcDwPgLx5Z7vDt2ByMzRDy8t0GrPmwpVpj8uzIVcTSdWUmiV
         OAFGjVa8ul+XH6Xfz+Qm8RRzlsTUtemwii8scSP1UkP6iHMLjisrBYTN/Jb86QZrTGJX
         67EPNo7bmFSLZiVrwwSqkxr46VrlkQ1z2o86NiakefXhCYxEMbRth8iXlKOlt4M4nXbn
         As/XsDmH49eczQVkLXj7Yy5Jogw/BxR5mFfPu4mob0KbPBR5V6NTB/KBAd/cfV/pKqdd
         h39eYGBwg1pYmLO7QxcL6n88I0X3RYuq4NZDCRuZsYF4YjQdGQMtOhpYgc0Ibk7CsQh5
         VF4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i2CAfjsgdnfgScdobTRv+BOYwy+VNm5eSQEvhMUNiyw=;
        b=mCtSsZepiVpi5kFMEqHBfvyhrIMRR3V1wVUh3r7L4C7Tlrubn7VSFLXj2Y7CstmYNt
         kZI6feI6477PKSZ5SbX89NPKD31dH4k1seVGS3EW1fll89RB2mmeTgfyOBr2yOSHzP28
         XhYDwAoXPLf4yvHiTZXlG5kE7dT3c/0OBSOfbn+8uPXRSNt4xO+Bs2fqGh01Sc5Inj1L
         1/8YAx36aey28w3M5EvI8VpL7Bxno/U3lmFO6AcKv0mFtbFMuJQof5nA51AWEKY2Pwyh
         7+YnCjSyQ/6p+flUCikRCI8FX3hhbZ1kP0qiJvT7ekFpAwiYLcJeUujNYofnk8UEMewW
         K/1Q==
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
Subject: [PATCH 4.15 122/122] md: only allow remove_and_add_spares when no sync_thread running.
Date: Wed,  7 Mar 2018 11:38:54 -0800
Message-Id: <20180307191747.295854504@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309318369465472?=
X-GMAIL-MSGID: =?utf-8?q?1594309318369465472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -8554,6 +8554,10 @@ static int remove_and_add_spares(struct
 	int removed = 0;
 	bool remove_some = false;
 
+	if (this && test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
+		/* Mustn't remove devices when resync thread is running */
+		return 0;
+
 	rdev_for_each(rdev, mddev) {
 		if ((this == NULL || rdev == this) &&
 		    rdev->raid_disk >= 0 &&
