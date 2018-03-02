Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330799-1519989222-2-4116496879734120978
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519989222; b=c1twZIPdkTYdQz2nBnpdSa3xacy4hFvv3XKLjbUPv6RUvv2
    yj13kVi7pfbszaDLCAlY/aPs99Rh+0fcynzBj6cRzWszw57jz2JzPMvNWh856HXh
    GYNFTLXvVvuVcainHat11GdLtZQFuGQ3iREOqj/N8Yp0UafvyklHNzTdo4AwxEbM
    tLh/URuHR3rcWMcH8zMo7OhKUuezxdWtUIG/YJcD7Fvsw4sd0Is1a7bDlNB4y9DC
    kjL7SXkX/R2kbrRhQZo0bYoxnmoNpcaEkCoGnSocC8sB0UefPVuix5D47Ulty5oc
    iR7WuVRzDGwgzhD8Xyeu+nOLhWF8oKA/x4FLnBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519989222; bh=w5YUndf2A9L51LCcyqNJJLj+Z1
    6L41G3nvDL1qVesyM=; b=jvrXYYubva0CkR887ZUKXnKgDi3H3oel2dvhQXsW7E
    TH3gAppkF8A2FzHGpF8iz9kSNy0DSojdjixdx7YZ9pxY6UYh7dablx3ymYGHJDsM
    Jto2zXib9GlxNpUdmdm+3h6EFxNEIqKMtBgPiNl6WmEpDGn3cBDbepmfbkcQi6DJ
    iGhlmHNn4B+endMSsocvcSI4ELwPdi2doB3jkqMM42lvkuuwQZIDTWSy6oPqaMPt
    N3NfdDpKqyVmjVXpI5eN8MYj8nBDmLtKRfbH9e7PKM572af1WlFczJ5csmzSmx7h
    mF8eTzwfMVVJwaj5UqW7jj1yKEmADLdVjPdXjxeAv2Sw==
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
        id S1423449AbeCBIyJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:54:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423442AbeCBIyI (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cathy Avery <cavery@redhat.com>,
        Long Li <longli@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 10/34] scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error
Date: Fri,  2 Mar 2018 09:51:06 +0100
Message-Id: <20180302084436.632697204@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
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

From: Cathy Avery <cavery@redhat.com>


[ Upstream commit d1b8b2391c24751e44f618fcf86fb55d9a9247fd ]

When an I/O is returned with an srb_status of SRB_STATUS_INVALID_LUN
which has zero good_bytes it must be assigned an error. Otherwise the
I/O will be continuously requeued and will cause a deadlock in the case
where disks are being hot added and removed. sd_probe_async will wait
forever for its I/O to complete while holding scsi_sd_probe_domain.

Also returning the default error of DID_TARGET_FAILURE causes multipath
to not retry the I/O resulting in applications receiving I/O errors
before a failover can occur.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/storvsc_drv.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -890,10 +890,11 @@ static void storvsc_handle_error(struct
 		case TEST_UNIT_READY:
 			break;
 		default:
-			set_host_byte(scmnd, DID_TARGET_FAILURE);
+			set_host_byte(scmnd, DID_ERROR);
 		}
 		break;
 	case SRB_STATUS_INVALID_LUN:
+		set_host_byte(scmnd, DID_NO_CONNECT);
 		do_work = true;
 		process_err_fn = storvsc_remove_lun;
 		break;
