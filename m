Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF961C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A44D26BC3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 13:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A44D26BC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965684AbeFZNzk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 09:55:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965621AbeFZNzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 09:55:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAA2040753AB;
        Tue, 26 Jun 2018 13:55:37 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-227.ams2.redhat.com [10.36.116.227])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B37302156880;
        Tue, 26 Jun 2018 13:55:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] console/fbcon: Add support for deferred console takeover
Date:   Tue, 26 Jun 2018 15:55:32 +0200
Message-Id: <20180626135535.2990-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 13:55:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 26 Jun 2018 13:55:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v3 of my patch, now patch-set, to delay fbcon taking over the
console (and binding to fbdev devices) until there actually is some text
output to the console. This is intended for use with the "quiet" cmdline
option, in combination with a bootloader which leaves the vendor's logo /
EFI bootgraphics put up by the firmware intact on the EFI framebuffer.

The end goal here is a boot where the firmware shows its boot graphics
and these stay in place for a couple of seconds until the GUI loads and
the GUI then smoothly takes over the framebuffer without any distruptions.

New in v3 are the following changes:
-Export is_console_locke() for use in modules (as fbcon may be built as a .ko)
-Use WARN_CONSOLE_UNLOCKED() in several places in the fbcon code to assert
 proper locking (requested by Daniel)
-Unregister the fbcon-dummycon-output-notifier on fbcon_exit() (req. by Daniel)
-Document the fbcon=nodefer commandline option (req. by Emil)

These changes mean that this patch-set now spans 2 subsystems.

Petr, the printk subsys change is really trivial (1 line addition) can we
get your Acked-by for merging all 3 patches through the fbdev tree?

Regards,

Hans


