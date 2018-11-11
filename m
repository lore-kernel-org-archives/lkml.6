Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92D9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900EC20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj+Q9Ng0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900EC20871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbeKLJl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732868AbeKLISc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:32 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEFFC2243E;
        Sun, 11 Nov 2018 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975316;
        bh=PVKfxCesz2ag/ifK4tL2CUSP1Fp939ecLTaDyGErv/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nj+Q9Ng0nMsHB6qbRJmJB3FeSxAFS/vXSzqyIoQg8NObMwT4r4F+AZSq36zgP9QqO
         lssFFLPVsSMYJaRuIbqMkZHGAZ+93U8IyW4KqgYOwt+tp2wBXEytYD/a2NyE7HFMvk
         GrmF3gBFra2AcIKHd1h16MQmN9Qn49qbvOkwJ5dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.19 304/361] media: cec: forgot to cancel delayed work
Date:   Sun, 11 Nov 2018 14:20:51 -0800
Message-Id: <20181111221657.723763203@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit 490d84f6d73c12f4204241cff8651eed60aae914 upstream.

If the wait for completion was interrupted, then make sure to cancel
any delayed work.

This can only happen if a transmit is waiting for a reply, and you press
Ctrl-C or reboot/poweroff or something like that which interrupts the
thread waiting for the reply and then proceeds to delete the CEC message.

Since the delayed work wasn't canceled, once it would trigger it referred
to stale data and resulted in a kernel oops.

Fixes: 7ec2b3b941a6 ("cec: add new tx/rx status bits to detect aborts/timeouts")

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Cc: <stable@vger.kernel.org>      # for v4.18 and up
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/cec/cec-adap.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/cec/cec-adap.c
+++ b/drivers/media/cec/cec-adap.c
@@ -831,6 +831,8 @@ int cec_transmit_msg_fh(struct cec_adapt
 	 */
 	mutex_unlock(&adap->lock);
 	wait_for_completion_killable(&data->c);
+	if (!data->completed)
+		cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);
 
 	/* Cancel the transmit if it was interrupted */


