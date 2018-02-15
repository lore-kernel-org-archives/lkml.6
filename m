Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518711018-2-2497050462083491059
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
    t=1518711017; b=t9Jv76/2bYixCIRJWsAvUUIzR2aA6MtKpuBhwijxR3j1owK
    0W30bFvl5RHCPWLKJ1whUwOTN72rljpUfpdEHz92Yg3sfhMy/04jrvLNSI+EgWdo
    P5u/qlYyLQzq342m+5nQWA8s4odjZ02HQh0IPe1LM0lY3OxXwV0kRhwK7JVIobUk
    47hyjiRWxIU529ASanxv80cbDjWJqJNBvvISYnE6FO6IOLPlC9S4HyFxkISwBkng
    GedNtod2mpv8nAApLo65N+kxbCdKPP24zI1tzVvr3EwV0h+dnVKRY7QiV1pkBkb0
    Te5RPlD6FInlxPiBkypTdQzHA6Wz3LQDOTJdwkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518711017; bh=lcyEYzbhMr1AkNyjrn6xYHAhYX
    0JO1iDG4we3xALJCM=; b=wIt0Qb6y3dWFmLIEeCiw7MKngpTCENytSWgyTP/Ot+
    YT3IeX01nwchDT9GoNstVgYMbQ2hyZ75VyhZN1ZYAQ2Svl9GDZ4sA/bbdEa7qOMV
    D87JxriNHp65bl4slsNq+1mwZISLuOJIgSYoIzWERSvO1XK9KYcVyoHhAetKNrcF
    LDcd15TP0wIVJvO7qmovUGF2/amKJCtrxY/fIHvppl2MX+9kHav3NKFBBY2dqL8G
    mGoMvS+CECvf44TvyE8xHwNbSw8WxUOlUYuak6yfLQM/UXVoToKhmW+DTIsefCCN
    hBeWAOa7xGorrG+M+FJ5UZfWx3feYLI6a2k7EvO5NuDw==
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
        id S1424626AbeBOQIP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:08:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34984 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424477AbeBOPp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Daniel Scheller <d.scheller@gmx.net>
Subject: [PATCH 4.15 150/202] media: dvb_frontend: be sure to init dvb_frontend_handle_ioctl() return code
Date: Thu, 15 Feb 2018 16:17:30 +0100
Message-Id: <20180215151720.826401890@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <mchehab@s-opensource.com>

commit a9cb97c3e628902e37583d8a40bb28cf76522cf1 upstream.

As smatch warned:
	drivers/media/dvb-core/dvb_frontend.c:2468 dvb_frontend_handle_ioctl() error: uninitialized symbol 'err'.

The ioctl handler actually got a regression here: before changeset
d73dcf0cdb95 ("media: dvb_frontend: cleanup ioctl handling logic"),
the code used to return -EOPNOTSUPP if an ioctl handler was not
implemented on a driver. After the change, it may return a random
value.

Fixes: d73dcf0cdb95 ("media: dvb_frontend: cleanup ioctl handling logic")
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Tested-by: Daniel Scheller <d.scheller@gmx.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/dvb-core/dvb_frontend.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2110,7 +2110,7 @@ static int dvb_frontend_handle_ioctl(str
 	struct dvb_frontend *fe = dvbdev->priv;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	int i, err;
+	int i, err = -EOPNOTSUPP;
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
@@ -2145,6 +2145,7 @@ static int dvb_frontend_handle_ioctl(str
 			}
 		}
 		kfree(tvp);
+		err = 0;
 		break;
 	}
 	case FE_GET_PROPERTY: {
@@ -2196,6 +2197,7 @@ static int dvb_frontend_handle_ioctl(str
 			return -EFAULT;
 		}
 		kfree(tvp);
+		err = 0;
 		break;
 	}
 
