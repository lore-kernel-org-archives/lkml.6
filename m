Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5F4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5EC20872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217768;
	bh=2Bfq2t4gLVive4tIbhGkyAzlpIxxWfJU6LqhtumUFUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HTvNWmNYrfmBwJyKd5135+w/vyN4IAYTD+/caKg7+kNAxcvq0MKGkVV2Yz5gZvlAo
	 TtBfGK6DY44XniBRFZkos50VzrEtwVXXEFNsK1b+Wj7PvZ75werZYAiz7c7rAyQUlJ
	 4W8DWtVB09Q7l8Sn9WLbcFNg0cH14LxCTwz7e0I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbfAKOmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404218AbfAKOmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E63320872;
        Fri, 11 Jan 2019 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217763;
        bh=2Bfq2t4gLVive4tIbhGkyAzlpIxxWfJU6LqhtumUFUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usImlUFPWJo5H/lNImPm7fpisF7W2dSwjmokhsMpoAX/Taqnzgp5h2qYYTynR+O43
         VyBmWi0SrC4Q8RWkBWDCsDYsW5I2xX6H24OxG97Mt0hsO2zGKCHOqbsczgGceJQ5GC
         r+Mf/u9RYEpTkjJvApv4YJW31dHOxWxSyxxfnUvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        David Teigland <teigland@redhat.com>, stable@kernel.org
Subject: [PATCH 4.20 30/65] dlm: possible memory leak on error path in create_lkb()
Date:   Fri, 11 Jan 2019 15:15:16 +0100
Message-Id: <20190111131100.497920209@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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
@@ -1209,6 +1209,7 @@ static int create_lkb(struct dlm_ls *ls,
 
 	if (rv < 0) {
 		log_error(ls, "create_lkb idr error %d", rv);
+		dlm_free_lkb(lkb);
 		return rv;
 	}
 


