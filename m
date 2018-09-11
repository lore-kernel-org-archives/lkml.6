Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5923C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8BA20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MEm2tptB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B/Nmeenz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8BA20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeIKSIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:08:18 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39368 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKSIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:08:18 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 14C43609A1; Tue, 11 Sep 2018 13:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536671342;
        bh=5kdkKMj+1JAIxNHow0D00mlne6A6xuDtMS7nIKVlbBM=;
        h=Date:From:To:Cc:Subject:From;
        b=MEm2tptBJFlKfHovYdYDZGP2b2QITvIQGIXbPUlgecmTwVo0a+AcDjn0oxbQ+nijO
         qh7vzIqt7JedqiScNpl7D8mB+W/xrELvrP+iUmxgudUO0O1Yla4rt2mLwnmZW+1VRT
         htsDTvVgaE+JrQSqnbEb2QHBTndsgzZAy1XkPOzw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id B30286092A;
        Tue, 11 Sep 2018 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536671341;
        bh=5kdkKMj+1JAIxNHow0D00mlne6A6xuDtMS7nIKVlbBM=;
        h=Date:From:To:Cc:Subject:From;
        b=B/NmeenzIV7iPq6H4mb3Mn67tLBjym2cnkdPvlPESUJGKXl+PsqBnkx2NfqV8x9uz
         L4HmU3Pp++Mz6WPv2h4OCVHBWpFGKMs1CtW9pcs4bNZFbcDNQxUe2ba2fdbS0LOl5m
         /qQOsJddKCRW0HuUEk8tVoIbyv6ANa4J/PWj6E2U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 11 Sep 2018 06:09:01 -0700
From:   Sodagudi Prasad <psodagud@codeaurora.org>
To:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: EDAC polling
Message-ID: <ed6869d5d90e03c52ad2b8577f7f5772@codeaurora.org>
X-Sender: psodagud@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi All,

While adding edac_device control info using edac_device_add_device(), 
changed the poll_msec at client driver level.
For example -.
https://source.codeaurora.org/quic/la/kernel/msm-4.9/tree/drivers/edac/qcom_llcc_edac.c?h=msm-4.9#n385


I see that client driver request is not considered and always default 
value(1 second) is considered. During the initialization
edac_device_workq_setup sets poll_msed to 1 second.

int edac_device_add_device(struct edac_device_ctl_info *edac_dev)
{
...
...
         /* If there IS a check routine, then we are running POLLED */
         if (edac_dev->edac_check != NULL) {
                 /* This instance is NOW RUNNING */
                 edac_dev->op_state = OP_RUNNING_POLL;

                 /*
                  * enable workq processing on this instance,
                  * default = 1000 msec
                  */
                 edac_device_workq_setup(edac_dev, 1000);
         } else {
                 edac_dev->op_state = OP_RUNNING_INTERRUPT;
         }


May I know why client edev_ctl->poll_msec settings is not considered?


-Thanks, Prasad

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
