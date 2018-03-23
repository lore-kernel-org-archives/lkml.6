Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802410-2-15767274907225775405
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802409; b=Rb3LjBCVLiWAVoBxyFKOlCkvYBQ+Ga6xSrhO1N7WudGcJ7D
    1PwCv6Fxl+Yb1mIviboCvOUFtevQI1K+xkqVemVoig6awSjHn6CmJZGp9PCAmCil
    LWNkuae5AzOSsU64IAaZDHG3wwv3pxWb5/UzOxUzzStGhOc4V5n92PZOFKWFPLHp
    fp2Q0KAd6wWnY83Hp/qaGng1h+ybREltkyVWTUjKXxxLcRrW+5gPkNzBKPcpGgeg
    pJmIX0Uv6yYqKBvrMFT85S/wWwZtKGC2TC5pBDlhYvErltDpiTBGJFoJt/tgTwOD
    OgWFtpaVIIgddATM2JA1Y1hX1EUK6siCM7O9QoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802409; bh=Bu8DxgSe+AFTJ3LXRokFtnzlyt
    SNm+rt3O9SoR5A2+0=; b=KmXpAQm7s4Uh0SohOhnJSZBeIP02zvkDKXieahlU1E
    x3pL/KMzIdSdEopAsNJYFmW5yZu3jfQIlMtFWDXad5TG92MQoNeMDcUnZ8rEco92
    WG+sQ630MH1aA0EqIspz/tHLFN7OBOKyH7QO2mYy0xiOrxCogGZef6VnoBLGYdav
    k4s7KoUp9YWMcjP7fc+EIPvjaUQa81dsJ5QUg6m2s0L/AE6maV4Z71L8GjEHFyaP
    JnF7qEkPt74eR7z+2neH0ZsbFb0zMcf+T46OyGTOlptAxDzJH/klzYNx8og6YLWc
    9SSX55Gl0H5n8gTTauG1SnFTXaBrd3IdtNJdLQukAhxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeCWKxA (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:53:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44998 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755934AbeCWKNx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@primarydata.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 27/97] NFS: Fix missing pg_cleanup after nfs_pageio_cond_complete()
Date: Fri, 23 Mar 2018 10:54:14 +0100
Message-Id: <20180323094159.137676612@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>


[ Upstream commit 43b7d964ed30dbca5c83c90cb010985b429ec4f9 ]

Commit a7d42ddb3099727f58366fa006f850a219cce6c8 ("nfs: add mirroring
support to pgio layer") moved pg_cleanup out of the path when there was
non-sequental I/O that needed to be flushed.  The result is that for
layouts that have more than one layout segment per file, the pg_lseg is not
cleared, so we can end up hitting the WARN_ON_ONCE(req_start >= seg_end) in
pnfs_generic_pg_test since the pg_lseg will be pointing to that
previously-flushed layout segment.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: a7d42ddb3099 ("nfs: add mirroring support to pgio layer")
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfs/pagelist.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1273,8 +1273,10 @@ void nfs_pageio_cond_complete(struct nfs
 		mirror = &desc->pg_mirrors[midx];
 		if (!list_empty(&mirror->pg_list)) {
 			prev = nfs_list_entry(mirror->pg_list.prev);
-			if (index != prev->wb_index + 1)
-				nfs_pageio_complete_mirror(desc, midx);
+			if (index != prev->wb_index + 1) {
+				nfs_pageio_complete(desc);
+				break;
+			}
 		}
 	}
 }
