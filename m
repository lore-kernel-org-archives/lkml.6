Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2179907-1518720145-2-7110416264369030286
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518720144; b=JvEm/RI3BFcTSV0YvfEUoAsCEynlW1X0cxa0YJI1C55RnLp
    hJM1QonoWzNct5QbYIVddVGxdL5Z+zu4c50Efm9tn2/6qILBdxIK+LLoLzE5utBO
    o/ssXDiAa2d9LEtF73F36LROFj17ACNoeKJdPkMIY3F8tU/faHAk/SPHaebSHRrW
    HUD+nbmA92sGXxe8hXPBct81hbiuZ79m9cPtWc/wNWJEmxi29aJuroUzLI8m72hr
    hdrlbfDR9gtzE4yubcG1p3RfmUkYK0FzuV8q3w45Iq40Od4dgOoD4Pzfto5VwkX4
    tcOEVV2q6k32Wntzt25n3CcDCLQ2P9mM1xOGHSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720144; bh=E50h4MA41GT56MYs7sOz3dhHP8
    wIOsuZR58+cf8zwp0=; b=LDHbONest9Wq2KOsoTF8aRqR2mjbs9dQYOFBelxcJK
    jQ6rZpqFw9ZXV3xFbNsBTm6rjR1cUHVQN8/vo9GgwfcG+UbWc1sy56uLBwLlalJo
    qF4G/I6TPQYt9TPr/bASqTNj2SgMWSsJVyTYfsIqn7d1jSt1DBH36hXcWcd7jjit
    bl56RIC+WAJN3tLeaayM+X7jFVLmJ4KaSIm/M13Cg3XmutydImn2eoWMmEvA5m0Q
    8V8/OBDFKsXduE/sp7K48Cvuef7DfJwKr4uodBYNKuXDBXxQ2cHfLAFAKOtFtJ+l
    6kwHPqzeVpKGrrRetvNi2jny3CvyBAXqbGaZYKrCGiUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161947AbeBOPXk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51310 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162688AbeBOPXe (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Ivan Vecera <ivecera@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.4 063/108] kernfs: fix regression in kernfs_fop_write caused by wrong type
Date: Thu, 15 Feb 2018 16:17:00 +0100
Message-Id: <20180215151231.206819040@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

commit ba87977a49913129962af8ac35b0e13e0fa4382d upstream.

Commit b7ce40cff0b9 ("kernfs: cache atomic_write_len in
kernfs_open_file") changes type of local variable 'len' from ssize_t
to size_t. This change caused that the *ppos value is updated also
when the previous write callback failed.

Mentioned snippet:
...
len = ops->write(...); <- return value can be negative
...
if (len > 0)           <- true here in this case
        *ppos += len;
...

Fixes: b7ce40cff0b9 ("kernfs: cache atomic_write_len in kernfs_open_file")
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/kernfs/file.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -272,7 +272,7 @@ static ssize_t kernfs_fop_write(struct f
 {
 	struct kernfs_open_file *of = kernfs_of(file);
 	const struct kernfs_ops *ops;
-	size_t len;
+	ssize_t len;
 	char *buf;
 
 	if (of->atomic_write_len) {
