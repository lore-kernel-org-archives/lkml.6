Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27434C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D3921582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3+hUXqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D3921582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404810AbeKLIYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:24:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbeKLIYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:24:42 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E30421707;
        Sun, 11 Nov 2018 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975684;
        bh=WLG8CwGt7GS0EQg29XY2XlnY89rTBsd96EoAOuNFC8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3+hUXqZaQQs3awAOwAzGYjqCX0r5G/RINGaOcHmnpqve9xbitmDssDjKNfeguhqJ
         6rG5I5Zteqpk3JAyyFJCLCd7vgXzOno8/uRNmOq6iVUDFSTDcAg6MqIMXp51Ck5Cs6
         ncpcQODfIUhYiIXBbQ7ZUbcevZjCzCYx8WBoTWXg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.9 091/141] HID: hiddev: fix potential Spectre v1
Date:   Sun, 11 Nov 2018 14:25:50 -0800
Message-Id: <20181111221640.779038211@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221627.853046496@linuxfoundation.org>
References: <20181111221627.853046496@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit f11274396a538b31bc010f782e05c2ce3f804c13 upstream.

uref->usage_index can be indirectly controlled by userspace, hence leading
to a potential exploitation of the Spectre variant 1 vulnerability.

This field is used as an array index by the hiddev_ioctl_usage() function,
when 'cmd' is either HIDIOCGCOLLECTIONINDEX, HIDIOCGUSAGES or
HIDIOCSUSAGES.

For cmd == HIDIOCGCOLLECTIONINDEX case, uref->usage_index is compared to
field->maxusage and then used as an index to dereference field->usage
array. The same thing happens to the cmd == HIDIOC{G,S}USAGES cases, where
uref->usage_index is checked against an array maximum value and then it is
used as an index in an array.

This is a summary of the HIDIOCGCOLLECTIONINDEX case, which matches the
traditional Spectre V1 first load:

	copy_from_user(uref, user_arg, sizeof(*uref))
	if (uref->usage_index >= field->maxusage)
		goto inval;
	i = field->usage[uref->usage_index].collection_index;
	return i;

This patch fixes this by sanitizing field uref->usage_index before using it
to index field->usage (HIDIOCGCOLLECTIONINDEX) or field->value in
HIDIOC{G,S}USAGES arrays, thus, avoiding speculation in the first load.

Cc: <stable@vger.kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
v2: Contemplate cmd == HIDIOC{G,S}USAGES case
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/usbhid/hiddev.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -521,14 +521,24 @@ static noinline int hiddev_ioctl_usage(s
 			if (cmd == HIDIOCGCOLLECTIONINDEX) {
 				if (uref->usage_index >= field->maxusage)
 					goto inval;
+				uref->usage_index =
+					array_index_nospec(uref->usage_index,
+							   field->maxusage);
 			} else if (uref->usage_index >= field->report_count)
 				goto inval;
 		}
 
-		if ((cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) &&
-		    (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
-		     uref->usage_index + uref_multi->num_values > field->report_count))
-			goto inval;
+		if (cmd == HIDIOCGUSAGES || cmd == HIDIOCSUSAGES) {
+			if (uref_multi->num_values > HID_MAX_MULTI_USAGES ||
+			    uref->usage_index + uref_multi->num_values >
+			    field->report_count)
+				goto inval;
+
+			uref->usage_index =
+				array_index_nospec(uref->usage_index,
+						   field->report_count -
+						   uref_multi->num_values);
+		}
 
 		switch (cmd) {
 		case HIDIOCGUSAGE:


