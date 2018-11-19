Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2462086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBIEf+eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2462086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbeKTDBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:32940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730931AbeKTDBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:01:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE14206BA;
        Mon, 19 Nov 2018 16:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645420;
        bh=ZcLCg0n1QsEvzfXnxxWUfMH1/ZoSpQHEEURJ4Q7XhEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bBIEf+ehMV//dH/tBpFxoodEhuJvnNn30V6V3t8glY01Ug8jte/Hi17Ms+J9zTdEO
         qvN7V//LnZD06h34sg3CeuQK3FJvE3JqZHaIQrlCOHgj82xM7l8Cy2tzfxekdx6lfv
         xgZZ33zJBr/bo5tIVXCFYHvl+Vb+V33nI5kASSfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 4.19 156/205] NFSv4: Dont exit the state manager without clearing NFS4CLNT_MANAGER_RUNNING
Date:   Mon, 19 Nov 2018 17:27:43 +0100
Message-Id: <20181119162639.136105635@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

commit 21a446cf186570168b7281b154b1993968598aca upstream.

If we exit the NFSv4 state manager due to a umount, then we can end up
leaving the NFS4CLNT_MANAGER_RUNNING flag set. If another mount causes
the nfs4_client to be rereferenced before it is destroyed, then we end
up never being able to recover state.

Fixes: 47c2199b6eb5 ("NFSv4.1: Ensure state manager thread dies on last ...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/nfs4state.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2583,11 +2583,12 @@ static void nfs4_state_manager(struct nf
 		nfs4_clear_state_manager_bit(clp);
 		/* Did we race with an attempt to give us more work? */
 		if (clp->cl_state == 0)
-			break;
+			return;
 		if (test_and_set_bit(NFS4CLNT_MANAGER_RUNNING, &clp->cl_state) != 0)
-			break;
+			return;
 	} while (refcount_read(&clp->cl_count) > 1);
-	return;
+	goto out_drain;
+
 out_error:
 	if (strlen(section))
 		section_sep = ": ";
@@ -2595,6 +2596,7 @@ out_error:
 			" with error %d\n", section_sep, section,
 			clp->cl_hostname, -status);
 	ssleep(1);
+out_drain:
 	nfs4_end_drain_session(clp);
 	nfs4_clear_state_manager_bit(clp);
 }


