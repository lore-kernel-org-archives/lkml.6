Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3759000-1519416457-2-10060324596363911102
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
    t=1519416457; b=vwDdxxeAEyVl0d/MCFi0/d7dJTurckrYEaowyOoWPanJvq/
    B87aHrmcSVuDdYmfSENJGD83IgVBH993pKjS9cs/RI0xN5s+Ril8EAJXLUozXs+m
    4ySbzQf/AjyhVevfh12lzi1deeuZX8Kh84HlBxvQKpGIUXf20deWqDa0++RDlkuS
    hvDM45IKH5wrj1jUTl47BoUCRaf/sR9vqxC7gw9Dm41XytJC/tKgjLka9j8c2E+w
    +/swDFRh2if5QBW/W56iBGbllrheQTln4ks4eJ2tc/A7jnp9DiXOrIZILpQDbacz
    GTqYQhSiJTGg2T6tzlLAuef1+i3lXupVPXqKGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416457; bh=jkz3x4PTQ/KnIroJw+sCCSdS6b
    2T+LPZZW99XXUE20o=; b=eeRy5g6rt0RR7LUhJC6EMbxHyuFVv6qAmp839KSVb/
    Cb/p8K29nal66HoNAm2ahk6R43qMe4dZNn19osbS678WikYS3jN6zFJdKLqWlPAS
    myfJXM2zFMBFwH/8wnrAET1AHf697Gr8abO4JtkXExCCew989gvczGyn+/HbwBHV
    yZvyKyrNHOtxGY3gtroFfVdRI3hldjn26kMW0zFdpugm2TaMDfOxdE977XMBP9mO
    51StiYqwZmIDFFWkcLRDMysVAxbaay1C8230oR7f+aQUt5fhWnN1Cd/FT7G1O0+/
    13udsyOTEQoNvzSPsJ7eMtsMek8zDp+OF4oundTIflQw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933135AbeBWSmr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41918 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSmq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Douglas Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 019/145] blk_rq_map_user_iov: fix error override
Date: Fri, 23 Feb 2018 19:25:25 +0100
Message-Id: <20180223170727.146950163@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Gilbert <dgilbert@interlog.com>

commit 69e0927b3774563c19b5fb32e91d75edc147fb62 upstream.

During stress tests by syzkaller on the sg driver the block layer
infrequently returns EINVAL. Closer inspection shows the block
layer was trying to return ENOMEM (which is much more
understandable) but for some reason overroad that useful error.

Patch below does not show this (unchanged) line:
   ret =__blk_rq_map_user_iov(rq, map_data, &i, gfp_mask, copy);
That 'ret' was being overridden when that function failed.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-map.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -116,7 +116,7 @@ int blk_rq_map_user_iov(struct request_q
 	unsigned long align = q->dma_pad_mask | queue_dma_alignment(q);
 	struct bio *bio = NULL;
 	struct iov_iter i;
-	int ret;
+	int ret = -EINVAL;
 
 	if (!iter_is_iovec(iter))
 		goto fail;
@@ -145,7 +145,7 @@ unmap_rq:
 	__blk_rq_unmap_user(bio);
 fail:
 	rq->bio = NULL;
-	return -EINVAL;
+	return ret;
 }
 EXPORT_SYMBOL(blk_rq_map_user_iov);
 
