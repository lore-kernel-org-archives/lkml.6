Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802530-2-8953633286224955477
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
    t=1521802530; b=EPUnzabxwncPUIR45Sbf50063hKhdBEn7NOLrGijBxvaDi6
    2aH0tBsp1G2axNzpFb2JthJH4QwJiIpP3OvtTFImh7anq3KcPYzgFUWarAvnMMYY
    yAMn1KJMKBBM/WZmRGpicJ57wCal8QSAwdDpp6EIHemIsDxs6OozlhlG3t+OdUR+
    S49cSdlnlc+HNI5fctGtwOiZ4BNix5xX2rSsNWBGCw0ngNVfv4NOsYe76y3AkhEj
    +OcP9RphONXkIj2mTf1WqjwcMUEkx1dTjM9k+XTRZfRExeQbcq/+VJRM0ZKJ0SFP
    EhOUyaXotLXpIbZMK+hUIuhCwXA6BTbitEkvNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802530; bh=OrWy35bBzeterRcezIZxSf3ge9
    SWbXmkvhGWK8TeC/0=; b=jn6AZeB7MptG4aCIjhrC64vkLZgEZB/3FSetdG6Jqi
    +D9MWBJ+Xism3sdyQFlHWIMFWiuYjJllNcMkPiKdi8akwvRFmimFZgZv6UzHncpw
    IK0zkL/QT4OeLZNG5I7oGdgeZqqrl7r7Cmszy7jgMKuaWzN8ON/EEoKHSpQT1YGf
    sB+d5SIOLQCofHq4ViZZIRqZXVSX2a9Q4fnE2KDMDD6MY1zd1GJ5u+hLhSsvzhZ9
    LRoqvDPRAMRCHcFDGuAt4UM15bTRq1iV+fKN+1JQKGIvCkSHp1Cvb3GzwLDWGyGp
    XEUHl6VF6eWGMPaeMQlZZWx3uTSevGWneL4YDU+7vftQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1755843AbeCWKNX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44784 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755832AbeCWKNW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <smfrench@gmail.com>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [PATCH 4.4 03/97] SMB3: Validate negotiate request must always be signed
Date: Fri, 23 Mar 2018 10:53:50 +0100
Message-Id: <20180323094157.732693350@linuxfoundation.org>
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

From: Steve French <smfrench@gmail.com>

commit 4587eee04e2ac7ac3ac9fa2bc164fb6e548f99cd upstream.

According to MS-SMB2 3.2.55 validate_negotiate request must
always be signed. Some Windows can fail the request if you send it unsigned

See kernel bugzilla bug 197311

CC: Stable <stable@vger.kernel.org>
Acked-by: Ronnie Sahlberg <lsahlber.redhat.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1558,6 +1558,9 @@ SMB2_ioctl(const unsigned int xid, struc
 	} else
 		iov[0].iov_len = get_rfc1002_length(req) + 4;
 
+	/* validate negotiate request must be signed - see MS-SMB2 3.2.5.5 */
+	if (opcode == FSCTL_VALIDATE_NEGOTIATE_INFO)
+		req->hdr.Flags |= SMB2_FLAGS_SIGNED;
 
 	rc = SendReceive2(xid, ses, iov, num_iovecs, &resp_buftype, 0);
 	rsp = (struct smb2_ioctl_rsp *)iov[0].iov_base;
