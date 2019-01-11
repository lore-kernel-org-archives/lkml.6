Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AADC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741522177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216982;
	bh=ven6ux7xPgrmAY0YOkjtsLZUnhxAM9scYAPdc8o/AOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=THh5gXR0J+nwOfhPEz/STa/z2QECRvho31wQbmThDz8wg0drQBI6KpTrWEWbGJizn
	 YVLAAzq7HSixTPAKbDVrPA4Rt+vnXlSCQaBtbrKycjx8oy6adtlJwSJpFhH8ziTjSS
	 Nyh1rSmQ7y6+qW2Levlyq+rAUqciwnMGgSVpcCRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbfAKO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:29:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388780AbfAKO3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:29:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE7721841;
        Fri, 11 Jan 2019 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216980;
        bh=ven6ux7xPgrmAY0YOkjtsLZUnhxAM9scYAPdc8o/AOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zT+yz7RR4jVPxoRrarfSybcGegh+MI78JiaGyUZDpj08NyRrPfo/m2RwMAYjAbgH9
         ma6/G8icYmTxvAn8gpk4rchAefQsUG7qk2Bdy4fqTUxYtktqKumeCb5thRDspVFr+g
         J/hp3aqr5B8Thg4eZSDfBfhcoAxA2/L3XRVzEEoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4.9 59/63] ceph: dont update importing caps mseq when handing cap export
Date:   Fri, 11 Jan 2019 15:15:02 +0100
Message-Id: <20190111131055.234170081@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131046.387528003@linuxfoundation.org>
References: <20190111131046.387528003@linuxfoundation.org>
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

From: Yan, Zheng <zyan@redhat.com>

commit 3c1392d4c49962a31874af14ae9ff289cb2b3851 upstream.

Updating mseq makes client think importer mds has accepted all prior
cap messages and importer mds knows what caps client wants. Actually
some cap messages may have been dropped because of mseq mismatch.

If mseq is left untouched, importing cap's mds_wanted later will get
reset by cap import message.

Cc: stable@vger.kernel.org
Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ceph/caps.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3343,7 +3343,6 @@ retry:
 			tcap->cap_id = t_cap_id;
 			tcap->seq = t_seq - 1;
 			tcap->issue_seq = t_seq - 1;
-			tcap->mseq = t_mseq;
 			tcap->issued |= issued;
 			tcap->implemented |= issued;
 			if (cap == ci->i_auth_cap)


