Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8544FC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6163821916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeLUQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:42:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41190 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729043AbeLUQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:42:25 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gaNsR-0001Fb-KU; Fri, 21 Dec 2018 16:42:19 +0000
Date:   Fri, 21 Dec 2018 16:42:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] smack: Fix a memory leak in smack_add_opt()
Message-ID: <20181221164219.GZ2217@ZenIV.linux.org.uk>
References: <20181221090958.GE2735@kadam>
 <20181221163654.GY2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221163654.GY2217@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 04:36:54PM +0000, Al Viro wrote:
> On Fri, Dec 21, 2018 at 12:09:58PM +0300, Dan Carpenter wrote:
> > The function is leaking "opts" on the error paths.
> > 
> > Fixes: 90e3b564ab93 ("smack: take the guts of smack_parse_opts_str() into a new helper")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> D'oh...  Applied, thanks for spotting that braino.

On the other hand, it's easier to do it this way - the caller will free the damn thing
on error, anyway:

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 11da1e2531c8..cf0c0380e5dd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -608,6 +608,7 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 		opts = kzalloc(sizeof(struct smack_mnt_opts), GFP_KERNEL);
 		if (!opts)
 			return -ENOMEM;
+		*mnt_opts = opts;
 	}
 	if (!s)
 		return -ENOMEM;
@@ -639,7 +640,6 @@ static int smack_add_opt(int token, const char *s, void **mnt_opts)
 		opts->fstransmute = s;
 		break;
 	}
-	*mnt_opts = opts;
 	return 0;
 
 out_opt_err:
