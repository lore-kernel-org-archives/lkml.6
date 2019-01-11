Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E8C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3C2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217631;
	bh=UOdzwU+SPY92oRjHbsCbeqtGlHkhSteNjOpf+XoZmeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gpFqb+91pI8me8ad6ZP6EmztSeoGW6JKJc7p+FLaJksgWdVdZXdCr4/+eD+CNRM42
	 ngWpjcUFZ18lz5eZIs1oaubKEGOH1nd5KlH2lN7pRN+g5YVqhWEsEkFIVOveJ9W94G
	 SFjQPY4ZX4tzb5Fe/qf+CZOQ9hPFRex32aFccSVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391237AbfAKOka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:40:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391207AbfAKOk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:40:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8308206B6;
        Fri, 11 Jan 2019 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217628;
        bh=UOdzwU+SPY92oRjHbsCbeqtGlHkhSteNjOpf+XoZmeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=btpBoXUp3PYeZ2/aomEruqQhflwtm/rDSpThjf1SdtTlNtBDQGz9pTW8BuRX93TQR
         QPgStjtl3HBL+bdkK4YdoAyH4CTbqibVRPx+vIyoEFa+YSaHlxd+2tEDHhb0cXPnRH
         Z32HD2WifyT7rjxaaf4an20oFsu/m88nF9U2siRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com,
        Dominique Martinet <dominique.martinet@cea.fr>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: [PATCH 4.19 131/148] 9p/net: put a lower bound on msize
Date:   Fri, 11 Jan 2019 15:15:09 +0100
Message-Id: <20190111131119.509618306@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

From: Dominique Martinet <dominique.martinet@cea.fr>

commit 574d356b7a02c7e1b01a1d9cba8a26b3c2888f45 upstream.

If the requested msize is too small (either from command line argument
or from the server version reply), we won't get any work done.
If it's *really* too small, nothing will work, and this got caught by
syzbot recently (on a new kmem_cache_create_usercopy() call)

Just set a minimum msize to 4k in both code paths, until someone
complains they have a use-case for a smaller msize.

We need to check in both mount option and server reply individually
because the msize for the first version request would be unchecked
with just a global check on clnt->msize.

Link: http://lkml.kernel.org/r/1541407968-31350-1-git-send-email-asmadeus@codewreck.org
Reported-by: syzbot+0c1d61e4db7db94102ca@syzkaller.appspotmail.com
Signed-off-by: Dominique Martinet <dominique.martinet@cea.fr>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/9p/client.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -181,6 +181,12 @@ static int parse_opts(char *opts, struct
 				ret = r;
 				continue;
 			}
+			if (option < 4096) {
+				p9_debug(P9_DEBUG_ERROR,
+					 "msize should be at least 4k\n");
+				ret = -EINVAL;
+				continue;
+			}
 			clnt->msize = option;
 			break;
 		case Opt_trans:
@@ -993,10 +999,18 @@ static int p9_client_version(struct p9_c
 	else if (!strncmp(version, "9P2000", 6))
 		c->proto_version = p9_proto_legacy;
 	else {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned an unknown version: %s\n", version);
 		err = -EREMOTEIO;
 		goto error;
 	}
 
+	if (msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "server returned a msize < 4096: %d\n", msize);
+		err = -EREMOTEIO;
+		goto error;
+	}
 	if (msize < c->msize)
 		c->msize = msize;
 
@@ -1055,6 +1069,13 @@ struct p9_client *p9_client_create(const
 	if (clnt->msize > clnt->trans_mod->maxsize)
 		clnt->msize = clnt->trans_mod->maxsize;
 
+	if (clnt->msize < 4096) {
+		p9_debug(P9_DEBUG_ERROR,
+			 "Please specify a msize of at least 4k\n");
+		err = -EINVAL;
+		goto free_client;
+	}
+
 	err = p9_client_version(clnt);
 	if (err)
 		goto close_trans;


