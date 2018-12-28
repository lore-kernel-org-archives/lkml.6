Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DA3C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0112087F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S7aUHADL";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="S7aUHADL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeL1HtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:49:04 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbeL1HtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:49:04 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8565F607F1; Fri, 28 Dec 2018 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545983343;
        bh=1F/Yn44DPECdXMHddk3/h6tLbhV1GEAPKLXSN3qQwNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7aUHADLd4FxPVpsq/ZBLAefCk1Rw1cSMQ/N2h8Glym7rJ4E/+PCc7KzqkkTM6khy
         /X0XPmPVLfbp3Y3s0Ob7Oum3oa9JKiAOhsuW1XyUiMuwUHe5aVInAKUUWWMpTxmYOn
         T5ubwBfhbbGDN3v0O2QXg3Ls56GxR44EVeiabuw8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id EA45660364;
        Fri, 28 Dec 2018 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1545983343;
        bh=1F/Yn44DPECdXMHddk3/h6tLbhV1GEAPKLXSN3qQwNM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S7aUHADLd4FxPVpsq/ZBLAefCk1Rw1cSMQ/N2h8Glym7rJ4E/+PCc7KzqkkTM6khy
         /X0XPmPVLfbp3Y3s0Ob7Oum3oa9JKiAOhsuW1XyUiMuwUHe5aVInAKUUWWMpTxmYOn
         T5ubwBfhbbGDN3v0O2QXg3Ls56GxR44EVeiabuw8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Dec 2018 13:19:02 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 3/6] Bluetooth: hci_qca: Fix frame reassembly errors
 for wcn3990
In-Reply-To: <20181227202514.GK261387@google.com>
References: <20181227073136.8431-1-bgodavar@codeaurora.org>
 <20181227073136.8431-4-bgodavar@codeaurora.org>
 <20181227202514.GK261387@google.com>
Message-ID: <3ff6a55912a5b4f9462484d90bab3084@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2018-12-28 01:55, Matthias Kaehlcke wrote:
> On Thu, Dec 27, 2018 at 01:01:33PM +0530, Balakrishna Godavarthi wrote:
>> During initalization of wcn3990, we observed UART is reading some
>> stray bytes on the Rx line. This is logging Frame reassembly errors
>> on the serial console. This could be because of tristate of Tx line
>> of wcn3990 during boot up.
> 
> My testing suggests that this change is not needed if the Rx line of
> the SoC/AP is configured with a pull-up. We'd probably all prefer not
> to have this change if there's a neater way to address the garbage
> data. Could you test with adding the pull-up and dropping this patch
> on your side?
> 
> Thanks
> 
> Matthias

Thanks a lot it worked to me. will drop this patch.

-- 
Regards
Balakrishna.
