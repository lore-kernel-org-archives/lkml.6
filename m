Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2243538-1518720765-2-14632928465524450854
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
    t=1518720764; b=rdgnqTEqC+fYSh8YMrS1whFVZfqX40kqn7hdDFc64X4Qu2Q
    aUmRLoia/AsPThxskAtqQ7LWMTKaJ1P+7PeRTAN+jn8r9A6pDz/y0CaEGYmnMaCB
    wW9a/NThZsjsFNAy2YJVIX5oHb9hQ13zSmBtyB0eDVVL+JYzfYwUPBeQ9N6plM8t
    dMikMswlRtY9N0DnWa4RawvVsd58Ru0zJQnAMofPzgD2cQuFW94ZSrTikQsxpXZT
    gMbJeZmPXLfMMYXg1t7NY8NJrecKtBjj+yLhG6YQ1590NLpf0ZBnDTkngjNo+xf8
    3cJx7QkPFsn+4pxw39HateVvklUN0QdRwJhnqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518720764; bh=ILzphEwl8JiPoqOpYWyG4+1yyw
    xSLJH7wjzXyyDUKgQ=; b=NEnH6kg6R3p7woydy892fXLDYA8I6h+Akhirgq0xei
    hMTAt6Xlqgkueiewy3xAijf/osrHIEMaQoDV0c77GRAxX7MxScOcvHdWKFJTQ3q3
    CmPOiQeUvVul57+LTuQW3z0UpUS04J5ifECtjjWdbpfGXqz94tC1Lv6JpBjbxP1r
    MAI180SibYKoaWmrCxnSrlewZgSlK3ppz+I8lxOn+CD+dATIKB/jp1PW8Y1oYTEg
    vpoO1JiXB2tRuo33PGjyZGErO7nqfxHxoIfo7TD3yqfM8trMPmaNPjHGBGt10Jch
    XN1dyEC/nrYFSQRmPB5pNaBOFPQI/ZUFxVV3VouTBvjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162007AbeBOPVQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:21:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161999AbeBOPVM (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:21:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 4.4 019/108] usbip: fix 3eee23c3ec14 tcp_socket address still in the status file
Date: Thu, 15 Feb 2018 16:16:16 +0100
Message-Id: <20180215151225.239469900@linuxfoundation.org>
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

From: Shuah Khan <shuahkh@osg.samsung.com>

Commit 3eee23c3ec14 ("usbip: prevent vhci_hcd driver from leaking a
socket pointer address") backported the following commit from mailine.
However, backport error caused the tcp_socket address to still leak.

commit 2f2d0088eb93 ("usbip: prevent vhci_hcd driver from leaking a
socket pointer address")

When a client has a USB device attached over IP, the vhci_hcd driver is
locally leaking a socket pointer address via the

/sys/devices/platform/vhci_hcd/status file (world-readable) and in debug
output when "usbip --debug port" is run.

Fix it to not leak. The socket pointer address is not used at the moment
and it was made visible as a convenient way to find IP address from
socket pointer address by looking up /proc/net/{tcp,tcp6}.

As this opens a security hole, the fix replaces socket pointer address
with sockfd.

Reported-by: Eric Biggers <ebiggers3@gmail.com>
Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/usbip/vhci_sysfs.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -53,7 +53,7 @@ static ssize_t status_show(struct device
 	 * a security hole, the change is made to use sockfd instead.
 	 */
 	out += sprintf(out,
-		       "prt sta spd bus dev sockfd local_busid\n");
+		       "prt sta spd dev      sockfd local_busid\n");
 
 	for (i = 0; i < VHCI_NPORTS; i++) {
 		struct vhci_device *vdev = port_to_vdev(i);
@@ -64,12 +64,11 @@ static ssize_t status_show(struct device
 		if (vdev->ud.status == VDEV_ST_USED) {
 			out += sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out += sprintf(out, "%16p ", vdev->ud.tcp_socket);
-			out += sprintf(out, "%06u", vdev->ud.sockfd);
+			out += sprintf(out, "%06u ", vdev->ud.sockfd);
 			out += sprintf(out, "%s", dev_name(&vdev->udev->dev));
 
 		} else
-			out += sprintf(out, "000 000 000 000000 0-0");
+			out += sprintf(out, "000 00000000 000000 0-0");
 
 		out += sprintf(out, "\n");
 		spin_unlock(&vdev->ud.lock);
