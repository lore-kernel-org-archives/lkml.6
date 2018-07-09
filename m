Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A326C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05721208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ouTuBhHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05721208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933971AbeGIRkb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 13:40:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39008 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933594AbeGIRk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 13:40:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id s21-v6so14178290pfm.6;
        Mon, 09 Jul 2018 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9L7Qrhzm5wAaPCu1tTl3jr1EUMDrxPePAjT87Alcew=;
        b=ouTuBhHc2uxbf/KdE235Z2iUcBDnUKrpjbHa1o37IqDdFsYQE+GfLicTGspii9zHQv
         DshuDZGmIpaVzyrz22dfFT3jpFjLGgeXnue44xAMQ+GQfnmobPJ0nYwZDQBqds/E9NlI
         x+d/N3RX5lMPXGmPowXxcqyZSujOGDvMYWews4DPk9Ze9eehmwyvgTsE5oKaMmInPFpI
         U1QLbG/gSa44EtDvQubtiBlxiIampPNU2Dl+CkaBkmVSZKIofO6ZixbqQiP3Ox1dA/RV
         kc9tntE4kN8JASHfHd9nzuGVsubAVf9bdLLXqctzcilotV3cYxqUZ0b4pdYJpJGV60gq
         vKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B9L7Qrhzm5wAaPCu1tTl3jr1EUMDrxPePAjT87Alcew=;
        b=McO8E/V9CyGNTIMYambGAehDJHfFc4zJlfGpZE1hA5Sytfep3dyWsPkEuGlLvAZHH2
         jM1ZSC+F91SmwXRmyVf/UMZ9yAWNvVO7VCtLshkuSCI88IqHy/AFoAgnEK6Wmxkih6vO
         D1Axk08KGf+6K1x6owOVArwg6KfwzVqeTtbJ6UvVZxt2tI4fIFRfB0UKBTt6ssjz5o0b
         6iITo113ZqZF2fBwjE6y0OehIcyHlMZYqwHKYF97DjzyG0e3LfdqBQmA/Ktd1DSxwInw
         PvSVLU+sT3c8wWiOjQ67U1VCK8i2EjavyA5qHFLmtuIiZMMaImKIGPNPzCNjHMbhLwkO
         3g+w==
X-Gm-Message-State: APt69E1C0qbmrMgLTG0K7RsrhCF86ACZscb0q7SDDLWXWY0nVLf7V3+T
        PCdqC0GBJ0vnDPDuJzPlqsM=
X-Google-Smtp-Source: AAOMgpeR//fj0iQ87qIN/r3oXcDqmV5g4AQoQL3reEYZILfav8MTNBjGEj/iX3RXVPlL8Brdz67SGw==
X-Received: by 2002:a63:d309:: with SMTP id b9-v6mr6366321pgg.163.1531158028579;
        Mon, 09 Jul 2018 10:40:28 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id c12-v6sm8843063pfl.20.2018.07.09.10.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 10:40:27 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/6] arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
Date:   Mon,  9 Jul 2018 10:40:25 -0700
Message-Id: <20180709174025.11495-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <1527530497-10392-7-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com> <1527530497-10392-7-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 May 2018 11:01:37 -0700, Ray Jui <ray.jui@broadcom.com> wrote:
> Enable the SP805 watchdog timer
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> ---

Applied to defconfig-arm64/next, thanks!
--
Florian
