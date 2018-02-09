Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185238-2-17765681994738480548
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
    t=1518185238; b=L5swn52zggdmfJtweGokFpmevBJyJVkFDw9xC0rIXV9Nv1b
    /kgR/Qha59+2DImVrasFG5VoDvbP/IJgvmZx17vhldnECD6w38NLrt3Sc2E2S88u
    SAFBhEJ1uvNbX+tosp3AxkklyX4b03RtRv17dnQA0C60l83PcYxq1bmg5ehpZy0m
    gdhfRTsNRchFvdk3EaR1+kaeXT6S1hqjxx3n0JJ7NAbROvhVS6rd9qVcZmmkVgDS
    SWDckFrydy+grJRwc1EuZZFuinWPqja8sE2MfxbHwTnf3b4xKa0JaIr+YPjCSIlk
    OeBlEyVytu5zhpfLkG7ooO+p3BjDxoFDFCrqg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518185238; bh=qWTxznYorpi9PAYn4buJA2oTtt
    MMST1JEvmS6hXpJ+s=; b=SkMc0Wk5lfnGFXBR6EliBuW9qQz5TXVMw5ZIt3v8Ja
    s5opxaP8xx4kkbz/pP7hanEDH8EL1KYGOwZ1sbfuupWTR2GtKwwHfOvqKqDJkfVF
    ST+7EyWLxjVEUQ5UYIjk87cg6s+O5byarp59jEsrRHAdLmtH5VoFRVLXb0+qAtoI
    fQj03QjlMGwBQ6q4nYlyZYoedNGS/XEq3EwY7zbfwc8l642dC9OSSWzdhnUgDjnz
    ow5OqrXT5KGcl6jKyBTJh81ECbus8lChE8xjeVQ+fRabWa255OcbVD/h0WWBcBYD
    +bYmdISbilpMavnfbyw0SNx+VWbRtzSdMMF9zsShAsYw==
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
        id S1752978AbeBINml (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 08:42:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:49934 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeBINmk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:42:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4.9 18/92] serial: core: mark port as initialized after successful IRQ change
Date: Fri,  9 Feb 2018 14:38:47 +0100
Message-Id: <20180209133932.595583765@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 44117a1d1732c513875d5a163f10d9adbe866c08 upstream.

setserial changes the IRQ via uart_set_info(). It invokes
uart_shutdown() which free the current used IRQ and clear
TTY_PORT_INITIALIZED. It will then update the IRQ number and invoke
uart_startup() before returning to the caller leaving
TTY_PORT_INITIALIZED cleared.

The next open will crash with
|  list_add double add: new=ffffffff839fcc98, prev=ffffffff839fcc98, next=ffffffff839fcc98.
since the close from the IOCTL won't free the IRQ (and clean the list)
due to the TTY_PORT_INITIALIZED check in uart_shutdown().

There is same pattern in uart_do_autoconfig() and I *think* it also
needs to set TTY_PORT_INITIALIZED there.
Is there a reason why uart_startup() does not set the flag by itself
after the IRQ has been acquired (since it is cleared in uart_shutdown)?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/serial_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -965,6 +965,8 @@ static int uart_set_info(struct tty_stru
 		}
 	} else {
 		retval = uart_startup(tty, state, 1);
+		if (retval == 0)
+			tty_port_set_initialized(port, true);
 		if (retval > 0)
 			retval = 0;
 	}
