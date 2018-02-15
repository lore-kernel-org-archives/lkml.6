Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720465-2-16555721634847465696
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
    t=1518720465; b=R3nhIdKSAbXlNzJildKNDYh2OsEWge0/R/p2Vd1z8fWhX7X
    qpJOGAPQcuYzQJ0Joxj0lxy7Hc1mA+vcMA1+Q8NGXvlGUxh/6cq7XW58IGRUq/VD
    n8ZTs5snIeK6I/utH5IgHO2stfBVGYDLs8UYoC9CwaBziLVtqhnzNcfl/lF10smy
    gZ8vn7LPCFviWHmSzTHDA7WYyvnrOguKE6+G6iRIlMwYS/fC7NPT2rOSgT24oYz2
    90Gc4ImC57BEHh7oM92h+mb3aeH0XeyYpCmu9wOHv2d5Y3s1mfG67rx85W86TBHo
    OsCZwX5TZUJt/cadpmDkMTsDAPHz929MOAwWncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720465; bh=nyuKq6xklvsZsqYXP/wA6Y5I/B
    B6xKfOueonHWnMTrg=; b=e7JqRYl+Y6mWVFV2ALx3qf8n9TjRzGoOYnf7kp7lZa
    T6ce2XNNobihVD+03VT6K2aysMaLdHY4zQf3EOls3pWH2YwqM7bCoZJK8/7/Qj2g
    67kY2C5zX0sYyNdD7qXIjkboOWP8p9udahT7NLUa7yC2/JO0Zdf0j9/SCLtZ90nR
    mv7nqvNrSVps+zOLy9TyjoLWH1j6XRaF3aqO5HVhtpvUZwnfzqVdPGi24a1OMk9W
    hvghDOV1Uchxd+7m3VKQyhf8lCkbb8LCXuEikphpbMV+BV2n0hqKi+iGzeV1VveW
    irl8Yz3quqv+cXnaA13w3mkM5oc3ceVGYqSuh6O1/NQw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162386AbeBOSr1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:47:27 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49490 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162358AbeBOPWS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:22:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel N Pettersson <danielnp@axis.com>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH 4.4 041/108] cifs: Fix autonegotiate security settings mismatch
Date: Thu, 15 Feb 2018 16:16:38 +0100
Message-Id: <20180215151228.157301627@linuxfoundation.org>
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

From: Daniel N Pettersson <danielnp@axis.com>

commit 9aca7e454415f7878b28524e76bebe1170911a88 upstream.

Autonegotiation gives a security settings mismatch error if the SMB
server selects an SMBv3 dialect that isn't SMB3.02. The exact error is
"protocol revalidation - security settings mismatch".
This can be tested using Samba v4.2 or by setting the global Samba
setting max protocol = SMB3_00.

The check that fails in smb3_validate_negotiate is the dialect
verification of the negotiate info response. This is because it tries
to verify against the protocol_id in the global smbdefault_values. The
protocol_id in smbdefault_values is SMB3.02.
In SMB2_negotiate the protocol_id in smbdefault_values isn't updated,
it is global so it probably shouldn't be, but server->dialect is.

This patch changes the check in smb3_validate_negotiate to use
server->dialect instead of server->vals->protocol_id. The patch works
with autonegotiate and when using a specific version in the vers mount
option.

Signed-off-by: Daniel N Pettersson <danielnp@axis.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/smb2pdu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -580,8 +580,7 @@ int smb3_validate_negotiate(const unsign
 	}
 
 	/* check validate negotiate info response matches what we got earlier */
-	if (pneg_rsp->Dialect !=
-			cpu_to_le16(tcon->ses->server->vals->protocol_id))
+	if (pneg_rsp->Dialect != cpu_to_le16(tcon->ses->server->dialect))
 		goto vneg_out;
 
 	if (pneg_rsp->SecurityMode != cpu_to_le16(tcon->ses->server->sec_mode))
