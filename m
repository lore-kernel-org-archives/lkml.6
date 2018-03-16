Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3328118-1521214496-2-3990597748278790859
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214495; b=THbnOhP3FPAO/5c2tuEKfDABqHuDx3bcsjNGKVrpsuifhJU
    d6tJn+ldU5jlpVjr3+k1CPfxoy6/o8U7JhhIg5QR1fpmFoKfSDx2mnsMorf8Cu/x
    p5Ep1CG/pLsqcihftSVAyAtp2voK3FE08h817LEifbh2rp4uQQjJcHTC9FQrGlAY
    3cvKAaCRryR+OOallhlwvsE+EnBDcI4hPaae51II1eav/6XFSdox4/10kTnvxZXh
    OfKwt6lZ1GKP0r7yXUeAtgRXyjyZnX6TA0ivuMoMu3SB1xKUlehZq9XlBxR+NiAE
    7TcIkKzDtyVZOxy9Y6W8Ki0Jw1qEXbb8mnqXTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214495; bh=nhryQ9KFIqyL66UHhiAuQ2TCq3
    3rwFSt8FB+u9cJwOg=; b=iMdzuntwutNRJnVqQnfuld4IrJx+KDMI55L/c8l7wX
    k1neKcsoa5zninvsVEcxtbbqwIZSG9I7G88JXJDsi/Rv9mDilga1Co7aXQmsXHDQ
    SgKkC2NE2UuWamJ5n1DTBFacgDjuZEIylcvNI8u3L3j+b0sU6KoS544bZWXtX/1v
    Lt5rxejMswhqRWrwoMJs0r/Ze14CwNRThTPWf5Wk1qGuMYtRMOAnT19PB09JsGRg
    yK5LLsluGhWKUDHxp1z67l6Alqbl4g6xMb1kCn7Ikuy+qnIEpGWnUWkm4oZPbIuY
    OGIpyFZgYRrpgBpEXYydYvfl7XxKjrkpWUiUmNCdI9nA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933420AbeCPPex (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:34:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCPPev (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:34:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 025/109] dm mpath: fix passing integrity data
Date: Fri, 16 Mar 2018 16:22:54 +0100
Message-Id: <20180316152331.320267295@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Maier <maier@linux.vnet.ibm.com>

commit 8c5c147339d2e201108169327b1f99aa6d57d2cd upstream.

After v4.12 commit e2460f2a4bc7 ("dm: mark targets that pass integrity
data"), dm-multipath, e.g. on DIF+DIX SCSI disk paths, does not support
block integrity any more. So add it to the whitelist.

This is also a pre-requisite to use block integrity with other dm layer(s)
on top of multipath, such as kpartx partitions (dm-linear) or LVM.

Also, bump target version to reflect this fix.

Fixes: e2460f2a4bc7 ("dm: mark targets that pass integrity data")
Cc: <stable@vger.kernel.org> #4.12+
Bisected-by: Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-mpath.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1941,8 +1941,9 @@ static int multipath_busy(struct dm_targ
  *---------------------------------------------------------------*/
 static struct target_type multipath_target = {
 	.name = "multipath",
-	.version = {1, 12, 0},
-	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
+	.version = {1, 13, 0},
+	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE |
+		    DM_TARGET_PASSES_INTEGRITY,
 	.module = THIS_MODULE,
 	.ctr = multipath_ctr,
 	.dtr = multipath_dtr,
