Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802174-2-16635931290662506231
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802173; b=bnq3MbO4JEL8JcpcUEGQG2NSxtFJKqWSYrcvjCSlXtJNh9L
    8F6bB3q+IQtVWMv81qxilRwgCrujSDcP/VR32Iu7031LdEPPbuFw+aGO5lMnjrGa
    5CzDJYcjExTE2Mie27+0NHrbjijmBTVSjYMc+Gwg1a7m1Oh2PvpyQX38+4Q9h+k8
    WNR1pSi3ZbXa57Pp9gnTP7s87AAeGEkpSo7jgnTNqPyNPA6KtwxRzH6t9Mg5V3tV
    gPz4oTwDdBJX0SrreLQWPOOYu66KFwbkq5qeJffyirFX9fZsBEsnWi1aRCRBXP/U
    iWxatYdL6+ekKMtQHvEqfi1Yk1LFN9gho1uxR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802173; bh=BDOqnD1JQyzn0/AjcDAiOHABPF
    2fLnSAlLXfNy3q+Bs=; b=wzdJCOQdH1xBVNeaVRV2EyxUFUpCMTVFm8kMkE7IOl
    ynXpqnXOezG3hhv37OnujUfU1bojTx+Q6iJh7RzBe+BzYzSCbfDrgu4FY/d6htqk
    TDRj1lxh88yyGUgxSOqI2DSFJQKz0AkdxL5oCGFF4aa2+RnPU6frBRWuZQpta9kU
    3cOFfIRomGYsX9m7RUmHNfsu4hjzd7fltkXEyGOv8iHhBhCKyKZW9KQt6INoAKkw
    xOEHbDlg++JAouKRgBC+VHDYZCNN8+7gzrmBKTWsp4CgqEXulfwNlk05ZnEpW4Ef
    WP4xAVarvn+NcOARy4WK73v7ALSSlojy9frRkMbbzCww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeCWKOt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45366 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933345AbeCWKOq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vlad Tsyrklevich <vlad@tsyrklevich.net>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 44/97] infiniband/uverbs: Fix integer overflows
Date: Fri, 23 Mar 2018 10:54:31 +0100
Message-Id: <20180323094200.109336079@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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

From: Vlad Tsyrklevich <vlad@tsyrklevich.net>


[ Upstream commit 4f7f4dcfff2c19debbcdbcc861c325610a15e0c5 ]

The 'num_sge' variable is verfied to be smaller than the 'sge_count'
variable; however, since both are user-controlled it's possible to cause
an integer overflow for the kmalloc multiply on 32-bit platforms
(num_sge and sge_count are both defined u32). By crafting an input that
causes a smaller-than-expected allocation it's possible to write
controlled data out-of-bounds.

Signed-off-by: Vlad Tsyrklevich <vlad@tsyrklevich.net>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/uverbs_cmd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -2436,9 +2436,13 @@ ssize_t ib_uverbs_destroy_qp(struct ib_u
 
 static void *alloc_wr(size_t wr_size, __u32 num_sge)
 {
+	if (num_sge >= (U32_MAX - ALIGN(wr_size, sizeof (struct ib_sge))) /
+		       sizeof (struct ib_sge))
+		return NULL;
+
 	return kmalloc(ALIGN(wr_size, sizeof (struct ib_sge)) +
 			 num_sge * sizeof (struct ib_sge), GFP_KERNEL);
-};
+}
 
 ssize_t ib_uverbs_post_send(struct ib_uverbs_file *file,
 			    struct ib_device *ib_dev,
@@ -2664,6 +2668,13 @@ static struct ib_recv_wr *ib_uverbs_unma
 			ret = -EINVAL;
 			goto err;
 		}
+
+		if (user_wr->num_sge >=
+		    (U32_MAX - ALIGN(sizeof *next, sizeof (struct ib_sge))) /
+		    sizeof (struct ib_sge)) {
+			ret = -EINVAL;
+			goto err;
+		}
 
 		next = kmalloc(ALIGN(sizeof *next, sizeof (struct ib_sge)) +
 			       user_wr->num_sge * sizeof (struct ib_sge),
