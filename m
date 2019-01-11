Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEE9206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217989;
	bh=ovmtQlXGn31Rhr/kBzg0WxGis0FDsQeCTnXf2timqLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b2DdN7uPOE3XFUfICD/bkQmfiE1hWRho6QPitMnC+k6pW3jnoxGycg698YdDwRNTQ
	 y82D0XaTOFwc47vUvZh3cUPVGT7n7Vodc34B7V32Ll+MOAGRnPfhvHh5LlaU+a/Cyx
	 dx4pR7tWBOBvBPEvEUYXNvkjtBqNUSk07OkB8Keg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391464AbfAKOq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:46:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:36130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404340AbfAKOnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:43:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61F821848;
        Fri, 11 Jan 2019 14:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217794;
        bh=ovmtQlXGn31Rhr/kBzg0WxGis0FDsQeCTnXf2timqLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wvYju3mQVU2PlPriN5QFluCeevHQkTZMReJoj4u1f/pj2aoCNB356nH+O901dO/U0
         TioUjijSlFP8rSyDsXYK2AxWBgEn3uQ4w/t/RMlOLS9Y2PaLojrOJARebxCnxeDxSL
         Mg/A0DtgC3m9e4g3m/x3rMRWN63ObNCc7FdQY/o4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.20 44/65] iio: dac: ad5686: fix bit shift read register
Date:   Fri, 11 Jan 2019 15:15:30 +0100
Message-Id: <20190111131102.416207544@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mircea Caprioru <mircea.caprioru@analog.com>

commit 0e76df5c978338f3051e5126fc0c4245c57a307a upstream.

This patch solves the register readback issue with the bit shift. When the
dac resolution was lower than the register size (ex. 12 bits out of 16
bits) the readback value was not shifted with the difference in bits and
the value was higher. Also a mask is applied on the read value in order to
get the value relative to the actual bit size.

Fixes: 0357e488b8 ("iio:dac:ad5686: Refactor the driver")
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/ad5686.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -124,7 +124,8 @@ static int ad5686_read_raw(struct iio_de
 		mutex_unlock(&indio_dev->mlock);
 		if (ret < 0)
 			return ret;
-		*val = ret;
+		*val = (ret >> chan->scan_type.shift) &
+			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->vref_mv;


