Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518720192-2-8412572821347079638
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
    t=1518720191; b=a9UfpfNNcKG/llm27Fu2h7b3gizqUVTSXwjj181CUN2TRSX
    lo6irkRqJ4lhLQIfKVemkmFJUWxGq5eqeqjZB7Pswu6SjlVfDoYbFfQa5IsaFZ6h
    3msDYfQklkNavl/pOu/G7l8OjcLIwBVNijHJAo9MfR9GYBWmBOiq+2VFyl4rn40L
    y79QB72zsv5gxeRc0TfQVDrD3+kozPFqsi5OXyiGkWTJxAQsPjwVIjsChmYkGYcq
    s7rZaTmWvzkQTDe8bPoJAAhIPCR/yIZdsprl7Dg9bMfGqVamFsGQloYxdW30N1IO
    /uLxLC4SeTHnIvwlihWfktsiQuNiVmp4ZxfWVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720191; bh=Wq1NMvKuNthfPgYzbcUkO4HQeg
    VtKTmXTZYxvQHeRK0=; b=TnexiCgSxmwOjSTcQLQMIvDhhhrttPfqe4qT/ZZN+J
    W5nCAAyZjB39gb7QfDmwLddMrAiCEm1su0AEOElM03NyuWAhtDS8SxdysXq6+9oN
    ZEgRXFzxVwFtsHMINE2pkYuHBfm9krYrhSzHy2IN8uvsQkw2NVQ7m50rkplhBvbC
    BHhmvts0K7VCfbMVMytRCemRyOCJ9LQRuoKvqQHDdBwy3uCy+PewY7mTAGGeWlVh
    KM2bINwjtAKgkd6wwxkgZXUSEtEj8/GTy41irpJN3sw8Bpi1dyjUNpZxSknmDkT6
    T0XXFy97ilObTIgF73zNUSc6m3O/vw7Db83+Ya/J7b5w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162650AbeBOPX0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:23:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51066 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161910AbeBOPXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:23:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "J. Bruce Fields" <bfields@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>
Subject: [PATCH 4.4 061/108] NFS: commit direct writes even if they fail partially
Date: Thu, 15 Feb 2018 16:16:58 +0100
Message-Id: <20180215151230.988630891@linuxfoundation.org>
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

From: J. Bruce Fields <bfields@redhat.com>

commit 1b8d97b0a837beaf48a8449955b52c650a7114b4 upstream.

If some of the WRITE calls making up an O_DIRECT write syscall fail,
we neglect to commit, even if some of the WRITEs succeed.

We also depend on the commit code to free the reference count on the
nfs_page taken in the "if (request_commit)" case at the end of
nfs_direct_write_completion().  The problem was originally noticed
because ENOSPC's encountered partway through a write would result in a
closed file being sillyrenamed when it should have been unlinked.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/nfs/direct.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -787,10 +787,8 @@ static void nfs_direct_write_completion(
 
 	spin_lock(&dreq->lock);
 
-	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
-		dreq->flags = 0;
+	if (test_bit(NFS_IOHDR_ERROR, &hdr->flags))
 		dreq->error = hdr->error;
-	}
 	if (dreq->error == 0) {
 		nfs_direct_good_bytes(dreq, hdr);
 		if (nfs_write_need_commit(hdr)) {
