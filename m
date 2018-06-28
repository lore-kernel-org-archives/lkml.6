Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FBCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B5B2710D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 09:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B5B2710D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933329AbeF1JD4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 05:03:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932262AbeF1JDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 05:03:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4CFAC87A80;
        Thu, 28 Jun 2018 09:03:54 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1793D2026D69;
        Thu, 28 Jun 2018 09:03:52 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] console/fbcon: Add support for deferred console takeover
Date:   Thu, 28 Jun 2018 11:03:48 +0200
Message-Id: <20180628090351.15581-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 09:03:54 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 28 Jun 2018 09:03:54 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v5 of my patch-set, to delay fbcon taking over the console (and
binding to fbdev devices) until there actually is some text output to the
console. This is intended for use with the "quiet" cmdline option, in
combination with a bootloader which leaves the vendor's logo /
EFI bootgraphics put up by the firmware intact on the EFI framebuffer.

The end goal here is a boot where the firmware shows its boot graphics
and these stay in place for a couple of seconds until the GUI loads and
the GUI then smoothly takes over the framebuffer without any distruptions.

Bartlomiej, I believe that this patch-set is ready for merging now and
the first patch has Petr's ack, so can we get this merged now?

Also please create an inmutable (or topic) branch for this, so that the
drm people can merge it into drm-tip for additional testing.

Changelog:

Changes in v5:
-Improve commit message, explain why dummy_con.c is used to detect the
 first printout, instead of handling this entirely inside the fbcon code
 (no code changes, only updated the commit message)

Changes in v4:
-Keep the comments about which fbcon functions need locks in place

Changes in v3:
-Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
-Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
 proper locking (requested by Daniel)
-Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
-Document the fbcon=nodefer commandline option (req. by Emil)

Changes in v2:
-Check the whole string when checking for erases in putcs, instead of just
 the first char
-Make dummycon_blank return 1, so that a redraw gets triggered and any text
 rendered while blanked gets output so that it can trigger a deferred
 takeover if one is pending

Regards,

Hans

