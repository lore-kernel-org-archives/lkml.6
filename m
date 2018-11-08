Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FE0C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C720825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="qAznThQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205C720825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeKHVxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:53:11 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:57674 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeKHVxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:53:11 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id F2795460901;
        Thu,  8 Nov 2018 13:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1541679475;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=+ktdjOJID9J95uDUA6oZ6OQ4LzjRRpQiDyqagK5FdUs=;
        b=qAznThQT72ZHYOKXZ39EAX84UkUFaJNN8MTCGZDcxv1oBK0soVpLcDMN+Nm8v22SUf0nqT
        FJzT/auV7Mvpg6scXvVptqZMa3FjRrCgf4nEqd1wFbYRFDV4y/EWZbgUCw4hLC9uJObOr8
        gKZg0gPQ+R0qVRzOAzXA6pTmXiFZuKQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 vulcan.natalenko.name F2795460901
Authentication-Results: vulcan.natalenko.name; dmarc=fail (p=none dis=none) header.from=natalenko.name
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 08 Nov 2018 13:17:54 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     kai.heng.feng@canonical.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, ulf.hansson@linaro.org
Subject: Re: [PATCH 0/5 v7] Keep rtsx_usb suspended when there's no card
In-Reply-To:  <<20181105084506.6476-1-kai.heng.feng@canonical.com>>
Message-ID: <58a96c0933bf4c812fa2dd382e6cb377@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1541679475;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=+ktdjOJID9J95uDUA6oZ6OQ4LzjRRpQiDyqagK5FdUs=;
        b=FwN6BJfO0oqEJAK/NthG6tHLgU3f2qjM34Gyn1sAgOe+5j58UAZ3RDKtrqMouP12pZwGHs
        8bJ4b2tKNh6XUpR46RGUy9ZScke9sEz5xtWWkGz/TqAKVca96c2YwBVRZMuZmovvOzHqGE
        e0dLE45idB+EUAynDuZjma26H3kKUDg=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1541679475; a=rsa-sha256;
        cv=none;
        b=uld86ex1TFcuUEy3XjgjYQuzzC+ifd8Fzn01VMAyX67kvhlwKTw1/4AjYdBzrKphs0wiMpqJXLIki3izQ+3AgzqdPB+bCxgKFy0P8XYMWFIWwP428LfhQ8oEejuJS+OSRdxOU7r3exzHYrxnrs6ePFstEFqv9gpkIpimAxMWrM0=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is based on Ulf's work [1] [2].
> 
> This patch series can keep rtsx_usb suspended, to save ~0.5W on Intel
> platforms and ~1.5W on AMD platforms.
> 
> [1] https://patchwork.kernel.org/patch/10440583/
> [2] https://patchwork.kernel.org/patch/10445725/

Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>

-- 
   Oleksandr Natalenko (post-factum)
