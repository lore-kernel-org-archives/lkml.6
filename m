Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790A3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A40208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6G8dgML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35A40208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbeKLIUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:20:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388712AbeKLIUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:35 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC6862154B;
        Sun, 11 Nov 2018 22:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975439;
        bh=kYackdTy1prGr0rKuxKzH/R7jX28YOIJYefXHTQJ75o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W6G8dgMLG7Bq9wWF4U4xUsvESuextZtHWtAGift1Lnwpb+5XEADrr5Y4LrKvW6D9P
         2OMvw9i26kJNnu8iyRmyERAv6CoFDajrYkZEhYQGvRB+JmyNEOOlsH3KpVediMXJir
         J9VlBUlIHYptLt/3o/EHmRuUMu2zBzfeuL/dzYk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4.18 191/350] OPP: Free OPP table properly on performance state irregularities
Date:   Sun, 11 Nov 2018 14:20:55 -0800
Message-Id: <20181111221716.015225573@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 2fbb8670b4ff4454f1c0de510f788d737edc4b90 upstream.

The OPP table was freed, but not the individual OPPs which is done from
_dev_pm_opp_remove_table(). Fix it by calling _dev_pm_opp_remove_table()
as well.

Cc: 4.18 <stable@vger.kernel.org> # v4.18
Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/opp/of.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -425,6 +425,7 @@ static int _of_add_opp_table_v2(struct d
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
+		_dev_pm_opp_remove_table(opp_table, dev, false);
 		goto put_opp_table;
 	}
 


