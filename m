Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F18C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE491217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277227;
	bh=6RjvFGh78mC10Iz3XalPr/34Y0LrgTFzVEm6GWXTLBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jBVg5TbL2hkaloFMNwkvNUtohoXx6mp1UMQH3pxcHVq4LreCSS0Tvgdu0Aq2ynVAW
	 wPTXUQDSWOdj0jGlQLVocj+a1no4Drs2v5opmgVc/JV3KA9s6davFm3yMD1tpoARiI
	 AqGa/w48HsNfALoGdOPjv4jhs8a1KOWPRzB+A3QU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731562AbfBDKrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:45330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731545AbfBDKrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2103217D6;
        Mon,  4 Feb 2019 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277223;
        bh=6RjvFGh78mC10Iz3XalPr/34Y0LrgTFzVEm6GWXTLBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h+M88l8IHIyDmvsCuJIFlDAW4t/gVyIjMtClm/qCRo5VS5sqlmfyehrTVXyKBs4+O
         2euYxUSBW097vJOm4d0DZBJuHhSzZryGIu8xYnhuMVd8TSZ/J0w2/lN3PZ7Ty6Tl+6
         MKtobvDlzWJVOjztlVh59k1qFi2qmB64s8HZ1EbY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, George Amanakis <gamanakis@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/74] tun: move the call to tun_set_real_num_queues
Date:   Mon,  4 Feb 2019 11:36:29 +0100
Message-Id: <20190204103621.686479583@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Amanakis <gamanakis@gmail.com>

[ Upstream commit 3a03cb8456cc1d61c467a5375e0a10e5207b948c ]

Call tun_set_real_num_queues() after the increment of tun->numqueues
since the former depends on it. Otherwise, the number of queues is not
correctly accounted for, which results to warnings similar to:
"vnet0 selects TX queue 11, but real number of TX queues is 11".

Fixes: 0b7959b62573 ("tun: publish tfile after it's fully initialized")
Reported-and-tested-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: George Amanakis <gamanakis@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tun.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -866,8 +866,6 @@ static int tun_attach(struct tun_struct
 		tun_napi_init(tun, tfile, napi, napi_frags);
 	}
 
-	tun_set_real_num_queues(tun);
-
 	/* device is allowed to go away first, so no need to hold extra
 	 * refcnt.
 	 */
@@ -879,6 +877,7 @@ static int tun_attach(struct tun_struct
 	rcu_assign_pointer(tfile->tun, tun);
 	rcu_assign_pointer(tun->tfiles[tun->numqueues], tfile);
 	tun->numqueues++;
+	tun_set_real_num_queues(tun);
 out:
 	return err;
 }


