Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E66C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F0420856
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 08:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F0420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeICMUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 08:20:05 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:54844 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeICMUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 08:20:05 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 813DF15AF4B;
        Mon,  3 Sep 2018 17:01:05 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w83814mw019015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Sep 2018 17:01:05 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w83814OP001866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Sep 2018 17:01:04 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w83813Ev001865;
        Mon, 3 Sep 2018 17:01:03 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
References: <20180902131932.11558-1-pali.rohar@gmail.com>
        <87bm9ft5h5.fsf@mail.parknet.co.jp>
        <20180903074005.7e3guj24ksq2l44c@pali>
Date:   Mon, 03 Sep 2018 17:01:03 +0900
In-Reply-To: <20180903074005.7e3guj24ksq2l44c@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Mon, 3 Sep 2018 09:40:05 +0200")
Message-ID: <874lf7t3gg.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

>> Just relaxing validation doesn't work. The block layer doesn't support
>> smaller than 512, and lager than PAGE_SIZE.  (And in specification, fat
>> doesn't support lager than 4096.)
>
> Hi! I just sent this patch for discussion, with links to (now open
> source) Windows implementation. I guess that Windows driver
> implementation is more "authoritative" then Microsoft's own
> specification. It is known that Windows implementation does not match
> Microsoft specification.
>
> I know at least 3 FAT specifications (MS EFI FAT, MS/SD card FAT,
> ECMA-107) and you are right that Microsoft's one does not allow sector
> sizes larger then 4096.
>
> If there is limitation by block layer, then:
>
> 1) Why we do not check for PAGE_SIZE?

That source seems to check power_of_2(size) and 128 <= size <=
4096. Rather why do you want to support larger than 4096? Or I'm missing
something?

> 2) Is check in fat driver really needed (if block layer checks it)?

Yes, isolating block layer error and fat format error to be better error
report.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
