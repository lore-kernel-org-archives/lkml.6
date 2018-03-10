Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641152-2-3913359326436171777
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641152; b=jFjz+09fzOBgJKvU2yOIcHok2C8lA48+0HpJoyX+t84Ajdk
    +7AsuwfbrE2BCfg6dpScRf2XLRqP2FcB3MrL4FsUMEL5rblRGQXuIJD51nwNNcUw
    1eqUo0o5FrT4sZ/42ybaBQ44UeoBxZ+lpt/mVK8uc3Nm0D4Z/ygKB+paXOMpJVfs
    8nwgu6+2IGZF6W87d8r3g6Q/JkNc4nosK2NL1HE81ElkCDYPtxDnxMwiGIWOMBWB
    edGPr82UXASf+uuvfcWIKJdvs+GqotAgYwL/Isz3d5PL/AodWxitQjVBjTm80C1G
    zPilYzB2eRbTpoH5WUiHbI3n9g4lya++RksrEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641152; bh=6d48tajXMes9+wsB8Rnn0Z33nw
    v+3LbJBj+cE20j0wY=; b=P+cFSARpEj6V48M/pJo4VUhEuoi/CkBpuZS81p4XDQ
    U7UDwzXwoxGHtpWa7rGn+3qeCNVWDW1eTAQdi4xZdHK8G0vxAfJyGrivksQp+B7O
    2X0osrQ5mWejZcy+jGJkj54KzTiVXQOK+k5/dC7W93TgD6i/I9oOtnf/dlLSBEmL
    3h1gT+4PgasWwdwxsZOdHchVt1mwgv3FraTiBIubt088NxD6esGvDVVu+x7utfHs
    C9/SM/MWrKsso7i6E/39j+MlSGUSWXSssyo49RVdp9nG3Ko/VYaLF2vs2mHf349C
    hd+WAhJJ5O772dlnlecAprlRy+3j9HjFzBE/tDzwvWag==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCJATJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:19:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932571AbeCJATH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:19:07 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nathan Sullivan <nathan.sullivan@ni.com>,
        Zach Brown <zach.brown@ni.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 3.18 07/21] leds: do not overflow sysfs buffer in led_trigger_show
Date: Fri,  9 Mar 2018 16:18:29 -0800
Message-Id: <20180310001801.468099665@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001801.045114869@linuxfoundation.org>
References: <20180310001801.045114869@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Sullivan <nathan.sullivan@ni.com>

commit 3b9b95363c45365d606ad4bbba16acca75fdf6d3 upstream.

Per the documentation, use scnprintf instead of sprintf to ensure there
is never more than PAGE_SIZE bytes of trigger names put into the
buffer.

Signed-off-by: Nathan Sullivan <nathan.sullivan@ni.com>
Signed-off-by: Zach Brown <zach.brown@ni.com>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/led-triggers.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -78,21 +78,23 @@ ssize_t led_trigger_show(struct device *
 	down_read(&led_cdev->trigger_lock);
 
 	if (!led_cdev->trigger)
-		len += sprintf(buf+len, "[none] ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "[none] ");
 	else
-		len += sprintf(buf+len, "none ");
+		len += scnprintf(buf+len, PAGE_SIZE - len, "none ");
 
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (led_cdev->trigger && !strcmp(led_cdev->trigger->name,
 							trig->name))
-			len += sprintf(buf+len, "[%s] ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "[%s] ",
+					 trig->name);
 		else
-			len += sprintf(buf+len, "%s ", trig->name);
+			len += scnprintf(buf+len, PAGE_SIZE - len, "%s ",
+					 trig->name);
 	}
 	up_read(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
 
-	len += sprintf(len+buf, "\n");
+	len += scnprintf(len+buf, PAGE_SIZE - len, "\n");
 	return len;
 }
 EXPORT_SYMBOL_GPL(led_trigger_show);
