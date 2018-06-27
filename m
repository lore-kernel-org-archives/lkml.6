Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D36C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B334F26244
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVyyYKsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B334F26244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753357AbeF0JfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:35:02 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:56010 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbeF0JfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:35:01 -0400
Received: by mail-it0-f51.google.com with SMTP id 16-v6so6545293itl.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mLc3ztpTgvfMtXeXhuqoEF2Oxv8BBcSdyiDY5wFaJ4E=;
        b=tVyyYKsSnCXTgZqBAgrZC/6SoaOmQ0waDUQuNDOvDjerxqhMLrNwuCD09sxdTSyXFl
         nBUpT6sebTMBoevQqGtJeANkyq3/GPPpYEgL1AYTg/B51YpzQZGjUdhauMb/717qB2Po
         7dRROLyYpXZZ3Qp6nYSjnPASxB58U0dRenLYCDlV/wcM+S/zGdxXmP+Lnmey41TrRDXX
         gEabxkfGzSJkkPYkelMv9AYWje03+VmZedvcUlhznlT+BhQkNdOdf7QtKqFWA6ZAQXj8
         ODak/pSoxcXsWqL7iaCbOlBS2EKIhDYdkirvPD4zeqFJXF/7XeVmXsgeBdNr1mRQu2LT
         yRew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mLc3ztpTgvfMtXeXhuqoEF2Oxv8BBcSdyiDY5wFaJ4E=;
        b=aalr/uyCSeLry3ovv+lpsiij36rsBWR824icDHC3iS2IgCo4LMeM+L/VTRvxwoTPbP
         L4uqbQjyAiIno9IQDZg3rFNqERt43GZFHOgIeqdiQZM3ZIP5sa5mCrFF6UEzvOjkfoyS
         dW95F7SgYehCPmphM22PU6G7e0xL2Q0RwD1UO6HniFrVi2M5aQs+1ZqqQaMIf9hFCJzB
         jYD3jyqzeX9dXA+4hEe7aza8CCzVZeb3CYddTOxlnoyw65HWcS62klPG31nGp8v9wYN8
         B7Bbh1Mz8Qiw/6hUW+7FgcgjsNKZswAOYzUVGIKM1zXxMJDusegrmhsnbD4Wy0f7uf/W
         RNLQ==
X-Gm-Message-State: APt69E13qEFGHiKaUXjSnnJLV2g8S2h4Zu7UKmwmd7xtTJWmOtX9e7J1
        JB/QmfxQkeDeFfGMENpBO6zApric
X-Google-Smtp-Source: AAOMgpdgB2PWdIV/2y4nC7Kh+rKFZ9H9s64HuLbMBCcJrKFwLPWJoZbpuDGEkGYPhHTIdwDgQdG4WQ==
X-Received: by 2002:a24:db42:: with SMTP id c63-v6mr4114723itg.49.1530092100167;
        Wed, 27 Jun 2018 02:35:00 -0700 (PDT)
Received: from [192.168.1.196] (c-69-180-151-171.hsd1.mn.comcast.net. [69.180.151.171])
        by smtp.gmail.com with ESMTPSA id w139-v6sm2943255iow.61.2018.06.27.02.34.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:34:59 -0700 (PDT)
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jefferson Carpenter <jeffersoncarpenter2@gmail.com>
Subject: Memory zeroed when made available to user process
Message-ID: <71d13d76-4591-9206-ebbb-5e9599f10c7c@gmail.com>
Date:   Wed, 27 Jun 2018 09:34:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way for a user process to mark memory as 'sensitive' or 
'non-sensitive' when it is allocated?  That could allow it not to have 
to be zeroed before being allocated to another process.
