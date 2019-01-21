Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E0C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00DFB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078595;
	bh=zMcXSkkqS1g6gk6cAGN6H5KrY7Fw3eG3BGc0+dVgO1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j1oIIHErcMKM3xqVa02TIvsbB8muEN11HPTXffYBDsF2FhQ7ANcp6LJzFedRu3Tnd
	 Bbu6+1pKVt9hao4OUZdcKYV2T2XAHt+icX97i04eRYHx+d8m8gwk8buAtahmO05zua
	 bJckID1Q1DtkYafsH3/ZSD7AfPPZxHWIg6GOtAfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfAUNtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbfAUNtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:49:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5C7A20861;
        Mon, 21 Jan 2019 13:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078590;
        bh=zMcXSkkqS1g6gk6cAGN6H5KrY7Fw3eG3BGc0+dVgO1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xz/AzdTCDKHxr/qF+9zuz+1AkIlsKAvk9ArWB5lsb1OBPLpj4DR8oPZ6S+5VzNlb6
         SfEk7oP4VkDKxayLzs463EyC5uhBRmA0C9FuuaJ0uNwTrh3zK/qrdnuAlX1o1mrnVc
         LArTS/FAuxOFv3sVEUKqKutCLMzCB+IVbchb9tSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+6664500f0f18f07a5c0e@syzkaller.appspotmail.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Paul Moore <paul@paul-moore.com>
Subject: [PATCH 4.20 084/111] selinux: fix GPF on invalid policy
Date:   Mon, 21 Jan 2019 14:43:18 +0100
Message-Id: <20190121122505.443434965@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -732,7 +732,8 @@ static int sens_destroy(void *key, void
 	kfree(key);
 	if (datum) {
 		levdatum = datum;
-		ebitmap_destroy(&levdatum->level->cat);
+		if (levdatum->level)
+			ebitmap_destroy(&levdatum->level->cat);
 		kfree(levdatum->level);
 	}
 	kfree(datum);


