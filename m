Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C95C3279B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF16240B5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 00:47:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF16240B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeGEArI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 20:47:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50914 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752937AbeGEArG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 20:47:06 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fasQH-0004FU-3C; Thu, 05 Jul 2018 00:47:01 +0000
Date:   Thu, 5 Jul 2018 01:47:01 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH] HID: debug: check length before copy_to_user()
Message-ID: <20180705004700.GB30522@ZenIV.linux.org.uk>
References: <20180702235937.111619-1-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702235937.111619-1-drosen@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:59:37PM -0700, Daniel Rosenberg wrote:
> If our length is greater than the size of the buffer, we
> overflow the buffer

Hmm...

How about this:
	buf = list->hid_debug_buf;
	if (list->tail < list->head) {
		ret = simple_read_from_buffer(buffer, count, &list->head,
					buf, HID_DEBUG_BUFSIZE);
		if (ret < 0)
			break;
		if (list->head != buf + HID_DEBUG_BUFSIZE)
			break;
		list->head = 0;
	}
	n = simple_read_from_buffer(buffer + ret, count - ret, &list->head,
					buf, list->tail);
	if (n >= 0)
		ret += n;
	if (list->head == buf + HID_DEBUG_BUFSIZE)
		list->head = 0;
instead?
