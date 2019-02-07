Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28531C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C6C21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539852;
	bh=udosWZycVKCmAzWF5oS75tmvz342lbikJ3DehgwMCmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q3sfaSowDhQctFWZBqXSt8Xx2LOhyF28OtM/y+Ve6OuCdc2K5qS+5RgpRgFe1e+DZ
	 U/L47rJTHKlQgjSC47I/GRjQUFia2hcvKunAyd+UX53vEHverMlWrrM9vxSDMUCw45
	 dTlVVMsjWmoZP7hgCyW5P6knbxVmMTCzIPH2QECc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfBGLoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:44:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfBGLoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:44:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5C702080F;
        Thu,  7 Feb 2019 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539845;
        bh=udosWZycVKCmAzWF5oS75tmvz342lbikJ3DehgwMCmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Exavx/wGawBXL50PDh7VgqEvHtVSBrm9oBjfTvcZmEtxSXHqyt4cCz9ecpZLMf9G5
         G18qPmrrL1HR5wKY4B8goFpXgIO+RplWBGKauSKLfcmF51A2y/E+6MxTJdZ/b8+qC9
         DpE5PxPaCMknsbpwGZDwVbhGTINXIkPoU1qWlJ3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Rantala, Tommi" <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.4 34/34] rcu: Force boolean subscript for expedited stall warnings
Date:   Thu,  7 Feb 2019 12:42:16 +0100
Message-Id: <20190207113026.866667243@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

commit ec3833ed02ae6ef2a933ece9de7cbab0c64c699e upstream.

The cpu_online() function can return values other than 0 and 1, which
can result in subscript overflow when applied to a two-element array.
This commit allows for this behavior by using "!!" on the return value
from cpu_online() when used as a subscript.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: "Rantala, Tommi" <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/rcu/tree.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3817,7 +3817,7 @@ static void synchronize_sched_expedited_
 					continue;
 				rdp = per_cpu_ptr(rsp->rda, cpu);
 				pr_cont(" %d-%c%c%c", cpu,
-					"O."[cpu_online(cpu)],
+					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
 					"N."[!!(rdp->grpmask & rnp->expmaskinitnext)]);
 			}


