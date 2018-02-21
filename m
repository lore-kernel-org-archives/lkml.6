Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519218909-2-11729501942910315472
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218908; b=okWlQPPO5gFq08bVykzP6Dqr83bn05XiD5EU2df2VFdLgOB
    bEbD2R9ZNDEZaY43HmwPoaCblbJDnmDjh3s0Y9AVkFbojFF96i5wv1Xx4xpijTXJ
    iO8/u1S7fH7lABTDpURsVhMvO0efE38neGcKrsMWr5z/NACdJr2lsoxU0pA0wJHz
    m2U5Ns8hwQdDiFFm2PRJ85uN657RhZLRa379VZ+tPMjcf1MmCWD3lW6er72o3iAK
    7XFQrsjQj6UcGYNAGIaLedqHqsccaE3hbSBSjc++Q8Dpa68kkpp5AjqznIr9274K
    alL10g/ngqE8AGfhwm/BeXGGXdTzMhEJCN69bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218908; bh=hadewxZHm/0fGiSNmT3kTEWm9B
    9N2OMB8dxu7i8Srf8=; b=Ys5djejiRZ7svBz629iC95bw85AghB2+zNgeD1EDTh
    QHKhhGCMr9m9uRr07x2fMU1tHg+NixFtXXHC+VS8b6mLNQZMv9vQ2GHG05jFviJR
    zFHSzlQOI/RkcnTG7/FxZ8blFcaV+3pPoyCrPlzkf/6Hw91e7NKsl62Le3Q4UGXZ
    i9adKe5UhAnAQb73uMb4LP+kstOrx8pqb/iS8XCWdBqycPnlXWbI9GZs1fX9x5fY
    LYv9LGYDCln+71Nf4LSbR1i9eZcuNTx/k1RME5GyWZbe7+yAkV0ACCso+S0Ao4XD
    c4beVsWWTfAhTL7HFkcCmSjZzu73o+3Z57qT8trRXS+A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965707AbeBUNNT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:19 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753216AbeBUNNQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:16 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.15 134/163] dm: correctly handle chained bios in dec_pending()
Date: Wed, 21 Feb 2018 13:49:23 +0100
Message-Id: <20180221124537.599868211@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.com>

commit 8dd601fa8317243be887458c49f6c29c2f3d719f upstream.

dec_pending() is given an error status (possibly 0) to be recorded
against a bio.  It can be called several times on the one 'struct
dm_io', and it is careful to only assign a non-zero error to
io->status.  However when it then assigned io->status to bio->bi_status,
it is not careful and could overwrite a genuine error status with 0.

This can happen when chained bios are in use.  If a bio is chained
beneath the bio that this dm_io is handling, the child bio might
complete and set bio->bi_status before the dm_io completes.

This has been possible since chained bios were introduced in 3.14, and
has become a lot easier to trigger with commit 18a25da84354 ("dm: ensure
bio submission follows a depth-first tree walk") as that commit caused
dm to start using chained bios itself.

A particular failure mode is that if a bio spans an 'error' target and a
working target, the 'error' fragment will complete instantly and set the
->bi_status, and the other fragment will normally complete a little
later, and will clear ->bi_status.

The fix is simply to only assign io_error to bio->bi_status when
io_error is not zero.

Reported-and-tested-by: Milan Broz <gmazyland@gmail.com>
Cc: stable@vger.kernel.org (v3.14+)
Signed-off-by: NeilBrown <neilb@suse.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -817,7 +817,8 @@ static void dec_pending(struct dm_io *io
 			queue_io(md, bio);
 		} else {
 			/* done with normal IO or empty flush */
-			bio->bi_status = io_error;
+			if (io_error)
+				bio->bi_status = io_error;
 			bio_endio(bio);
 		}
 	}
