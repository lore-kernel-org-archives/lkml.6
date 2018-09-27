Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F99CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212E521533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212E521533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbeI0PvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:51:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57274 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbeI0PvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:51:05 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4B56C1133;
        Thu, 27 Sep 2018 09:33:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>,
        Allen Pais <allen.pais@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 4.4 02/28] NFC: Fix the number of pipes
Date:   Thu, 27 Sep 2018 11:06:26 +0200
Message-Id: <20180927090637.789555010@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
References: <20180927090637.687829444@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suren Baghdasaryan <surenb@google.com>

commit e285d5bfb7e9785d289663baef252dd315e171f8 upstream.

According to ETSI TS 102 622 specification chapter 4.4 pipe identifier
is 7 bits long which allows for 128 unique pipe IDs. Because
NFC_HCI_MAX_PIPES is used as the number of pipes supported and not
as the max pipe ID, its value should be 128 instead of 127.

nfc_hci_recv_from_llc extracts pipe ID from packet header using
NFC_HCI_FRAGMENT(0x7F) mask which allows for pipe ID value of 127.
Same happens when NCI_HCP_MSG_GET_PIPE() is being used. With
pipes array having only 127 elements and pipe ID of 127 the OOB memory
access will result.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Allen Pais <allen.pais@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/net/nfc/hci.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -87,7 +87,7 @@ struct nfc_hci_pipe {
  * According to specification 102 622 chapter 4.4 Pipes,
  * the pipe identifier is 7 bits long.
  */
-#define NFC_HCI_MAX_PIPES		127
+#define NFC_HCI_MAX_PIPES		128
 struct nfc_hci_init_data {
 	u8 gate_count;
 	struct nfc_hci_gate gates[NFC_HCI_MAX_CUSTOM_GATES];


