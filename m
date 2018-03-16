Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3555996-1521221809-5-1000453670104523050
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
    t=1521221809; b=Tau7KH/UsF++dW2fTl3TLioT5MFVEEzG9Vb3shsigRPNYT6
    TXrEThwvIpJNaf2B1R0ob7tPZarBlP1mMY/TyQMo9DvhSAm77RfWS7x4otiqeJ4z
    2gFUBHT/VJnMWXF40s3wOMAWqmjkLV2HvRrQRpUhHjFXUk5/iuRZcULIeIxSGO4r
    o7maviiBFlH70T5HCLqwOW5PjZKJDW7QG5SWb6EB/CXZNQoRd42HSXX71DZ4iCqk
    xTUv9qWGAOPhmNvYesEVnUuIyWsBROymvrfSpXMWuVM6r5LfUoPXzOL2oXolQrcR
    thqLgigjaBNgsBeFNjv0zoXiIMNVvha4uw6ijGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221809; bh=K61mrNrdzR8UBmdgxxnZ3SW5u7
    WPpuQ9YHc+WviPN+A=; b=Lxvn1vxj07TcRUBBPpJg3iybIYqLvr5P3i0yl7mJUL
    FsKkAcfTHQuMfWZhPDVx+AABNOCyBWY2gc48EVYPNlveE5FGkiZj/w99hmqz+VA5
    tBiYOc0oOJJzaMopFrWEAR2Ij5WGfri5t6htqpAMsROtj3/KVzOd3ql3kh7DHluz
    aUiGo9WeDNnR38PXtVgoNqpLOqaLSPw2Z4xzgrrSw2pRWjviLKM1HAwpTZBUimO8
    kFJ4jtFq08sW1hBS7kPA9zyxG/0oX4G4uWRdVD9tsjw5y125j+bV//72jzzOxlI8
    K06s3qaIpuDomceLC9+j4qixskfv3cxIURCoebKcoFKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S1753051AbeCPRgb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 13:36:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33942 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeCPP0m (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:26:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <ulrich.hecht+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Subject: [PATCH 3.18 17/25] serial: sh-sci: prevent lockup on full TTY buffers
Date: Fri, 16 Mar 2018 16:23:04 +0100
Message-Id: <20180316152233.456424538@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
References: <20180316152232.750180431@linuxfoundation.org>
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

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

commit 7842055bfce4bf0170d0f61df8b2add8399697be upstream.

When the TTY buffers fill up to the configured maximum, a system lockup
occurs:

[  598.820128] INFO: rcu_preempt detected stalls on CPUs/tasks:
[  598.825796]  0-...!: (1 GPs behind) idle=5a6/2/0 softirq=1974/1974 fqs=1
[  598.832577]  (detected by 3, t=62517 jiffies, g=296, c=295, q=126)
[  598.838755] Task dump for CPU 0:
[  598.841977] swapper/0       R  running task        0     0      0 0x00000022
[  598.849023] Call trace:
[  598.851476]  __switch_to+0x98/0xb0
[  598.854870]            (null)

This can be prevented by doing a dummy read of the RX data register.

This issue affects both HSCIF and SCIF ports. Reported for R-Car H3 ES2.0;
reproduced and fixed on H3 ES1.1. Probably affects other R-Car platforms
as well.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: stable <stable@vger.kernel.org>
Tested-by: Nguyen Viet Dung <dung.nguyen.aj@renesas.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/sh-sci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -736,6 +736,8 @@ static void sci_receive_chars(struct uar
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tport);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		serial_port_in(port, SCxRDR);
 		serial_port_in(port, SCxSR); /* dummy read */
 		serial_port_out(port, SCxSR, SCxSR_RDxF_CLEAR(port));
 	}
