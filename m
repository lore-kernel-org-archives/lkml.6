Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E152C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3ABB214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216151;
	bh=cA5wIsK3G0ubxI5QPQUASVky4ckSyCmx9kRBgdJkEhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=izphp7uW2/ty0Q+5uyloIOGazeXP5OQGqyh9h+ca5+wxQct/CPov+lxMVXoOplyV7
	 mUdDhy6D8eB/bcYZdDPwZJzA3udjy/Fav9H6OVsHqhkb/V614Gy0yDNrxIwCxewxTS
	 +43zQzY3kgqbHX7DKD0prebMoyLOcpNQgm1c66k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbfAKOPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387468AbfAKOPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 982EC20874;
        Fri, 11 Jan 2019 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216147;
        bh=cA5wIsK3G0ubxI5QPQUASVky4ckSyCmx9kRBgdJkEhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtW691rZ5YNySw0X5RCB4S+7LvChn+SGXW9gj948FUB2metgBJrCFltSAFHcfhlWt
         yvmzX12PK1Bbo2T2lpUoAbcoLa4SYGF7rHOcUMeDv3uqwZRnF9qOftPVxOg4bLUQ64
         OB9zre2CreEyURQTIvFUkdY/0G8yxr300ckbvAu8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 3.18 39/47] dlm: possible memory leak on error path in create_lkb()
Date:   Fri, 11 Jan 2019 15:08:24 +0100
Message-Id: <20190111131001.147498819@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Averin <vvs@virtuozzo.com>

commit 23851e978f31eda8b2d01bd410d3026659ca06c7 upstream.

Fixes 3d6aa675fff9 ("dlm: keep lkbs in idr")
Cc: stable@kernel.org # 3.1

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dlm/lock.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -1210,6 +1210,7 @@ static int create_lkb(struct dlm_ls *ls,
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 


