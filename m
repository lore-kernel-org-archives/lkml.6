Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FORGED_MUA_MOZILLA,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914F0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8692146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 04:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfBKEqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 23:46:06 -0500
Received: from [195.159.176.226] ([195.159.176.226]:50694 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfBKEqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 23:46:06 -0500
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1gt3To-000Exi-Mo
        for linux-kernel@vger.kernel.org; Mon, 11 Feb 2019 05:46:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Salah Coronya <salahx@yahoo.com>
Subject: Cannot read payload of an encrypted key rooted in a trusted key
Date:   Sun, 10 Feb 2019 22:45:58 -0600
Message-ID: <q3qum6$1nnk$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file Documentation/security/keys-trusted-encrypted, an example is 
shown for to create an encrypted key rooted in trusted key. Basically, 
the following should work:

KMK_KEY=$(keyctl add trusted kmk "new 32" @u)
keyctl pipe $KMK_KEY > ~/kmk-trusted.blob
EVM_KEY=$(keyctl add encrypted evm "new default trusted:kmk 32" @u)
keyctl pipe $EVM_KEY > ~/evm-trusted.blob

But the last command does not work. It reports "keyctl_read_alloc: 
Operation not supported"

strace shows this:

keyctl(KEYCTL_READ, 404204492, NULL, 0) = 185
keyctl(KEYCTL_READ, 404204492, 0x557a43f66260, 185) = -1 EOPNOTSUPP 
(Operation not supported)

I've tried this on kernel 4.4.163, 4.14.83, and 4.20.6, on a machine 
with real TPM, and a virtual TPM in a VM, both versions 1.2 and 2.0 and 
none of the cases work.

However, an encrypted key rooted in a (random) user key DOES work:

KMK_USER=$(dd if=/dev/urandom bs=1 count=32 2>/dev/null | keyctl padd 
user kmk-user @u)
keyctl pipe $KMK_USER > ~/kmk-user.blob
EVM_USER=$(keyctl add encrypted evm-user "new default user:kmk-user 32" @u)
keyctl pipe $EVM_USER > ~/evm-user.blob

I'm not sure if there is a missing step in the examples, if have I hit a 
kernel bug, or if I'm doing something wrong.

