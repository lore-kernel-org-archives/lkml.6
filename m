Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B80FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40D820700
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550760416;
	bh=0QN1qWkZTytdjvVKMtg/YZz6+ERS0Qzj7ZXN1suIjr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FDensgnar1Zas1zsHmApCok6oNZHoaCue7dDNo6BUXg1QcTOBv6I38WPq5DT9yRsL
	 9ZSPDw7Zg0hJfkfTNqx7q0YNLRFcLeFJKxFlUW3HiQCSiINU3fcvJdchHx5ll+FuvP
	 vYp2kzzO6wnz6lbn5Nh1qRaL/C/qnXYfD34TArPs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbfBUOlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:41:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729325AbfBUOl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:41:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269412084D;
        Thu, 21 Feb 2019 14:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550760088;
        bh=0QN1qWkZTytdjvVKMtg/YZz6+ERS0Qzj7ZXN1suIjr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dp8+51zKWIeLILaoLYwNPuMqAfQWJ3SVixsb8uxy5N7LAHMakOmOPykFcM41Y9ADf
         O9HxX8AxUJjSnsjgNyUnrLkIlnBr0zxwZzggg6mb9fGXWjGf4xtGRH2VzEntdEkHnU
         Nbkryl3XMKwr/DtdI2TNGHuMvFxeAwFDNjwBUzQc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.19 22/30] scsi: target/core: Use kmem_cache_free() instead of kfree()
Date:   Thu, 21 Feb 2019 15:36:04 +0100
Message-Id: <20190221125251.797439101@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221125250.543158526@linuxfoundation.org>
References: <20190221125250.543158526@linuxfoundation.org>
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

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 8b2db98e814a5ec45e8800fc22ca9000ae0a517b upstream.

memory allocated by kmem_cache_alloc() should be freed using
kmem_cache_free(), not kfree().

Fixes: ad669505c4e9 ("scsi: target/core: Make sure that target_wait_for_sess_cmds() waits long enough")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/target_core_transport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -266,7 +266,7 @@ struct se_session *transport_alloc_sessi
 	}
 	ret = transport_init_session(se_sess);
 	if (ret < 0) {
-		kfree(se_sess);
+		kmem_cache_free(se_sess_cache, se_sess);
 		return ERR_PTR(ret);
 	}
 	se_sess->sup_prot_ops = sup_prot_ops;


