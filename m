Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519217343-2-4036160069489191266
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
    t=1519217342; b=PXwBZKJxRzKpBMMf8pua5+8Uih1FiGlJa/LdCy+Om+bO4o8
    bayWZQk7mFLlDFXs57zUZWvU8sQMvKSgSuviodD9n6Xi2VQ5Cfr5XqlAgtlYzScC
    2TTtZbF81adcSeBNVZPu24ZQfHGGoNN634VmouL34cWf1bYh4lkF+0M/FqGVlVEi
    jlLbJv259CYVBd8ZqLKPQwUD+5fjSiFAuoUCYbS7ZKUkWRkY2Qpc8WGpuqXqNwq5
    IwdvH0gmDBdoG6mxbvoxKMHvWH+3QovOxI3WMWJAcg+PlAHyFWJ8jictzuNT+ffx
    3QoBDsyX/2ktU/l3c/exlqZ05e/svHM1wmJ/Ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217342; bh=6KXcr96LIE0i302yBZVuziF5/j
    5uVeSmAbXNpD/jTjA=; b=KOetsXuNWah0OENIVPxOFMHObXiBpYUzwaQThgEl4N
    DallOzVV2fbUL0AlmkoXiEC2bDeH7g9vZ/yYraOI3wx1chLyGK9bq2Afde0oAZjI
    ptPyGDMN9ui9HmT7T0EXyNW8IWHDD+7JWxGNwPN8M0ANrjwg6SM/Ziwa48Cv0vTJ
    FrFKGH2lyhIsWP01vN+svwAedJcGdtYCRZjHCePfFGZ76z3n0KLrBylioPavjccL
    GQjenpaRjSSZUaTOiBlnlgfUY/j4WYWstyAPCaJgtmDA2eUc4mz6Qy1RfRMLJlh4
    89SVhyIC6akqo2PHDiprOSh58fiOEVy3wIUge0hEj6Ow==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933924AbeBUMqd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59786 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933905AbeBUMqb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:31 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neilb@suse.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.4 28/33] dm: correctly handle chained bios in dec_pending()
Date: Wed, 21 Feb 2018 13:45:11 +0100
Message-Id: <20180221124411.045394813@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -974,7 +974,8 @@ static void dec_pending(struct dm_io *io
 		} else {
 			/* done with normal IO or empty flush */
 			trace_block_bio_complete(md->queue, bio, io_error);
-			bio->bi_error = io_error;
+			if (io_error)
+				bio->bi_error = io_error;
 			bio_endio(bio);
 		}
 	}
