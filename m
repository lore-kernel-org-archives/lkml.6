Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521561-1519218805-2-14089200014710879454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519218805; b=Jdmdme7KvVpce6xFDAqln2f6q7MF4bBnQF23/7deEqgueDF
    t3ruJJ+oJt6Iz52/R0JsAO6tlW0+ZMWrybk/QRpjE2UEpt7KA6GzFF8DseXtHIoP
    SILriBeZ635RgLXkvHXzD0CPDmm24qZIPYKsG8CxtcoYT7IIpg/X+/T8mm3Kq4o7
    PIGnOt0kd0M5y3TqB+MUVWd227/APbr1eQ73UcQVFydoiuID4zeSOWHHP4ba/da9
    8cf9RZmzGK+Qdts3gCTKmQ8ZL+wy2XuhD+L4FV0K8PqZEQ+fKDw6M/v9oy0fwDVZ
    4zEuXugEkQQvMj2HenYmx36Er0HpTw6t4BCI2CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519218805; bh=TZuQIvJJJx9szFGOHZGNWWSSU7
    MCpfi+nRTFS3+qMYc=; b=seA4cZIxsamYgH51Al51Mz1INjBhKjflhbUhLhEeBl
    dLDpcxDPM22527ocE9jCxGMqu4n0kpbqMbw+yHMlYlj9Aba+XsjfIIYI4RRM9S5g
    NkZGzYiqYXcRr+bhbM5fJOEIBO3bqB021o8eYPfltnaajeTTO4yXL3ueblejl92m
    F+a6HzOwmr7RIZtzAh4FUfP09ClLVEKuKXr291jL4EN4XabnzWXSKolbElJ+kYqq
    aNVpNZXv2VQFE11QwQaeB5HxL5GhBJylesx9OEguHM/Ca6uErohBL7Gm8zWeqrE5
    lLBMpYxURcC9i+TAXb/UKdMSRuUAMmMlzbgZ7mhaj0iQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbeBUNNS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:13:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeBUNNN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:13:13 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Christie <mchristi@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>
Subject: [PATCH 4.15 133/163] iscsi-target: make sure to wake up sleeping login worker
Date: Wed, 21 Feb 2018 13:49:22 +0100
Message-Id: <20180221124537.534820304@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 1c130ae00b769a2e2df41bad3d6051ee8234b636 upstream.

Mike Christie reports:
  Starting in 4.14 iscsi logins will fail around 50% of the time.

Problem appears to be that iscsi_target_sk_data_ready() callback may
return without doing anything in case it finds the login work queue
is still blocked in sock_recvmsg().

Nicholas Bellinger says:
  It would indicate users providing their own ->sk_data_ready() callback
  must be responsible for waking up a kthread context blocked on
  sock_recvmsg(..., MSG_WAITALL), when a second ->sk_data_ready() is
  received before the first sock_recvmsg(..., MSG_WAITALL) completes.

So, do this and invoke the original data_ready() callback -- in
case of tcp sockets this takes care of waking the thread.

Disclaimer: I do not understand why this problem did not show up before
tcp prequeue removal.

(Drop WARN_ON usage - nab)

Reported-by: Mike Christie <mchristi@redhat.com>
Bisected-by: Mike Christie <mchristi@redhat.com>
Tested-by: Mike Christie <mchristi@redhat.com>
Diagnosed-by: Nicholas Bellinger <nab@linux-iscsi.org>
Fixes: e7942d0633c4 ("tcp: remove prequeue support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/target/iscsi/iscsi_target_nego.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -432,6 +432,9 @@ static void iscsi_target_sk_data_ready(s
 	if (test_and_set_bit(LOGIN_FLAGS_READ_ACTIVE, &conn->login_flags)) {
 		write_unlock_bh(&sk->sk_callback_lock);
 		pr_debug("Got LOGIN_FLAGS_READ_ACTIVE=1, conn: %p >>>>\n", conn);
+		if (iscsi_target_sk_data_ready == conn->orig_data_ready)
+			return;
+		conn->orig_data_ready(sk);
 		return;
 	}
 
