Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1141254-1519337456-2-1235442862906859505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519337456; b=BGfj0/o7DgmhqNlflnp4Syeu0u5X26FErivJwTvZjWuc0cu
    L3dajcD0qhZTItPsinPp1tXIYIhJl1am5FcrYeqW/Xe5LUup92fZiYN/4gBs61c4
    a0Us2Pj5TidYShVfx8MvPv3ECXpknije67Wg1fqVTIDkfB9newChS8pjhS+P/Grh
    ix1sfA8v3I4SXJFmIGvh0t0xC+YvM5f+42EXCHmBVaPFswR3PJ1WqbN++krXspjb
    ZU2ACl81f9E2TJpQYq5JSgjz/9lROD1jjIgHJ2vvjxhxmeE52utoh6MIqvhF93SV
    75nwOmGMWEd6BojLc6wNMqNi9bSW/YEwE8zUm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519337456; bh=l
    pfx9ja7caavscmdjD4amZm2EytAQWRZTA5uMUFTlyY=; b=r0vvTA8kEK2uBbRo3
    a5nvkILjTD/8h48yx3ayCEKnVL4mXcNb4aFuX4UUj+JWu42Wj/fh1CIUVfEL5zVw
    f33cjKilCw17SEiTChUuZbLZILx6N/Xdc5KCSnyniwxJAvqtsQ2EHVQ7MKEyEera
    NvA3gBalqR7tnvJ03vXx4VD1//THCkUsJ3rwlThrF2TBJbmVwK2LFiQoPYe9nrh+
    ZNHRD7niguSMWW0eeK2icGeA6hz/bn1PpAsoUwHK1AqrSaZyBuAi3fSwJhFdGka1
    tG5QZJYaWzijTe2p6C9BX2uRogp7Dq47z8CHhm9geWn8Ol2TVpMmbOngtTw9sIip
    D694w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Fri, 23 Feb 2018 09:09:33 +1100
Subject: [PATCH 2/3] staging: lustre: lmv: correctly iput lmo_root
Message-ID: <151933737384.16436.1999360148075400466.stgit@noble>
In-Reply-To: <151933726925.16436.9827896439357574011.stgit@noble>
References: <151933726925.16436.9827896439357574011.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 8f18c8a48b73 ("staging: lustre: lmv: separate master object
with master stripe") changed how lmo_root inodes were managed,
particularly when LMV_HASH_FLAG_MIGRATION is not set.
Previously lsm_md_oinfo[0].lmo_root was always a borrowed
inode reference and didn't need to by iput().
Since the change, that special case only applies when
LMV_HASH_FLAG_MIGRATION is set

In the upstream (lustre-release) version of this patch [Commit
60e07b972114 ("LU-4690 lod: separate master object with master
stripe")] the for loop in the lmv_unpack_md() was changed to count
from 0 and to ignore entry 0 if LMV_HASH_FLAG_MIGRATION is set.
In the patch that got applied to Linux, that change was missing,
so lsm_md_oinfo[0].lmo_root is never iput().
This results in a "VFS: Busy inodes" warning at unmount.

Fixes: 8f18c8a48b73 ("staging: lustre: lmv: separate master object with master stripe")
Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/lmv/lmv_obd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/lustre/lustre/lmv/lmv_obd.c b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
index 179651531862..e8a9b9902c37 100644
--- a/drivers/staging/lustre/lustre/lmv/lmv_obd.c
+++ b/drivers/staging/lustre/lustre/lmv/lmv_obd.c
@@ -2695,7 +2695,7 @@ static int lmv_unpackmd(struct obd_export *exp, struct lmv_stripe_md **lsmp,
 	if (lsm && !lmm) {
 		int i;
 
-		for (i = 1; i < lsm->lsm_md_stripe_count; i++) {
+		for (i = 0; i < lsm->lsm_md_stripe_count; i++) {
 			/*
 			 * For migrating inode, the master stripe and master
 			 * object will be the same, so do not need iput, see


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
