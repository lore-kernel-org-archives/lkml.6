Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED57C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4621736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865966;
	bh=JS//P338n5iFs7cy9x4xdC0vL/oTqGGUF4wbTgNmKuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PFVS8SZxbO3QitvoFjF2CAEv+te7orIEeeBlr9FxrOP4Q7ZL0rRp1ShOVxqSrzclY
	 OmupFVEDyDIX/nkcOGyqvSyWwCn2b5GqcNs1UbztALi06TbhrmLl5y8skgzDMIgtN3
	 2wFa2p203Q3e8FpEAipLvrL1QNtuzfaX3CzPhdQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfAGM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfAGM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:59:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69AF5206BB;
        Mon,  7 Jan 2019 12:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865959;
        bh=JS//P338n5iFs7cy9x4xdC0vL/oTqGGUF4wbTgNmKuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyxCJgzPG1zA6RIxmYGT8rG6cdeV8qqFk8+zz675yO4jv8ukcWTonD8ZzU34FnnsX
         ILsTHaAbHv03KS61R11w0bZmlYcSzOzUYr3PK+P891xYqKeHvma2dUFDcOTfJByKmH
         PinC22GmefY/QZ8PnO7lF/BvO4Ib763dumsmnIjM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 143/170] media: cec-pin: fix broken tx_ignore_nack_until_eom error injection
Date:   Mon,  7 Jan 2019 13:32:50 +0100
Message-Id: <20190107104509.811204613@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit ac791f19a273a7fe254a7596f193af6534582a9f upstream.

If the tx_ignore_nack_until_eom error injection was activated,
then tx_nacked was never set instead of setting it when the last
byte of the message was transmitted.

As a result the transmit was marked as OK, when it should have
been NACKed.

Modify the condition so that it always sets tx_nacked when the
last byte of the message was transmitted.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.17 and up
Signed-off-by: Hans Verkuil <hansverk@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/cec/cec-pin.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/media/cec/cec-pin.c
+++ b/drivers/media/cec/cec-pin.c
@@ -601,8 +601,9 @@ static void cec_pin_tx_states(struct cec
 			break;
 		/* Was the message ACKed? */
 		ack = cec_msg_is_broadcast(&pin->tx_msg) ? v : !v;
-		if (!ack && !pin->tx_ignore_nack_until_eom &&
-		    pin->tx_bit / 10 < pin->tx_msg.len && !pin->tx_post_eom) {
+		if (!ack && (!pin->tx_ignore_nack_until_eom ||
+		    pin->tx_bit / 10 == pin->tx_msg.len - 1) &&
+		    !pin->tx_post_eom) {
 			/*
 			 * Note: the CEC spec is ambiguous regarding
 			 * what action to take when a NACK appears


