Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tOBGL0DhGlv5KwAAmS7hNA
	; Fri, 08 Jun 2018 20:04:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B29E2607E7; Fri,  8 Jun 2018 20:04:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 29623601D2;
	Fri,  8 Jun 2018 20:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29623601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFHUEO (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:04:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752478AbeFHUEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:04:11 -0400
Received: from vmware.local.home (unknown [217.76.163.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8819120874;
        Fri,  8 Jun 2018 20:04:02 +0000 (UTC)
Date: Fri, 8 Jun 2018 16:03:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Johan Hovold <johan@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Bernd Petrovitsch <bernd@petrovitsch.priv.at>,
        "Du, Changbin" <changbin.du@intel.com>, gregkh@linuxfoundation.org,
        alex.elder@linaro.org, kbuild test robot <lkp@intel.com>,
        linux-arch@vger.kernel.org, michal.lkml@markovi.net,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        yamada.masahiro@socionext.com, lgirdwood@gmail.com,
        broonie@kernel.org, rdunlap@infradead.org, x86@kernel.org,
        linux@armlinux.org.uk, linux-sparse@vger.kernel.org,
        mingo@redhat.com, kbuild-all@01.org, akpm@linux-foundation.org,
        changbin.du@gmail.com, tglx@linutronix.de,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/4] kernel hacking: new config NO_AUTO_INLINE to
 disable compiler auto-inline optimizations
Message-ID: <20180608160355.67712eb8@vmware.local.home>
In-Reply-To: <20180607091816.GT13775@localhost>
References: <1528186420-6615-3-git-send-email-changbin.du@intel.com>
        <201806060501.btF3aJMZ%fengguang.wu@intel.com>
        <20180606095714.1d3c2def@vmware.local.home>
        <20180606142600.GN13775@localhost>
        <20180606142622.2338abf6@vmware.local.home>
        <20180607041718.qpqucjzlvcm5h3gn@vireshk-i7>
        <20180607074628.kd3iyxevwj3ypzbr@intel.com>
        <20180607083856.ealw62v3wx43zeqz@vireshk-i7>
        <1303b1abf9f9229a8d3ccbb68a3e413266b360d7.camel@petrovitsch.priv.at>
        <20180607091025.m7dfix3e2xbwx4cs@vireshk-i7>
        <20180607091816.GT13775@localhost>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018 11:18:16 +0200
Johan Hovold <johan@kernel.org> wrote:


> If you want to work around the warning and think you can do it in some
> non-contrived way, then go for it.
> 
> Clearing the request buffer, checking for termination using strnlen, and
> then using memcpy might not be too bad.
> 
> But after all, it is a false positive, so leaving things as they stand
> is fine too.

Not sure how contrived you think this is, but it solves the warning
without adding extra work in the normal case.

-- Steve

diff --git a/drivers/staging/greybus/fw-management.c b/drivers/staging/greybus/fw-management.c
index 71aec14f8181..4fb9f1dff47d 100644
--- a/drivers/staging/greybus/fw-management.c
+++ b/drivers/staging/greybus/fw-management.c
@@ -150,15 +150,18 @@ static int fw_mgmt_load_and_validate_operation(struct fw_mgmt *fw_mgmt,
 	}
 
 	request.load_method = load_method;
-	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE);
+	strncpy(request.firmware_tag, tag, GB_FIRMWARE_TAG_MAX_SIZE - 1);
 
 	/*
 	 * The firmware-tag should be NULL terminated, otherwise throw error and
 	 * fail.
 	 */
-	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
-		dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
-		return -EINVAL;
+	if (request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 2] != '\0') {
+		if (tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] != '\0') {
+			dev_err(fw_mgmt->parent, "load-and-validate: firmware-tag is not NULL terminated\n");
+			return -EINVAL;
+		}
+		request.firmware_tag[GB_FIRMWARE_TAG_MAX_SIZE - 1] = '\0';
 	}
 
 	/* Allocate ids from 1 to 255 (u8-max), 0 is an invalid id */
