Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8DC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B012420879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079033;
	bh=MKkmEPYRSLAp2IrMkL99Q3odUpyNmgjsUKjFH1+N6vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QYAOj+/p/4KYqGA39qa/wUDsBgB1Er45tSxoQHHwsoq0XCJS45UdAD+jbb5GbpJ3z
	 kpyn9bs6TjOQ6DhgE9TxG0nt0hoZfO4SPLtnSgxMbyzJrSB9QxPrji7Vek17V2D5X+
	 5J6LBGL7zAOY5buat84tcqPbISFTDcnWEwYV3lzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbfAUN4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731318AbfAUN4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:56:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC5720879;
        Mon, 21 Jan 2019 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078992;
        bh=MKkmEPYRSLAp2IrMkL99Q3odUpyNmgjsUKjFH1+N6vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1NTia49beA5S4wAjjxdmyx9QKB7hEsnzadSKVRq9FsqeCQxulwOJ3amUgWRk2Fb/t
         WsqvcTCLA14I1CeC+X5S5PeT31R3iEyxNdVYRtxoRXBHu5AURekB7QXpMiS1RnL2E4
         x0qrNAcdIoNbsLO0/MvhxwWvvh+w2s70QmNes3QY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.9 38/51] selinux: fix GPF on invalid policy
Date:   Mon, 21 Jan 2019 14:44:34 +0100
Message-Id: <20190121122457.387079145@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephen Smalley <sds@tycho.nsa.gov>

commit 5b0e7310a2a33c06edc7eb81ffc521af9b2c5610 upstream.

levdatum->level can be NULL if we encounter an error while loading
the policy during sens_read prior to initializing it.  Make sure
sens_destroy handles that case correctly.

Reported-by: syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 security/selinux/ss/policydb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -726,7 +726,8 @@ static int sens_destroy(void *key, void
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		ebitmap_destroy(&levdatum->level->cat);
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
 		kfree(levdatum->level);
 	}
 	kfree(datum);


